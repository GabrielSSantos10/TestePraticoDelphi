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
      Result := Usuario
    else
      Usuario.Free;
  end;
end;

end.
