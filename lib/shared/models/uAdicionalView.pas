unit uAdicionalView;

interface

uses
  FMX.Objects, uProduto, FMX.StdCtrls, FMX.Effects;

type
{$TYPEINFO ON}
  TAdicionalView = class(TObject)
  private
    { private declarations }
    FNomeProduto: TLabel;
    FSelecaoProduto: TShadowEffect;
    FSelecionado: Boolean;
    FProduto: TProduto;
    FQuantidade: Currency;
    FRetangulo: TRectangle;
    procedure SetNomeProduto(const Value: TLabel);
    procedure SetProduto(const Value: TProduto);
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetSelecaoProduto(const Value: TShadowEffect);
    procedure SetSelecionado(const Value: Boolean);
    procedure criaNomeProduto;
    procedure criaSelecaoProduto;
    procedure SetQuantidade(const Value: Currency);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(Produto: TProduto; Retangulo: TRectangle);
      reintroduce; overload;
    procedure select;
  published
    { published declarations }
    property NomeProduto: TLabel read FNomeProduto write SetNomeProduto;
    property SelecaoProduto: TShadowEffect read FSelecaoProduto
      write SetSelecaoProduto;
    property Selecionado: Boolean read FSelecionado write SetSelecionado;
    property Produto: TProduto read FProduto write SetProduto;
    property Quantidade: Currency read FQuantidade write SetQuantidade;
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
  end;

implementation

uses
  FMX.Types, System.UITypes;

{ TAdicionalView }

constructor TAdicionalView.Create(Produto: TProduto; Retangulo: TRectangle);
begin
  if ((Assigned(Produto)) and (Assigned(Retangulo))) then
  begin
    FProduto := Produto;
    FRetangulo := Retangulo;

    criaNomeProduto;
    criaSelecaoProduto;
  end;
end;

procedure TAdicionalView.criaNomeProduto;
begin
  FNomeProduto := TLabel.Create(FRetangulo);
  FNomeProduto.Parent := FRetangulo;
  FNomeProduto.Align := TAlignLayout.Client;
  FNomeProduto.TextSettings.HorzAlign := TTextAlign.Center;
  FNomeProduto.StyledSettings := [];
  FNomeProduto.Tag := FRetangulo.Tag;
  FNomeProduto.OnDblClick := FRetangulo.OnDblClick;
  FNomeProduto.Text := FProduto.DescricaoCupom;
  FNomeProduto.TextSettings.WordWrap := True;
end;

procedure TAdicionalView.criaSelecaoProduto;
begin
  FSelecaoProduto := TShadowEffect.Create(FRetangulo);
  FSelecaoProduto.Parent := FRetangulo;
  FSelecaoProduto.Opacity := 0;
  FSelecaoProduto.Softness := 0;
  FSelecaoProduto.ShadowColor := TAlphaColors.Blue;
end;

procedure TAdicionalView.select;
begin
  if FSelecionado then
  begin
    FSelecaoProduto.Opacity := 0;
    FSelecaoProduto.Softness := 0;
    FSelecionado := False;
  end
  else
  begin
    FSelecaoProduto.Opacity := 0.6;
    FSelecaoProduto.Softness := 0.4;
    FSelecionado := True;
  end;
end;

procedure TAdicionalView.SetNomeProduto(const Value: TLabel);
begin
  FNomeProduto := Value;
end;

procedure TAdicionalView.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TAdicionalView.SetQuantidade(const Value: Currency);
begin
  FQuantidade := Value;
end;

procedure TAdicionalView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TAdicionalView.SetSelecaoProduto(const Value: TShadowEffect);
begin
  FSelecaoProduto := Value;
end;

procedure TAdicionalView.SetSelecionado(const Value: Boolean);
begin
  FSelecionado := Value;
end;

end.
