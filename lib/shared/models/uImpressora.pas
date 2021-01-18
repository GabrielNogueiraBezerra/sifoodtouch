unit uImpressora;

interface

uses
  System.Generics.Collections, uCaminhoImpressora;

type
{$TYPEINFO ON}
  TImpressora = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FDescricao: String;
    FCaminhosImpressora: TObjectList<TCaminhoImpressora>;
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetCaminhosImpressora(
      const Value: TObjectList<TCaminhoImpressora>);
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
    property CaminhosImpressora: TObjectList<TCaminhoImpressora>
      read FCaminhosImpressora write SetCaminhosImpressora;
  end;

implementation

uses
  System.SysUtils;

{ TImpressora }

procedure TImpressora.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FreeAndNil(FCaminhosImpressora);
end;

constructor TImpressora.Create;
begin
  FCaminhosImpressora := TObjectList<TCaminhoImpressora>.Create;
end;

destructor TImpressora.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TImpressora.SetCaminhosImpressora(
  const Value: TObjectList<TCaminhoImpressora>);
begin
  FCaminhosImpressora := Value;
end;

procedure TImpressora.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TImpressora.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
