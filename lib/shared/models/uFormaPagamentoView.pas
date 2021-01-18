unit uFormaPagamentoView;

interface

uses
  uFormaPagamento, FMX.Objects, FMX.StdCtrls, FMX.Effects;

type
{$TYPEINFO ON}
  TFormaPagamentoView = class(TObject)
  private
    { private declarations }
    FNomeFormaPagamento: TLabel;
    FRetangulo: TRectangle;
    FFormaPagamento: TFormaPagamento;
    FSelecionado: Boolean;
    FSelecao: TShadowEffect;
    FValor: Currency;
    procedure SetFormaPagamento(const Value: TFormaPagamento);
    procedure SetNomeFormaPagamento(const Value: TLabel);
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetRetanguloSelecao(const Value: TRectangle);
    procedure SetRetanguloSelecaoCheck(const Value: TRectangle);
    procedure criaNomeFormaPagamento;
    procedure criaSelecao;
    procedure SetSelecionado(const Value: Boolean);
    procedure SetSelecao(const Value: TShadowEffect);
    procedure SetValor(const Value: Currency);

  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(FormaPagamento: TFormaPagamento; Retangulo: TRectangle);
      reintroduce; overload;
    procedure seleciona;
    procedure shadow;
  published
    { published declarations }
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
    property NomeFormaPagamento: TLabel read FNomeFormaPagamento
      write SetNomeFormaPagamento;
    property FormaPagamento: TFormaPagamento read FFormaPagamento
      write SetFormaPagamento;
    property Selecionado: Boolean read FSelecionado write SetSelecionado;
    property Selecao: TShadowEffect read FSelecao write SetSelecao;
    property Valor: Currency read FValor write SetValor;
  end;

implementation

uses
  Vcl.Controls, FMX.Types, System.UITypes;

{ TFormaPagamentoView }

constructor TFormaPagamentoView.Create(FormaPagamento: TFormaPagamento;
  Retangulo: TRectangle);
begin
  if (Assigned(FormaPagamento)) and (Assigned(Retangulo)) then
  begin
    FRetangulo := Retangulo;
    FFormaPagamento := FormaPagamento;
    criaNomeFormaPagamento;
    criaSelecao;
  end;
end;

procedure TFormaPagamentoView.criaNomeFormaPagamento;
begin
  FNomeFormaPagamento := TLabel.Create(FRetangulo);
  FNomeFormaPagamento.Parent := FRetangulo;
  FNomeFormaPagamento.Align := TAlignLayout.Client;
  FNomeFormaPagamento.StyledSettings := [];
  FNomeFormaPagamento.Text := FFormaPagamento.Descricao;
  FNomeFormaPagamento.TextSettings.Font.Family := TFontName('Tahoma');
  FNomeFormaPagamento.TextSettings.HorzAlign := TTextAlign.Center;
  FNomeFormaPagamento.Tag := FRetangulo.Tag;
  FNomeFormaPagamento.OnClick := FRetangulo.OnClick;
end;

procedure TFormaPagamentoView.criaSelecao;
begin
  FSelecao := TShadowEffect.Create(FRetangulo);
  FSelecao.Opacity := 0;
  FSelecao.Softness := 0;
  FSelecao.Parent := FRetangulo;
end;

procedure TFormaPagamentoView.seleciona;
begin
  if FSelecionado then
  begin
    FSelecao.Opacity := 0;
    FSelecao.Softness := 0;
  end
  else
  begin
    FSelecao.Opacity := 1;
    FSelecao.Softness := 0.7;
    FSelecao.ShadowColor := $FF00754D;
  end;

  FSelecionado := not FSelecionado;
end;

procedure TFormaPagamentoView.SetFormaPagamento(const Value: TFormaPagamento);
begin
  FFormaPagamento := Value;
end;

procedure TFormaPagamentoView.SetNomeFormaPagamento(const Value: TLabel);
begin
  FNomeFormaPagamento := Value;
end;

procedure TFormaPagamentoView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TFormaPagamentoView.SetRetanguloSelecao(const Value: TRectangle);
begin

end;

procedure TFormaPagamentoView.SetRetanguloSelecaoCheck(const Value: TRectangle);
begin

end;

procedure TFormaPagamentoView.SetSelecao(const Value: TShadowEffect);
begin
  FSelecao := Value;
end;

procedure TFormaPagamentoView.SetSelecionado(const Value: Boolean);
begin
  FSelecionado := Value;
end;

procedure TFormaPagamentoView.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TFormaPagamentoView.shadow;
begin
  if FSelecionado then
  begin
    FSelecao.Opacity := 0;
    FSelecao.Softness := 0;
  end
  else
  begin
    FSelecao.Opacity := 1;
    FSelecao.Softness := 0.7;
    FSelecao.ShadowColor := $FF00754D;
  end;
end;

end.
