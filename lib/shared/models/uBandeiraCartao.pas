unit uBandeiraCartao;

interface

type
{$TYPEINFO ON}
  TBandeiraCartao = class(TObject)
  private
    FCodigoTef: String;
    FTaxaDebito: Currency;
    FAtivo: Boolean;
    FDescricao: String;
    FCodigo: Integer;
    FDiasCredito: Integer;
    FTipoCartao: String;
    FDiasDebito: Integer;
    FTaxaCredito: Currency;
    procedure SetAtivo(const Value: Boolean);
    procedure SetCodigo(const Value: Integer);
    procedure SetCodigoTef(const Value: String);
    procedure SetDescricao(const Value: String);
    procedure SetDiasCredito(const Value: Integer);
    procedure SetDiasDebito(const Value: Integer);
    procedure SetTaxaCredito(const Value: Currency);
    procedure SetTaxaDebito(const Value: Currency);
    procedure SetTipoCartao(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property Descricao: String read FDescricao write SetDescricao;
    property Ativo: Boolean read FAtivo write SetAtivo;
    property TaxaCredito: Currency read FTaxaCredito write SetTaxaCredito;
    property TaxaDebito: Currency read FTaxaDebito write SetTaxaDebito;
    property DiasCredito: Integer read FDiasCredito write SetDiasCredito;
    property DiasDebito: Integer read FDiasDebito write SetDiasDebito;
    property TipoCartao: String read FTipoCartao write SetTipoCartao;
    property CodigoTef: String read FCodigoTef write SetCodigoTef;
  end;

implementation

{ TBandeiraCartao }

procedure TBandeiraCartao.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FAtivo := false;
  FTaxaCredito := 0;
  FTaxaDebito := 0;
  FDiasCredito := 0;
  FDiasDebito := 0;
  FTipoCartao := '';
  FCodigoTef := '';
end;

constructor TBandeiraCartao.Create;
begin
  Clear;
end;

destructor TBandeiraCartao.Destroy;
begin
  inherited;
  Clear;
end;

procedure TBandeiraCartao.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TBandeiraCartao.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TBandeiraCartao.SetCodigoTef(const Value: String);
begin
  FCodigoTef := Value;
end;

procedure TBandeiraCartao.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TBandeiraCartao.SetDiasCredito(const Value: Integer);
begin
  FDiasCredito := Value;
end;

procedure TBandeiraCartao.SetDiasDebito(const Value: Integer);
begin
  FDiasDebito := Value;
end;

procedure TBandeiraCartao.SetTaxaCredito(const Value: Currency);
begin
  FTaxaCredito := Value;
end;

procedure TBandeiraCartao.SetTaxaDebito(const Value: Currency);
begin
  FTaxaDebito := Value;
end;

procedure TBandeiraCartao.SetTipoCartao(const Value: String);
begin
  FTipoCartao := Value;
end;

end.
