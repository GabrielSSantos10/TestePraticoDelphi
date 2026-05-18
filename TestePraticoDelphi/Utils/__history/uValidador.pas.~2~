unit uValidador;

interface

uses System.SysUtils, System.StrUtils;


function ValidarCPF(const CPF: string): Boolean;
function ExtrairNumeros(const Texto: string): string;

implementation

function ValidarCPF(const CPF: string): Boolean;
var
  S: string;
  I, Soma, Digito1, Digito2: Integer;
  TodosIguais: Boolean;

begin
  Result := False;

  S := StringReplace(CPF, '.', '', [rfReplaceAll]);
  S := StringReplace(S, '-', '', [rfReplaceAll]);
  S := Trim(S);

  if Length(S) <> 11 then Exit;

  TodosIguais := True;
  for I := 2 to 11 do
    if S[I] <> S[1] then TodosIguais := False;
  if TodosIguais then Exit;

  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(S[I]) * (11 - I);
  Digito1 := 11 - (Soma mod 11);
  if Digito1 >= 10 then Digito1 := 0;

  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(S[I]) * (12 - I);
  Digito2 := 11 - (Soma mod 11);
  if Digito2 >= 10 then Digito2 := 0;

  if (IntToStr(Digito1) = S[10]) and (IntToStr(Digito2) = S[11]) then
    Result := True;
end;

function ExtrairNumeros(const Texto: string): string;
var
  C: Char;
begin
  Result := '';
  for C in Texto do
  begin
    if CharInSet(C, ['0'..'9']) then
      Result := Result + C;
  end;
end;

end.
