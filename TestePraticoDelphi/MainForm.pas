unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.DApt, Vcl.StdCtrls, Vcl.ExtCtrls,
  uLoginForm, uUsuario;

type
  TForm1 = class(TForm)
    FDConnection: TFDConnection;
    procedure FormShow(Sender: TObject);
    procedure FDConnectionAfterConnect(Sender: TObject);
  private
    FUsuarioLogado: TUsuario;
  public
    property UsuarioLogado: TUsuario read FUsuarioLogado write FUsuarioLogado;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FDConnectionAfterConnect(Sender: TObject);
begin
  FDConnection.ExecSQL('PRAGMA foreign_keys = ON;');
end;

procedure TForm1.FormShow(Sender: TObject);
var
  LLoginForm: TLoginForm;
begin
  if not Assigned(FUsuarioLogado) then
  begin
    LLoginForm := TLoginForm.Create(Self);
    try
      LLoginForm.SetConnection(FDConnection);
      if LLoginForm.ShowModal = mrOk then
      begin
        FUsuarioLogado := LLoginForm.UsuarioLogado;
        ShowMessage('Bem-vindo ' + FUsuarioLogado.Login + '! Perfil: ' + FUsuarioLogado.Perfil);
      end
      else
        Application.Terminate;
    finally
      LLoginForm.Free;
    end;
  end;
end;

end.
