unit PessoaController;

interface

uses
  uPessoa, uEndereco, PessoaDAO, EnderecoDAO, System.Generics.Collections,
  FireDAC.Comp.Client, System.SysUtils, LogDAO, uLog;

type
  TPessoaController = class
  private
    FConn: TFDConnection;
    FPessoaDAO: TPessoaDAO;
    FEnderecoDAO: TEnderecoDAO;
    FLogDAO: TLogDAO;
    FUsuarioIDAtual: Integer;
    procedure RegistrarLog(DAO: TLogDAO; UsuarioID: Integer; Acao, Detalhes: string);
  public
    constructor Create(AConn: TFDConnection; AUsuarioID: Integer);
    destructor Destroy; override;

    function InserirNovaPessoa(Pessoa: TPessoa; Endereco: TEndereco): Boolean;
    function AtualizarPessoa(Pessoa: TPessoa; Endereco: TEndereco): Boolean;
    function ExcluirPessoa(PessoaID: Integer): Boolean;
    function BuscarPessoaPorID(PessoaID: Integer): TPessoa;
    function BuscarTodos: TObjectList<TPessoa>;
  end;

implementation

constructor TPessoaController.Create(AConn: TFDConnection; AUsuarioID: Integer);
begin
  FConn := AConn;
  FUsuarioIDAtual := AUsuarioID;
  FPessoaDAO := TPessoaDAO.Create(FConn);
  FEnderecoDAO := TEnderecoDAO.Create(FConn);
  FLogDAO := TLogDAO.Create(FConn);
end;

destructor TPessoaController.Destroy;
begin
  FPessoaDAO.Free;
  FEnderecoDAO.Free;
  FLogDAO.Free;
  inherited;
end;

function TPessoaController.InserirNovaPessoa(Pessoa: TPessoa; Endereco: TEndereco): Boolean;
begin
  Result := False;

  if FPessoaDAO.CpfJaExiste(Pessoa.CPF) then
    raise Exception.Create('Este CPF já está cadastrado no sistema.');

  FConn.StartTransaction;
  try
    if FEnderecoDAO.Inserir(Endereco) then
    begin
      Endereco.ID := FEnderecoDAO.GetLastInsertID;
      Pessoa.EnderecoID := Endereco.ID;

      if FPessoaDAO.Inserir(Pessoa) then
      begin
        FConn.Commit;
        Result := True;
        RegistrarLog(FLogDAO, FUsuarioIDAtual, 'INSERIR', 'Cadastrou a pessoa CPF: ' + Pessoa.CPF);
      end
      else
        FConn.Rollback;
    end
    else
      FConn.Rollback;
  except
    on E: Exception do
    begin
      FConn.Rollback;
      raise Exception.Create('Erro ao inserir pessoa: ' + E.Message);
    end;
  end;
end;

function TPessoaController.AtualizarPessoa(Pessoa: TPessoa; Endereco: TEndereco): Boolean;
begin
  Result := False;

  if FPessoaDAO.CpfJaExiste(Pessoa.CPF, Pessoa.ID) then
    raise Exception.Create('Este CPF já está cadastrado no sistema.');

  try
    if FEnderecoDAO.Atualizar(Endereco) then
    begin
      Result := FPessoaDAO.Atualizar(Pessoa);
      if Result then
        RegistrarLog(FLogDAO, FUsuarioIDAtual, 'ATUALIZAR', 'Atualizou a pessoa CPF: ' + Pessoa.CPF);
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao atualizar pessoa: ' + E.Message);
  end;
end;

function TPessoaController.ExcluirPessoa(PessoaID: Integer): Boolean;
var
  Pessoa: TPessoa;
begin
  Result := False;
  try
    Pessoa := FPessoaDAO.BuscarPorID(PessoaID);
    if Assigned(Pessoa) then
    begin
      Result := FPessoaDAO.Excluir(PessoaID) and
                FEnderecoDAO.Excluir(Pessoa.EnderecoID);

      if Result then
        RegistrarLog(FLogDAO, FUsuarioIDAtual, 'EXCLUIR', 'Excluiu o usuário: ' + Pessoa.CPF);

      Pessoa.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao excluir pessoa: ' + E.Message);
  end;
end;

function TPessoaController.BuscarPessoaPorID(PessoaID: Integer): TPessoa;
begin
  Result := FPessoaDAO.BuscarPorID(PessoaID);
end;

function TPessoaController.BuscarTodos: TObjectList<TPessoa>;
begin
  Result := FPessoaDAO.BuscarTodos;
end;

procedure TPessoaController.RegistrarLog(DAO: TLogDAO; UsuarioID: Integer; Acao, Detalhes: string);
var
  L: TLog;
begin
  L := TLog.Create(0, UsuarioID, Acao, Now, Detalhes);
  try
    DAO.Inserir(L);
  finally
    L.Free;
  end;
end;

end.
