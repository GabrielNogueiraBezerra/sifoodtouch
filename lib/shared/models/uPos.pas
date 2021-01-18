unit uPos;

interface

uses
  uAdministradoraCartao;

type
{$TYPEINFO ON}
  TPos = class(TObject)
  private
    FAdministradoraCartao: TAdministradoraCartao;
    FCodigo: Integer;
    FSerial: String;
    FNome: String;
    { TOTAL INFORMADO NO POS }
    FTotal: Currency;
    FIdPagamento: Integer;
    procedure SetAdministradoraCartao(const Value: TAdministradoraCartao);
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetSerial(const Value: String);
    procedure SetTotal(const Value: Currency);
    procedure SetIdPagamento(const Value: Integer);
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
    property Codigo: Integer read FCodigo write SetCodigo;
    property Nome: String read FNome write SetNome;
    property Serial: String read FSerial write SetSerial;
    property AdministradoraCartao: TAdministradoraCartao
      read FAdministradoraCartao write SetAdministradoraCartao;
    property Total: Currency read FTotal write SetTotal;
    property IdPagamento: Integer read FIdPagamento Write SetIdPagamento;

  end;

implementation

uses
  System.SysUtils;

{ TPos }

procedure TPos.Clear;
begin
  FCodigo := 0;
  FNome := '';
  FSerial := '';
  FreeAndNil(FAdministradoraCartao);
  FTotal := 0;
end;

constructor TPos.Create;
begin
  Clear;
  FAdministradoraCartao := TAdministradoraCartao.Create;
end;

destructor TPos.Destroy;
begin
  inherited;
  Clear;
end;

procedure TPos.SetAdministradoraCartao(const Value: TAdministradoraCartao);
begin
  FAdministradoraCartao := Value;
end;

procedure TPos.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TPos.SetIdPagamento(const Value: Integer);
begin
  FIdPagamento := Value;
end;

procedure TPos.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TPos.SetSerial(const Value: String);
begin
  FSerial := Value;
end;

procedure TPos.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

end.
