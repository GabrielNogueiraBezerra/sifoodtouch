unit uFrmComanda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.ListBox, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Edit,
  FMX.Effects, FMX.Filter.Effects, FMX.ExtCtrls, uContaView, FMX.SearchBox,
  FMX.Memo, FMX.ImgList, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ListView.Adapters.Base;

type
  TFrmComanda = class(TFrame)
    retSecoes: TRectangle;
    retSelected: TRectangle;
    vRetSecoes: TVertScrollBox;
    vRetProdutos: TVertScrollBox;
    retModalLancProduto: TRectangle;
    retLancamentoProduto: TRectangle;
    retProduto: TRectangle;
    lblNomeProduto: TLabel;
    label1: TLabel;
    Label2: TLabel;
    Rectangle1: TRectangle;
    btnDesistir: TCornerButton;
    btnConfirmar: TCornerButton;
    btnAddQuantidade: TCornerButton;
    btnRemoveQuantidade: TCornerButton;
    Label3: TLabel;
    EdtValorProduto: TEdit;
    cbGarcom: TComboBox;
    GridPanelLayout1: TGridPanelLayout;
    btnConferenciaDetalhada: TCornerButton;
    retAddIndicador: TRectangle;
    Label4: TLabel;
    cbIndicadores: TComboBox;
    Rectangle6: TRectangle;
    lblNomeIndicador: TLabel;
    retProdutos: TRectangle;
    retObservacoes: TRectangle;
    vRetObservacoes: THorzScrollBox;
    retStatusComanda: TRectangle;
    Label11: TLabel;
    lblMesa: TLabel;
    Label13: TLabel;
    lblAbertura: TLabel;
    Label15: TLabel;
    lblContadorMesa: TLabel;
    Label17: TLabel;
    lblDescricaoMesa: TLabel;
    lblTotalLiquido: TLabel;
    Label20: TLabel;
    lblTotalParcial: TLabel;
    Label22: TLabel;
    lblTaxaServico: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    lblTotal: TLabel;
    retSeparadorProdutos: TRectangle;
    retObsCancelaMesa: TRectangle;
    Rectangle9: TRectangle;
    Label12: TLabel;
    Label14: TLabel;
    mmObservacao: TMemo;
    Rectangle13: TRectangle;
    btnConfirmarCancelamentoMesa: TCornerButton;
    btnDesistirCancelamentoMesa: TCornerButton;
    EdtQuantidadeProduto: TEdit;
    retTransferenciaComanda: TRectangle;
    Rectangle2: TRectangle;
    Label16: TLabel;
    label18: TLabel;
    btnSelecionarMesaTransferencia: TCornerButton;
    Rectangle4: TRectangle;
    Line3: TLine;
    Rectangle14: TRectangle;
    Line4: TLine;
    btnCancelarTransferencia: TCornerButton;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Line5: TLine;
    btnTransferirItens: TCornerButton;
    btnTransferirTodosItens: TCornerButton;
    Rectangle17: TRectangle;
    Rectangle18: TRectangle;
    vRetItensTransferencia: TVertScrollBox;
    Rectangle20: TRectangle;
    btnCancelarIndicador: TCornerButton;
    btnRemoverIndicador: TCornerButton;
    btnSelecionarIndicador: TCornerButton;
    retAddAdicionais: TRectangle;
    Rectangle21: TRectangle;
    lblNomeAdicionalTotal: TLabel;
    retAdicionais: TRectangle;
    vRetAdicionais: TVertScrollBox;
    Label21: TLabel;
    Rectangle19: TRectangle;
    retAlteraInformacoesMesa: TRectangle;
    Rectangle22: TRectangle;
    Label23: TLabel;
    EdtDescricaoMesa: TEdit;
    Label26: TLabel;
    Rectangle23: TRectangle;
    EdtQuantidadePessoas: TEdit;
    retItens: TRectangle;
    Rectangle24: TRectangle;
    Rectangle25: TRectangle;
    Rectangle26: TRectangle;
    retAddAdicional: TRectangle;
    Rectangle28: TRectangle;
    lblNomeAdicional: TLabel;
    Rectangle34: TRectangle;
    EdtQuantidadeAdicional: TEdit;
    btnRemoveAdicional: TCornerButton;
    btnAddAdicional: TCornerButton;
    Label28: TLabel;
    btnDesistirAddAdicional: TCornerButton;
    btnConfirmarAddAdicional: TCornerButton;
    lblTotalAdicional: TLabel;
    Label19: TLabel;
    lblNomeIndicadorStatus: TLabel;
    Label27: TLabel;
    lblTotalPessoas: TLabel;
    retInformacoesItemConta: TRectangle;
    Rectangle35: TRectangle;
    Rectangle27: TRectangle;
    Label29: TLabel;
    btnDesistirInformacaoItem: TCornerButton;
    btnCancelarItem: TCornerButton;
    retObsCancelamentoItem: TRectangle;
    Rectangle37: TRectangle;
    Label34: TLabel;
    Rectangle38: TRectangle;
    Rectangle36: TRectangle;
    Label35: TLabel;
    mmObservacaoCancelItem: TMemo;
    btnConfirmarObsCancelItem: TCornerButton;
    btnDesisitirObsCancelItem: TCornerButton;
    Rectangle39: TRectangle;
    Line6: TLine;
    vRetAdicionaisProdutoSel: TVertScrollBox;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    lblInfoItem: TLabel;
    lblInfoProduto: TLabel;
    lblInfoReferencia: TLabel;
    lblInfoValor: TLabel;
    lblInfoQuantidade: TLabel;
    lblInfoTotal: TLabel;
    lblInfoGarcom: TLabel;
    lblInfoObservacao: TLabel;
    Label45: TLabel;
    lblInfoHoraLancamento: TLabel;
    Label46: TLabel;
    lblInfoTotalAdicional: TLabel;
    Label47: TLabel;
    lblInfoTotalGeral: TLabel;
    retSelecaoTipoPagamento: TRectangle;
    Rectangle41: TRectangle;
    Label36: TLabel;
    retPagamentoParcialValor: TRectangle;
    Rectangle8: TRectangle;
    Label51: TLabel;
    Rectangle10: TRectangle;
    Line7: TLine;
    vRetAdicionaisInfoProduto: TVertScrollBox;
    Rectangle7: TRectangle;
    btnDesistirPagamentoParcialValor: TCornerButton;
    Rectangle11: TRectangle;
    VertScrollBox1: TVertScrollBox;
    retLancPagamentoParcialValor: TRectangle;
    Rectangle12: TRectangle;
    Image1: TImage;
    Line8: TLine;
    Rectangle42: TRectangle;
    Rectangle43: TRectangle;
    Label9: TLabel;
    Rectangle44: TRectangle;
    Label10: TLabel;
    EdtLancPagParcialValor: TEdit;
    btnDesistirLancPagamentoParcialV: TCornerButton;
    btnConfirmarLancPagParcialValor: TCornerButton;
    retDeletaPagamentoParcial: TRectangle;
    Rectangle40: TRectangle;
    Label512312312312321: TLabel;
    btnRemoverPagamentoParcial: TCornerButton;
    btnDesistirRemoverPagamentoParcial: TCornerButton;
    Label5: TLabel;
    lblInfoTotalParcial: TLabel;
    retPagamentoParcialProduto: TRectangle;
    Rectangle45: TRectangle;
    Label6: TLabel;
    vRetProdutosParcial: TVertScrollBox;
    Rectangle46: TRectangle;
    btnDesistirPagamentoParcialProduto: TCornerButton;
    mmHistoricoPagamentoParcialValor: TMemo;
    Label7: TLabel;
    retBottomPagamentoParcialProduto: TRectangle;
    btnConfirmarpagamentoParcialProduto: TCornerButton;
    retFormasPagamentoParcialProduto: TRectangle;
    Rectangle48: TRectangle;
    Label8: TLabel;
    Rectangle47: TRectangle;
    btnConfirmarSelecaoFormaPagamento: TCornerButton;
    btnDesistirSelecaoFormaPagamento: TCornerButton;
    vRetFormasPagamento: TVertScrollBox;
    vRetPagamentosParciaisProduto: TVertScrollBox;
    Rectangle49: TRectangle;
    Rectangle50: TRectangle;
    Line9: TLine;
    retFrmComanda: TRectangle;
    retComponentesFrmComanda: TRectangle;
    retLocalSecaoProdutos: TRectangle;
    retBotoes: TRectangle;
    retSecoesProdutosItensComanda: TRectangle;
    retItensComandaInformacoes: TRectangle;
    ShadowEffect1: TShadowEffect;
    Line1: TLine;
    Rectangle3: TRectangle;
    retInformacoes: TRectangle;
    Rectangle5: TRectangle;
    Label48: TLabel;
    Rectangle29: TRectangle;
    btnSairInformacoesMesa: TCornerButton;
    retFinalizacaoVenda: TRectangle;
    Rectangle51: TRectangle;
    Label49: TLabel;
    Rectangle52: TRectangle;
    btnFinalizarComanda: TCornerButton;
    btnDesistirFinalizacaoComanda: TCornerButton;
    Rectangle53: TRectangle;
    Line2213: TLine;
    vRetFormasPagamentoFinalizacao: TVertScrollBox;
    Rectangle54: TRectangle;
    Rectangle56: TRectangle;
    Label50: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    lblSubTotalFinalizacao: TLabel;
    Label56: TLabel;
    lblDescontoFinalizacao: TLabel;
    lblTotalServicoFinalizacao: TLabel;
    lblTotalParcialFinalizacao: TLabel;
    lblTotalGeralFinalizacao: TLabel;
    Rectangle55: TRectangle;
    Label55: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label66: TLabel;
    lblAberturaFinalizacao: TLabel;
    lblDescricaoMesaFinalizacao: TLabel;
    lblIndicadorFinalizacao: TLabel;
    lblPessoasFinalizacao: TLabel;
    Label58: TLabel;
    Rectangle57: TRectangle;
    lblTotalFormasPagamentoParcialProduto: TLabel;
    lblTotalPessoaFinalizacao: TLabel;
    Label59: TLabel;
    Line15: TLine;
    btnDescontoFinalizacao: TCornerButton;
    btnAcrecimoFinalizacao: TCornerButton;
    retLancamentoDescAcresFinalizacao: TRectangle;
    Rectangle58: TRectangle;
    Label57: TLabel;
    Rectangle59: TRectangle;
    btnConfirmarDescAcresFinalizacao: TCornerButton;
    btnDesistirDescAcresFinalizacao: TCornerButton;
    EdtDescAcresFinalizacao: TEdit;
    btnAlterarInformacoesFinalizacao: TCornerButton;
    Rectangle63: TRectangle;
    Rectangle64: TRectangle;
    Line2: TLine;
    Rectangle65: TRectangle;
    EdtDescAcresPercentualFinalizacao: TEdit;
    Label63: TLabel;
    Label64: TLabel;
    retInserirValorFormaPagamento: TRectangle;
    Rectangle61: TRectangle;
    Label62: TLabel;
    Rectangle60: TRectangle;
    btnConfirmarValor: TCornerButton;
    btnDesistirValor: TCornerButton;
    Label65: TLabel;
    lblTotalPagoFinalizacao: TLabel;
    Label67: TLabel;
    lblValorTrocoFinalizacao: TLabel;
    retLancamentoContasReceberCartao: TRectangle;
    Rectangle66: TRectangle;
    Label68: TLabel;
    Label69: TLabel;
    cbAdministradorasCartao: TComboBox;
    Rectangle67: TRectangle;
    Label70: TLabel;
    Rectangle68: TRectangle;
    cbBandeirasCartao: TComboBox;
    Rectangle69: TRectangle;
    btnConfirmaLancamentosCartao: TCornerButton;
    btnDesistirLancamentoCartao: TCornerButton;
    Label71: TLabel;
    btnRemoveParcelas: TCornerButton;
    btnAddParcelas: TCornerButton;
    lblParcelasCartao: TLabel;
    Label72: TLabel;
    Rectangle70: TRectangle;
    EdtValorLancamentoCartao: TEdit;
    Label73: TLabel;
    Rectangle71: TRectangle;
    EdtNumeroAutorizacao: TEdit;
    Label74: TLabel;
    Rectangle72: TRectangle;
    mmObservacaoLancamentoCartao: TMemo;
    retLancamentosCartoes: TRectangle;
    vRetLancamentosCartoes: TVertScrollBox;
    Line16: TLine;
    lblTGeralFinalizacao: TLabel;
    Label76: TLabel;
    btnAlterarDadosVendaFinalizacao: TCornerButton;
    retStatusEnvioFiscal: TRectangle;
    lblStatusEnvioFiscal: TLabel;
    Image2: TImage;
    lblClienteFinalizacaoVenda: TLabel;
    lblTipoVendaFinalizacaoVenda: TLabel;
    Rectangle62: TRectangle;
    EdtValorFormaPagamento: TEdit;
    Label78: TLabel;
    btnConferenciaResumida: TCornerButton;
    btnPagamento: TCornerButton;
    btnPagamentoParcial: TCornerButton;
    btnImprimeCozinhaBar: TCornerButton;
    btnTransferenciaMesa: TCornerButton;
    btnDesbloquearMesa: TCornerButton;
    btnIndicador: TCornerButton;
    btnCancelarMesa: TCornerButton;
    btnRetiraTaxaServico: TCornerButton;
    btnAlteraInformacoesMesa: TCornerButton;
    btnRecarregaInformacoes: TCornerButton;
    btnInformacoesMesa: TCornerButton;
    btnItensComanda: TCornerButton;
    btnConfirmarAlteraInformacoes: TCornerButton;
    btnCancelarAlteraInformacoes: TCornerButton;
    btnPacialValor: TCornerButton;
    btnPacialProduto: TCornerButton;
    btnDesistirSelecaoPagamento: TCornerButton;
    retLancamentoQuantidadeTransferencia: TRectangle;
    Rectangle74: TRectangle;
    Rectangle76: TRectangle;
    btnDesistirQuantidadeTransferencia: TCornerButton;
    btnConfirmarQuantidadeTransferencia: TCornerButton;
    btnAddQuantidadeProdutoTransferencia: TCornerButton;
    btnRemoveQuantidadeProdutoTransferencia: TCornerButton;
    Label79: TLabel;
    Rectangle77: TRectangle;
    Label83: TLabel;
    Rectangle78: TRectangle;
    EdtQuantidadeProdutoTransferencia: TEdit;
    EdtMesaTransferencia: TLabel;
    btnMudarMesa: TCornerButton;
    retConsultaProduto: TRectangle;
    Rectangle75: TRectangle;
    Label80: TLabel;
    Rectangle79: TRectangle;
    btnBuscarProdutos: TCornerButton;
    btnDesistirBuscaProdutos: TCornerButton;
    Label81: TLabel;
    Rectangle80: TRectangle;
    EdtBuscaProduto: TEdit;
    listItensComanda: TListView;
    vRetItensComanda: TVertScrollBox;
    retCabecalhoItens: TRectangle;
    Line10: TLine;
    Rectangle30: TRectangle;
    Label30: TLabel;
    procedure imgCloseClick(Sender: TObject);
    procedure EdtPesquisaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btnDesistirClick(Sender: TObject);
    procedure btnAddQuantidadeClick(Sender: TObject);
    procedure btnRemoveQuantidadeClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDesbloquearMesaClick(Sender: TObject);
    procedure btnConferenciaResumidaClick(Sender: TObject);
    procedure btnImprimeCozinhaBarClick(Sender: TObject);
    procedure btnIndicadorClick(Sender: TObject);
    procedure btnConferenciaDetalhadaClick(Sender: TObject);
    procedure EdtValorProdutoExit(Sender: TObject);
    procedure btnCancelarMesaClick(Sender: TObject);
    procedure btnConfirmarCancelamentoMesaClick(Sender: TObject);
    procedure btnDesistirCancelamentoMesaClick(Sender: TObject);
    procedure btnCancelaMesaClick(Sender: TObject);
    procedure mmObservacaoClick(Sender: TObject);
    procedure mmObservacaoTap(Sender: TObject; const Point: TPointF);
    procedure lblQuantidadeClick(Sender: TObject);
    procedure EdtValorProdutoClick(Sender: TObject);
    procedure lblQuantidadeTap(Sender: TObject; const Point: TPointF);
    procedure lblQuantidadeGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure lblQuantidadeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure EdtQuantidadeProdutoClick(Sender: TObject);
    procedure EdtQuantidadeProdutoTap(Sender: TObject; const Point: TPointF);
    procedure btnRetiraTaxaServicoClick(Sender: TObject);
    procedure btnTransferenciaMesaClick(Sender: TObject);
    procedure btnCancelarTransferenciaClick(Sender: TObject);
    procedure btnSelecionarMesaTransferenciaClick(Sender: TObject);
    procedure btnTransferirTodosItensClick(Sender: TObject);
    procedure btnTransferirItensClick(Sender: TObject);
    procedure Rectangle17Click(Sender: TObject);
    procedure btnCancelarIndicadorClick(Sender: TObject);
    procedure btnRemoverIndicadorClick(Sender: TObject);
    procedure btnSelecionarIndicadorClick(Sender: TObject);
    procedure btnMostraAdicionaisClick(Sender: TObject);
    procedure btnDesisitirAdicionaisClick(Sender: TObject);
    procedure btnConfirmarAdicionaisClick(Sender: TObject);
    procedure btnAlteraInformacoesMesaClick(Sender: TObject);
    procedure btnConfirmarAlteraInformacoesClick(Sender: TObject);
    procedure btnCancelarAlteraInformacoesClick(Sender: TObject);
    procedure EdtDescricaoMesaClick(Sender: TObject);
    procedure EdtQuantidadePessoasClick(Sender: TObject);
    procedure btnAddAdicionalClick(Sender: TObject);
    procedure btnRemoveAdicionalClick(Sender: TObject);
    procedure btnConfirmarAddAdicionalClick(Sender: TObject);
    procedure btnDesistirAddAdicionalClick(Sender: TObject);
    procedure btnRecarregaInformacoesClick(Sender: TObject);
    procedure btnCancelarItemClick(Sender: TObject);
    procedure btnDesistirInformacaoItemClick(Sender: TObject);
    procedure btnConfirmarObsCancelItemClick(Sender: TObject);
    procedure btnDesisitirObsCancelItemClick(Sender: TObject);
    procedure mmObservacaoCancelItemClick(Sender: TObject);
    procedure btnPagamentoParcialClick(Sender: TObject);
    procedure btnPacialValorClick(Sender: TObject);
    procedure btnDesistirPagamentoParcialValorClick(Sender: TObject);
    procedure Rectangle12Click(Sender: TObject);
    procedure btnConfirmarLancPagParcialValorClick(Sender: TObject);
    procedure btnDesistirLancPagamentoParcialVClick(Sender: TObject);
    procedure Rectangle43Click(Sender: TObject);
    procedure btnDesistirSelecaoPagamentoClick(Sender: TObject);
    procedure btnRemoverPagamentoParcialClick(Sender: TObject);
    procedure btnDesistirRemoverPagamentoParcialClick(Sender: TObject);
    procedure btnPacialProdutoClick(Sender: TObject);
    procedure btnDesistirPagamentoParcialProdutoClick(Sender: TObject);
    procedure mmHistoricoPagamentoParcialValorClick(Sender: TObject);
    procedure btnConfirmarpagamentoParcialProdutoClick(Sender: TObject);
    procedure btnConfirmarSelecaoFormaPagamentoClick(Sender: TObject);
    procedure btnDesistirSelecaoFormaPagamentoClick(Sender: TObject);
    procedure btnInformacoesMesaClick(Sender: TObject);
    procedure btnSairInformacoesMesaClick(Sender: TObject);
    procedure btnPagamentoClick(Sender: TObject);
    procedure btnDesistirFinalizacaoComandaClick(Sender: TObject);
    procedure EdtQuantidadeProdutoExit(Sender: TObject);
    procedure btnDescontoFinalizacaoClick(Sender: TObject);
    procedure btnDesistirDescAcresFinalizacaoClick(Sender: TObject);
    procedure btnAcrecimoFinalizacaoClick(Sender: TObject);
    procedure btnConfirmarDescAcresFinalizacaoClick(Sender: TObject);
    procedure EdtDescAcresFinalizacaoClick(Sender: TObject);
    procedure btnAlterarInformacoesFinalizacaoClick(Sender: TObject);
    procedure EdtDescAcresPercentualFinalizacaoExit(Sender: TObject);
    procedure EdtDescAcresPercentualFinalizacaoClick(Sender: TObject);
    procedure EdtDescAcresFinalizacaoExit(Sender: TObject);
    procedure btnFinalizarComandaClick(Sender: TObject);
    procedure btnDesistirPreencherFormasPagamentoClick(Sender: TObject);
    procedure btnDesistirValorClick(Sender: TObject);
    procedure EdtValorFormaPagamentoClick(Sender: TObject);
    procedure btnConfirmarValorClick(Sender: TObject);
    procedure cbAdministradorasCartaoChange(Sender: TObject);
    procedure EdtValorLancamentoCartaoClick(Sender: TObject);
    procedure EdtNumeroAutorizacaoClick(Sender: TObject);
    procedure mmObservacaoLancamentoCartaoClick(Sender: TObject);
    procedure btnConfirmaLancamentosCartaoClick(Sender: TObject);
    procedure btnAddParcelasClick(Sender: TObject);
    procedure btnRemoveParcelasClick(Sender: TObject);
    procedure btnDesistirLancamentoCartaoClick(Sender: TObject);
    procedure btnAlterarDadosVendaFinalizacaoClick(Sender: TObject);
    procedure btnItensComandaClick(Sender: TObject);
    procedure EdtMesaTransferenciaTap(Sender: TObject; const Point: TPointF);
    procedure Rectangle17Tap(Sender: TObject; const Point: TPointF);
    procedure btnAddQuantidadeProdutoTransferenciaClick(Sender: TObject);
    procedure btnRemoveQuantidadeProdutoTransferenciaClick(Sender: TObject);
    procedure btnConfirmarQuantidadeTransferenciaClick(Sender: TObject);
    procedure btnDesistirQuantidadeTransferenciaClick(Sender: TObject);
    procedure EdtQuantidadeProdutoTransferenciaClick(Sender: TObject);
    procedure EdtQuantidadeProdutoTransferenciaTap(Sender: TObject;
      const Point: TPointF);
    procedure EdtMesaTransferenciaClick(Sender: TObject);
    procedure btnMudarMesaClick(Sender: TObject);
    procedure btnBuscarProdutosClick(Sender: TObject);
    procedure btnDesistirBuscaProdutosClick(Sender: TObject);
    procedure EdtBuscaProdutoClick(Sender: TObject);
    procedure listItensComandaUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure listItensComandaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
    FComanda: Integer;
    procedure SetComanda(const Value: Integer);
  public
    { Public declarations }
    procedure FormShow(mesa: TContaView);
    procedure FormClose;
  published
    { published declarations }
    property Comanda: Integer read FComanda write SetComanda;
  end;

implementation

uses uFrmComandaController, Winapi.Windows;

{$R *.fmx}
{ TFrmComanda }

procedure TFrmComanda.btnAcrecimoFinalizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnAcrecimoFinalizacaoClick');
end;

procedure TFrmComanda.btnAddAdicionalClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnAddAdicionalClick');
end;

procedure TFrmComanda.btnAddParcelasClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnAddParcelasClick');
end;

procedure TFrmComanda.btnAddQuantidadeClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnAddQuantidadeClick');
end;

procedure TFrmComanda.btnAddQuantidadeProdutoTransferenciaClick
  (Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnAddQuantidadeProdutoTransferenciaClick');
end;

procedure TFrmComanda.btnAlteraInformacoesMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnAlteraInformacoesMesaClick');
end;

procedure TFrmComanda.btnAlterarDadosVendaFinalizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnAlterarDadosVendaFinalizacaoClick');
end;

procedure TFrmComanda.btnAlterarInformacoesFinalizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnAlterarInformacoesFinalizacaoClick');
end;

procedure TFrmComanda.btnBuscarProdutosClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnBuscarProdutosClick');
end;

procedure TFrmComanda.btnCancelaMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnCancelarMesaClick');
end;

procedure TFrmComanda.btnCancelarAlteraInformacoesClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnCancelarAlteraInformacoesClick');
end;

procedure TFrmComanda.btnCancelarIndicadorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnCancelarIndicadorClick');
end;

procedure TFrmComanda.btnCancelarItemClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnCancelarItemClick');
end;

procedure TFrmComanda.btnCancelarMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnCancelarMesaClick');
end;

procedure TFrmComanda.btnCancelarTransferenciaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnCancelarTransferenciaClick');
end;

procedure TFrmComanda.btnConferenciaDetalhadaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConferenciaDetalhadaClick');
end;

procedure TFrmComanda.btnConferenciaResumidaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConferenciaResumidaClick');
end;

procedure TFrmComanda.btnConfirmaLancamentosCartaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmaLancamentosCartaoClick');
end;

procedure TFrmComanda.btnConfirmarAddAdicionalClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarAddAdicionalClick');
end;

procedure TFrmComanda.btnConfirmarAdicionaisClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarAdicionaisClick');
end;

procedure TFrmComanda.btnConfirmarAlteraInformacoesClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarAlteraInformacoesClick');
end;

procedure TFrmComanda.btnConfirmarCancelamentoMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarCancelamentoMesaClick');
end;

procedure TFrmComanda.btnConfirmarClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarClick');
end;

procedure TFrmComanda.btnConfirmarDescAcresFinalizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarDescAcresFinalizacaoClick');
end;

procedure TFrmComanda.btnConfirmarLancPagParcialValorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarLancPagParcialValorClick');
end;

procedure TFrmComanda.btnConfirmarObsCancelItemClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarObsCancelItemClick');
end;

procedure TFrmComanda.btnConfirmarpagamentoParcialProdutoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarpagamentoParcialProdutoClick');
end;

procedure TFrmComanda.btnConfirmarQuantidadeTransferenciaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarQuantidadeTransferenciaClick');
end;

procedure TFrmComanda.btnConfirmarSelecaoFormaPagamentoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarSelecaoFormaPagamentoClick');
end;

procedure TFrmComanda.btnConfirmarValorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnConfirmarValorClick');
end;

procedure TFrmComanda.btnDesbloquearMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesbloquearMesaClick');
end;

procedure TFrmComanda.btnDescontoFinalizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDescontoFinalizacaoClick');
end;

procedure TFrmComanda.btnDesisitirAdicionaisClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesisitirAdicionaisClick');
end;

procedure TFrmComanda.btnDesisitirObsCancelItemClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesisitirObsCancelItemClick');
end;

procedure TFrmComanda.btnDesistirAddAdicionalClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirAddAdicionalClick');
end;

procedure TFrmComanda.btnDesistirBuscaProdutosClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirBuscaProdutosClick');
end;

procedure TFrmComanda.btnDesistirCancelamentoMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirCancelamentoMesaClick');
end;

procedure TFrmComanda.btnDesistirClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirClick');
end;

procedure TFrmComanda.btnDesistirDescAcresFinalizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirDescAcresFinalizacaoClick');
end;

procedure TFrmComanda.btnDesistirFinalizacaoComandaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirFinalizacaoComandaClick');
end;

procedure TFrmComanda.btnDesistirInformacaoItemClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirInformacaoItemClick');
end;

procedure TFrmComanda.btnDesistirLancamentoCartaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirLancamentoCartaoClick');
end;

procedure TFrmComanda.btnDesistirLancPagamentoParcialVClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirLancPagamentoParcialVClick');
end;

procedure TFrmComanda.btnDesistirPagamentoParcialProdutoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirPagamentoParcialProdutoClick');
end;

procedure TFrmComanda.btnDesistirPagamentoParcialValorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirPagamentoParcialValorClick');
end;

procedure TFrmComanda.btnDesistirPreencherFormasPagamentoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirPreencherFormasPagamentoClick');
end;

procedure TFrmComanda.btnDesistirQuantidadeTransferenciaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirQuantidadeTransferenciaClick');
end;

procedure TFrmComanda.btnDesistirRemoverPagamentoParcialClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirRemoverPagamentoParcialClick');
end;

procedure TFrmComanda.btnDesistirSelecaoFormaPagamentoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirSelecaoFormaPagamentoClick');
end;

procedure TFrmComanda.btnDesistirSelecaoPagamentoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirSelecaoPagamentoClick');
end;

procedure TFrmComanda.btnDesistirValorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnDesistirValorClick');
end;

procedure TFrmComanda.btnFinalizarComandaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnFinalizarComandaClick');
end;

procedure TFrmComanda.btnImprimeCozinhaBarClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnImprimeCozinhaBarClick');
end;

procedure TFrmComanda.btnIndicadorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnIndicadorClick');
end;

procedure TFrmComanda.btnInformacoesMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnInformacoesMesaClick');
end;

procedure TFrmComanda.btnItensComandaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnItensComandaClick');
end;

procedure TFrmComanda.btnMostraAdicionaisClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnMostraAdicionaisClick');
end;

procedure TFrmComanda.btnMudarMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtMesaTransferenciaClick');
end;

procedure TFrmComanda.btnPacialProdutoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnPacialProdutoClick');
end;

procedure TFrmComanda.btnPacialValorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnPacialValorClick');
end;

procedure TFrmComanda.btnPagamentoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnPagamentoClick');
end;

procedure TFrmComanda.btnPagamentoParcialClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnPagamentoParcialClick');
end;

procedure TFrmComanda.btnRecarregaInformacoesClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnRecarregaInformacoesClick');
end;

procedure TFrmComanda.btnRemoveAdicionalClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnRemoveAdicionalClick');
end;

procedure TFrmComanda.btnRemoveParcelasClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnRemoveParcelasClick');
end;

procedure TFrmComanda.btnRemoveQuantidadeClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnRemoveQuantidadeClick');
end;

procedure TFrmComanda.btnRemoveQuantidadeProdutoTransferenciaClick
  (Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnRemoveQuantidadeProdutoTransferencia');
end;

procedure TFrmComanda.btnRemoverIndicadorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnRemoverIndicadorClick');
end;

procedure TFrmComanda.btnRemoverPagamentoParcialClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnRemoverPagamentoParcialClick');
end;

procedure TFrmComanda.btnRetiraTaxaServicoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnRetiraTaxaServicoClick');
end;

procedure TFrmComanda.btnSairInformacoesMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnSairInformacoesMesaClick');
end;

procedure TFrmComanda.btnSelecionarIndicadorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnSelecionarIndicadorClick');
end;

procedure TFrmComanda.btnSelecionarMesaTransferenciaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnSelecionarMesaTransferenciaClick');
end;

procedure TFrmComanda.btnTransferenciaMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnTransferenciaMesaClick');
end;

procedure TFrmComanda.btnTransferirItensClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnTransferirItensClick');
end;

procedure TFrmComanda.btnTransferirTodosItensClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('btnTransferirTodosItensClick');
end;

procedure TFrmComanda.cbAdministradorasCartaoChange(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('cbAdministradorasCartaoChange');
end;

procedure TFrmComanda.EdtBuscaProdutoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtBuscaProdutoClick');
end;

procedure TFrmComanda.EdtDescAcresFinalizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtDescAcresFinalizacaoClick');
end;

procedure TFrmComanda.EdtDescAcresFinalizacaoExit(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtDescAcresFinalizacaoExit');
end;

procedure TFrmComanda.EdtDescAcresPercentualFinalizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtDescAcresPercentualFinalizacaoClick');
end;

procedure TFrmComanda.EdtDescAcresPercentualFinalizacaoExit(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtDescAcresPercentualFinalizacaoExit');
end;

procedure TFrmComanda.EdtDescricaoMesaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtDescricaoMesaClick');
end;

procedure TFrmComanda.EdtMesaTransferenciaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtMesaTransferenciaClick');
end;

procedure TFrmComanda.EdtMesaTransferenciaTap(Sender: TObject;
  const Point: TPointF);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtMesaTransferenciaClick');
end;

procedure TFrmComanda.EdtNumeroAutorizacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtNumeroAutorizacaoClick');
end;

procedure TFrmComanda.EdtPesquisaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtPesquisaKeyDown');
end;

procedure TFrmComanda.EdtQuantidadePessoasClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtQuantidadePessoasClick');
end;

procedure TFrmComanda.EdtQuantidadeProdutoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtQuantidadeClick');
end;

procedure TFrmComanda.EdtQuantidadeProdutoExit(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtQuantidadeProdutoExit');
end;

procedure TFrmComanda.EdtQuantidadeProdutoTap(Sender: TObject;
  const Point: TPointF);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtQuantidadeClick');
end;

procedure TFrmComanda.EdtQuantidadeProdutoTransferenciaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtQuantidadeProdutoTransferenciaClick');
end;

procedure TFrmComanda.EdtQuantidadeProdutoTransferenciaTap(Sender: TObject;
  const Point: TPointF);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtQuantidadeProdutoTransferenciaClick');
end;

procedure TFrmComanda.EdtValorFormaPagamentoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtValorFormaPagamentoClick');
end;

procedure TFrmComanda.EdtValorLancamentoCartaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtValorLancamentoCartaoClick');
end;

procedure TFrmComanda.EdtValorProdutoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtValorProdutoClick');
end;

procedure TFrmComanda.EdtValorProdutoExit(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('EdtValorProdutoExit');
end;

procedure TFrmComanda.FormClose;
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('FormClose');
end;

procedure TFrmComanda.FormShow(mesa: TContaView);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('FormShow', mesa);
end;

procedure TFrmComanda.imgCloseClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('FormClose');
end;

procedure TFrmComanda.lblQuantidadeClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('lblQuantidadeClick');
end;

procedure TFrmComanda.lblQuantidadeGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('lblQuantidadeClick');
end;

procedure TFrmComanda.lblQuantidadeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('lblQuantidadeClick');
end;

procedure TFrmComanda.lblQuantidadeTap(Sender: TObject; const Point: TPointF);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('lblQuantidadeClick');
end;

procedure TFrmComanda.listItensComandaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('listItensComandaItemClick', AItem);
end;

procedure TFrmComanda.listItensComandaUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
  if AItem.Data['Text4'].AsString = '1' then
  begin
    TListItemText(AItem.Objects.FindDrawable('Text1')).TextColor :=
      TAlphaColors.Blue;
    TListItemText(AItem.Objects.FindDrawable('Text2')).TextColor :=
      TAlphaColors.Blue;
    TListItemText(AItem.Objects.FindDrawable('Text3')).TextColor :=
      TAlphaColors.Blue;
  end;

  if AItem.Data['Text4'].AsString = '2' then
  begin
    TListItemText(AItem.Objects.FindDrawable('Text1')).TextColor :=
      TAlphaColors.red;
    TListItemText(AItem.Objects.FindDrawable('Text2')).TextColor :=
      TAlphaColors.red;
    TListItemText(AItem.Objects.FindDrawable('Text3')).TextColor :=
      TAlphaColors.red;
  end;

  if AItem.Data['Text4'].AsString = '0' then
  begin
    TListItemText(AItem.Objects.FindDrawable('Text1')).TextColor :=
      TAlphaColors.Black;
    TListItemText(AItem.Objects.FindDrawable('Text2')).TextColor :=
      TAlphaColors.Black;
    TListItemText(AItem.Objects.FindDrawable('Text3')).TextColor :=
      TAlphaColors.Black;
  end;

end;

procedure TFrmComanda.mmHistoricoPagamentoParcialValorClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('mmHistoricoPagamentoParcialValorClick');
end;

procedure TFrmComanda.mmObservacaoCancelItemClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('mmObservacaoCancelItemClick');
end;

procedure TFrmComanda.mmObservacaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('mmObservacaoClick');
end;

procedure TFrmComanda.mmObservacaoLancamentoCartaoClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('mmObservacaoLancamentoCartaoClick');
end;

procedure TFrmComanda.mmObservacaoTap(Sender: TObject; const Point: TPointF);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('mmObservacaoClick');
end;

procedure TFrmComanda.Rectangle12Click(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('Rectangle12Click');
end;

procedure TFrmComanda.Rectangle17Click(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('Rectangle17Click');
end;

procedure TFrmComanda.Rectangle17Tap(Sender: TObject; const Point: TPointF);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('Rectangle17Click');
end;

procedure TFrmComanda.Rectangle43Click(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(Self);
  controller.evento('Rectangle43Click');
end;

procedure TFrmComanda.SetComanda(const Value: Integer);
begin
  FComanda := Value;
end;

end.
