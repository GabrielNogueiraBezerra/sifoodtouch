unit uItemContaClienteView;

interface

uses
  FMX.Objects, uItemContaCliente, FMX.StdCtrls, uDmConexao;

type
{$TYPEINFO ON}
  TItemContaClienteView = class(TObject)
  private
    { private declarations }
    FRetangulo: TRectangle;
    FItemContaCliente: TItemContaCliente;
    FLinha: TLine;
    FRetanguloOrdem: TRectangle;
    FLabelOrdem: TLabel;
    FLinhaOrdem: TLine;
    FRetanguloDescricaoProduto: TRectangle;
    FLabelDescricaoProduto: TLabel;
    FLinhaDescricaoProduto: TLine;
    FRetanguloTotal: TRectangle;
    FLabelTotal: TLabel;
    FLinhaTotal: TLine;
    FRetanguloAcao: TRectangle;
    FBotaoAcao: Tbutton;
    FLinhaAcao: TLine;
    FImagemAcao: TImage;
    procedure SetBotaoAcao(const Value: Tbutton);
    procedure SetLabelDescricaoProduto(const Value: TLabel);
    procedure SetLabelOrdem(const Value: TLabel);
    procedure SetLabelTotal(const Value: TLabel);
    procedure SetLinha(const Value: TLine);
    procedure SetLinhaDescricaoProduto(const Value: TLine);
    procedure SetLinhaOrdem(const Value: TLine);
    procedure SetLinhaTotal(const Value: TLine);
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetRetanguloAcao(const Value: TRectangle);
    procedure SetRetanguloDescricaoProduto(const Value: TRectangle);
    procedure SetRetanguloOrdem(const Value: TRectangle);
    procedure SetRetanguloTotal(const Value: TRectangle);
    procedure SetLinhaAcao(const Value: TLine);
    procedure criaComponents;
    procedure criaLinha;
    procedure criaRetanguloOrdem;
    procedure criaLabelOrdem;
    procedure criaLinhaOrdem;
    procedure criaRetanguloDescricaoProduto;
    procedure criaLabelDescricaoProduto;
    procedure criaLinhaDescricaoProduto;
    procedure criaRetanguloTotal;
    procedure criaLabelTotal;
    procedure criaLinhaTotal;
    procedure criaRetanguloAcao;
    procedure criaBotaoAcao;
    procedure criaLinhaAcao;
    procedure ordenaInformacoes;

  class var
    FTamanhoWidth: Single;
    FPosicaoUltimo: Single;
    procedure SetItemContaCliente(const Value: TItemContaCliente);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce; overload;
    constructor Create(Retangulo: TRectangle;
      ItemContaCliente: TItemContaCliente); reintroduce; overload;
    procedure Impresso;
    procedure CancelaItem;
  published
    { published declarations }
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
    property Linha: TLine read FLinha write SetLinha;
    property RetanguloOrdem: TRectangle read FRetanguloOrdem
      write SetRetanguloOrdem;
    property LabelOrdem: TLabel read FLabelOrdem write SetLabelOrdem;
    property LinhaOrdem: TLine read FLinhaOrdem write SetLinhaOrdem;
    property RetanguloDescricaoProduto: TRectangle
      read FRetanguloDescricaoProduto write SetRetanguloDescricaoProduto;
    property LabelDescricaoProduto: TLabel read FLabelDescricaoProduto
      write SetLabelDescricaoProduto;
    property LinhaDescricaoProduto: TLine read FLinhaDescricaoProduto
      write SetLinhaDescricaoProduto;
    property RetanguloTotal: TRectangle read FRetanguloTotal
      write SetRetanguloTotal;
    property LabelTotal: TLabel read FLabelTotal write SetLabelTotal;
    property LinhaTotal: TLine read FLinhaTotal write SetLinhaTotal;
    property RetanguloAcao: TRectangle read FRetanguloAcao
      write SetRetanguloAcao;
    property BotaoAcao: Tbutton read FBotaoAcao write SetBotaoAcao;
    property LinhaAcao: TLine read FLinhaAcao write SetLinhaAcao;
    property ItemContaCliente: TItemContaCliente read FItemContaCliente
      write SetItemContaCliente;
  end;

implementation

uses
  FMX.Types, System.UITypes, System.SysUtils, Vcl.Graphics, FMX.Layouts,
  uComprovante;

{ TItemContaClienteView }

procedure TItemContaClienteView.CancelaItem;
begin
  if ItemContaCliente.Cancelado = 1 then
  begin
    FLabelTotal.TextSettings.FontColor := TAlphaColors.Red;
    FLabelDescricaoProduto.TextSettings.FontColor := TAlphaColors.Red;
    FLabelOrdem.TextSettings.FontColor := TAlphaColors.Red;
    FBotaoAcao := nil;
    FImagemAcao.OnClick := nil;
  end;
end;

constructor TItemContaClienteView.Create(Retangulo: TRectangle;
  ItemContaCliente: TItemContaCliente);
begin
  if (Assigned(Retangulo)) and (Assigned(ItemContaCliente)) then
  begin
    FRetangulo := Retangulo;
    FItemContaCliente := ItemContaCliente;

    if FTamanhoWidth = 0 then
      FTamanhoWidth := TVertScrollBox(FRetangulo.parent).width - 2;

    FRetangulo.Position.Y := FPosicaoUltimo;

    FRetangulo.Align := TAlignLayout.Top;

    FPosicaoUltimo := FPosicaoUltimo + 40;

    criaComponents;

    Retangulo.OnClick := nil;

    ordenaInformacoes;
  end;
end;

procedure TItemContaClienteView.criaBotaoAcao;
begin

  try
    FImagemAcao := TImage.Create(FRetanguloAcao);
    FImagemAcao.Align := TAlignLayout.Client;
    if not FImagemAcao.MultiResBitmap.Items[FImagemAcao.MultiResBitmap.Count -
      1].Bitmap.isempty then
      FImagemAcao.MultiResBitmap.Add;

    FImagemAcao.MultiResBitmap.Items[FImagemAcao.MultiResBitmap.Count - 1]
      .Bitmap.loadfromfile(Dmconexao.Configuracao.LocalAplicacao +
      '/assets/images/0011.png');
    FImagemAcao.WrapMode := TImageWrapMode.Center;
    FImagemAcao.Margins.Bottom := 1;
    FImagemAcao.Margins.Left := 1;
    FImagemAcao.Margins.Right := 1;
    FImagemAcao.Margins.Top := 1;
    FImagemAcao.Tag := FItemContaCliente.Ordem;
    FImagemAcao.parent := FRetanguloAcao;
    if ItemContaCliente.Cancelado <> 1 then
      FImagemAcao.OnClick := Retangulo.OnClick;
    FImagemAcao.Tag := Retangulo.Tag;
  except
    FBotaoAcao := Tbutton.Create(FRetanguloAcao);
    FBotaoAcao.parent := FRetanguloAcao;
    FBotaoAcao.Text := 'INFO';
    FBotaoAcao.Align := TAlignLayout.Client;
    FBotaoAcao.Margins.Left := 1;
    FBotaoAcao.Margins.Top := 1;
    FBotaoAcao.Margins.Bottom := 1;
    FBotaoAcao.Margins.Right := 1;
    FBotaoAcao.StyledSettings := [];
    FBotaoAcao.TextSettings.FontColor := TAlphaColors.Black;
    if ItemContaCliente.Cancelado <> 1 then
      FBotaoAcao.OnClick := Retangulo.OnClick;
    FBotaoAcao.Tag := Retangulo.Tag;
  end;
end;

procedure TItemContaClienteView.criaComponents;
begin

  criaLinha;
  criaRetanguloOrdem;
  criaLabelOrdem;
  criaLinhaOrdem;
  criaRetanguloDescricaoProduto;
  criaLabelDescricaoProduto;
  criaLinhaDescricaoProduto;
  criaRetanguloTotal;
  criaLabelTotal;
  criaLinhaTotal;
  criaRetanguloAcao;
  criaBotaoAcao;

end;

procedure TItemContaClienteView.criaLabelDescricaoProduto;
begin
  FLabelDescricaoProduto := TLabel.Create(FRetanguloDescricaoProduto);
  FLabelDescricaoProduto.parent := FRetanguloDescricaoProduto;
  FLabelDescricaoProduto.Align := TAlignLayout.Client;
  FLabelDescricaoProduto.Margins.Left := 5;
  FLabelDescricaoProduto.StyledSettings := [];
  FLabelDescricaoProduto.Text := FItemContaCliente.Produto.DescricaoCupom;
  FLabelDescricaoProduto.TextSettings.HorzAlign := TTextAlign.Center;
  FLabelDescricaoProduto.TextSettings.Font.Style := [TFontStyle.fsBold];

  if FItemContaCliente.Cancelado = 1 then
    FLabelDescricaoProduto.TextSettings.FontColor := TAlphaColors.Red
  else if FItemContaCliente.Impresso = 'S' then
    FLabelDescricaoProduto.TextSettings.FontColor := TAlphaColors.Blue
  else
    FLabelDescricaoProduto.TextSettings.FontColor := TAlphaColors.Black;
end;

procedure TItemContaClienteView.criaLabelOrdem;
begin
  FLabelOrdem := TLabel.Create(FRetanguloOrdem);
  FLabelOrdem.parent := FRetanguloOrdem;
  FLabelOrdem.Align := TAlignLayout.Client;
  FLabelOrdem.StyledSettings := [];
  if FItemContaCliente.Ordem < 10 then
    FLabelOrdem.Text := TComprovante.FormataStringD
      (IntToStr(FItemContaCliente.Ordem), '2', '0')
  else
    FLabelOrdem.Text := CurrToStr(FItemContaCliente.Ordem);
  FLabelOrdem.TextSettings.HorzAlign := TTextAlign.Center;
  FLabelOrdem.TextSettings.Font.Style := [TFontStyle.fsBold];

  if FItemContaCliente.Cancelado = 1 then
    FLabelOrdem.TextSettings.FontColor := TAlphaColors.Red
  else if FItemContaCliente.Impresso = 'S' then
    FLabelOrdem.TextSettings.FontColor := TAlphaColors.Blue
  else
    FLabelOrdem.TextSettings.FontColor := TAlphaColors.Black;
end;

procedure TItemContaClienteView.criaLabelTotal;
begin
  FLabelTotal := TLabel.Create(FRetanguloTotal);
  FLabelTotal.parent := FRetanguloTotal;
  FLabelTotal.Align := TAlignLayout.Client;
  FLabelTotal.StyledSettings := [];
  FLabelTotal.Text := 'R$ ' + formatfloat('#,##0.00',
    FItemContaCliente.TotalItem);
  FLabelTotal.TextSettings.HorzAlign := TTextAlign.Center;
  FLabelTotal.TextSettings.Font.Style := [TFontStyle.fsBold];

  if FItemContaCliente.Cancelado = 1 then
    FLabelTotal.TextSettings.FontColor := TAlphaColors.Red
  else if FItemContaCliente.Impresso = 'S' then
    FLabelTotal.TextSettings.FontColor := TAlphaColors.Blue
  else
    FLabelTotal.TextSettings.FontColor := TAlphaColors.Black;
end;

procedure TItemContaClienteView.criaLinha;
begin
  FLinha := TLine.Create(FRetangulo);
  FLinha.parent := FRetangulo;
  FLinha.Align := TAlignLayout.Bottom;
  FLinha.Height := 1;
  FLinha.Stroke.Color := TAlphaColors.Black;
end;

procedure TItemContaClienteView.criaLinhaAcao;
begin
  FLinhaAcao := TLine.Create(FRetanguloAcao);
  FLinhaAcao.parent := FRetanguloAcao;
  FLinhaAcao.Align := TAlignLayout.Right;
  FLinhaAcao.width := 1;
  FLinhaAcao.Stroke.Color := TAlphaColors.Black;
end;

procedure TItemContaClienteView.criaLinhaDescricaoProduto;
begin
  FLinhaDescricaoProduto := TLine.Create(FRetanguloDescricaoProduto);
  FLinhaDescricaoProduto.parent := FRetanguloDescricaoProduto;
  FLinhaDescricaoProduto.Align := TAlignLayout.Right;
  FLinhaDescricaoProduto.width := 1;
  FLinhaDescricaoProduto.Stroke.Color := TAlphaColors.Black;
end;

procedure TItemContaClienteView.criaLinhaOrdem;
begin
  FLinhaOrdem := TLine.Create(FRetanguloOrdem);
  FLinhaOrdem.parent := FRetanguloOrdem;
  FLinhaOrdem.Align := TAlignLayout.Right;
  FLinhaOrdem.width := 1;
  FLinhaOrdem.Stroke.Color := TAlphaColors.Black;
end;

procedure TItemContaClienteView.criaLinhaTotal;
begin
  FLinhaTotal := TLine.Create(FRetanguloTotal);
  FLinhaTotal.parent := FRetanguloTotal;
  FLinhaTotal.Align := TAlignLayout.Right;
  FLinhaTotal.width := 1;
  FLinhaTotal.Stroke.Color := TAlphaColors.Black;
end;

procedure TItemContaClienteView.criaRetanguloAcao;
begin
  FRetanguloAcao := TRectangle.Create(FRetangulo);
  FRetanguloAcao.parent := FRetangulo;
  FRetanguloAcao.Align := TAlignLayout.Left;
  FRetanguloAcao.Fill.Color := TAlphaColors.White;
  FRetanguloAcao.Stroke.Color := TAlphaColors.White;
  FRetanguloAcao.width := 80;
end;

procedure TItemContaClienteView.criaRetanguloDescricaoProduto;
begin
  FRetanguloDescricaoProduto := TRectangle.Create(FRetangulo);
  FRetanguloDescricaoProduto.parent := FRetangulo;
  FRetanguloDescricaoProduto.Align := TAlignLayout.Left;
  FRetanguloDescricaoProduto.Fill.Color := TAlphaColors.White;
  FRetanguloDescricaoProduto.Stroke.Color := TAlphaColors.White;
  FRetanguloDescricaoProduto.width := 294;
end;

procedure TItemContaClienteView.criaRetanguloOrdem;
begin
  FRetanguloOrdem := TRectangle.Create(FRetangulo);
  FRetanguloOrdem.parent := FRetangulo;
  FRetanguloOrdem.Align := TAlignLayout.Left;
  FRetanguloOrdem.Fill.Color := TAlphaColors.White;
  FRetanguloOrdem.Stroke.Color := TAlphaColors.White;
  FRetanguloOrdem.width := 35;
end;

procedure TItemContaClienteView.criaRetanguloTotal;
begin
  FRetanguloTotal := TRectangle.Create(FRetangulo);
  FRetanguloTotal.parent := FRetangulo;
  FRetanguloTotal.Align := TAlignLayout.Left;
  FRetanguloTotal.Fill.Color := TAlphaColors.White;
  FRetanguloTotal.Stroke.Color := TAlphaColors.White;
  FRetanguloTotal.width := 88;
end;

procedure TItemContaClienteView.Impresso;
begin
  if ItemContaCliente.Cancelado = 0 then
  begin
    FLabelTotal.TextSettings.FontColor := TAlphaColors.Blue;
    FLabelDescricaoProduto.TextSettings.FontColor := TAlphaColors.Blue;
    FLabelOrdem.TextSettings.FontColor := TAlphaColors.Blue;
  end;
end;

procedure TItemContaClienteView.ordenaInformacoes;
begin
  FRetanguloDescricaoProduto.width := FTamanhoWidth -
    (FRetanguloOrdem.width + FRetanguloTotal.width + FRetanguloAcao.width);

  FRetanguloOrdem.Align := TAlignLayout.Right;
  FRetanguloDescricaoProduto.Align := TAlignLayout.Right;
  FRetanguloTotal.Align := TAlignLayout.Right;
  FRetanguloAcao.Align := TAlignLayout.Right;

  FRetanguloOrdem.Align := TAlignLayout.Left;
  FRetanguloDescricaoProduto.Align := TAlignLayout.Left;
  FRetanguloTotal.Align := TAlignLayout.Left;
  FRetanguloAcao.Align := TAlignLayout.Left;
end;

constructor TItemContaClienteView.Create;
begin

end;

procedure TItemContaClienteView.SetBotaoAcao(const Value: Tbutton);
begin
  FBotaoAcao := Value;
end;

procedure TItemContaClienteView.SetItemContaCliente
  (const Value: TItemContaCliente);
begin
  FItemContaCliente := Value;
end;

procedure TItemContaClienteView.SetLabelDescricaoProduto(const Value: TLabel);
begin
  FLabelDescricaoProduto := Value;
end;

procedure TItemContaClienteView.SetLabelOrdem(const Value: TLabel);
begin
  FLabelOrdem := Value;
end;

procedure TItemContaClienteView.SetLabelTotal(const Value: TLabel);
begin
  FLabelTotal := Value;
end;

procedure TItemContaClienteView.SetLinha(const Value: TLine);
begin
  FLinha := Value;
end;

procedure TItemContaClienteView.SetLinhaAcao(const Value: TLine);
begin
  FLinhaAcao := Value;
end;

procedure TItemContaClienteView.SetLinhaDescricaoProduto(const Value: TLine);
begin
  FLinhaDescricaoProduto := Value;
end;

procedure TItemContaClienteView.SetLinhaOrdem(const Value: TLine);
begin
  FLinhaOrdem := Value;
end;

procedure TItemContaClienteView.SetLinhaTotal(const Value: TLine);
begin
  FLinhaTotal := Value;
end;

procedure TItemContaClienteView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TItemContaClienteView.SetRetanguloAcao(const Value: TRectangle);
begin
  FRetanguloAcao := Value;
end;

procedure TItemContaClienteView.SetRetanguloDescricaoProduto
  (const Value: TRectangle);
begin
  FRetanguloDescricaoProduto := Value;
end;

procedure TItemContaClienteView.SetRetanguloOrdem(const Value: TRectangle);
begin
  FRetanguloOrdem := Value;
end;

procedure TItemContaClienteView.SetRetanguloTotal(const Value: TRectangle);
begin
  FRetanguloTotal := Value;
end;

end.
