unit uGrupoIcms;

interface

uses
  uClass;

type
{$TYPEINFO ON}
  TGrupoIcms = class(TObject)
  private
    FDescricao: String;
    FCodigo: Integer;
    FAliquota: Currency;
    FOrigem: Integer;
    FTipoIcmsServico: TTipoIcmsServico;
    FCSTCSOSN: String;
    procedure SetAliquota(const Value: Currency);
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetOrigem(const Value: Integer);
    procedure SetTipoIcmsServico(const Value: TTipoIcmsServico);
    procedure SetCSTCSOSN(const Value: String);
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
    property Descricao: String read FDescricao write SetDescricao;
    property Aliquota: Currency read FAliquota write SetAliquota;
    property Origem: Integer read FOrigem write SetOrigem;
    property TipoIcmsServico: TTipoIcmsServico read FTipoIcmsServico
      write SetTipoIcmsServico;
    property CSTCSOSN: String read FCSTCSOSN write SetCSTCSOSN;

  end;

implementation

{ TGrupoIcms }

procedure TGrupoIcms.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FAliquota := 0;
  FOrigem := 0;
  FCSTCSOSN := '';
end;

constructor TGrupoIcms.Create;
begin
  Clear;
end;

destructor TGrupoIcms.Destroy;
begin
  inherited;
  Clear;
end;

procedure TGrupoIcms.SetAliquota(const Value: Currency);
begin
  FAliquota := Value;
end;

procedure TGrupoIcms.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TGrupoIcms.SetCSTCSOSN(const Value: String);
begin
  FCSTCSOSN := Value;
end;

procedure TGrupoIcms.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TGrupoIcms.SetOrigem(const Value: Integer);
begin
  FOrigem := Value;
end;

procedure TGrupoIcms.SetTipoIcmsServico(const Value: TTipoIcmsServico);
begin
  FTipoIcmsServico := Value;
end;

end.
