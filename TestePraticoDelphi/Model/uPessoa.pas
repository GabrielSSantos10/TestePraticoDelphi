unit uPessoa;

interface

type
  TPessoa = class
  private
    FID: Integer;
    FTipoPessoaID: Integer;
    FNome: string;
    FDataNascimento: TDate;
    FCPF: string;
    FRG: string;
    FEmail: string;
    FTelefone: string;
    FEnderecoID: Integer;
  public
    property ID: Integer read FID write FID;
    property TipoPessoaID: Integer read FTipoPessoaID write FTipoPessoaID;
    property Nome: string read FNome write FNome;
    property DataNascimento: TDate read FDataNascimento write FDataNascimento;
    property CPF: string read FCPF write FCPF;
    property RG: string read FRG write FRG;
    property Email: string read FEmail write FEmail;
    property Telefone: string read FTelefone write FTelefone;
    property EnderecoID: Integer read FEnderecoID write FEnderecoID;

    constructor Create; overload;
    constructor Create(AID, ATipoPessoaID: Integer; ANome: string; ADataNascimento: TDate;
                       ACPf, ARG, AEmail, ATelefone: string; AEnderecoID: Integer); overload;
  end;

implementation

constructor TPessoa.Create;
begin
  FID := 0;
  FTipoPessoaID := 0;
  FNome := '';
  FDataNascimento := 0;
  FCPF := '';
  FRG := '';
  FEmail := '';
  FTelefone := '';
  FEnderecoID := 0;
end;

constructor TPessoa.Create(AID, ATipoPessoaID: Integer; ANome: string;
  ADataNascimento: TDate; ACPf, ARG, AEmail, ATelefone: string;
  AEnderecoID: Integer);
begin
  FID := AID;
  FTipoPessoaID := ATipoPessoaID;
  FNome := ANome;
  FDataNascimento := ADataNascimento;
  FCPF := ACPf;
  FRG := ARG;
  FEmail := AEmail;
  FTelefone := ATelefone;
  FEnderecoID := AEnderecoID;
end;

end.
