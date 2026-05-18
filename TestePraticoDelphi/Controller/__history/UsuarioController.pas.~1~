unit UsuarioController;

interface

uses
  uUsuario, UsuarioDAO, FireDAC.Comp.Client, System.SysUtils, uHash;

type
  TUsuarioController = class
  private
    FConn: TFDConnection;
    FUsuarioDAO: TUsuarioDAO;
  public
    constructor Create(AConn: TFDConnection);
    destructor Destroy; override;

    // Retorna o objeto TUsuario se o login for válido, ou nil se falhar
    function Autenticar(Login, SenhaEmTexto: string): TUsuario;
  end;

implementation

constructor TUsuarioController.Create(AConn: TFDConnection);
begin
  FConn := AConn;
  FUsuarioDAO := TUsuarioDAO.Create(FConn);
end;

destructor TUsuarioController.Destroy;
begin
  FUsuarioDAO.Free;
  inherited;
end;

function TUsuarioController.Autenticar(Login, SenhaEmTexto: string): TUsuario;
var
  Usuario: TUsuario;
  SenhaHash: string;
begin
  Result := nil;
  Usuario := FUsuarioDAO.BuscarPorLogin(Login);

  if Assigned(Usuario) then
  begin
    SenhaHash := GerarMD5(SenhaEmTexto);
    if SenhaHash = Usuario.SenhaHash then
      Result := Usuario // Login e senha corretos
    else
      Usuario.Free; // Libera a memória se a senha estiver errada
  end;
end;

end.
