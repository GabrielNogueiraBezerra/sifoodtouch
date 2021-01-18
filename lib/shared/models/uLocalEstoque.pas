unit uLocalEstoque;

interface

type
{$TYPEINFO ON}
  TLocalEstoque = class(TObject)
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

{ TLocalEstoque }

procedure TLocalEstoque.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
end;

constructor TLocalEstoque.Create;
begin
  Clear;
end;

destructor TLocalEstoque.Destroy;
begin
  inherited;
  Clear;
end;

procedure TLocalEstoque.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TLocalEstoque.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
