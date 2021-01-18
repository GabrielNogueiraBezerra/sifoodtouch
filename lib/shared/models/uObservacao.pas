unit uObservacao;

interface

uses
  uSecao;

type
{$TYPEINFO ON}
  TObservacao = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FDescricao: String;
    FAtivo: Boolean;
    FSecao: TSecao;
    procedure SetAtivo(const Value: Boolean);
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetSecao(const Value: TSecao);
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
    property Secao: TSecao read FSecao write SetSecao;
  end;

implementation

uses
  System.SysUtils;

{ TObservacao }

procedure TObservacao.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FAtivo := false;
  FreeAndNil(FSecao);
end;

constructor TObservacao.Create;
begin
  self.Clear;
  FSecao := TSecao.Create;
end;

destructor TObservacao.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TObservacao.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TObservacao.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TObservacao.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TObservacao.SetSecao(const Value: TSecao);
begin
  FSecao := Value;
end;

end.
