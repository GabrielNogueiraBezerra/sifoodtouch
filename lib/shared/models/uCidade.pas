unit uCidade;

interface

type
{$TYPEINFO ON}
  TCidade = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FDescricao: String;
    FUf: String;

    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetUf(const Value: String);
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
    property UF: String read FUf write SetUf;
  end;

implementation

{ TCidade }

procedure TCidade.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FUf := '';
end;

constructor TCidade.Create;
begin
end;

destructor TCidade.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TCidade.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TCidade.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TCidade.SetUf(const Value: String);
begin
  FUf := Value;
end;

end.
