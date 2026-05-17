program CadastroPessoas;

uses
  Vcl.Forms,
  Vcl.Controls,
  MainForm in 'MainForm.pas' {Form1},
  uTipoPessoa in 'Model\uTipoPessoa.pas',
  uEndereco in 'Model\uEndereco.pas',
  TipoPessoaDAO in 'DAO\TipoPessoaDAO.pas',
  EnderecoDAO in 'DAO\EnderecoDAO.pas',
  uPessoa in 'Model\uPessoa.pas',
  uUsuario in 'Model\uUsuario.pas',
  PessoaDAO in 'DAO\PessoaDAO.pas',
  UsuarioDAO in 'DAO\UsuarioDAO.pas',
  uLog in 'Model\uLog.pas',
  LogDAO in 'DAO\LogDAO.pas',
  uHash in 'Utils\uHash.pas',
  uLoginForm in 'View\uLoginForm.pas' {LoginForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);

  LoginForm := TLoginForm.Create(nil);
  try
    LoginForm.SetConnection(Form1.FDConnection);
    if LoginForm.ShowModal = mrOk then
      Application.Run
    else
      Application.Terminate;
  finally
    LoginForm.Free;
  end;
end.
