unit EnderecoController;

interface

uses
  uEndereco, EnderecoDAO, FireDAC.Comp.Client, System.SysUtils, System.JSON,
  System.Net.HttpClient, System.Net.URLClient,
  System.Net.HttpClientComponent; // <-- UNIT ADICIONADA AQUI

type
  TEnderecoController = class
  private
    FConn: TFDConnection;
    FEnderecoDAO: TEnderecoDAO;
  public
    constructor Create(AConn: TFDConnection);
    destructor Destroy; override;

    // CRUD
    function Inserir(Endereco: TEndereco): Boolean;
    function Atualizar(Endereco: TEndereco): Boolean;
    function Excluir(EnderecoID: Integer): Boolean;
    function BuscarPorID(EnderecoID: Integer): TEndereco;

    // Integração VIACEP
    function BuscarEnderecoViaCEP(CEP: string; out Endereco: TEndereco): Boolean;
  end;

implementation

constructor TEnderecoController.Create(AConn: TFDConnection);
begin
  FConn := AConn;
  FEnderecoDAO := TEnderecoDAO.Create(FConn);
end;

destructor TEnderecoController.Destroy;
begin
  FEnderecoDAO.Free;
  inherited;
end;

function TEnderecoController.Inserir(Endereco: TEndereco): Boolean;
begin
  Result := FEnderecoDAO.Inserir(Endereco);
end;

function TEnderecoController.Atualizar(Endereco: TEndereco): Boolean;
begin
  Result := FEnderecoDAO.Atualizar(Endereco);
end;

function TEnderecoController.Excluir(EnderecoID: Integer): Boolean;
begin
  Result := FEnderecoDAO.Excluir(EnderecoID);
end;

function TEnderecoController.BuscarPorID(EnderecoID: Integer): TEndereco;
begin
  Result := FEnderecoDAO.BuscarPorID(EnderecoID);
end;

function TEnderecoController.BuscarEnderecoViaCEP(CEP: string; out Endereco: TEndereco): Boolean;
var
  HTTP: TNetHTTPClient;
  Response: IHTTPResponse;
  JSON: TJSONObject;
begin
  Result := False;
  Endereco := nil;

  HTTP := TNetHTTPClient.Create(nil);
  try
    Response := HTTP.Get('https://viacep.com.br/ws/' + CEP + '/json/');

    if Response.StatusCode = 200 then
    begin
      JSON := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8)) as TJSONObject;
      if JSON <> nil then
      begin
        try
          // O ViaCEP retorna um nó "erro": true quando o CEP não existe
          if JSON.GetValue('erro') = nil then
          begin
            Endereco := uEndereco.TEndereco.Create(
              0, // ID será gerado ao inserir no banco
              JSON.GetValue<string>('cep', ''),
              JSON.GetValue<string>('logradouro', ''),
              JSON.GetValue<string>('complemento', ''), // Mapeando o complemento que vem da API
              JSON.GetValue<string>('bairro', ''),
              JSON.GetValue<string>('localidade', ''),  // ViaCEP chama a cidade de localidade
              JSON.GetValue<string>('uf', '')           // Pode trocar por 'estado' se preferir o nome por extenso
            );
            Result := True;
          end;
        finally
          JSON.Free; // Importante liberar o JSON da memória
        end;
      end;
    end;
  finally
    HTTP.Free; // Importante liberar o componente HTTP da memória
  end;
end;

end.
