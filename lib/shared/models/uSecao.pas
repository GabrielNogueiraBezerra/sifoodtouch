unit uSecao;

interface

type
{$TYPEINFO ON}
  TSecao = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FDescricao: String;
    FAdicional: Boolean;
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetAdicional(const Value: Boolean);
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
    property Adicional: Boolean read FAdicional write SetAdicional;

  end;

implementation

{ TSecao }

procedure TSecao.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
end;

constructor TSecao.Create;
begin
  Self.Clear;
end;

destructor TSecao.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TSecao.SetAdicional(const Value: Boolean);
begin
  FAdicional := Value;
end;

procedure TSecao.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TSecao.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
