unit uUnidadeMedida;

interface

type
{$TYPEINFO ON}
  TUnidadeMedida = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FDescricao: String;
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
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

  end;

implementation

{ TUnidadeMedida }

procedure TUnidadeMedida.Clear;
begin
  FDescricao := '';
  FCodigo := 0;
end;

constructor TUnidadeMedida.Create;
begin
  Clear;
end;

destructor TUnidadeMedida.Destroy;
begin
  inherited;
  Clear;
end;

procedure TUnidadeMedida.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TUnidadeMedida.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
