unit uFuncoes;

interface

type
{$TYPEINFO ON}
  TFuncoes = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FNome: String;
    FItemMenu: String;
    procedure SetCodigo(const Value: Integer);
    procedure SetItemMenu(const Value: String);
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
    property ItemMenu: String read FItemMenu write SetItemMenu;
  end;

implementation

{ TFuncoes }

procedure TFuncoes.Clear;
begin
  FCodigo := 0;
  FNome := '';
  FItemMenu := '';
end;

constructor TFuncoes.Create;
begin
  Self.Clear;
end;

destructor TFuncoes.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TFuncoes.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TFuncoes.SetItemMenu(const Value: String);
begin
  FItemMenu := Value;
end;

procedure TFuncoes.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
