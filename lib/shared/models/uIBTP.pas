unit uIBTP;

interface

type
{$TYPEINFO ON}
  TIBTP = class(TObject)
  private
    FAliquotaNacional: Currency;
    FAliquotaImportado: Currency;
    FAliquotaEstadual: Currency;
    FAliquotaMunicipal: Currency;
    procedure SetAliquotaEstadual(const Value: Currency);
    procedure SetAliquotaImportado(const Value: Currency);
    procedure SetAliquotaNacional(const Value: Currency);
    procedure SetAliquotaMunicipal(const Value: Currency);
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
    property AliquotaNacional: Currency read FAliquotaNacional
      write SetAliquotaNacional;
    property AliquotaImportado: Currency read FAliquotaImportado
      write SetAliquotaImportado;
    property AliquotaEstadual: Currency read FAliquotaEstadual
      write SetAliquotaEstadual;
    property AliquotaMunicipal: Currency read FAliquotaMunicipal
      write SetAliquotaMunicipal;

  end;

implementation

{ TIBTP }

procedure TIBTP.Clear;
begin
  FAliquotaNacional := 0;
  FAliquotaImportado := 0;
  FAliquotaEstadual := 0;
  FAliquotaMunicipal := 0;
end;

constructor TIBTP.Create;
begin
  Clear;
end;

destructor TIBTP.Destroy;
begin
  inherited;
  Clear;
end;

procedure TIBTP.SetAliquotaEstadual(const Value: Currency);
begin
  FAliquotaEstadual := Value;
end;

procedure TIBTP.SetAliquotaImportado(const Value: Currency);
begin
  FAliquotaImportado := Value;
end;

procedure TIBTP.SetAliquotaMunicipal(const Value: Currency);
begin
  FAliquotaMunicipal := Value;
end;

procedure TIBTP.SetAliquotaNacional(const Value: Currency);
begin
  FAliquotaNacional := Value;
end;

end.
