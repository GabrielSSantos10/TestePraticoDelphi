unit PessoaDAO;

interface

uses
  System.SysUtils, System.Generics.Collections, FireDAC.Comp.Client, FireDAC.DApt, uPessoa;

type
  TPessoaDAO = class
  private
    FConn: TFDConnection;
  public
    constructor Create(AConn: TFDConnection);

    function BuscarPorID(AID: Integer): TPessoa;
    function BuscarTodos: TObjectList<TPessoa>;
    function Inserir(Pessoa: TPessoa): Boolean;
    function Atualizar(Pessoa: TPessoa): Boolean;
    function Excluir(AID: Integer): Boolean;
  end;

implementation

constructor TPessoaDAO.Create(AConn: TFDConnection);
begin
  FConn := AConn;
end;

function TPessoaDAO.BuscarPorID(AID: Integer): TPessoa;
var
  qry: TFDQuery;
begin
  Result := nil;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text :=
      'SELECT pessoa_id, tipo_pessoa_id, nome, data_nascimento, cpf, rg, email, telefone, endereco_id ' +
      'FROM Pessoa WHERE pessoa_id = :id';
    qry.ParamByName('id').AsInteger := AID;
    qry.Open;
    if not qry.Eof then
      Result := TPessoa.Create(
        qry.FieldByName('pessoa_id').AsInteger,
        qry.FieldByName('tipo_pessoa_id').AsInteger,
        qry.FieldByName('nome').AsString,
        qry.FieldByName('data_nascimento').AsDateTime,
        qry.FieldByName('cpf').AsString,
        qry.FieldByName('rg').AsString,
        qry.FieldByName('email').AsString,
        qry.FieldByName('telefone').AsString,
        qry.FieldByName('endereco_id').AsInteger
      );
  finally
    qry.Free;
  end;
end;

function TPessoaDAO.BuscarTodos: TObjectList<TPessoa>;
var
  qry: TFDQuery;
  item: TPessoa;
begin
  Result := TObjectList<TPessoa>.Create;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text :=
      'SELECT pessoa_id, tipo_pessoa_id, nome, data_nascimento, cpf, rg, email, telefone, endereco_id ' +
      'FROM Pessoa';
    qry.Open;
    while not qry.Eof do
    begin
      item := TPessoa.Create(
        qry.FieldByName('pessoa_id').AsInteger,
        qry.FieldByName('tipo_pessoa_id').AsInteger,
        qry.FieldByName('nome').AsString,
        qry.FieldByName('data_nascimento').AsDateTime,
        qry.FieldByName('cpf').AsString,
        qry.FieldByName('rg').AsString,
        qry.FieldByName('email').AsString,
        qry.FieldByName('telefone').AsString,
        qry.FieldByName('endereco_id').AsInteger
      );
      Result.Add(item);
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

function TPessoaDAO.Inserir(Pessoa: TPessoa): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text :=
      'INSERT INTO Pessoa (tipo_pessoa_id, nome, data_nascimento, cpf, rg, email, telefone, endereco_id) ' +
      'VALUES (:tipo_pessoa_id, :nome, :data_nascimento, :cpf, :rg, :email, :telefone, :endereco_id)';
    qry.ParamByName('tipo_pessoa_id').AsInteger := Pessoa.TipoPessoaID;
    qry.ParamByName('nome').AsString := Pessoa.Nome;
    qry.ParamByName('data_nascimento').AsDate := Pessoa.DataNascimento;
    qry.ParamByName('cpf').AsString := Pessoa.CPF;
    qry.ParamByName('rg').AsString := Pessoa.RG;
    qry.ParamByName('email').AsString := Pessoa.Email;
    qry.ParamByName('telefone').AsString := Pessoa.Telefone;
    qry.ParamByName('endereco_id').AsInteger := Pessoa.EnderecoID;
    qry.ExecSQL;
    Result := True;
  finally
    qry.Free;
  end;
end;

function TPessoaDAO.Atualizar(Pessoa: TPessoa): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text :=
      'UPDATE Pessoa SET tipo_pessoa_id = :tipo_pessoa_id, nome = :nome, data_nascimento = :data_nascimento, ' +
      'cpf = :cpf, rg = :rg, email = :email, telefone = :telefone, endereco_id = :endereco_id ' +
      'WHERE pessoa_id = :id';
    qry.ParamByName('tipo_pessoa_id').AsInteger := Pessoa.TipoPessoaID;
    qry.ParamByName('nome').AsString := Pessoa.Nome;
    qry.ParamByName('data_nascimento').AsDate := Pessoa.DataNascimento;
    qry.ParamByName('cpf').AsString := Pessoa.CPF;
    qry.ParamByName('rg').AsString := Pessoa.RG;
    qry.ParamByName('email').AsString := Pessoa.Email;
    qry.ParamByName('telefone').AsString := Pessoa.Telefone;
    qry.ParamByName('endereco_id').AsInteger := Pessoa.EnderecoID;
    qry.ParamByName('id').AsInteger := Pessoa.ID;
    qry.ExecSQL;
    Result := True;
  finally
    qry.Free;
  end;
end;

function TPessoaDAO.Excluir(AID: Integer): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text := 'DELETE FROM Pessoa WHERE pessoa_id = :id';
    qry.ParamByName('id').AsInteger := AID;
    qry.ExecSQL;
    Result := True;
  finally
    qry.Free;
  end;
end;

end.
