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
    // seus controles
    procedure FormShow(Sender: TObject);
  private
    FUsuarioLogado: TUsuario;
  public
    property UsuarioLogado: TUsuario read FUsuarioLogado write FUsuarioLogado;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
var
  LLoginForm: TLoginForm;
begin
  // Só faz login na primeira exibição
  if not Assigned(FUsuarioLogado) then
  begin
    LLoginForm := TLoginForm.Create(Self);
    try
      LLoginForm.SetConnection(FDConnection);
      if LLoginForm.ShowModal = mrOk then
      begin
        FUsuarioLogado := LLoginForm.UsuarioLogado;
        // Agora você pode controlar permissões pelo perfil:
        // if FUsuarioLogado.Perfil = 'ADM' then ... else ...
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
