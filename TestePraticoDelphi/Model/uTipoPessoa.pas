unit uTipoPessoa;

interface

type
  TTipoPessoa = class
  private
    FID: Integer;
    FDescricao: string;
  public
    property ID: Integer read FID write FID;
    property Descricao: string read FDescricao write FDescricao;

    constructor Create; overload;
    constructor Create(AID: Integer; ADescricao: string); overload;
  end;

implementation

constructor TTipoPessoa.Create;
begin
  FID := 0;
  FDescricao := '';
end;

constructor TTipoPessoa.Create(AID: Integer; ADescricao: string);
begin
  FID := AID;
  FDescricao := ADescricao;
end;

end.
