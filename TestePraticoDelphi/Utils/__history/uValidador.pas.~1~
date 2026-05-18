unit uValidador;

interface

uses System.SysUtils, System.StrUtils;

// Assinatura da função
function ValidarCPF(const CPF: string): Boolean;

implementation

function ValidarCPF(const CPF: string): Boolean;
var
  S: string;
  I, Soma, Digito1, Digito2: Integer;
  TodosIguais: Boolean;
begin
  Result := False;

  // 1. Remove formatação (pontos e traços) e espaços
  S := StringReplace(CPF, '.', '', [rfReplaceAll]);
  S := StringReplace(S, '-', '', [rfReplaceAll]);
  S := Trim(S);

  // 2. Verifica tamanho
  if Length(S) <> 11 then Exit;

  // 3. Rejeita CPFs com todos os números iguais (ex: 111.111.111-11)
  TodosIguais := True;
  for I := 2 to 11 do
    if S[I] <> S[1] then TodosIguais := False;
  if TodosIguais then Exit;

  // 4. Calcula o primeiro dígito verificador
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(S[I]) * (11 - I);
  Digito1 := 11 - (Soma mod 11);
  if Digito1 >= 10 then Digito1 := 0;

  // 5. Calcula o segundo dígito verificador
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(S[I]) * (12 - I);
  Digito2 := 11 - (Soma mod 11);
  if Digito2 >= 10 then Digito2 := 0;

  // 6. Confere se os dígitos batem
  if (IntToStr(Digito1) = S[10]) and (IntToStr(Digito2) = S[11]) then
    Result := True;
end;

end.
