unit uLog;

interface

type
  TLog = class
  private
    FID: Integer;
    FUsuarioID: Integer;
    FAcao: string;
    FDataHora: TDateTime;
    FDetalhes: string;
  public
    property ID: Integer read FID write FID;
    property UsuarioID: Integer read FUsuarioID write FUsuarioID;
    property Acao: string read FAcao write FAcao;
    property DataHora: TDateTime read FDataHora write FDataHora;
    property Detalhes: string read FDetalhes write FDetalhes;

    constructor Create; overload;
    constructor Create(AID, AUsuarioID: Integer; AAcao: string;
                       ADataHora: TDateTime; ADetalhes: string); overload;
  end;

implementation

constructor TLog.Create;
begin
  FID := 0;
  FUsuarioID := 0;
  FAcao := '';
  FDataHora := 0;
  FDetalhes := '';
end;

constructor TLog.Create(AID, AUsuarioID: Integer; AAcao: string;
                       ADataHora: TDateTime; ADetalhes: string);
begin
  FID := AID;
  FUsuarioID := AUsuarioID;
  FAcao := AAcao;
  FDataHora := ADataHora;
  FDetalhes := ADetalhes;
end;

end.
