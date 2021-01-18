unit uIndicador;

interface

type
{$TYPEINFO ON}
  TIndicador = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FNome: String;
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: String);
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
    property Nome: String read FNome write SetNome;

  end;

implementation

{ TIndicador }

procedure TIndicador.Clear;
begin
  FCodigo := 0;
  FNome := '';
end;

constructor TIndicador.Create;
begin
end;

destructor TIndicador.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TIndicador.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TIndicador.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.

