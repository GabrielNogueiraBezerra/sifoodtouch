unit uProdutoView;

interface

uses
  FMX.StdCtrls, FMX.Objects, uProduto, FMX.Effects, uItemContaCliente;

type
{$TYPEINFO ON}
  TProdutoView = class(TObject)
  private
    { private declarations }
    FImagem: TImage;
    FNomeProduto: TLabel;
    FLocal: TRectangle;
    FProduto: TProduto;
    FSelecao: TShadowEffect;
    FBotaoRemove: TCornerButton;
    FQuantidade: Integer;
    FBotaoAdd: TCornerButton;
    FLQuantidade: TLabel;
    FLocalQuantidade: TRectangle;
    FItemContaCliente: TItemContaCliente;
    procedure SetImagem(const Value: TImage);
    procedure SetNomeProduto(const Value: TLabel);
    procedure SetProduto(const Value: TProduto);
    constructor Create; reintroduce; overload;
    procedure SetLocal(const Value: TRectangle);
    procedure SetSelecao(const Value: TShadowEffect);
    procedure criaImagem;
    procedure criaNomeProduto;
    procedure criaSelecao;
    procedure criaLocalBotoes;
    procedure criaBotaoAdd;
    procedure criaBotaoRemove;
    procedure criaLQuantidade;
    procedure SetBotaoAdd(const Value: TCornerButton);
    procedure SetBotaoRemove(const Value: TCornerButton);
    procedure SetQuantidade(const Value: Integer);
    procedure SetLQuantidade(const Value: TLabel);
    procedure SetLocalQuantidade(const Value: TRectangle);
    procedure onClickBotaoAdd(Sender: TObject);
    procedure onClickBotaoRemove(Sender: TObject);
    procedure SetItemContaCliente(const Value: TItemContaCliente);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(Local: TRectangle; Produto: TProduto; Imagem: TImage;
      NomeProduto: TLabel); reintroduce; overload;
    constructor Create(Local: TRectangle; Produto: TProduto);
      reintroduce; overload;
    constructor Create(Local: TRectangle; Produto: TProduto;
      ItemContaCliente: TItemContaCliente); reintroduce; overload;
    procedure selecionaProduto;
    procedure removeSelecaoProduto;
  published
    { published declarations }
    property Imagem: TImage read FImagem write SetImagem;
    property Local: TRectangle read FLocal write SetLocal;
    property NomeProduto: TLabel read FNomeProduto write SetNomeProduto;
    property Produto: TProduto read FProduto write SetProduto;
    property Selecao: TShadowEffect read FSelecao write SetSelecao;
    property Quantidade: Integer read FQuantidade write SetQuantidade;
    property BotaoAdd: TCornerButton read FBotaoAdd write SetBotaoAdd;
    property BotaoRemove: TCornerButton read FBotaoRemove write SetBotaoRemove;
    property LQuantidade: TLabel read FLQuantidade write SetLQuantidade;
    property LocalQuantidade: TRectangle read FLocalQuantidade
      write SetLocalQuantidade;
    property ItemContaCliente: TItemContaCliente read FItemContaCliente
      write SetItemContaCliente;
  end;

implementation

uses
  FMX.Types, Vcl.Controls, System.SysUtils, System.UITypes;

{ TProdutoView }

constructor TProdutoView.Create;
begin

end;

constructor TProdutoView.Create(Local: TRectangle; Produto: TProduto;
  Imagem: TImage; NomeProduto: TLabel);
begin
  FImagem := Imagem;
  FLocal := Local;
  FProduto := Produto;
  FNomeProduto := NomeProduto;
end;

constructor TProdutoView.Create(Local: TRectangle; Produto: TProduto);
begin
  if Assigned(Local) and Assigned(Produto) then
  begin
    FLocal := Local;
    FProduto := Produto;
    criaImagem;
    criaNomeProduto;
    criaSelecao;
  end;
end;

procedure TProdutoView.criaBotaoAdd;
begin
  FBotaoAdd := TCornerButton.Create(FLocalQuantidade);
  FBotaoAdd.Parent := FLocalQuantidade;
  FBotaoAdd.Text := '+';
  FBotaoAdd.StyledSettings := [];
  FBotaoAdd.Align := TAlignLayout.Right;
  FBotaoAdd.TextSettings.FontColor := TAlphaColors.White;
  FBotaoAdd.Width := 30;
  FBotaoAdd.Margins.Top := 5;
  FBotaoAdd.Margins.Left := 0;
  FBotaoAdd.Margins.Right := 5;
  FBotaoAdd.Margins.Bottom := 5;
  FBotaoAdd.OnClick := onClickBotaoAdd;
end;

procedure TProdutoView.criaBotaoRemove;
begin
  FBotaoRemove := TCornerButton.Create(FLocalQuantidade);
  FBotaoRemove.Parent := FLocalQuantidade;
  FBotaoRemove.Text := '-';
  FBotaoRemove.StyledSettings := [];
  FBotaoRemove.Align := TAlignLayout.Left;
  FBotaoRemove.Width := 30;
  FBotaoRemove.Margins.Top := 5;
  FBotaoRemove.Margins.Left := 5;
  FBotaoRemove.Margins.Right := 0;
  FBotaoRemove.Margins.Bottom := 5;
  FBotaoRemove.OnClick := onClickBotaoRemove;
  FBotaoRemove.TextSettings.FontColor := TAlphaColors.White;
end;

procedure TProdutoView.criaImagem;
begin
  if Produto.CaminhoFoto <> '' then
  begin
    try
      FImagem := TImage.Create(FLocal);
      FImagem.Align := TAlignLayout.Top;
      FImagem.Height := 65;
      if not FImagem.MultiResBitmap.Items[FImagem.MultiResBitmap.Count - 1]
        .Bitmap.isempty then
        FImagem.MultiResBitmap.Add;

      FImagem.MultiResBitmap.Items[FImagem.MultiResBitmap.Count - 1]
        .Bitmap.loadfromfile(Produto.CaminhoFoto);
      FImagem.WrapMode := TImageWrapMode.Stretch;
      FImagem.Margins.Bottom := 1;
      FImagem.Margins.Left := 1;
      FImagem.Margins.Right := 1;
      FImagem.Margins.Top := 1;
      FImagem.Tag := Produto.Codigo;
      FImagem.OnDblClick := FLocal.OnDblClick;
      FImagem.Parent := FLocal;
    except
      on E: Exception do
        FImagem := nil;
    end;
  end
  else
    FImagem := nil;
end;

procedure TProdutoView.criaLocalBotoes;
begin
  FLocalQuantidade := TRectangle.Create(FLocal);
  FLocalQuantidade.Parent := FLocal;
  FLocalQuantidade.Align := TAlignLayout.Bottom;
  FLocalQuantidade.Height := 45;
  FLocalQuantidade.Fill.Color := TAlphaColors.Whitesmoke;
  FLocalQuantidade.Stroke.Color := TAlphaColors.Gray;
end;

procedure TProdutoView.criaLQuantidade;
begin
  FLQuantidade := TLabel.Create(FLocalQuantidade);
  FLQuantidade.Align := TAlignLayout.Client;
  FLQuantidade.StyledSettings := [];
  FLQuantidade.TextSettings.HorzAlign := TTextAlign.Center;
  FLQuantidade.Text := IntToStr(FQuantidade);
  FLQuantidade.Parent := FLocalQuantidade;
end;

procedure TProdutoView.criaNomeProduto;
begin
  NomeProduto := TLabel.Create(FLocal);
  NomeProduto.Align := TAlignLayout.Client;
  NomeProduto.StyledSettings := [];
  NomeProduto.TextSettings.HorzAlign := TTextAlign.Center;

  if Assigned(FImagem) then
    NomeProduto.TextSettings.Font.Size := 9;

  NomeProduto.Text := Produto.DescricaoCupom;
  NomeProduto.Parent := FLocal;
  NomeProduto.Cursor := crHandPoint;
  NomeProduto.OnDblClick := FLocal.OnDblClick;
  NomeProduto.Margins.Left := 2;
  NomeProduto.Margins.Top := 2;
  NomeProduto.Margins.Bottom := 2;
  NomeProduto.Margins.Right := 2;
  NomeProduto.Tag := Produto.Codigo;
end;

procedure TProdutoView.criaSelecao;
begin
  FSelecao := TShadowEffect.Create(FLocal);
  FSelecao.Opacity := 0;
  FSelecao.Softness := 0;
  FSelecao.Parent := FLocal;
end;

procedure TProdutoView.onClickBotaoAdd(Sender: TObject);
var
  TotalItem: Currency;
begin
  TotalItem := ItemContaCliente.Valor +
    (ItemContaCliente.TotalAdicionais / ItemContaCliente.Quantidade);

  if ((StrToInt(FLQuantidade.Text) + 1) * TotalItem) <= ItemContaCliente.TotalItem
  then
    FLQuantidade.Text := IntToStr(StrToInt(FLQuantidade.Text) + 1);
end;

procedure TProdutoView.onClickBotaoRemove(Sender: TObject);
begin
  if ((StrToInt(FLQuantidade.Text)) > 0) then
    FLQuantidade.Text := IntToStr(StrToInt(FLQuantidade.Text) - 1);
end;

procedure TProdutoView.removeSelecaoProduto;
begin
  if Assigned(FSelecao) then
  begin
    FSelecao.Opacity := 0;
    FSelecao.Softness := 0;
  end;
end;

procedure TProdutoView.selecionaProduto;
begin
  if Assigned(FSelecao) then
  begin
    FSelecao.Opacity := 1;
    FSelecao.Softness := 0.7;
    FSelecao.ShadowColor := $FF00754D;
  end;
end;

procedure TProdutoView.SetBotaoAdd(const Value: TCornerButton);
begin
  FBotaoAdd := Value;
end;

procedure TProdutoView.SetBotaoRemove(const Value: TCornerButton);
begin
  FBotaoRemove := Value;
end;

procedure TProdutoView.SetImagem(const Value: TImage);
begin
  FImagem := Value;
end;

procedure TProdutoView.SetLocal(const Value: TRectangle);
begin
  FLocal := Value;
end;

procedure TProdutoView.SetLocalQuantidade(const Value: TRectangle);
begin
  FLocalQuantidade := Value;
end;

procedure TProdutoView.SetLQuantidade(const Value: TLabel);
begin
  FLQuantidade := Value;
end;

procedure TProdutoView.SetNomeProduto(const Value: TLabel);
begin
  FNomeProduto := Value;
end;

procedure TProdutoView.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TProdutoView.SetQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

procedure TProdutoView.SetItemContaCliente(const Value: TItemContaCliente);
begin
  FItemContaCliente := Value;
end;

procedure TProdutoView.SetSelecao(const Value: TShadowEffect);
begin
  FSelecao := Value;
end;

constructor TProdutoView.Create(Local: TRectangle; Produto: TProduto;
  ItemContaCliente: TItemContaCliente);
begin
  if (Assigned(Local)) and (Assigned(Produto)) then
  begin
    FLocal := Local;
    FProduto := Produto;
    FQuantidade := 0;
    FItemContaCliente := ItemContaCliente;
    criaNomeProduto;
    criaSelecao;
    criaLocalBotoes;

    criaBotaoAdd;
    criaBotaoRemove;
    criaLQuantidade;
  end;
end;

end.
