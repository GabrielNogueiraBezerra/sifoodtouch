unit uFormaPagamento;

interface

uses
  uClass;

type
{$TYPEINFO ON}
  TFormaPagamento = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FDescricao: String;
    FTipo: String;
    FTipoCartao: TTipoCartao;
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetTipo(const Value: String);
    procedure SetTipoCartao(const Value: TTipoCartao);
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
    property Tipo: String read FTipo write SetTipo;
    property TipoCartao: TTipoCartao read FTipoCartao write SetTipoCartao;
  end;

implementation

{ TFormaPagamento }

procedure TFormaPagamento.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FTipo := '';
  FTipoCartao := opCredito;
end;

constructor TFormaPagamento.Create;
begin
  self.Clear;
end;

destructor TFormaPagamento.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TFormaPagamento.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TFormaPagamento.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TFormaPagamento.SetTipo(const Value: String);
begin
  FTipo := Value;
end;

procedure TFormaPagamento.SetTipoCartao(const Value: TTipoCartao);
begin
  FTipoCartao := Value;
end;

end.
