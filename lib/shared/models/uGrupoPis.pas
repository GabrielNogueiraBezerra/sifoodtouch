unit uGrupoPis;

interface

type
{$TYPEINFO ON}
  TGrupoPis = class(TObject)
  private
    FDescricao: String;
    FCodigo: Integer;
    FAliquota: Currency;
    FCST: String;
    procedure SetAliquota(const Value: Currency);
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetCST(const Value: String);
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
    property Aliquota: Currency read FAliquota write SetAliquota;
    property CST: String read FCST write SetCST;

  end;

implementation

{ TGrupoPis }

procedure TGrupoPis.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FAliquota := 0;
end;

constructor TGrupoPis.Create;
begin
  Clear;
end;

destructor TGrupoPis.Destroy;
begin
  inherited;
  Clear;

end;

procedure TGrupoPis.SetAliquota(const Value: Currency);
begin
  FAliquota := Value;
end;

procedure TGrupoPis.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TGrupoPis.SetCST(const Value: String);
begin
  FCST := Value;
end;

procedure TGrupoPis.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
