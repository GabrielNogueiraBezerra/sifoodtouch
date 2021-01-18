unit uEstoque;

interface

uses
  uEmpresa, uLocalEstoque;

type
{$TYPEINFO ON}
  TEstoque = class(TObject)
  private
    FLocalEstoque: TLocalEstoque;
    FEstoque: Currency;
    FEmpresa: TEmpresa;
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetEstoque(const Value: Currency);
    procedure SetLocalEstoque(const Value: TLocalEstoque);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;
  published
    { published declarations }
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property Estoque: Currency read FEstoque write SetEstoque;
    property LocalEstoque: TLocalEstoque read FLocalEstoque
      write SetLocalEstoque;

  end;

implementation

uses
  System.SysUtils;

{ TEstoque }

procedure TEstoque.Clear;
begin
  FreeAndNil(FEmpresa);
  FreeAndNil(FLocalEstoque);
  FEstoque := 0;
end;

constructor TEstoque.Create;
begin
  Clear;

  FEmpresa := TEmpresa.Create;
  FLocalEstoque := TLocalEstoque.Create;
end;

destructor TEstoque.Destroy;
begin

  inherited;
end;

procedure TEstoque.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TEstoque.SetEstoque(const Value: Currency);
begin
  FEstoque := Value;
end;

procedure TEstoque.SetLocalEstoque(const Value: TLocalEstoque);
begin
  FLocalEstoque := Value;
end;

end.
