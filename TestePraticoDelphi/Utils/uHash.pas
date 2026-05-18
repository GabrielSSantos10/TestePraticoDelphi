unit uHash;

interface

function GerarMD5(const Value: string): string;

implementation

uses
  System.Hash, System.SysUtils;

function GerarMD5(const Value: string): string;
begin
  Result := LowerCase(THashMD5.GetHashString(Value));
end;

end.
