unit uCaminhoImpressora;

interface

type
{$TYPEINFO ON}
  TCaminhoImpressora = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FPorta: String;
    FModelo: Integer;
    FColunas: Integer;
    FPaginaCodigo: Integer;
    FParametroString: String;
    FEspacoEntreLinhas: Integer;
    FControlaPorta: Boolean;
    FCortaPapel: Boolean;
    procedure SetCodigo(const Value: Integer);
    procedure SetColunas(const Value: Integer);
    procedure SetModelo(const Value: Integer);
    procedure SetPorta(const Value: String);
    procedure SetControlaPorta(const Value: Boolean);
    procedure SetCortaPapel(const Value: Boolean);
    procedure SetEspacoEntreLinhas(const Value: Integer);
    procedure SetPaginaCodigo(const Value: Integer);
    procedure SetParametroString(const Value: String);
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
    property Porta: String read FPorta write SetPorta;
    property Modelo: Integer read FModelo write SetModelo;
    property Colunas: Integer read FColunas write SetColunas;
    property PaginaCodigo: Integer read FPaginaCodigo write SetPaginaCodigo;
    property ParametroString: String read FParametroString write SetParametroString;
    property EspacoEntreLinhas: Integer read FEspacoEntreLinhas write SetEspacoEntreLinhas;
    property ControlaPorta: Boolean read FControlaPorta write SetControlaPorta;
    property CortaPapel: Boolean read FCortaPapel write SetCortaPapel;
  end;

implementation

{ TCaminhoImpressora }

procedure TCaminhoImpressora.Clear;
begin
  FCodigo := 0;
  FPorta := '';
  FModelo := 0;
  FCodigo := 0;
end;

constructor TCaminhoImpressora.Create;
begin
end;

destructor TCaminhoImpressora.Destroy;
begin

  inherited;
  Self.Clear;
end;

procedure TCaminhoImpressora.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TCaminhoImpressora.SetColunas(const Value: Integer);
begin
  FColunas := Value;
end;

procedure TCaminhoImpressora.SetControlaPorta(const Value: Boolean);
begin
  FControlaPorta := Value;
end;

procedure TCaminhoImpressora.SetCortaPapel(const Value: Boolean);
begin
  FCortaPapel := Value;
end;

procedure TCaminhoImpressora.SetEspacoEntreLinhas(const Value: Integer);
begin
  FEspacoEntreLinhas := Value;
end;

procedure TCaminhoImpressora.SetModelo(const Value: Integer);
begin
  FModelo := Value;
end;

procedure TCaminhoImpressora.SetPaginaCodigo(const Value: Integer);
begin
  FPaginaCodigo := Value;
end;

procedure TCaminhoImpressora.SetParametroString(const Value: String);
begin
  FParametroString := Value;
end;

procedure TCaminhoImpressora.SetPorta(const Value: String);
begin
  FPorta := Value;
end;

end.
