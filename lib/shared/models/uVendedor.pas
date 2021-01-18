unit uVendedor;

interface

uses
  System.SysUtils, uEmpresa;

type
{$TYPEINFO ON}
  TVendedor = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FNome: String;
    FAtivo: Boolean;
    FEmpresa: TEmpresa;
    procedure SetAtivo(const Value: Boolean);
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetEmpresa(const Value: TEmpresa);
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
    property Ativo: Boolean read FAtivo write SetAtivo;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
  end;

implementation

{ TVendedor }

procedure TVendedor.Clear;
begin
  FCodigo := 0;
  FNome := '';
  FAtivo := false;
  FreeAndNil(FEmpresa);
end;

constructor TVendedor.Create;
begin
  FEmpresa := TEmpresa.Create;
end;

destructor TVendedor.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TVendedor.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TVendedor.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TVendedor.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TVendedor.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
