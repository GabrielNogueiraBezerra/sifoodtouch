unit uSetor;

interface

type
{$TYPEINFO ON}
  TSetor = class(TObject)
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

{ TSetor }

procedure TSetor.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
end;

constructor TSetor.Create;
begin
end;

destructor TSetor.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TSetor.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TSetor.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.

