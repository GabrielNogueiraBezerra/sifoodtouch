unit uPagamentoPOSView;

interface

uses
  uPos, FMX.Objects, FMX.StdCtrls, FMX.Effects;

type
{$TYPEINFO ON}
  TPagamentoPOSView = class(TObject)
  private
    FRetangulo: TRectangle;
    FValor: Currency;
    FNomePOS: TLabel;
    FPOS: TPos;
    FSelecionado: Boolean;
    FSelecao: TShadowEffect;
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetNomePOS(const Value: TLabel);
    procedure SetPOS(const Value: TPos);
    procedure SetValor(const Value: Currency);
    procedure SetSelecao(const Value: TShadowEffect);
    procedure SetSelecionado(const Value: Boolean);
    procedure CriaNomePOS;
    procedure CriaSelecao;
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce; overload;
    constructor Create(Retangulo: TRectangle; POS: TPos); reintroduce; overload;
  published
    { published declarations }
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
    property POS: TPos read FPOS write SetPOS;
    property NomePOS: TLabel read FNomePOS write SetNomePOS;
    property Valor: Currency read FValor write SetValor;
    property Selecionado: Boolean read FSelecionado write SetSelecionado;
    property Selecao: TShadowEffect read FSelecao write SetSelecao;
  end;

implementation

uses
  FMX.Types, Vcl.Graphics;

{ TPagamentoPOSView }

constructor TPagamentoPOSView.Create;
begin

end;

constructor TPagamentoPOSView.Create(Retangulo: TRectangle; POS: TPos);
begin
  if (Assigned(Retangulo) and (Assigned(POS))) then
  begin
    FRetangulo := Retangulo;
    FPOS := POS;

    CriaNomePOS;
    CriaSelecao;
  end;
end;

procedure TPagamentoPOSView.CriaNomePOS;
begin
  FNomePOS := TLabel.Create(FRetangulo);
  FNomePOS.Parent := FRetangulo;
  FNomePOS.Align := TAlignLayout.Client;
  FNomePOS.Text := POS.Nome;
  FNomePOS.StyledSettings := [];
  FNomePOS.TextSettings.Font.Family := TFontName('Tahoma');
  FNomePOS.TextSettings.Font.Size := 13;
  FNomePOS.TextSettings.HorzAlign := TTextAlign.Center;
  FNomePOS.TextSettings.WordWrap := True;
end;

procedure TPagamentoPOSView.CriaSelecao;
begin
  FSelecao := TShadowEffect.Create(FRetangulo);
  FSelecao.Opacity := 0;
  FSelecao.Softness := 0;
  FSelecao.Parent := FRetangulo;
end;

procedure TPagamentoPOSView.SetNomePOS(const Value: TLabel);
begin
  FNomePOS := Value;
end;

procedure TPagamentoPOSView.SetPOS(const Value: TPos);
begin
  FPOS := Value;
end;

procedure TPagamentoPOSView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TPagamentoPOSView.SetSelecao(const Value: TShadowEffect);
begin
  FSelecao := Value;
end;

procedure TPagamentoPOSView.SetSelecionado(const Value: Boolean);
begin
  FSelecionado := Value;
end;

procedure TPagamentoPOSView.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
