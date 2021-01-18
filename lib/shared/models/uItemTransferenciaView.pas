unit uItemTransferenciaView;

interface

uses
  uItemContaCliente, FMX.StdCtrls, FMX.Objects;

type
{$TYPEINFO ON}
  TItemTransferenciaView = class(TObject)
  private
    { private declarations }
    FRetangulo: TRectangle;
    FRetanguloCheckBox: TRectangle;
    FRetanguloSelecaoCheckBox: TRectangle;
    FSelecionado: Boolean;
    FOrdemItem: TLabel;
    FDescricaoProduto: TLabel;
    FDescricaoGarcom: TLabel;
    FLinhaSeparacao: TLine;
    FItemContaCliente: TItemContaCliente;
    FQuantidadeSelecionada: Currency;
    constructor Create; overload;
    procedure criaRetanguloCheckBox;
    procedure criaRetanguloSelecaoCheckBox;
    procedure criaOrdemItem;
    procedure criaDescricaoProduto;
    procedure criaDescricaoGarcom;
    procedure criaLinhaSeparacao;
    procedure SetDescricaoGarcom(const Value: TLabel);
    procedure SetDescricaoProduto(const Value: TLabel);
    procedure SetItemContaCliente(const Value: TItemContaCliente);
    procedure SetLinhaSeparacao(const Value: TLine);
    procedure SetOrdemItem(const Value: TLabel);
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetRetanguloCheckBox(const Value: TRectangle);
    procedure SetRetanguloSelecaoCheckBox(const Value: TRectangle);
    procedure SetSelecionado(const Value: Boolean);
    procedure SetQuantidadeSelecionada(const Value: Currency);

  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(ItemContaCliente: TItemContaCliente;
      Retangulo: TRectangle); reintroduce; overload;
    procedure selecao;
  published
    { published declarations }
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
    property RetanguloCheckBox: TRectangle read FRetanguloCheckBox
      write SetRetanguloCheckBox;
    property RetanguloSelecaoCheckBox: TRectangle read FRetanguloSelecaoCheckBox
      write SetRetanguloSelecaoCheckBox;
    property Selecionado: Boolean read FSelecionado write SetSelecionado;
    property OrdemItem: TLabel read FOrdemItem write SetOrdemItem;
    property DescricaoProduto: TLabel read FDescricaoProduto
      write SetDescricaoProduto;
    property DescricaoGarcom: TLabel read FDescricaoGarcom
      write SetDescricaoGarcom;
    property LinhaSeparacao: TLine read FLinhaSeparacao write SetLinhaSeparacao;
    property ItemContaCliente: TItemContaCliente read FItemContaCliente
      write SetItemContaCliente;
    property QuantidadeSelecionada: Currency read FQuantidadeSelecionada
      write SetQuantidadeSelecionada;
  end;

implementation

uses
  FMX.Types, System.UITypes, System.SysUtils;

{ TItemTransferenciaView }

constructor TItemTransferenciaView.Create;
begin

end;

constructor TItemTransferenciaView.Create(ItemContaCliente: TItemContaCliente;
  Retangulo: TRectangle);
begin
  if ((Assigned(Retangulo)) and (Assigned((ItemContaCliente)))) then
  begin
    FRetangulo := Retangulo;
    FItemContaCliente := ItemContaCliente;

    criaRetanguloCheckBox;
    criaRetanguloSelecaoCheckBox;
    criaOrdemItem;
    criaDescricaoProduto;
    criaDescricaoGarcom;
    FSelecionado := False;
    criaLinhaSeparacao;
  end;
end;

procedure TItemTransferenciaView.criaDescricaoGarcom;
begin
  FDescricaoGarcom := TLabel.Create(Retangulo);
  FDescricaoGarcom.Parent := FRetangulo;
  FDescricaoGarcom.Position.X := 324;
  FDescricaoGarcom.Position.Y := 16;
  FDescricaoGarcom.Height := 17;
  FDescricaoGarcom.Width := 211;
  FDescricaoGarcom.StyledSettings := [];
  FDescricaoGarcom.Text := FItemContaCliente.Garcom.Nome;
  FDescricaoGarcom.OnDblClick := Retangulo.OnDblClick;
  FDescricaoGarcom.Tag := Retangulo.Tag;
end;

procedure TItemTransferenciaView.criaDescricaoProduto;
begin
  FDescricaoProduto := TLabel.Create(Retangulo);
  FDescricaoProduto.Parent := FRetangulo;
  FDescricaoProduto.Position.X := 102;
  FDescricaoProduto.Position.Y := 16;
  FDescricaoProduto.Height := 17;
  FDescricaoProduto.Width := 211;
  FDescricaoProduto.StyledSettings := [];
  FDescricaoProduto.Text := FItemContaCliente.Produto.DescricaoCupom;
  FDescricaoProduto.OnDblClick := Retangulo.OnDblClick;
  FDescricaoProduto.Tag := Retangulo.Tag;
end;

procedure TItemTransferenciaView.criaLinhaSeparacao;
begin
  FLinhaSeparacao := TLine.Create(FRetangulo);
  FLinhaSeparacao.Align := TAlignLayout.Bottom;
  FLinhaSeparacao.Parent := Retangulo;
  FLinhaSeparacao.Height := 1;
  FLinhaSeparacao.OnDblClick := Retangulo.OnDblClick;
  FLinhaSeparacao.Tag := Retangulo.Tag;
end;

procedure TItemTransferenciaView.criaOrdemItem;
begin
  FOrdemItem := TLabel.Create(Retangulo);
  FOrdemItem.Parent := FRetangulo;
  FOrdemItem.Position.X := 52;
  FOrdemItem.Position.Y := 16;
  FOrdemItem.Height := 17;
  FOrdemItem.Width := 43;
  FOrdemItem.StyledSettings := [];
  FOrdemItem.TextSettings.HorzAlign := TTextAlign.Center;
  FOrdemItem.Text := IntToStr(FItemContaCliente.Ordem);
  FOrdemItem.OnDblClick := Retangulo.OnDblClick;
  FOrdemItem.Tag := Retangulo.Tag;
end;

procedure TItemTransferenciaView.criaRetanguloCheckBox;
begin
  FRetanguloCheckBox := TRectangle.Create(Retangulo);
  FRetanguloCheckBox.Parent := Retangulo;
  FRetanguloCheckBox.Fill.Color := TAlphaColors.White;
  FRetanguloCheckBox.Height := 35;
  FRetanguloCheckBox.Width := 35;
  FRetanguloCheckBox.Position.X := 8;
  FRetanguloCheckBox.Position.Y := 8;
  FRetanguloCheckBox.Stroke.Color := TAlphaColors.Black;
  FRetanguloCheckBox.OnDblClick := Retangulo.OnDblClick;
  FRetanguloCheckBox.Tag := Retangulo.Tag;
end;

procedure TItemTransferenciaView.criaRetanguloSelecaoCheckBox;
begin
  FRetanguloSelecaoCheckBox := TRectangle.Create(FRetanguloCheckBox);
  FRetanguloSelecaoCheckBox.Parent := FRetanguloCheckBox;
  FRetanguloSelecaoCheckBox.Fill.Color := TAlphaColors.White;
  FRetanguloSelecaoCheckBox.Height := 25;
  FRetanguloSelecaoCheckBox.Width := 25;
  FRetanguloSelecaoCheckBox.Position.X := 5;
  FRetanguloSelecaoCheckBox.Position.Y := 5;
  FRetanguloSelecaoCheckBox.Stroke.Color := TAlphaColors.White;
  FRetanguloSelecaoCheckBox.Align := TAlignLayout.Center;
  FRetanguloSelecaoCheckBox.OnDblClick := Retangulo.OnDblClick;
  FRetanguloSelecaoCheckBox.Tag := Retangulo.Tag;
end;

procedure TItemTransferenciaView.selecao;
begin
  if FSelecionado then
  begin
    FSelecionado := False;
    FRetanguloSelecaoCheckBox.Fill.Color := TAlphaColors.White;
    FRetanguloSelecaoCheckBox.Stroke.Color := TAlphaColors.White;
  end
  else
  begin
    FSelecionado := True;
    FRetanguloSelecaoCheckBox.Fill.Color := TAlphaColors.Black;
    FRetanguloSelecaoCheckBox.Stroke.Color := TAlphaColors.Black;
  end;
end;

procedure TItemTransferenciaView.SetDescricaoGarcom(const Value: TLabel);
begin
  FDescricaoGarcom := Value;
end;

procedure TItemTransferenciaView.SetDescricaoProduto(const Value: TLabel);
begin
  FDescricaoProduto := Value;
end;

procedure TItemTransferenciaView.SetItemContaCliente
  (const Value: TItemContaCliente);
begin
  FItemContaCliente := Value;
end;

procedure TItemTransferenciaView.SetLinhaSeparacao(const Value: TLine);
begin
  FLinhaSeparacao := Value;
end;

procedure TItemTransferenciaView.SetOrdemItem(const Value: TLabel);
begin
  FOrdemItem := Value;
end;

procedure TItemTransferenciaView.SetQuantidadeSelecionada(
  const Value: Currency);
begin
  FQuantidadeSelecionada := Value;
end;

procedure TItemTransferenciaView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TItemTransferenciaView.SetRetanguloCheckBox(const Value: TRectangle);
begin
  FRetanguloCheckBox := Value;
end;

procedure TItemTransferenciaView.SetRetanguloSelecaoCheckBox
  (const Value: TRectangle);
begin
  FRetanguloSelecaoCheckBox := Value;
end;

procedure TItemTransferenciaView.SetSelecionado(const Value: Boolean);
begin
  FSelecionado := Value;
end;

end.
