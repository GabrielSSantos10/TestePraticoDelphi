unit uLoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UsuarioDAO, uUsuario,
  FireDAC.Comp.Client, FireDAC.DApt, uHash, UsuarioController, uConsultaPessoasForm;

type
  TLoginForm = class(TForm)
    edtLogin: TEdit;
    edtSenha: TEdit;
    lblLogin: TLabel;
    lblSenha: TLabel;
    btnEntrar: TButton;
    Label1: TLabel;

    procedure btnEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FConn: TFDConnection;
    FUsuarioLogado: TUsuario;
  public
    procedure SetConnection(AConn: TFDConnection);
    property UsuarioLogado: TUsuario read FUsuarioLogado;
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

procedure TLoginForm.SetConnection(AConn: TFDConnection);
begin
  FConn := AConn;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  Label1.Caption := 'Digite seu usuário e senha para acessar o sistema';
  edtSenha.PasswordChar := '*';
end;

procedure TLoginForm.btnEntrarClick(Sender: TObject);
var
  Controller: TUsuarioController;
begin
  Label1.Caption := '';
  Controller := TUsuarioController.Create(FConn);
  try
    FUsuarioLogado := Controller.Autenticar(Trim(edtLogin.Text), Trim(edtSenha.Text));

    if Assigned(FUsuarioLogado) then
    begin
      Self.Hide;

      if not Assigned(uConsultarPessoas) then
        Application.CreateForm(TuConsultarPessoas, uConsultarPessoas);

      uConsultarPessoas.FConn := Self.FConn;
      uConsultarPessoas.FUsuarioLogado := Self.FUsuarioLogado;

      uConsultarPessoas.Show;
    end
    else
    begin
      Label1.Caption := 'Usuário ou senha incorretos!';
      Label1.Font.Color := clRed;
      edtSenha.Clear;
      edtSenha.SetFocus;
    end;
  finally
    Controller.Free;
  end;
end;


end.

