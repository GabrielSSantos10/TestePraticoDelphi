unit EnderecoDAO;

interface

uses
  System.SysUtils, System.Generics.Collections, FireDAC.Comp.Client, FireDAC.DApt, uEndereco;

type
  TEnderecoDAO = class
  private
    FConn: TFDConnection;
  public
    constructor Create(AConn: TFDConnection);

    function BuscarPorID(AID: Integer): TEndereco;
    function BuscarTodos: TObjectList<TEndereco>;
    function Inserir(Endereco: TEndereco): Boolean;
    function Atualizar(Endereco: TEndereco): Boolean;
    function Excluir(AID: Integer): Boolean;
    function GetLastInsertID: Integer;
  end;

implementation

constructor TEnderecoDAO.Create(AConn: TFDConnection);
begin
  FConn := AConn;
end;

function TEnderecoDAO.BuscarPorID(AID: Integer): TEndereco;
var
  qry: TFDQuery;
begin
  Result := nil;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text := 'SELECT * FROM Endereco WHERE endereco_id = :id';
    qry.ParamByName('id').AsInteger := AID;
    qry.Open;
    if not qry.Eof then
      Result := TEndereco.Create(
        qry.FieldByName('endereco_id').AsInteger,
        qry.FieldByName('cep').AsString,
        qry.FieldByName('logradouro').AsString,
        qry.FieldByName('complemento').AsString,
        qry.FieldByName('bairro').AsString,
        qry.FieldByName('cidade').AsString,
        qry.FieldByName('estado').AsString
      );
  finally
    qry.Free;
  end;
end;

function TEnderecoDAO.BuscarTodos: TObjectList<TEndereco>;
var
  qry: TFDQuery;
  item: TEndereco;
begin
  Result := TObjectList<TEndereco>.Create;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text := 'SELECT * FROM Endereco';
    qry.Open;
    while not qry.Eof do
    begin
      item := TEndereco.Create(
        qry.FieldByName('endereco_id').AsInteger,
        qry.FieldByName('cep').AsString,
        qry.FieldByName('logradouro').AsString,
        qry.FieldByName('complemento').AsString,
        qry.FieldByName('bairro').AsString,
        qry.FieldByName('cidade').AsString,
        qry.FieldByName('estado').AsString
      );
      Result.Add(item);
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

function TEnderecoDAO.Inserir(Endereco: TEndereco): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text :=
      'INSERT INTO Endereco (cep, logradouro, complemento, bairro, cidade, estado) ' +
      'VALUES (:cep, :logradouro, :complemento, :bairro, :cidade, :estado)';
    qry.ParamByName('cep').AsString := Endereco.CEP;
    qry.ParamByName('logradouro').AsString := Endereco.Logradouro;
    qry.ParamByName('complemento').AsString := Endereco.Complemento;
    qry.ParamByName('bairro').AsString := Endereco.Bairro;
    qry.ParamByName('cidade').AsString := Endereco.Cidade;
    qry.ParamByName('estado').AsString := Endereco.Estado;
    qry.ExecSQL;
    Result := True;
  finally
    qry.Free;
  end;
end;

function TEnderecoDAO.Atualizar(Endereco: TEndereco): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text :=
      'UPDATE Endereco SET cep = :cep, logradouro = :logradouro, complemento = :complemento, ' +
      'bairro = :bairro, cidade = :cidade, estado = :estado WHERE endereco_id = :id';
    qry.ParamByName('cep').AsString := Endereco.CEP;
    qry.ParamByName('logradouro').AsString := Endereco.Logradouro;
    qry.ParamByName('complemento').AsString := Endereco.Complemento;
    qry.ParamByName('bairro').AsString := Endereco.Bairro;
    qry.ParamByName('cidade').AsString := Endereco.Cidade;
    qry.ParamByName('estado').AsString := Endereco.Estado;
    qry.ParamByName('id').AsInteger := Endereco.ID;
    qry.ExecSQL;
    Result := True;
  finally
    qry.Free;
  end;
end;

function TEnderecoDAO.Excluir(AID: Integer): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text := 'DELETE FROM Endereco WHERE endereco_id = :id';
    qry.ParamByName('id').AsInteger := AID;
    qry.ExecSQL;
    Result := True;
  finally
    qry.Free;
  end;
end;

function TEnderecoDAO.GetLastInsertID: Integer;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.SQL.Text := 'SELECT last_insert_rowid() AS ID';
    qry.Open;
    Result := qry.FieldByName('ID').AsInteger;
  finally
    qry.Free;
  end;
end;

end.
