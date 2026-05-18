unit PessoaController;

interface

uses
  uPessoa, uEndereco, PessoaDAO, EnderecoDAO, System.Generics.Collections,
  FireDAC.Comp.Client, System.SysUtils;

type
  TPessoaController = class
  private
    FConn: TFDConnection;
    FPessoaDAO: TPessoaDAO;
    FEnderecoDAO: TEnderecoDAO;
  public
    constructor Create(AConn: TFDConnection);
    destructor Destroy; override;

    // Retorna True se OK, False se falhar.
    function InserirNovaPessoa(Pessoa: TPessoa; Endereco: TEndereco): Boolean;
    function AtualizarPessoa(Pessoa: TPessoa; Endereco: TEndereco): Boolean;
    function ExcluirPessoa(PessoaID: Integer): Boolean;
    function BuscarPessoaPorID(PessoaID: Integer): TPessoa;
    function BuscarTodos: TObjectList<TPessoa>;
  end;

implementation

constructor TPessoaController.Create(AConn: TFDConnection);
begin
  FConn := AConn;
  FPessoaDAO := TPessoaDAO.Create(FConn);
  FEnderecoDAO := TEnderecoDAO.Create(FConn);
end;

destructor TPessoaController.Destroy;
begin
  FPessoaDAO.Free;
  FEnderecoDAO.Free;
  inherited;
end;

function TPessoaController.InserirNovaPessoa(Pessoa: TPessoa; Endereco: TEndereco): Boolean;
begin
  Result := False;
  FConn.StartTransaction; // 1. Inicia a transação
  try
    if FEnderecoDAO.Inserir(Endereco) then
    begin
      Endereco.ID := FEnderecoDAO.GetLastInsertID; // Lembre-se que criamos isso antes!
      Pessoa.EnderecoID := Endereco.ID;

      if FPessoaDAO.Inserir(Pessoa) then
      begin
        FConn.Commit; // 2. Se as duas deram certo, salva de vez!
        Result := True;
      end
      else
        FConn.Rollback; // Desfaz se a pessoa falhou
    end
    else
      FConn.Rollback; // Desfaz se o endereço falhou
  except
    on E: Exception do
    begin
      FConn.Rollback; // 3. Desfaz em caso de erro fatal (ex: banco fora do ar)
      raise Exception.Create('Erro ao inserir pessoa: ' + E.Message);
    end;
  end;
end;

function TPessoaController.AtualizarPessoa(Pessoa: TPessoa; Endereco: TEndereco): Boolean;
begin
  Result := False;
  try
    if FEnderecoDAO.Atualizar(Endereco) then
      Result := FPessoaDAO.Atualizar(Pessoa);
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

end.
