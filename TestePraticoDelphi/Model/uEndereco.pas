unit uEndereco;

interface

type
  TEndereco = class
  private
    FID: Integer;
    FCEP: string;
    FLogradouro: string;
    FComplemento: string;
    FBairro: string;
    FCidade: string;
    FEstado: string;
  public
    property ID: Integer read FID write FID;
    property CEP: string read FCEP write FCEP;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;

    constructor Create; overload;
    constructor Create(AID: Integer; ACEP, ALogradouro, AComplemento, ABairro, ACidade, AEstado: string); overload;
  end;

implementation

constructor TEndereco.Create;
begin
  FID := 0;
  FCEP := '';
  FLogradouro := '';
  FComplemento := '';
  FBairro := '';
  FCidade := '';
  FEstado := '';
end;

constructor TEndereco.Create(
  AID: Integer;
  ACEP, ALogradouro, AComplemento, ABairro, ACidade, AEstado: string);
begin
  FID := AID;
  FCEP := ACEP;
  FLogradouro := ALogradouro;
  FComplemento := AComplemento;
  FBairro := ABairro;
  FCidade := ACidade;
  FEstado := AEstado;
end;

end.
