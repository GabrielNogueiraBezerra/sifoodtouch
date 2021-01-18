unit uFrmComandaController;

interface

uses
  uDMConexao, StrUtils, uFrmComanda, uSecao,
  uSecaoDAO, uSecaoView, uProdutoView, uContaView, uVendedorDAO, uVendedor,
  System.Generics.Collections, uComprovante, uItemContaCliente, uImpressora,
  uIndicador, uObservacao, uObservacaoView, uProduto, uContaCliente,
  uItemTransferenciaView, uAdicionalView, uItemContaClienteView,
  uFormaPagamentoView, uPagamentoPacialView, uVenda, uFormaPagamento,
  uVendaFormaPagamento, uAdministradoraCartao, uLancamentoCartaoView,
  uBandeiraCartao, uContaReceberCartao, uClass, uSat, uFrmLancamentoPOS;

type
  TFrmComandaController = class(TObject)
  private
    { private declarations }
    FView: TFrmComanda;

    procedure FormShow;
    procedure FormClose;
    procedure Clean;

    procedure btnDesistirClick;
    procedure btnAddQuantidadeClick;
    procedure btnRemoveQuantidadeClick;
    procedure btnConfirmarClick;
    procedure btnDesbloquearMesaClick;
    procedure btnConferenciaResumidaClick;
    procedure btnImprimeCozinhaBarClick;
    procedure btnIndicadorClick;
    procedure btnCancelarIndicadorClick;
    procedure btnRemoverIndicadorClick;
    procedure btnSelecionarIndicadorClick;
    procedure btnConferenciaDetalhadaClick;
    procedure EdtValorProdutoExit;
    procedure btnCancelarMesaClick;
    procedure btnConfirmarCancelamentoMesaClick;
    procedure btnDesistirCancelamentoMesaClick;
    procedure mmObservacaoClick;
    procedure EdtQuantidadeClick;
    procedure EdtValorProdutoClick;
    procedure btnRetiraTaxaServicoClick;
    procedure btnTransferenciaMesaClick;
    procedure btnCancelarTransferenciaClick;
    procedure btnSelecionarMesaTransferenciaClick;
    procedure btnTransferirTodosItensClick;
    procedure btnTransferirItensClick;
    procedure Rectangle17Click;
    procedure btnAlteraInformacoesMesaClick;
    procedure btnConfirmarAlteraInformacoesClick;
    procedure btnCancelarAlteraInformacoesClick;
    procedure EdtDescricaoMesaClick;
    procedure EdtQuantidadePessoasClick;
    procedure btnAddAdicionalClick;
    procedure btnRemoveAdicionalClick;
    procedure btnConfirmarAddAdicionalClick;
    procedure btnDesistirAddAdicionalClick;
    procedure btnRecarregaInformacoesClick;
    procedure btnCancelarItemClick;
    procedure btnDesistirInformacaoItemClick;
    procedure btnConfirmarObsCancelItemClick;
    procedure btnDesisitirObsCancelItemClick;
    procedure mmObservacaoCancelItemClick;
    procedure btnPagamentoParcialClick;
    procedure btnPacialValorClick;
    procedure btnDesistirPagamentoParcialValorClick;
    procedure Rectangle12Click;
    procedure btnConfirmarLancPagParcialValorClick;
    procedure btnDesistirLancPagamentoParcialVClick;
    procedure Rectangle43Click;
    procedure btnDesistirSelecaoPagamentoClick;
    procedure btnRemoverPagamentoParcialClick;
    procedure btnDesistirRemoverPagamentoParcialClick;
    procedure btnPacialProdutoClick;
    procedure btnDesistirPagamentoParcialProdutoClick;
    procedure mmHistoricoPagamentoParcialValorClick;
    procedure btnConfirmarpagamentoParcialProdutoClick;
    procedure btnConfirmarSelecaoFormaPagamentoClick;
    procedure btnDesistirSelecaoFormaPagamentoClick;
    procedure btnInformacoesMesaClick;
    procedure btnSairInformacoesMesaClick;
    procedure btnPagamentoClick;
    procedure btnDesistirFinalizacaoComandaClick;
    procedure EdtQuantidadeProdutoExit;
    procedure EdtMesaTransferenciaClick;
    procedure btnDescontoFinalizacaoClick;
    procedure btnDesistirDescAcresFinalizacaoClick;
    procedure btnAcrecimoFinalizacaoClick;
    procedure btnConfirmarDescAcresFinalizacaoClick;
    procedure EdtDescAcresFinalizacaoClick;
    procedure btnAlterarInformacoesFinalizacaoClick;
    procedure EdtDescAcresPercentualFinalizacaoExit;
    procedure EdtDescAcresPercentualFinalizacaoClick;
    procedure EdtDescAcresFinalizacaoExit;
    procedure btnFinalizarComandaClick;
    procedure btnDesistirValorClick;
    procedure EdtValorFormaPagamentoClick;
    procedure btnConfirmarValorClick;
    procedure cbAdministradorasCartaoChange;
    procedure EdtValorLancamentoCartaoClick;
    procedure EdtNumeroAutorizacaoClick;
    procedure mmObservacaoLancamentoCartaoClick;
    procedure btnConfirmaLancamentosCartaoClick;
    procedure btnAddParcelasClick;
    procedure btnRemoveParcelasClick;
    procedure btnDesistirLancamentoCartaoClick;
    procedure btnAlterarDadosVendaFinalizacaoClick;
    procedure btnItensComandaClick;
    procedure btnAddQuantidadeProdutoTransferenciaClick;
    procedure btnRemoveQuantidadeProdutoTransferencia;
    procedure btnConfirmarQuantidadeTransferenciaClick;
    procedure btnDesistirQuantidadeTransferenciaClick;
    procedure EdtQuantidadeProdutoTransferenciaClick;
    procedure btnBuscarProdutosClick;
    procedure btnDesistirBuscaProdutosClick;
    procedure EdtBuscaProdutoClick;

    procedure addSecoes; overload;
    procedure addSecaoMaisUsado;
    procedure addSecaoProdutoSelecionado(X, Y: Single);
    procedure addProdutos; overload;
    procedure addObservacoes(Produto: TProduto);
    procedure addProdutosAgrupados(ItensContaClienteAgrupado
      : TObjectList<TItemContaCliente>);
    procedure addAdicionaisAgrupados(ProdutoAgrupado: TItemContaCliente;
      ProdutoConta: TItemContaCliente);
    procedure addItensTransferencia;
    procedure addAdicionais;
    procedure addInformacoesProduto;
    procedure addInformacoesProdutoAdicionais;
    procedure addItensComanda;
    procedure addFormasPagamentoPacialValor;
    procedure addFormasPagamentoPacialProduto;
    procedure addFormasPagamentoFinalizacao;
    procedure addDados(const atualiza: String = 'S');
    procedure addPagamentosPaciais;
    procedure addItemsPagamentoParcialProduto;
    procedure addPagamentosParciaisProduto;
    procedure addItensImpressos;
    procedure addItensFinalizacao;
    procedure addInformacoesFinalizacao;
    procedure addItensLancamentoAdmCartao;

    procedure limpaProdutos;
    procedure limpaSecoes;
    procedure limpaObservacoes;
    procedure limpaInformacoesProduto;
    procedure limpaInformacoesProdutoAdicionais;
    procedure limpaItensComanda;
    procedure limpaItensTransferencia;
    procedure limpaAdicionais;
    procedure limpaFormasPagamentoParcialValor;
    procedure limpaPagamentosPaciais;
    procedure limpaItemsPagamentoParcialProduto;
    procedure limpaItensFinalizacao;
    procedure limpaItensLancamentoAdmCartao;
    procedure limpaDadosLancamentoCartao;

    procedure onClickS(Sender: TObject);
    procedure onClickP(Sender: TObject);
    procedure onClickObs(Sender: TObject);
    procedure onClickObItemTransferencia(Sender: TObject);
    procedure onClickAdicional(Sender: TObject);
    procedure onClickItem(Sender: TObject);
    procedure onClickFormasPagamento(Sender: TObject);
    procedure onClickPagamentoParcial(Sender: TObject);
    procedure onClickItemPagamentoParcial(Sender: TObject);
    procedure onClickFormasPagamentoFinalizacao(Sender: TObject);
    procedure OnClickLancamentoAdmCartao(Sender: TObject);
    procedure onClickSecaoAddProduto(Sender: TObject);

    procedure abreTelaStatusEnviaFiscal(Value: Boolean);
    procedure atualizaMesa;
    procedure comanda;
    procedure comandaProduto;
    procedure imprimeComprovanteComanda(Local: String);
    function buscarProduto(Codigo: Integer;
      ItensContaClienteAgrupado: TObjectList<TItemContaCliente>)
      : TItemContaCliente;
    procedure atualizaProdutosImpressos;
    function retornaProdutosComandaImpressora(Impressora: TImpressora)
      : TObjectList<TItemContaCliente>;
    function retornaContaReceberCartao(ContasReceberCartao
      : TObjectList<TContaReceberCartao>;
      AdministradoraCartao: TAdministradoraCartao): TContaReceberCartao;
    procedure cancelaMesa;
    procedure CancelaItem;
    procedure ImprimirItemCanceladoProduto;
    procedure ImprimirItemCancelado;
    function totalAdicionais: Currency;
    procedure botoes(Acao: Boolean);
    procedure IniciaVenda;
    procedure IniciaProdutosVenda;
    procedure IniciaComanda(mesa: TContaView);
    procedure listItensComandaItemClick(Sender: TObject);
    function buscaContaReceberCartaoVenda(FormaPagamento: TFormaPagamento)
      : TContaReceberCartao;

  class var
    FListaSecoes: TObjectList<TSecaoView>;
    FListaProdutos: TObjectList<TProdutoView>;
    FListaProdutosFinalizacao: TObjectList<TProdutoView>;
    FListaGarcom: TObjectList<TVendedor>;
    FListaIndicador: TObjectList<TIndicador>;
    FListaObservacoes: TObjectList<TObservacaoView>;
    FListaInfoProdutosAdicionais: TObjectList<TAdicionalView>;
    FItensTransferencia: TObjectList<TItemTransferenciaView>;
    FListaProdutosAdicionais: TObjectList<TAdicionalView>;
    FListaItensComanda: TObjectList<TItemContaClienteView>;
    FListaFormasPagamento: TObjectList<TFormaPagamentoView>;
    FListaPagamentosParciais: TObjectList<TPagamentoParcialView>;
    FListaItemsParcialProduto: TObjectList<TProdutoView>;
    FListaAdministradorasCartao: TObjectList<TAdministradoraCartao>;
    FListaLancamentosAdmCartao: TObjectList<TLancamentoCartaoView>;
    FFormaPagamentoSelecionado: TFormaPagamentoView;
    FPagamentoParcialSelecionado: TPagamentoParcialView;
    FProdutoSelecionado: TProdutoView;
    FConta: TContaView;
    FContaTransferencia: TContaCliente;
    FAdicionalSelecionado: TAdicionalView;
    ItemSelecionado: TItemContaCliente;
    FVendaFormaPagamento: TVendaFormaPagamento;
    FSat: TSat;
    FItemTransferenciaSelecionado: Integer;
    Impressoras: TObjectList<TImpressora>;
    procedure limpaPagamentosPaciaisProduto;
  protected
    { protected declarations }
  public
    { public declarations }

    procedure Clear;
    constructor Create(view: TFrmComanda); reintroduce;
    destructor Destroy; override;
    procedure evento(evento: String); overload;
    procedure evento(evento: String; mesa: TContaView); overload;
    procedure evento(evento: String; Sender: TObject); overload;
    function buscaSecao(Codigo: Integer): TSecaoView;
    function buscaProduto(Codigo: Integer): TProdutoView;
    function buscaGarcom(Codigo: Integer): TVendedor;
    function buscaIndicador(Codigo: Integer): TIndicador;
    function buscaObservacao(Codigo: Integer): TObservacaoView;
    function buscaAdministradoraCartao(Codigo: Integer): TAdministradoraCartao;
    function retornaObservacao: String;
    function buscarBandeiraCartao(BandeiraCartao: TBandeiraCartao)
      : TAdministradoraCartao;

  end;

implementation

uses
  System.SysUtils, FMX.Dialogs, FMX.Forms, uProdutoDAO,
  FMX.ListView.Appearances, FMX.Types,
  FMX.ListView.Types, FMX.ListView, FMX.Objects, FMX.StdCtrls, System.UITypes,
  FMX.MultiResBitmap, uFrmMesas, uContaClienteDAO,
  uItemContaClienteDAO, System.Threading, uFrmMensagem,
  uCaixaDAO, uImpressoraDAO, uSetor, uIndicadorDAO,
  uObservacaoDAO, uFormaPagamentoDAO, uPagamentoParcial,
  uPagamentoParcialDAO, UVendaDAO, uItemVenda, uFrmPrincipal,
  uAdministradoraCartaoDAO, uBandeiraCartaoDAO,
  uContaReceberCartaoDAO, uFrmLancamentoPOSController, FMX.Effects,
  uFrmLancamentoContasReceber, uFrmLancamentoContasReceberController, uCliente,
  uTipoVenda, uContaReceberDAO,
  uFrmAlterarDadosVendaController, uFrmAlterarDadosvenda, FireDAC.Comp.Client,
  uConexaoFiredac, System.Classes;

{ TFrmComandaController }

procedure TFrmComandaController.addProdutos;
var
  I: Integer;
  X, Y: Single;
  Retangulo: TRectangle;
  Produto: TProduto;
  Result_Produtos: TFDQuery;
begin
  try
    X := 8;
    Y := 8;

    limpaProdutos;
    FView.vRetProdutos.Visible := False;

    Result_Produtos := nil;

    if FView.retSelected.Parent.Tag = 0 then
      Result_Produtos := TProdutoDao.getInstancia.buscarProdutosMaisUsados
    else
      Result_Produtos := TProdutoDao.getInstancia.buscaProdutos
        (buscaSecao(FView.retSelected.Parent.Tag).Secao);

    Result_Produtos.First;
    while not Result_Produtos.EOF do
    begin
      Produto := TProduto.Create;
      Produto.Codigo := Result_Produtos.FieldByName('COD_PRO').AsInteger;
      Produto.nome := Result_Produtos.FieldByName('NOME_PRO').AsString;
      Produto.DescricaoCupom := Result_Produtos.FieldByName
        ('DESC_CUPOM').AsString;
      Produto.CaminhoFoto := Result_Produtos.FieldByName
        ('CAMINHO_FOTO_PRO').AsString;
      Produto.PrecoVista := Result_Produtos.FieldByName('VALOR_PRO').AsCurrency;

      Produto.QuantidadeComposicao := Result_Produtos.FieldByName
        ('TOTAL_PRODUTOS_COMPOSICAO').AsInteger;

      Retangulo := TRectangle.Create(FView.vRetProdutos);
      Retangulo.Parent := FView.vRetProdutos;
      Retangulo.Fill.Color := TAlphaColors.Whitesmoke;
      Retangulo.Stroke.Color := TAlphaColors.Gray;
      Retangulo.Width := 100;
      Retangulo.Height := 100;
      Retangulo.Cursor := crHandPoint;
      Retangulo.Tag := Produto.Codigo;
      Retangulo.OnDblClick := onClickP;
      Retangulo.Position.X := X;
      Retangulo.Position.Y := Y;

      if (X + 105) > (FView.vRetProdutos.Width - 105) then
        X := 8
      else
        X := X + 105;

      if (X = 8) then
        Y := Y + 105;

      FListaProdutos.Add(TProdutoView.Create(Retangulo, Produto));
      Result_Produtos.Next;
    end;

    if Assigned(Result_Produtos) then
      TConexaoFiredac.getInstancia.closeConnection(Result_Produtos);

  finally
    FView.retSeparadorProdutos.Width := FView.vRetProdutos.Width;
    FView.retSeparadorProdutos.Position.X := 0;
    FView.retSeparadorProdutos.Height := 3;
    FView.retSeparadorProdutos.Align := TAlignLayout.Bottom;
    FView.vRetProdutos.Visible := True;
  end;
end;

procedure TFrmComandaController.abreTelaStatusEnviaFiscal(Value: Boolean);
begin
  FView.retStatusEnvioFiscal.Position.X :=
    (FView.Width - FView.retStatusEnvioFiscal.Width) / 2;
  FView.retStatusEnvioFiscal.Position.Y :=
    (FView.Height - FView.retStatusEnvioFiscal.Height) / 2;

  FView.retFinalizacaoVenda.Enabled := not Value;
  FView.retStatusEnvioFiscal.Visible := Value;

  Application.ProcessMessages;
end;

procedure TFrmComandaController.addAdicionais;
var
  secoes: TObjectList<TSecao>;
  Produtos: TObjectList<TProduto>;
  I, Z, contProdutos: Integer;
  X, Y: Single;
  Produto: TProduto;
  Retangulo: TRectangle;
begin
  FListaProdutosAdicionais := TObjectList<TAdicionalView>.Create;
  secoes := TSecaoDAO.getInstancia.buscarTodosComProduto;

  X := 15;
  Y := 8;
  contProdutos := 0;

  for I := 0 to secoes.Count - 1 do
  begin
    if secoes.Items[I].Adicional then
    begin
      Produtos := TProdutoDao.getInstancia.buscarTodos(secoes.Items[I]);

      for Z := 0 to Produtos.Count - 1 do
      begin
        Produto := Produtos.Items[Z];

        Retangulo := TRectangle.Create(FView.vRetAdicionais);
        Retangulo.Parent := FView.vRetAdicionais;

        if contProdutos <> 0 then
        begin
          if (X + 75) > (FView.vRetAdicionais.Width - 75) then
            X := 15
          else
            X := X + 75;

          if (X = 15) then
            Y := Y + 82;

        end;

        Retangulo.Position.X := X;
        Retangulo.Position.Y := Y;
        Retangulo.Fill.Color := TAlphaColors.Whitesmoke;
        Retangulo.Stroke.Color := TAlphaColors.Gray;
        Retangulo.Width := 70;
        Retangulo.Height := 70;
        Retangulo.OnDblClick := onClickAdicional;
        Retangulo.Tag := contProdutos;

        FListaProdutosAdicionais.Add(TAdicionalView.Create(Produto, Retangulo));

        inc(contProdutos);
      end;
    end;

  end;
end;

procedure TFrmComandaController.addInformacoesFinalizacao;
var
  TotalPago: Currency;
  I: Integer;
begin

  FConta.ContaCliente.Venda.Total := 0;
  TotalPago := 0;
  if Assigned(FListaFormasPagamento) then
    for I := 0 to FListaFormasPagamento.Count - 1 do
      if FListaFormasPagamento.Items[I].Selecionado then
        TotalPago := TotalPago + FListaFormasPagamento.Items[I].Valor;

  FView.lblSubTotalFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
    FConta.ContaCliente.Total);

  FConta.ContaCliente.Venda.Total := FConta.ContaCliente.Venda.Total +
    FConta.ContaCliente.Total;

  if (Assigned(FVendaFormaPagamento)) and (FVendaFormaPagamento.Valor > 0) then
  begin
    FView.lblValorTrocoFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
      FVendaFormaPagamento.Valor);

    FView.lblValorTrocoFinalizacao.Visible := True;
    FView.Label67.Visible := True;
  end
  else
  begin
    FView.lblValorTrocoFinalizacao.Visible := False;
    FView.Label67.Visible := False;
  end;

  if FConta.ContaCliente.DispensarTaxaServico = 'N' then
  begin
    FView.lblTotalServicoFinalizacao.Text := 'R$: ' +
      currtostrf(DMConexao.CalcularTaxaServico((FConta.ContaCliente.Total +
      FConta.ContaCliente.totalAdicionais) - FConta.ContaCliente.ValorPacial,
      FConta.ContaCliente), ffnumber, 2);

    FConta.ContaCliente.Venda.Total := FConta.ContaCliente.Venda.Total +
      DMConexao.CalcularTaxaServico
      ((FConta.ContaCliente.Total + FConta.ContaCliente.totalAdicionais) -
      FConta.ContaCliente.ValorPacial, FConta.ContaCliente);
  end
  else
  begin
    FView.lblTotalServicoFinalizacao.Text := 'R$: 0,00';
  end;

  FView.lblTotalParcialFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
    FConta.ContaCliente.ValorPacial);

  FConta.ContaCliente.Venda.Total := FConta.ContaCliente.Venda.Total -
    FConta.ContaCliente.ValorPacial;

  if FConta.ContaCliente.Venda.Desconto > 0 then
  begin
    FView.Label56.Text := '(-) Desconto: ';
    FView.lblDescontoFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
      FConta.ContaCliente.Venda.Desconto);

    FConta.ContaCliente.Venda.Total := FConta.ContaCliente.Venda.Total -
      FConta.ContaCliente.Venda.Desconto;
  end
  else if FConta.ContaCliente.Venda.Acrescimo > 0 then
  begin
    FView.Label56.Text := '(+) Acrescimo: ';
    FView.lblDescontoFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
      FConta.ContaCliente.Venda.Acrescimo);

    FConta.ContaCliente.Venda.Total := FConta.ContaCliente.Venda.Total +
      FConta.ContaCliente.Venda.Acrescimo;
  end
  else
  begin
    FView.Label56.Text := '(-) Desconto: ';
    FView.lblDescontoFinalizacao.Text := 'R$: 0,00';
  end;

  if FConta.ContaCliente.NumeroPessoas > 0 then
  begin
    FView.lblTotalPessoaFinalizacao.Visible := True;
    FView.Label59.Visible := True;
    FView.lblTotalPessoaFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
      (FConta.ContaCliente.Venda.Total / FConta.ContaCliente.NumeroPessoas));
  end
  else
  begin
    FView.lblTotalPessoaFinalizacao.Visible := False;
    FView.Label59.Visible := False;
  end;

  FView.lblTotalPagoFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
    TotalPago);

  FView.lblTGeralFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
    FConta.ContaCliente.Venda.Total);

  FConta.ContaCliente.Venda.Total := FConta.ContaCliente.Venda.Total -
    TotalPago;

  FView.lblTotalGeralFinalizacao.Text := 'R$: ' + formatfloat('#,##0.00',
    FConta.ContaCliente.Venda.Total);

  FView.lblAberturaFinalizacao.Text :=
    DateToStr(FConta.ContaCliente.DataAbertura) + ' ' +
    TimeToStr(FConta.ContaCliente.HoraAbertura);

  if Assigned(FConta.ContaCliente.Indicador) then
    FView.lblIndicadorFinalizacao.Text := FConta.ContaCliente.Indicador.nome
  else
    FView.lblIndicadorFinalizacao.Text := 'SEM INDICADOR';
  FView.lblPessoasFinalizacao.Text :=
    IntToStr(FConta.ContaCliente.NumeroPessoas);

  if FConta.ContaCliente.DescricaoMesa.Trim <> '' then
  begin
    FView.Label60.Visible := True;
    FView.lblDescricaoMesaFinalizacao.Visible := True;
    FView.lblDescricaoMesaFinalizacao.Text := FConta.ContaCliente.DescricaoMesa;
  end
  else
  begin
    FView.Label60.Visible := False;
    FView.lblDescricaoMesaFinalizacao.Visible := False;
  end;

  FView.lblClienteFinalizacaoVenda.Text :=
    FConta.ContaCliente.Venda.Cliente.NomeCliente;
  FView.lblTipoVendaFinalizacaoVenda.Text :=
    FConta.ContaCliente.Venda.TipoVenda.nome;

  FView.lblSubTotalFinalizacao.Visible := True;
  FView.lblTotalServicoFinalizacao.Visible := True;
  FView.lblTotalParcialFinalizacao.Visible := True;
  FView.lblDescontoFinalizacao.Visible := True;
  FView.lblTotalGeralFinalizacao.Visible := True;
end;

procedure TFrmComandaController.addInformacoesProduto;
begin
  FView.Label29.Text := ItemSelecionado.Produto.DescricaoCupom;

  FView.lblInfoGarcom.Text := ItemSelecionado.Garcom.nome;

  FView.lblInfoHoraLancamento.Text := TimeToStr(ItemSelecionado.Hora);

  FView.lblInfoItem.Text := TComprovante.FormataStringD
    (IntToStr(ItemSelecionado.Ordem), '3', '0');

  if ItemSelecionado.Observacao.Trim = '' then
    FView.Label44.Visible := False;

  FView.lblInfoObservacao.Text := ItemSelecionado.Observacao;

  FView.lblInfoProduto.Text := ItemSelecionado.Produto.DescricaoCupom;

  FView.lblInfoQuantidade.Text := formatfloat('#,##0.00',
    ItemSelecionado.Quantidade);

  FView.lblInfoReferencia.Text := ItemSelecionado.Produto.Referencia;

  FView.lblInfoTotal.Text := formatfloat('#,##0.00', ItemSelecionado.Total);

  FView.lblInfoValor.Text := formatfloat('#,##0.00', ItemSelecionado.Valor);

  FView.lblInfoTotalAdicional.Text := formatfloat('#,##0.00',
    ItemSelecionado.totalAdicionais);

  FView.lblInfoTotalParcial.Text := formatfloat('#,##0.00',
    ItemSelecionado.ValorParcial);

  FView.lblInfoTotalGeral.Text := formatfloat('#,##0.00',
    ItemSelecionado.TotalItem);

  if ItemSelecionado.Adicionais.Count > 0 then
    addInformacoesProdutoAdicionais;
end;

procedure TFrmComandaController.addInformacoesProdutoAdicionais;
var
  I: Integer;
  Retangulo: TRectangle;
  X, Y: Single;
begin

  limpaInformacoesProdutoAdicionais;

  X := 10;
  Y := 8;

  for I := 0 to ItemSelecionado.Adicionais.Count - 1 do
  begin
    Retangulo := TRectangle.Create(FView.vRetAdicionaisProdutoSel);
    Retangulo.Parent := FView.vRetAdicionaisProdutoSel;
    Retangulo.Fill.Color := $FFE0E0E0;
    Retangulo.Stroke.Color := $FFE0E0E0;
    Retangulo.Position.X := X;
    Retangulo.Position.Y := Y;
    Retangulo.Width := 70;
    Retangulo.Height := 70;

    if (((I + 1) mod 2) = 0) and (I <> 0) then
      X := 10
    else
      X := X + 80;

    if X = 10 then
      Y := Y + 80;

    FListaInfoProdutosAdicionais.Add
      (TAdicionalView.Create(ItemSelecionado.Adicionais.Items[I].Produto,
      Retangulo));
  end;
end;

procedure TFrmComandaController.addItensTransferencia;
var
  I: Integer;
  Retangulo: TRectangle;
begin

  FItensTransferencia := TObjectList<TItemTransferenciaView>.Create;

  for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
  begin
    if FConta.ContaCliente.ItensContaCliente.Items[I].Cancelado = 0 then
    begin
      Retangulo := TRectangle.Create(FView.vRetItensTransferencia);
      Retangulo.Align := TAlignLayout.Top;
      Retangulo.Height := 50;
      Retangulo.Stroke.Color := TAlphaColors.White;
      Retangulo.Fill.Color := TAlphaColors.White;
      Retangulo.Parent := FView.vRetItensTransferencia;
      Retangulo.OnDblClick := onClickObItemTransferencia;
      Retangulo.Tag := I;

      FItensTransferencia.Add(TItemTransferenciaView.Create
        (FConta.ContaCliente.ItensContaCliente.Items[I], Retangulo));
    end;
  end;
end;

procedure TFrmComandaController.addPagamentosPaciais;
var
  I: Integer;
  Retangulo: TRectangle;
  X, Y: Single;
begin

  limpaPagamentosPaciais;

  TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

  X := 145;
  Y := 8;

  for I := 0 to FConta.ContaCliente.PagamentosParciais.Count - 1 do
  begin
    Retangulo := TRectangle.Create(FView.VertScrollBox1);
    Retangulo.Parent := FView.VertScrollBox1;
    Retangulo.Fill.Color := TAlphaColors.Whitesmoke;
    Retangulo.Stroke.Color := TAlphaColors.Black;
    Retangulo.Height := 100;
    Retangulo.Width := 130;
    Retangulo.Position.X := X;
    Retangulo.Position.Y := Y;
    Retangulo.Tag := I;
    Retangulo.OnClick := onClickPagamentoParcial;

    if (X + 140) > (FView.VertScrollBox1.Width - 140) then
      X := 8
    else
      X := X + 140;

    if (X = 8) then
      Y := Y + 110;

    FListaPagamentosParciais.Add
      (TPagamentoParcialView.Create(FConta.ContaCliente.PagamentosParciais.Items
      [I], Retangulo));
  end;

end;

procedure TFrmComandaController.addPagamentosParciaisProduto;
var
  I: Integer;
  Retangulo: TRectangle;
  Y: Single;
begin

  if ItemSelecionado = nil then
    exit;

  limpaPagamentosPaciais;
  if ItemSelecionado.PagamentosParciais.Count > 0 then
  begin

    Y := 8;

    for I := 0 to ItemSelecionado.PagamentosParciais.Count - 1 do
    begin
      Retangulo := TRectangle.Create(FView.vRetPagamentosParciaisProduto);
      Retangulo.Parent := FView.vRetPagamentosParciaisProduto;
      Retangulo.Fill.Color := TAlphaColors.Whitesmoke;
      Retangulo.Stroke.Color := TAlphaColors.Black;
      Retangulo.Height := 100;
      Retangulo.Width := 130;
      Retangulo.Position.X := 8;
      Retangulo.Position.Y := Y;
      Retangulo.Tag := I;
      Retangulo.OnClick := onClickPagamentoParcial;

      Y := Y + 110;

      FListaPagamentosParciais.Add
        (TPagamentoParcialView.Create(ItemSelecionado.PagamentosParciais.Items
        [I], Retangulo));
    end;
  end;
end;

procedure TFrmComandaController.addAdicionaisAgrupados(ProdutoAgrupado,
  ProdutoConta: TItemContaCliente);
var
  I: Integer;
begin
  for I := 0 to ProdutoConta.Adicionais.Count - 1 do
    ProdutoAgrupado.Adicionais.Add(ProdutoConta.Adicionais.Items[I]);
end;

procedure TFrmComandaController.addProdutosAgrupados(ItensContaClienteAgrupado
  : TObjectList<TItemContaCliente>);
var
  I: Integer;
  ItemContaCliente: TItemContaCliente;
begin
  for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
  begin
    if FConta.ContaCliente.ItensContaCliente.Items[I].ContaOrigem <= 0 then
    begin
      if FConta.ContaCliente.ItensContaCliente.Items[I].Cancelado = 0 then
      begin
        ItemContaCliente :=
          buscarProduto(FConta.ContaCliente.ItensContaCliente.Items[I]
          .Produto.Codigo, ItensContaClienteAgrupado);

        if Assigned(ItemContaCliente) then
        begin
          ItemContaCliente.Quantidade := ItemContaCliente.Quantidade +
            FConta.ContaCliente.ItensContaCliente.Items[I].Quantidade;
          ItemContaCliente.Total := ItemContaCliente.Quantidade *
            ItemContaCliente.Valor;
          addAdicionaisAgrupados(ItemContaCliente,
            FConta.ContaCliente.ItensContaCliente.Items[I]);
        end
        else
          ItensContaClienteAgrupado.Add
            (FConta.ContaCliente.ItensContaCliente.Items[I]);
      end;
    end;
  end;
end;

procedure TFrmComandaController.atualizaMesa;
begin
  if FConta.ContaCliente.ConferenciaEmitida = 'S' then
  begin
    FView.btnDesbloquearMesa.Enabled := True;
    FView.retStatusComanda.Fill.Color := TAlphaColors.Gold;
    FView.retStatusComanda.Stroke.Color := TAlphaColors.Gold;
  end
  else
  begin
    FView.btnDesbloquearMesa.Enabled := False;
    FView.retStatusComanda.Fill.Color := TAlphaColors.Green;
    FView.retStatusComanda.Stroke.Color := TAlphaColors.Green;
  end;
end;

procedure TFrmComandaController.atualizaProdutosImpressos;
begin
  TContaClienteDAO.getInstancia.atualizaProdutosImpressos
    (FConta.ContaCliente.Codigo);
end;

procedure TFrmComandaController.addSecoes;
var
  I: Integer;
  Retangulo: TRectangle;
  secoes: TObjectList<TSecao>;
  SecaoView: TSecaoView;
  X, Y: Single;
begin
  try
    try
      limpaSecoes;

      FView.retSecoes.Visible := False;
      addSecaoMaisUsado;

      secoes := TSecaoDAO.getInstancia.buscarTodosComProduto;

      X := 121;
      Y := 1;

      for I := 0 to secoes.Count - 1 do
      begin
        if (Assigned(secoes.Items[I]) and
          (not Assigned(buscaSecao(secoes.Items[I].Codigo)))) then
        begin

          Retangulo := TRectangle.Create(FView);
          Retangulo.Parent := FView.vRetSecoes;
          // Retangulo.Align := TAlignLayout.Top;
          Retangulo.Fill.Color := TAlphaColors.White;
          Retangulo.Stroke.Color := TAlphaColors.White;
          Retangulo.Cursor := crHandPoint;
          Retangulo.Height := 60;
          Retangulo.Width := 120;
          Retangulo.OnClick := onClickS;
          Retangulo.Tag := secoes.Items[I].Codigo;
          Retangulo.Position.X := X;
          Retangulo.Position.Y := Y;

          if (X + 120) > (FView.vRetSecoes.Width - 120) then
            X := 1
          else
            X := X + 120;

          if (X = 1) then
            Y := Y + 60;

          FView.vRetSecoes.AddObject(Retangulo);
          FListaSecoes.Add(TSecaoView.Create(Retangulo, secoes.Items[I]));
        end;
      end;

      addSecaoProdutoSelecionado(X, Y);
    except
      on E: Exception do
      begin
        Application.CreateForm(TFrmMensagem, FrmMensagem);
        FrmMensagem.FTipo := 0;
        FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
          ', não foi possível realizar a ação. Mensagem retornada: ' + E.Message
          + '. Class name: ' + E.ClassName;
        FrmMensagem.FTitulo := 'Aviso!';
        FrmMensagem.ShowModal;
      end;
    end;
  finally
    FView.retSecoes.Visible := True;
  end;
end;

procedure TFrmComandaController.botoes(Acao: Boolean);
var
  I: Integer;
begin
  for I := 0 to FView.ComponentCount - 1 do
    if ((FView.Components[I] is TCornerButton) and
      (not(FView.Components[I] = FView.btnDesbloquearMesa))) then
      if not TCornerButton(FView.Components[I]).Enabled then
        TCornerButton(FView.Components[I]).Enabled := True;
end;

procedure TFrmComandaController.btnAcrecimoFinalizacaoClick;
begin
  FView.btnDescontoFinalizacao.Enabled := False;

  FView.retFinalizacaoVenda.Enabled := False;

  FView.retLancamentoDescAcresFinalizacao.Position.X :=
    (FView.Width - FView.retLancamentoDescAcresFinalizacao.Width) / 2;
  FView.retLancamentoDescAcresFinalizacao.Position.Y :=
    (FView.Height - FView.retLancamentoDescAcresFinalizacao.Height) / 2;

  FView.Rectangle58.Fill.Color := TAlphaColors.Red;
  FView.Rectangle58.Stroke.Color := TAlphaColors.Red;

  FView.Label57.Text := 'Acréscimo';
  FView.Label57.Tag := 1;

  FView.EdtDescAcresFinalizacao.Text :=
    currtostrf(FConta.ContaCliente.Venda.Acrescimo, ffnumber, 2);

  FView.EdtDescAcresPercentualFinalizacao.Text :=
    currtostrf
    ((((FConta.ContaCliente.Total +
    StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim)) /
    FConta.ContaCliente.Total) - 1) * 100, ffnumber, 2);

  FView.EdtDescAcresFinalizacao.Align := TAlignLayout.Client;

  FView.retLancamentoDescAcresFinalizacao.Visible := True;

  FView.btnDescontoFinalizacao.Enabled := True;
end;

procedure TFrmComandaController.btnAddAdicionalClick;
begin
  FView.btnAddAdicional.Enabled := False;

  FView.EdtQuantidadeAdicional.Text :=
    CurrToStr((StrToCurr(FView.EdtQuantidadeAdicional.Text.Trim) + 1));

  FView.lblTotalAdicional.Text := 'Total: R$ ' + formatfloat('#,##0.00',
    FAdicionalSelecionado.Produto.PrecoVista *
    StrToCurr(FView.EdtQuantidadeAdicional.Text.Trim));
  FView.btnAddAdicional.Enabled := True;

end;

procedure TFrmComandaController.btnAddParcelasClick;
begin
  FView.btnAddParcelas.Enabled := False;

  FView.lblParcelasCartao.Text := stringreplace(FView.lblParcelasCartao.Text,
    '.', '', [rfReplaceAll, rfIgnoreCase]);

  FView.lblParcelasCartao.Text :=
    CurrToStr((StrToInt(FView.lblParcelasCartao.Text.Trim) + 1));

  FView.btnAddParcelas.Enabled := True;
end;

procedure TFrmComandaController.btnAddQuantidadeClick;
begin

  FView.btnAddQuantidade.Enabled := False;

  FView.EdtValorProduto.Text := stringreplace(FView.EdtValorProduto.Text, '.',
    '', [rfReplaceAll, rfIgnoreCase]);

  FView.EdtQuantidadeProduto.Text :=
    stringreplace(FView.EdtQuantidadeProduto.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]);

  FView.EdtQuantidadeProduto.Text :=
    CurrToStr((StrToCurr(FView.EdtQuantidadeProduto.Text.Trim) + 1));

  FView.EdtValorProduto.Text :=
    currtostrf(StrToCurr(FView.EdtQuantidadeProduto.Text) *
    FProdutoSelecionado.Produto.PrecoVista, ffnumber, 2);

  FView.EdtQuantidadeProduto.Text :=
    currtostrf(StrToCurr(FView.EdtQuantidadeProduto.Text), ffnumber, 2);

  FView.btnAddQuantidade.Enabled := True;

end;

procedure TFrmComandaController.btnAddQuantidadeProdutoTransferenciaClick;
Var
  Quantidade: Currency;
begin
  FView.btnAddQuantidadeProdutoTransferencia.Enabled := False;

  Quantidade := StrToCurr
    (stringreplace(FView.EdtQuantidadeProdutoTransferencia.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]));

  if (Quantidade + 1) <= FItensTransferencia.Items
    [FItemTransferenciaSelecionado].ItemContaCliente.Quantidade then
  begin
    Quantidade := Quantidade + 1;
  end;
  FView.EdtQuantidadeProdutoTransferencia.Text :=
    formatfloat('#,##0.00', Quantidade);

  FView.btnAddQuantidadeProdutoTransferencia.Enabled := True;
end;

procedure TFrmComandaController.btnAlteraInformacoesMesaClick;
begin

  FView.btnAlteraInformacoesMesa.Enabled := False;

  TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

  FView.retModalLancProduto.Visible := True;
  FView.retAlteraInformacoesMesa.Visible := True;

  FView.EdtDescricaoMesa.Text := FConta.ContaCliente.DescricaoMesa;
  FView.EdtQuantidadePessoas.Text :=
    IntToStr(FConta.ContaCliente.NumeroPessoas);

  FView.retAlteraInformacoesMesa.Position.X :=
    (FView.Width - FView.retAlteraInformacoesMesa.Width) / 2;
  FView.retAlteraInformacoesMesa.Position.Y :=
    (FView.Height - FView.retAlteraInformacoesMesa.Height) / 2;

  FView.btnAlteraInformacoesMesa.Enabled := True;

end;

procedure TFrmComandaController.btnAlterarDadosVendaFinalizacaoClick;
begin
  FView.btnAlterarDadosVendaFinalizacao.Enabled := False;

  Application.CreateForm(TFrmAlterarDadosVenda, FrmAlterarDadosVenda);
  TFrmAlterarDadosVendaController.FVenda := FConta.ContaCliente.Venda;
  FrmAlterarDadosVenda.ShowModal;

  addInformacoesFinalizacao;

  FView.btnAlterarDadosVendaFinalizacao.Enabled := True;
end;

procedure TFrmComandaController.btnAlterarInformacoesFinalizacaoClick;
begin
  FView.btnAlterarInformacoesFinalizacao.Enabled := False;

  FView.retModalLancProduto.Visible := True;
  FView.retAlteraInformacoesMesa.Visible := True;

  FView.retFinalizacaoVenda.Enabled := False;

  FView.EdtDescricaoMesa.Text := FConta.ContaCliente.DescricaoMesa;
  FView.EdtQuantidadePessoas.Text :=
    IntToStr(FConta.ContaCliente.NumeroPessoas);

  FView.retAlteraInformacoesMesa.Position.X :=
    (FView.Width - FView.retAlteraInformacoesMesa.Width) / 2;
  FView.retAlteraInformacoesMesa.Position.Y :=
    (FView.Height - FView.retAlteraInformacoesMesa.Height) / 2;

  FView.btnAlterarInformacoesFinalizacao.Enabled := True;
end;

procedure TFrmComandaController.btnBuscarProdutosClick;
var
  I: Integer;
  X, Y: Single;
  Retangulo: TRectangle;
  Produto: TProduto;
  Result_Produtos: TFDQuery;
begin
  try
    X := 8;
    Y := 8;
    FView.vRetProdutos.Visible := False;

    Result_Produtos := nil;

    Result_Produtos := TProdutoDao.getInstancia.buscaProdutosDesc
      (FView.EdtBuscaProduto.Text);

    Result_Produtos.First;
    while not Result_Produtos.EOF do
    begin
      Produto := TProduto.Create;
      Produto.Codigo := Result_Produtos.FieldByName('COD_PRO').AsInteger;
      Produto.nome := Result_Produtos.FieldByName('NOME_PRO').AsString;
      Produto.DescricaoCupom := Result_Produtos.FieldByName
        ('DESC_CUPOM').AsString;
      Produto.CaminhoFoto := Result_Produtos.FieldByName
        ('CAMINHO_FOTO_PRO').AsString;

      Produto.QuantidadeComposicao := Result_Produtos.FieldByName
        ('TOTAL_PRODUTOS_COMPOSICAO').AsInteger;

      Retangulo := TRectangle.Create(FView.vRetProdutos);
      Retangulo.Parent := FView.vRetProdutos;
      Retangulo.Fill.Color := TAlphaColors.Whitesmoke;
      Retangulo.Stroke.Color := TAlphaColors.Gray;
      Retangulo.Width := 100;
      Retangulo.Height := 100;
      Retangulo.Cursor := crHandPoint;
      Retangulo.Tag := Produto.Codigo;
      Retangulo.OnDblClick := onClickP;
      Retangulo.Position.X := X;
      Retangulo.Position.Y := Y;

      if (X + 105) > (FView.vRetProdutos.Width - 105) then
        X := 8
      else
        X := X + 105;

      if (X = 8) then
        Y := Y + 105;

      FListaProdutos.Add(TProdutoView.Create(Retangulo, Produto));
      Result_Produtos.Next;
    end;

    if Assigned(Result_Produtos) then
      TConexaoFiredac.getInstancia.closeConnection(Result_Produtos);

  finally
    FView.retSeparadorProdutos.Width := FView.vRetProdutos.Width;
    FView.retSeparadorProdutos.Position.X := 0;
    FView.retSeparadorProdutos.Height := 3;
    FView.retSeparadorProdutos.Align := TAlignLayout.Bottom;
    FView.vRetProdutos.Visible := True;
    FView.retConsultaProduto.Visible := False;
    FView.retModalLancProduto.Visible := False;

  end;
end;

procedure TFrmComandaController.btnCancelarAlteraInformacoesClick;
begin

  FView.btnCancelarAlteraInformacoes.Enabled := False;

  if not FView.retFinalizacaoVenda.Visible then
    FView.retModalLancProduto.Visible := False;

  if FView.retFinalizacaoVenda.Visible then
    FView.retFinalizacaoVenda.Enabled := True;

  FView.retAlteraInformacoesMesa.Visible := False;

  FView.EdtQuantidadePessoas.Text := '';
  FView.EdtDescricaoMesa.Text := '';

  FView.btnCancelarAlteraInformacoes.Enabled := True;
end;

procedure TFrmComandaController.btnCancelarIndicadorClick;
begin

  FView.btnCancelarIndicador.Enabled := False;

  FView.retModalLancProduto.Visible := False;
  FView.retAddIndicador.Visible := False;

  addDados;

  FView.btnCancelarIndicador.Enabled := True;
end;

procedure TFrmComandaController.btnCancelarItemClick;
begin

  FView.btnCancelarItem.Enabled := False;

  FView.mmObservacaoCancelItem.Text := '';

  if DMConexao.Configuracao.SolicitaObsCancelComanda then
  begin

    FView.retObsCancelamentoItem.Position.X :=
      (FView.Width - FView.retObsCancelamentoItem.Width) / 2;
    FView.retObsCancelamentoItem.Position.Y :=
      (FView.Height - FView.retObsCancelamentoItem.Height) / 2;

    FView.retObsCancelamentoItem.Visible := True;
    FView.retInformacoesItemConta.Enabled := False;
    FView.btnCancelarItem.Enabled := True;
    exit;

  end
  else
    CancelaItem;

  btnDesistirInformacaoItemClick;

  FView.btnCancelarItem.Enabled := True;

end;

procedure TFrmComandaController.btnCancelarMesaClick;
var
  Value: Integer;
begin

  FView.btnCancelarMesa.Enabled := False;

  if not DMConexao.Usuario.buscaAcesso('A010') then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', Você não tem permissão para efetuar esta operação.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    FView.btnCancelarMesa.Enabled := True;
    exit;
  end;

  Value := DMConexao.mensagem(DMConexao.Usuario.nome +
    ', Confirma o cancelamento dessa comanda?', 1);

  if Value = 6 then
  begin
    FView.mmObservacao.Text := '';

    if DMConexao.Configuracao.SolicitaObsCancelComanda then
    begin

      FView.retObsCancelaMesa.Position.X :=
        (FView.Width - FView.retObsCancelaMesa.Width) / 2;
      FView.retObsCancelaMesa.Position.Y :=
        (FView.Height - FView.retObsCancelaMesa.Height) / 2;

      FView.retModalLancProduto.Visible := True;
      FView.retObsCancelaMesa.Visible := True;

      FView.mmObservacao.SetFocus;
    end
    else
      cancelaMesa;

  end;

  FView.btnCancelarMesa.Enabled := True;
end;

procedure TFrmComandaController.btnCancelarTransferenciaClick;
begin

  FView.btnCancelarTransferencia.Enabled := False;

  FView.retModalLancProduto.Visible := False;
  FView.retTransferenciaComanda.Visible := False;

  FContaTransferencia := nil;
  FView.EdtMesaTransferencia.Enabled := True;
  FView.btnSelecionarMesaTransferencia.Text := 'Selecionar comanda';

  limpaItensTransferencia;

  FView.btnCancelarTransferencia.Enabled := True;
end;

procedure TFrmComandaController.btnConferenciaDetalhadaClick;
var
  comprovante: TComprovante;
  I, Y: Integer;
  fecha: Boolean;
  sOrdemProduto, sQuantidadeProduto, sValorProduto, sValorProdutoCAdicional,
    sTotalProduto, sTotalProdutoCAdicional, sNomeGarcom: String;
  sTotalTodosProdutosAdicional, sQuantidadeProdutoAdicional,
    sValorProdutoAdicional, sTotalProdutoAdicional: String;
  sOrdemParcial, sHistoricoParcial, sDataHoraParcial, sValorParcial: String;
  cTotalMesa, cTotalTaxa: Currency;
begin
  try
    try

      FView.btnConferenciaDetalhada.Enabled := False;

      if not DMConexao.Usuario.buscaAcesso('M121') then
      begin
        Application.CreateForm(TFrmMensagem, FrmMensagem);
        FrmMensagem.FTipo := 0;
        FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
          ', Você não tem permissão para efetuar esta operação.';
        FrmMensagem.FTitulo := 'Aviso!';
        FrmMensagem.ShowModal;
        FView.btnConferenciaDetalhada.Enabled := True;

        exit;
      end;

      fecha := False;

      FView.btnConferenciaDetalhada.Enabled := False;

      TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

      with FConta.ContaCliente do
      begin
        comprovante := TComprovante.Create;

        { INFORMO O TITULO DO COMPROVANTE }
        if VendaDelivery = 'S' then
          comprovante.Titulo := 'CONFERENCIA DE VENDA DELIVERY DETALHADA'
        else if VendaBalcao = 'S' then
          comprovante.Titulo := 'CONFERENCIA DE VENDA BALCAO DETALHADA'
        else
          comprovante.Titulo := 'CONFERENCIA DETALHADA DA CONTA';

        comprovante.abreComprovante;

        comprovante.imprimeTextoComprovanteValor('COMANDA: ',
          comprovante.FormataStringD(IntToStr(Conta), '3', '0'));

        if DescricaoMesa.Trim <> '' then
          comprovante.imprimeTextoComprovanteValor('DESC. COMANDA: ',
            DescricaoMesa.Trim);

        if NumeroPessoas > 0 then
          comprovante.imprimeTextoComprovanteValor('NUM.PESSOAS: ',
            IntToStr(NumeroPessoas));

        comprovante.imprimeTextoComprovanteValor('DATA ABERTURA: ',
          DateToStr(DataAbertura));
        comprovante.imprimeTextoComprovanteValor('HORA ABERTURA: ',
          TimeToStr(HoraAbertura));

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
        begin
          if comprovante.NumeroColunas < 40 then
          begin
            comprovante.imprimeTextoComprovante('DESCRICAO', 'E', False);
            comprovante.imprimeTextoComprovanteEspaco('',
              'QTD    VALOR     TOTAL');
          end
          else
            comprovante.imprimeTextoComprovanteEspaco('DESCRICAO',
              'QTD    VALOR     TOTAL');
        end
        else
        begin
          if comprovante.NumeroColunas < 40 then
          begin
            comprovante.imprimeTextoComprovante('ITEM  DESCRICAO', 'E', False);
            comprovante.imprimeTextoComprovanteEspaco('',
              'QTD    VALOR     TOTAL');
          end
          else
            comprovante.imprimeTextoComprovanteEspaco('ITEM  DESCRICAO',
              'QTD    VALOR     TOTAL');
        end;

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        cTotalMesa := 0;
        cTotalTaxa := 0;
        for I := 0 to ItensContaCliente.Count - 1 do
        begin
          fecha := True;
          with ItensContaCliente.Items[I] do
          begin
            sOrdemProduto := comprovante.FormataStringD(IntToStr(Ordem),
              '4', '0');
            sQuantidadeProduto := CurrToStr(Quantidade);
            sValorProduto := currtostrf(Valor, ffnumber, 2);
            sValorProdutoCAdicional := currtostrf(TotalAdicional, ffnumber, 2);
            sTotalProduto := currtostrf(Total, ffnumber, 2);
            sTotalProdutoCAdicional := currtostrf(Total + TotalAdicional,
              ffnumber, 2);

            if comprovante.NumeroColunas < 40 then
            begin
              { RETIRAR REFERENCIA DOS PRODUTOS }
              if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
              begin
                comprovante.imprimeTextoComprovanteValor(Produto.DescricaoCupom,
                  comprovante.FormataStringD(sQuantidadeProduto, '11', ' ') +
                  comprovante.FormataStringE(sValorProdutoCAdicional, '11', ' ')
                  + comprovante.FormataStringE(sTotalProdutoCAdicional, '0',
                  ' '), 'C');

                if DMConexao.Configuracao.NomeGarcomConferenciaDetalhada then
                  comprovante.imprimeTextoComprovante
                    ('GARCOM: ' + Garcom.nome.Trim + '     ' + 'HORA: ' +
                    TimeToStr(Hora), 'C', False, 'C');

                if Cancelado = 1 then
                  comprovante.imprimeTextoComprovanteValor('CANCELADO',
                    '-' + currtostrf(Total, ffnumber, 2), 'C');

                if ContaOrigem > 0 then
                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('TRANSF. DA COMANDA: ' +
                    comprovante.FormataStringD(IntToStr(ContaOrigem), '3', '0')
                    ), 'C', False, 'C');
              end
              else
              begin
                comprovante.imprimeTextoComprovante(sOrdemProduto + ' ' +
                  Produto.DescricaoCupom, 'E', False);

                comprovante.imprimeTextoComprovanteValor('',
                  comprovante.FormataStringE(sQuantidadeProduto, '5', ' ') +
                  comprovante.FormataStringE(sValorProdutoCAdicional, '10', ' ')
                  + comprovante.FormataStringE(sTotalProdutoCAdicional,
                  '0', ' '));

                if DMConexao.Configuracao.NomeGarcomConferenciaDetalhada then
                  comprovante.imprimeTextoComprovante
                    ('GARCOM: ' + Garcom.nome.Trim + '     ' + 'HORA: ' +
                    TimeToStr(Hora), 'C', False);

                if Cancelado = 1 then
                  comprovante.imprimeTextoComprovanteValor('CANCELADO',
                    '-' + currtostrf(Total, ffnumber, 2));

                if ContaOrigem > 0 then
                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('TRANSF. DA COMANDA: ' +
                    comprovante.FormataStringD(IntToStr(ContaOrigem), '3', '0')
                    ), 'C', False);
              end;
            end
            else
            begin
              { RETIRAR REFERENCIA DOS PRODUTOS }
              if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
              begin

                comprovante.imprimeTextoComprovanteValor
                  (Produto.DescricaoCupom.Trim,
                  comprovante.FormataStringD(sQuantidadeProduto, '11', ' ') +
                  comprovante.FormataStringE(sValorProdutoCAdicional, '11', ' ')
                  + comprovante.FormataStringE(sTotalProdutoCAdicional, '0',
                  ' '), 'C');

                if DMConexao.Configuracao.NomeGarcomConferenciaDetalhada then
                  comprovante.imprimeTextoComprovante
                    ('GARCOM: ' + Garcom.nome.Trim + '     ' + 'HORA: ' +
                    TimeToStr(Hora), 'C', False, 'C');

                if Cancelado = 1 then
                  comprovante.imprimeTextoComprovanteValor('CANCELADO',
                    '-' + currtostrf(Total, ffnumber, 2), 'C');

                if ContaOrigem > 0 then
                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('TRANSF. DA COMANDA: ' +
                    comprovante.FormataStringD(IntToStr(ContaOrigem), '3', '0')
                    ), 'C', False, 'C');
              end
              else
              begin
                comprovante.imprimeTextoComprovante(sOrdemProduto + ' ' +
                  Produto.DescricaoCupom, 'E', False);

                comprovante.imprimeTextoComprovanteValor('',
                  comprovante.FormataStringE(sQuantidadeProduto, '5', ' ') +
                  comprovante.FormataStringE(sValorProdutoCAdicional, '10', ' ')
                  + comprovante.FormataStringE(sTotalProdutoCAdicional,
                  '0', ' '));

                if DMConexao.Configuracao.NomeGarcomConferenciaDetalhada then
                  comprovante.imprimeTextoComprovante
                    ('GARCOM: ' + Garcom.nome.Trim + '     ' + 'HORA: ' +
                    TimeToStr(Hora), 'C', False);

                if Cancelado = 1 then
                  comprovante.imprimeTextoComprovanteValor('CANCELADO',
                    '-' + currtostrf(Total, ffnumber, 2), 'N');

                if ContaOrigem > 0 then
                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('TRANSF. DA COMANDA: ' +
                    comprovante.FormataStringD(IntToStr(ContaOrigem), '3', '0')
                    ), 'C', False);
              end;

            end;

            for Y := 0 to Adicionais.Count - 1 do
            begin
              with Adicionais.Items[I] do
              begin
                sValorProdutoAdicional := currtostrf(Valor, ffnumber, 2);

                sQuantidadeProdutoAdicional := CurrToStr(Quantidade);

                sTotalTodosProdutosAdicional :=
                  currtostrf(TotalAdicional, ffnumber, 2);

                if comprovante.NumeroColunas < 40 then
                begin
                  { RETIRAR REFERENCIA DOS PRODUTOS }
                  if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
                  begin

                    if DMConexao.Configuracao.DiscriminarValorPorAdicionalRestante
                    then
                      comprovante.imprimeTextoComprovante
                        (comprovante.boldText('+ ' + Produto.DescricaoCupom.Trim
                        + ' ' + comprovante.FormataStringD
                        (sQuantidadeProdutoAdicional, '4', ' ') + ' ' +
                        comprovante.FormataStringD(sValorProdutoAdicional, '10',
                        ' ') + ' ' + comprovante.FormataStringD
                        (sTotalTodosProdutosAdicional, '0', ' ')), 'D',
                        False, 'C')
                    else
                      comprovante.imprimeTextoComprovante
                        (comprovante.boldText('+ ' + Produto.DescricaoCupom.Trim
                        + ' ' + comprovante.FormataStringD
                        (sQuantidadeProdutoAdicional, '4', ' ') + ' ' +
                        comprovante.FormataStringD(sValorProdutoAdicional, '5',
                        ' ') + ' '), 'D', False, 'C');

                    if Cancelado = 1 then
                      comprovante.imprimeTextoComprovante('ADICIONAL CANCELADO',
                        'E', False, 'C');
                  end
                  else
                  begin
                    if DMConexao.Configuracao.DiscriminarValorPorAdicionalRestante
                    then
                      comprovante.imprimeTextoComprovante
                        (comprovante.boldText('+ ' + Produto.DescricaoCupom.Trim
                        + ' ' + comprovante.FormataStringD
                        (sQuantidadeProdutoAdicional, '9', ' ') + ' ' +
                        comprovante.FormataStringD(sValorProdutoAdicional, '5',
                        ' ') + ' ' + comprovante.FormataStringD
                        (sTotalTodosProdutosAdicional, '8', ' ')), 'D', False)
                    else
                      comprovante.imprimeTextoComprovante
                        (comprovante.boldText('+ ' + Produto.DescricaoCupom.Trim
                        + ' ' + comprovante.FormataStringD
                        (sQuantidadeProdutoAdicional, '5', ' ') + ' ' +
                        comprovante.FormataStringD(sValorProdutoAdicional, '8',
                        ' ') + ' '), 'D', False);

                    if Cancelado = 1 then
                      comprovante.imprimeTextoComprovante('ADICIONAL CANCELADO',
                        'E', False, 'N');
                  end;
                end
                else
                begin
                  { RETIRAR REFERENCIA DOS PRODUTOS }
                  if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
                  begin

                    if DMConexao.Configuracao.DiscriminarValorPorAdicionalRestante
                    then
                      comprovante.imprimeTextoComprovante
                        (comprovante.boldText('+ ' + Produto.DescricaoCupom.Trim
                        + ' ' + comprovante.FormataStringD
                        (sQuantidadeProdutoAdicional, '4', ' ') + ' ' +
                        comprovante.FormataStringD(sValorProdutoAdicional, '10',
                        ' ') + ' ' + comprovante.FormataStringD
                        (sTotalTodosProdutosAdicional, '0', ' ')), 'D',
                        False, 'C')
                    else
                      comprovante.imprimeTextoComprovante
                        (comprovante.boldText('+ ' + Produto.DescricaoCupom.Trim
                        + ' ' + comprovante.FormataStringD
                        (sQuantidadeProdutoAdicional, '4', ' ') + ' ' +
                        comprovante.FormataStringD(sValorProdutoAdicional, '5',
                        ' ') + ' '), 'D', False, 'C');

                    if Cancelado = 1 then
                      comprovante.imprimeTextoComprovante('ADICIONAL CANCELADO',
                        'E', False, 'C');
                  end
                  else
                  begin
                    if DMConexao.Configuracao.DiscriminarValorPorAdicionalRestante
                    then
                      comprovante.imprimeTextoComprovante
                        (comprovante.boldText('+ ' + Produto.DescricaoCupom.Trim
                        + ' ' + comprovante.FormataStringD
                        (sQuantidadeProdutoAdicional, '9', ' ') + ' ' +
                        comprovante.FormataStringD(sValorProdutoAdicional, '5',
                        ' ') + ' ' + comprovante.FormataStringD
                        (sTotalTodosProdutosAdicional, '8', ' ')), 'D', False)
                    else
                      comprovante.imprimeTextoComprovante
                        (comprovante.boldText('+ ' + Produto.DescricaoCupom.Trim
                        + ' ' + comprovante.FormataStringD
                        (sQuantidadeProdutoAdicional, '5', ' ') + ' ' +
                        comprovante.FormataStringD(sValorProdutoAdicional, '8',
                        ' ') + ' '), 'D', False);

                    if Cancelado = 1 then
                      comprovante.imprimeTextoComprovante('ADICIONAL CANCELADO',
                        'E', False, 'N');
                  end;
                end;
              end;
            end;

            comprovante.imprimeTextoComprovante(comprovante.linhaPontilhada);

            if DMConexao.Configuracao.DiscriminarValorPorAdicionalRestante then
            begin
              if Cancelado = 0 then
                cTotalMesa := cTotalMesa + Total + TotalAdicional;

              if ((Cancelado = 0) and
                (Produto.CobrarTaxaServicoRestaurante = 'S') and
                (FConta.ContaCliente.DispensarTaxaServico = 'N')) then
                cTotalTaxa := cTotalTaxa + Total + TotalAdicional;

            end
            else
            begin
              if Cancelado = 0 then
                cTotalMesa := cTotalMesa + Total;

              if ((Cancelado = 0) and
                (Produto.CobrarTaxaServicoRestaurante = 'S') and
                (FConta.ContaCliente.DispensarTaxaServico = 'N')) then
                cTotalTaxa := cTotalTaxa + Total;
            end;
          end;
        end;

        comprovante.imprimeTextoComprovanteValor('TOTAL DA COMANDA: ',
          currtostrf(cTotalMesa, ffCurrency, 2));

        if FConta.ContaCliente.ValorPacial > 0 then
        begin

          TContaClienteDAO.getInstancia.buscarParciais(FConta.ContaCliente);

          comprovante.imprimeTextoTitulo('PARCIAIS');

          for I := 0 to PagamentosParciais.Count - 1 do
          begin
            with PagamentosParciais.Items[I] do
            begin
              sOrdemParcial := comprovante.FormataStringD(IntToStr(Ordem),
                '4', '0');
              sHistoricoParcial := Historico;
              sDataHoraParcial := TimeToStr(DataHora);
              sValorParcial := currtostrf(Valor, ffCurrency, 2);

              if comprovante.NumeroColunas < 40 then
              begin
                comprovante.imprimeTextoComprovante(sOrdemParcial + ' ' +
                  comprovante.FormataStringE(copy(sHistoricoParcial, 1, 27),
                  '27', ' '));
                comprovante.imprimeTextoComprovante('     ' + sDataHoraParcial +
                  '   ' + comprovante.FormataStringD(sValorParcial, '16', ' '));
              end
              else
                comprovante.imprimeTextoComprovanteValor
                  (sOrdemParcial + ' ' + sDataHoraParcial + ' ' +
                  comprovante.FormataStringE(copy(sHistoricoParcial, 1, 17),
                  '17', ' '), comprovante.FormataStringD(sValorParcial,
                  '9', ' '));
            end;
          end;

          comprovante.imprimeTextoComprovante('', 'E', False);

          comprovante.imprimeTextoComprovanteValor('TOTAL PARCIAL: ',
            currtostrf(ValorPacial, ffCurrency, 2));

          comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        end;

        comprovante.imprimeTextoComprovanteValor('TAXA DE SERVICO: ',
          currtostrf(DMConexao.CalcularTaxaServico(cTotalTaxa,
          FConta.ContaCliente), ffCurrency, 2));

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        comprovante.imprimeTextoComprovanteValor('TOTAL A PAGAR: ',
          currtostrf(DMConexao.CalcularTaxaServico(cTotalTaxa,
          FConta.ContaCliente) + cTotalMesa - ValorPacial, ffCurrency, 2));

        if NumeroPessoas > 0 then
          comprovante.imprimeTextoComprovanteValor('TOTAL PAGAR P/PESSOA: ',
            currtostrf((DMConexao.CalcularTaxaServico(cTotalTaxa,
            FConta.ContaCliente) + cTotalMesa - ValorPacial) / NumeroPessoas,
            ffCurrency, 2));
      end;

      if DMConexao.Configuracao.BloqueiaMesaComConferencia then
      begin
        FConta.ContaCliente.Caixa.Codigo := DMConexao.Configuracao.Caixa.Codigo;
        FConta.ContaCliente.ConferenciaEmitida := 'S';

        TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);

        atualizaMesa;
      end;
    except
      on E: Exception do
      begin
        Application.CreateForm(TFrmMensagem, FrmMensagem);
        FrmMensagem.FTipo := 0;
        FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
          ', não foi possível imprimir a conferência ' +
          'detalhada. Mensagem retornada: ' + E.Message;
        FrmMensagem.FTitulo := 'Atenção!';
        FrmMensagem.ShowModal;
        fecha := False;
      end;
    end;
  finally
    FView.btnConferenciaDetalhada.Enabled := True;

    comprovante.fechaComprovante(False, False, 8, fecha);
  end;
end;

procedure TFrmComandaController.btnConferenciaResumidaClick;
var
  comprovante: TComprovante;
  I, iOrdemItem, Y: Integer;
  sTotalProduto, sQuantidadeProduto, sValorProduto, sNomeProduto,
    sOrdemProduto: String;
  sTotalProdutoAdicional, sQuantidadeProdutoAdicional, sValorProdutoAdicional,
    sNomeProdutoAdicional, sOrdemProdutoAdicional, sContaOrigem: String;
  ItensContaClienteAgrupado: TObjectList<TItemContaCliente>;
  cTotalAdicional, cTotalAdicionalTaxaCalc, cValorTotal, cTotalTaxaCalc
    : Currency;
  fecha: Boolean;
begin
  try
    try

      FView.btnConferenciaResumida.Enabled := False;
      if not DMConexao.Usuario.buscaAcesso('M121') then
      begin
        Application.CreateForm(TFrmMensagem, FrmMensagem);
        FrmMensagem.FTipo := 0;
        FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
          ', Você não tem permissão para efetuar esta operação.';
        FrmMensagem.FTitulo := 'Aviso!';
        FrmMensagem.ShowModal;

        FView.btnConferenciaResumida.Enabled := True;
        exit;
      end;

      fecha := True;

      cTotalAdicionalTaxaCalc := 0;
      cValorTotal := 0;
      cTotalTaxaCalc := 0;

      TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

      with FConta.ContaCliente do
      begin
        { CRIO O COMPROVANTE }
        comprovante := TComprovante.Create;

        { CRIO O ARRAY LIST DE PRODUTOS IGUAIS }
        ItensContaClienteAgrupado := TObjectList<TItemContaCliente>.Create;

        { INFORMO O TITULO DO COMPROVANTE }
        if VendaDelivery = 'S' then
          comprovante.Titulo := 'CONFERENCIA DE VENDA DELIVERY'
        else if VendaBalcao = 'S' then
          comprovante.Titulo := 'CONFERENCIA DE VENDA BALCAO'
        else
          comprovante.Titulo := 'CONFERENCIA RESUMIDA DA CONTA';

        { CRIO TODO O CABECALO DO COMPROVANTE }
        comprovante.abreComprovante;

        { COLOCO O CONTEUDO DO COMPROVANTE }
        comprovante.imprimeTextoComprovanteValor('COMANDA: ',
          Trim(comprovante.FormataStringD(IntToStr(Conta), '3', '0')));

        if DescricaoMesa.Trim <> '' then
          comprovante.imprimeTextoComprovanteValor('DESC. COMANDA: ',
            copy(DescricaoMesa.Trim, 1, 20));

        if IntToStr(NumeroPessoas).Trim <> '' then
          if NumeroPessoas > 0 then
            comprovante.imprimeTextoComprovanteValor('NUM.PESSOAS: ',
              IntToStr(NumeroPessoas).Trim);

        comprovante.imprimeTextoComprovanteValor('DATA ABERTURA: ',
          DateToStr(DataAbertura));
        comprovante.imprimeTextoComprovanteValor('HORA ABERTURA: ',
          TimeToStr(HoraAbertura));

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
        begin
          if comprovante.NumeroColunas < 40 then
          begin
            comprovante.imprimeTextoComprovante('DESCRICAO', 'E', False);
            comprovante.imprimeTextoComprovanteEspaco('',
              'QTD    VALOR     TOTAL');
          end
          else
            comprovante.imprimeTextoComprovanteEspaco('DESCRICAO',
              'QTD    VALOR     TOTAL');
        end
        else
        begin
          if comprovante.NumeroColunas < 40 then
          begin
            comprovante.imprimeTextoComprovante('ITEM  DESCRICAO', 'E', False);
            comprovante.imprimeTextoComprovanteEspaco('',
              'QTD    VALOR     TOTAL');
          end
          else
            comprovante.imprimeTextoComprovanteEspaco('ITEM  DESCRICAO',
              'QTD    VALOR     TOTAL');
        end;

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        { PEGO OS PRODUTOS AGRUPADOS PELA QUANTIDADE }
        addProdutosAgrupados(ItensContaClienteAgrupado);

        iOrdemItem := 1;

        { PRODUTOS NÃO CANCELADOS E NÃO TRANSFERIDOS }
        for I := 0 to ItensContaClienteAgrupado.Count - 1 do
        begin
          sTotalProduto := currtostrf(ItensContaClienteAgrupado.Items[I].Total,
            ffnumber, 2);

          sQuantidadeProduto :=
            CurrToStr(ItensContaClienteAgrupado.Items[I].Quantidade);

          sValorProduto := currtostrf(ItensContaClienteAgrupado.Items[I].Valor,
            ffnumber, 2);

          sNomeProduto := ItensContaClienteAgrupado.Items[I]
            .Produto.DescricaoCupom;

          sOrdemProduto := comprovante.FormataStringD(IntToStr(iOrdemItem),
            '4', '0');

          if comprovante.NumeroColunas < 40 then
          begin
            { Impressão sem o numero do item }
            if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
            begin
              comprovante.imprimeTextoComprovante(sNomeProduto, 'E',
                False, 'C');

              comprovante.imprimeTextoComprovanteValor('',
                comprovante.FormataStringE(sQuantidadeProduto, '7', ' ') + ' ' +
                comprovante.FormataStringE(sValorProduto, '12', ' ') + ' ' +
                comprovante.FormataStringE(sTotalProduto, '0', ' '),
                'C', False);
            end
            else
            begin
              comprovante.imprimeTextoComprovante(sOrdemProduto + ' ' +
                sNomeProduto, 'E', False);

              comprovante.imprimeTextoComprovanteValor('',
                comprovante.FormataStringE(sQuantidadeProduto, '4', ' ') + ' ' +
                comprovante.FormataStringE(sValorProduto, '9', ' ') + ' ' +
                comprovante.FormataStringE(sTotalProduto, '0', ' '));
            end;
          end
          else
          begin
            { Imprime conferencia sem o número do item }
            if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
              comprovante.imprimeTextoComprovanteValor(sNomeProduto,
                comprovante.FormataStringD(sQuantidadeProduto, '5', ' ') +
                comprovante.FormataStringD(sValorProduto, '11', ' ') +
                comprovante.FormataStringD(sTotalProduto, '14', ' '),
                'C', False)
            else
            begin
              comprovante.imprimeTextoComprovante(sOrdemProduto + '  ' +
                sNomeProduto, 'E', False);

              comprovante.imprimeTextoComprovanteValor('',
                comprovante.FormataStringE(sQuantidadeProduto, '4', ' ') + ' ' +
                comprovante.FormataStringE(sValorProduto, '9', ' ') + ' ' +
                comprovante.FormataStringE(sTotalProduto, '0', ' '));
            end;
          end;

          cTotalAdicional := 0;

          for Y := 0 to ItensContaClienteAgrupado.Items[I]
            .Adicionais.Count - 1 do
          begin
            sNomeProdutoAdicional := ItensContaClienteAgrupado.Items[I]
              .Adicionais.Items[Y].Produto.DescricaoCupom;

            sTotalProdutoAdicional :=
              currtostrf(ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y]
              .Total, ffnumber, 2);

            sQuantidadeProdutoAdicional :=
              CurrToStr(ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y]
              .Quantidade);

            sValorProdutoAdicional :=
              currtostrf(ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y]
              .Valor, ffnumber, 2);

            if comprovante.NumeroColunas < 40 then
            begin
              { IMPRIME SEM A REFERENCIA E COM A FONTE MENOR }
              if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
              begin
                comprovante.imprimeTextoComprovante
                  (comprovante.boldText('+ ' + sNomeProdutoAdicional), 'E',
                  False, 'C');

                comprovante.imprimeTextoComprovanteValor('',
                  comprovante.boldText(comprovante.FormataStringE
                  (sQuantidadeProdutoAdicional, '6', ' ') + ' ' +
                  comprovante.FormataStringE(sValorProdutoAdicional, '10',
                  ' ') + ' ' + comprovante.FormataStringE
                  (sTotalProdutoAdicional, '0', ' ')), 'C', False);

                if ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y]
                  .Cancelado = 1 then
                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('ADICIONAL CANCELADO'), 'E',
                    False, 'C');
              end
              else
              begin
                comprovante.imprimeTextoComprovante
                  (comprovante.boldText('+ ' + sNomeProdutoAdicional), 'E',
                  False, 'N');

                comprovante.imprimeTextoComprovante
                  (comprovante.boldText(comprovante.FormataStringD
                  (sQuantidadeProdutoAdicional, '4', ' ') + ' ' +
                  comprovante.FormataStringD(sValorProdutoAdicional, '8', ' ') +
                  ' ' + comprovante.FormataStringD(sTotalProdutoAdicional, '9',
                  ' ')), 'E', False);

                if ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y]
                  .Cancelado = 1 then
                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('ADICIONAL CANCELADO'), 'C',
                    False, 'C');
              end;
            end
            else
            begin
              { IMPRIME SEM A REFERENCIA E COM A FONTE MENOR }
              if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
              begin
                comprovante.imprimeTextoComprovante
                  (comprovante.boldText('+ ' + sNomeProdutoAdicional + ' ' +
                  comprovante.FormataStringD(sQuantidadeProdutoAdicional, '6',
                  ' ') + ' ' + comprovante.FormataStringD
                  (sValorProdutoAdicional, '10', ' ') + ' ' +
                  comprovante.FormataStringD(sTotalProdutoAdicional, '13', ' ')
                  ), 'D', False, 'C');

                if ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y]
                  .Cancelado = 1 then
                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('ADICIONAL CANCELADO'), 'C',
                    False, 'C');
              end
              else
              begin

                comprovante.imprimeTextoComprovante
                  (comprovante.boldText('+ ' + sNomeProdutoAdicional + ' ' +
                  comprovante.FormataStringD(sQuantidadeProdutoAdicional, '4',
                  ' ') + ' ' + comprovante.FormataStringD
                  (sValorProdutoAdicional, '8', ' ') + ' ' +
                  comprovante.FormataStringD(sTotalProdutoAdicional, '9', ' ')),
                  'D', False);

                if ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y]
                  .Cancelado = 1 then
                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('ADICIONAL CANCELADO'), 'C',
                    False, 'C');
              end;
            end;

            cTotalAdicional := cTotalAdicional + ItensContaClienteAgrupado.Items
              [I].Adicionais.Items[Y].Total;

            if ((ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y]
              .Produto.CobrarTaxaServicoRestaurante = 'S') and
              (FConta.ContaCliente.DispensarTaxaServico = 'N')) then
              cTotalAdicionalTaxaCalc := cTotalAdicionalTaxaCalc +
                ItensContaClienteAgrupado.Items[I].Adicionais.Items[Y].Total;
          end;

          cValorTotal := cValorTotal + cTotalAdicional +
            ItensContaClienteAgrupado.Items[I].Total;

          if (ItensContaClienteAgrupado.Items[I]
            .Produto.CobrarTaxaServicoRestaurante = 'S') and
            (FConta.ContaCliente.DispensarTaxaServico = 'N') then
            cTotalTaxaCalc := cTotalTaxaCalc +
              ItensContaClienteAgrupado.Items[I].Total;

          inc(iOrdemItem);
        end;

        { IMPRIME PRODUTOS TRANSFERIDOS }
        for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
        begin
          if FConta.ContaCliente.ItensContaCliente.Items[I].ContaOrigem > 0 then
          begin

            if FConta.ContaCliente.ItensContaCliente.Items[I].Cancelado = 0 then
            begin
              sTotalProduto :=
                currtostrf(FConta.ContaCliente.ItensContaCliente.Items[I].Total,
                ffnumber, 2);

              sQuantidadeProduto :=
                CurrToStr(FConta.ContaCliente.ItensContaCliente.Items[I]
                .Quantidade);

              sValorProduto :=
                currtostrf(FConta.ContaCliente.ItensContaCliente.Items[I].Valor,
                ffnumber, 2);

              sNomeProduto := FConta.ContaCliente.ItensContaCliente.Items[I]
                .Produto.DescricaoCupom;

              sOrdemProduto := comprovante.FormataStringD(IntToStr(iOrdemItem),
                '4', '0');

              sContaOrigem := comprovante.FormataStringD
                (IntToStr(FConta.ContaCliente.ItensContaCliente.Items[I]
                .ContaOrigem), '3', '0');

              if comprovante.NumeroColunas < 40 then
              begin
                { Impressão sem o numero do item }
                if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
                begin
                  comprovante.imprimeTextoComprovante(sNomeProduto, 'E',
                    False, 'C');

                  comprovante.imprimeTextoComprovanteValor('',
                    comprovante.FormataStringE(sQuantidadeProduto, '7', ' ') +
                    ' ' + comprovante.FormataStringE(sValorProduto, '12', ' ') +
                    ' ' + comprovante.FormataStringE(sTotalProduto, '0', ' '),
                    'C', False);

                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('TRANS. DA COMANDA: ' + sContaOrigem),
                    'E', False, 'C');
                end
                else
                begin
                  comprovante.imprimeTextoComprovante
                    (sOrdemProduto + ' ' + sNomeProduto, 'E', False);

                  comprovante.imprimeTextoComprovanteValor('',
                    comprovante.FormataStringE(sQuantidadeProduto, '4', ' ') +
                    ' ' + comprovante.FormataStringE(sValorProduto, '9', ' ') +
                    ' ' + comprovante.FormataStringE(sTotalProduto, '0', ' '));

                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('TRANS. DA COMANDA: ' + sContaOrigem),
                    'E', False, 'N');
                end;
              end
              else
              begin
                { Imprime conferencia sem o número do item }
                if DMConexao.Configuracao.ItemConferenciaMesaEmUmaLinha then
                begin
                  comprovante.imprimeTextoComprovanteValor(sNomeProduto,
                    comprovante.FormataStringD(sQuantidadeProduto, '5', ' ') +
                    comprovante.FormataStringD(sValorProduto, '11', ' ') +
                    comprovante.FormataStringD(sTotalProduto, '14', ' '),
                    'C', False);

                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('TRANS. DA COMANDA: ' + sContaOrigem),
                    'C', False, 'C');
                end
                else
                begin
                  comprovante.imprimeTextoComprovante(sOrdemProduto + '  ' +
                    sNomeProduto, 'E', False);

                  comprovante.imprimeTextoComprovanteValor('',
                    comprovante.FormataStringE(sQuantidadeProduto, '4', ' ') +
                    ' ' + comprovante.FormataStringE(sValorProduto, '9', ' ') +
                    ' ' + comprovante.FormataStringE(sTotalProduto, '0', ' '));

                  comprovante.imprimeTextoComprovante
                    (comprovante.boldText('TRANS. DA COMANDA: ' + sContaOrigem),
                    'C', False, 'N');

                end;
              end;

              cValorTotal := cValorTotal +
                FConta.ContaCliente.ItensContaCliente.Items[I].Total;

              if (FConta.ContaCliente.ItensContaCliente.Items[I]
                .Produto.CobrarTaxaServicoRestaurante = 'S') and
                (FConta.ContaCliente.DispensarTaxaServico = 'N') then
                cTotalTaxaCalc := cTotalTaxaCalc +
                  FConta.ContaCliente.ItensContaCliente.Items[I].Total;

              inc(iOrdemItem);
            end;
          end;
        end;

        cTotalTaxaCalc := cTotalTaxaCalc + cTotalAdicionalTaxaCalc;

        { Imprime o Rodapé }
        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        comprovante.imprimeTextoComprovanteValor('TOTAL DA COMANDA: ',
          currtostrf(cValorTotal, ffCurrency, 2));

        if FConta.ContaCliente.ValorPacial > 0 then
          comprovante.imprimeTextoComprovanteValor('TOTAL PARCIAL: ',
            currtostrf(FConta.ContaCliente.ValorPacial, ffCurrency, 2));

        if cTotalTaxaCalc > 0 then
          comprovante.imprimeTextoComprovanteValor('TAXA DE SERVICO: ',
            currtostrf(DMConexao.CalcularTaxaServico(cTotalTaxaCalc,
            FConta.ContaCliente), ffCurrency, 2));

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        comprovante.imprimeTextoComprovanteValor('TAXA A PAGAR: ',
          currtostrf(DMConexao.CalcularTaxaServico(cTotalTaxaCalc,
          FConta.ContaCliente) + cValorTotal - FConta.ContaCliente.ValorPacial,
          ffCurrency, 2));

        if IntToStr(FConta.ContaCliente.NumeroPessoas).Trim <> '' then
          if FConta.ContaCliente.NumeroPessoas > 0 then
            comprovante.imprimeTextoComprovanteValor('TOTAL PAGAR P/PESSOA: ',
              currtostrf((DMConexao.CalcularTaxaServico(cTotalTaxaCalc,
              FConta.ContaCliente) + cValorTotal -
              FConta.ContaCliente.ValorPacial) /
              FConta.ContaCliente.NumeroPessoas, ffCurrency, 2));

      end;

      if DMConexao.Configuracao.BloqueiaMesaComConferencia then
      begin
        FConta.ContaCliente.Caixa.Codigo := DMConexao.Configuracao.Caixa.Codigo;
        FConta.ContaCliente.ConferenciaEmitida := 'S';

        TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);

        atualizaMesa;
      end;
    except
      on E: Exception do
      begin
        Application.CreateForm(TFrmMensagem, FrmMensagem);
        FrmMensagem.FTipo := 0;
        FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
          ', não foi possível imprimir a conferência ' +
          'resumida. Mensagem retornada: ' + E.Message;
        FrmMensagem.FTitulo := 'Atenção!';
        FrmMensagem.ShowModal;
        fecha := False;
      end;
    end;
  finally
    { FECHO O COMPROVANTE DIZENDO SE HÁ ASSINATURA, OPERADOR/CAIXA, E O AVANCO DE PAPEL }
    comprovante.fechaComprovante(False, False, 8, fecha);
    FView.btnConferenciaResumida.Enabled := True;
  end;
end;

procedure TFrmComandaController.btnConfirmaLancamentosCartaoClick;
var
  ContaReceberCartao: TContaReceberCartao;
  BandeiraCartao: TBandeiraCartao;
  I: Integer;
begin

  FView.btnConfirmaLancamentosCartao.Enabled := False;

  if FView.EdtValorLancamentoCartao.Text = '' then
    FView.EdtValorLancamentoCartao.Text := '0,00';

  FView.EdtValorLancamentoCartao.Text :=
    stringreplace(FView.EdtValorLancamentoCartao.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]);

  if StrToCurr(FView.EdtValorLancamentoCartao.Text) >
    FFormaPagamentoSelecionado.Valor then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', valor informado maior que o total da forma de pagamento.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;

    FView.btnConfirmaLancamentosCartao.Enabled := True;
    exit;
  end;

  if StrToCurr(FView.EdtValorLancamentoCartao.Text) >
    (FConta.ContaCliente.Venda.totalContasAdmCartao
    (FFormaPagamentoSelecionado.FormaPagamento) +
    StrToCurr(FView.EdtValorLancamentoCartao.Text)) then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', valor informado ultrapassará o valor da forma de pagamento.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;

    FView.btnConfirmaLancamentosCartao.Enabled := True;
    exit;
  end;

  if StrToCurr(FView.EdtValorLancamentoCartao.Text) <= 0 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', informe o valor da parcela do cartão.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;

    FView.btnConfirmaLancamentosCartao.Enabled := True;
    exit;
  end;

  if (DMConexao.Configuracao.ObrigarLancarNumeroAutorizacao) and
    (FView.EdtNumeroAutorizacao.Text = '') then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o número de autorização é obrigatório.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;

    FView.btnConfirmaLancamentosCartao.Enabled := True;
    exit;
  end;

  BandeiraCartao := TBandeiraCartao.Create;
  BandeiraCartao.Codigo :=
    StrToInt(copy(FView.cbBandeirasCartao.Items
    [FView.cbBandeirasCartao.ItemIndex], 1,
    pos(' ', FView.cbBandeirasCartao.Items
    [FView.cbBandeirasCartao.ItemIndex]) - 1));
  TBandeiraCartaoDAO.getInstancia.buscar(BandeiraCartao);

  for I := 0 to StrToInt(FView.lblParcelasCartao.Text) - 1 do
  begin
    ContaReceberCartao := TContaReceberCartao.Create;
    ContaReceberCartao.BandeiraCartao := BandeiraCartao;

    ContaReceberCartao.Emissao := Date;
    ContaReceberCartao.FormaPagamento :=
      FFormaPagamentoSelecionado.FormaPagamento;

    if ContaReceberCartao.BandeiraCartao.TipoCartao = 'D' then
      ContaReceberCartao.Vencimento := ContaReceberCartao.Emissao +
        (I * ContaReceberCartao.BandeiraCartao.DiasDebito)
    else if ContaReceberCartao.BandeiraCartao.TipoCartao = 'C' then
      ContaReceberCartao.Vencimento := ContaReceberCartao.Emissao +
        (I * ContaReceberCartao.BandeiraCartao.DiasCredito)
    else if ContaReceberCartao.BandeiraCartao.TipoCartao = 'A' then
      ContaReceberCartao.Vencimento := ContaReceberCartao.Emissao;

    ContaReceberCartao.Parcelas := StrToInt(FView.lblParcelasCartao.Text);

    ContaReceberCartao.Caixa := DMConexao.Configuracao.Caixa;
    ContaReceberCartao.Empresa := DMConexao.Empresa;
    ContaReceberCartao.Valor := StrToCurr(FView.EdtValorLancamentoCartao.Text) /
      StrToInt(FView.lblParcelasCartao.Text);

    if ContaReceberCartao.BandeiraCartao.TipoCartao = 'D' then
      ContaReceberCartao.Taxa := ContaReceberCartao.BandeiraCartao.TaxaDebito
    else if ContaReceberCartao.BandeiraCartao.TipoCartao = 'C' then
      ContaReceberCartao.Taxa := ContaReceberCartao.BandeiraCartao.TaxaCredito
    else if ContaReceberCartao.BandeiraCartao.TipoCartao = 'A' then
      ContaReceberCartao.Taxa := 0;

    ContaReceberCartao.Cliente := FConta.ContaCliente.Venda.Cliente;
    ContaReceberCartao.Parcela := I + 1;
    ContaReceberCartao.NumeroAutorizacao := FView.EdtNumeroAutorizacao.Text;
    ContaReceberCartao.Observacao := FView.mmObservacaoLancamentoCartao.Text;

    FConta.ContaCliente.Venda.ContasReceberCartao.Add(ContaReceberCartao);
  end;

  addItensLancamentoAdmCartao;

  limpaDadosLancamentoCartao;

  if FFormaPagamentoSelecionado.Valor = FConta.ContaCliente.Venda.
    totalContasAdmCartao(FFormaPagamentoSelecionado.FormaPagamento) then
    FView.btnConfirmaLancamentosCartao.Enabled := False
  else
    FView.btnConfirmaLancamentosCartao.Enabled := True;

end;

procedure TFrmComandaController.btnConfirmarAddAdicionalClick;
begin

  FView.btnConfirmarAddAdicional.Enabled := False;

  FAdicionalSelecionado.Quantidade :=
    StrToInt(FView.EdtQuantidadeAdicional.Text);

  FView.retAddAdicional.Visible := False;
  FAdicionalSelecionado := nil;

  FView.retLancamentoProduto.Enabled := True;

  FView.lblNomeAdicionalTotal.Text := 'Adicionais: R$ ' +
    formatfloat('#,##0.00', totalAdicionais);

  FView.btnConfirmarAddAdicional.Enabled := True;

end;

procedure TFrmComandaController.btnConfirmarAlteraInformacoesClick;
begin

  FView.btnConfirmarAlteraInformacoes.Enabled := False;

  if (FView.EdtQuantidadePessoas.Text.Length > 9) then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', Informe um número válido.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.EdtQuantidadePessoas.SetFocus;

    FView.btnConfirmarAlteraInformacoes.Enabled := True;
    exit;
  end;

  if (FView.EdtQuantidadePessoas.Text <> '') or
    (StrToInt(FView.EdtQuantidadePessoas.Text) > 0) then
    FConta.ContaCliente.NumeroPessoas :=
      StrToInt(FView.EdtQuantidadePessoas.Text);
  if FView.EdtDescricaoMesa.Text.Trim <> '' then
    FConta.ContaCliente.DescricaoMesa := FView.EdtDescricaoMesa.Text.Trim;

  if not FView.retFinalizacaoVenda.Visible then
    TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);

  if FView.retFinalizacaoVenda.Visible then
    addInformacoesFinalizacao
  else
    addDados;

  btnCancelarAlteraInformacoesClick;
  FView.btnConfirmarAlteraInformacoes.Enabled := True;

end;

procedure TFrmComandaController.btnConfirmarCancelamentoMesaClick;
begin

  FView.btnConfirmarCancelamentoMesa.Enabled := False;
  if FView.mmObservacao.Text.Trim = EmptyStr then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', informe a observação do cancelamento.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.mmObservacao.SetFocus;

    FView.btnConfirmarCancelamentoMesa.Enabled := True;
    exit;
  end;

  cancelaMesa;
  FView.retModalLancProduto.Visible := False;
  FView.retObsCancelaMesa.Visible := False;
  FView.btnConfirmarCancelamentoMesa.Enabled := True;
end;

procedure TFrmComandaController.btnConfirmarClick;
var
  Item: TItemContaCliente;
  Adicional: TItemContaCliente;
  I: Integer;
  Retangulo: TRectangle;
begin

  FView.btnConfirmar.Enabled := False;

  FView.EdtValorProduto.Text := stringreplace(FView.EdtValorProduto.Text, '.',
    '', [rfReplaceAll, rfIgnoreCase]);

  FView.EdtQuantidadeProduto.Text :=
    stringreplace(FView.EdtQuantidadeProduto.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]);

  // TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

  FConta.ContaCliente.OrdemFinal := FConta.ContaCliente.OrdemFinal + 1;

  Item := TItemContaCliente.Create;
  Item.Codigo := FConta.ContaCliente.Codigo;
  Item.Ordem := FConta.ContaCliente.OrdemFinal;
  Item.Produto := FProdutoSelecionado.Produto;
  Item.Garcom := buscaGarcom
    (StrToInt(copy(FView.cbGarcom.Items[FView.cbGarcom.ItemIndex], 1,
    pos(' ', FView.cbGarcom.Items[FView.cbGarcom.ItemIndex]) - 1)));
  Item.Valor := StrToCurr(FView.EdtValorProduto.Text) /
    StrToCurr(FView.EdtQuantidadeProduto.Text.Trim);
  Item.ContaOrigem := 0;
  Item.Empresa := DMConexao.Empresa;
  Item.Quantidade := StrToCurr(FView.EdtQuantidadeProduto.Text.Trim);
  Item.Total := StrToCurr(FView.EdtValorProduto.Text);
  Item.Impresso := 'N';
  Item.Hora := Time;
  Item.Observacao := retornaObservacao;
  Item.OrdemParPizza := 0;
  Item.Feito := 'N';
  Item.Avisado := 'N';
  Item.MotivoCancelamento := '';
  Item.DataHoraCancelamento := 0;
  Item.ObservacaoPizza := '';
  Item.OrdemItemPrincipal := 0;

  if Assigned(FListaProdutosAdicionais) then
  begin
    for I := 0 to FListaProdutosAdicionais.Count - 1 do
    begin
      if FListaProdutosAdicionais.Items[I].Selecionado then
      begin
        Adicional := TItemContaCliente.Create;
        Adicional.Codigo := FConta.ContaCliente.Codigo;
        FConta.ContaCliente.OrdemFinal := FConta.ContaCliente.OrdemFinal + 1;
        Adicional.Ordem := FConta.ContaCliente.OrdemFinal;
        Adicional.Produto := FListaProdutosAdicionais.Items[I].Produto;
        Adicional.Garcom := Item.Garcom;
        Adicional.Valor := FListaProdutosAdicionais.Items[I].Produto.PrecoVista;
        Adicional.ContaOrigem := 0;
        Adicional.Empresa := DMConexao.Empresa;
        Adicional.Quantidade := FListaProdutosAdicionais.Items[I].Quantidade;
        Adicional.Total := FListaProdutosAdicionais.Items[I].Produto.PrecoVista
          * FListaProdutosAdicionais.Items[I].Quantidade;
        Adicional.Impresso := 'N';
        Adicional.Hora := Time;
        Adicional.Observacao := '';
        Adicional.OrdemParPizza := 0;
        Adicional.Feito := 'N';
        Adicional.Avisado := 'N';
        Adicional.MotivoCancelamento := '';
        Adicional.DataHoraCancelamento := 0;
        Adicional.ObservacaoPizza := '';
        Adicional.OrdemItemPrincipal := Item.Ordem;

        Item.Adicionais.Add(Adicional);
      end;
    end;
  end;

  TItemContaClienteDAO.getInstancia.inserir(Item);

  addItensComanda;

  FView.retModalLancProduto.Visible := False;
  FView.retLancamentoProduto.Visible := False;

  FProdutoSelecionado.removeSelecaoProduto;

  limpaAdicionais;
  FView.btnConfirmar.Enabled := True;
  /// addDados;
end;

procedure TFrmComandaController.btnConfirmarDescAcresFinalizacaoClick;
begin

  FView.btnConfirmarDescAcresFinalizacao.Enabled := False;

  if FView.EdtDescAcresFinalizacao.Text.Trim = '' then
    FView.EdtDescAcresFinalizacao.Text := '0,00';

  case FView.Label57.Tag of
    { Desconto }
    0:
      begin
        if StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim) < 0 then
        begin
          Application.CreateForm(TFrmMensagem, FrmMensagem);
          FrmMensagem.FTipo := 0;
          FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
            ', o desconto não pode ser negativo.';
          FrmMensagem.FTitulo := 'Aviso!';
          FrmMensagem.ShowModal;
          FView.btnConfirmarDescAcresFinalizacao.Enabled := True;
          exit;
        end;

        if FConta.ContaCliente.Venda.Total -
          StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim) < 0 then
        begin
          Application.CreateForm(TFrmMensagem, FrmMensagem);
          FrmMensagem.FTipo := 0;
          FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
            ', o desconto deixará a venda negativa.';
          FrmMensagem.FTitulo := 'Aviso!';
          FrmMensagem.ShowModal;
          FView.btnConfirmarDescAcresFinalizacao.Enabled := True;
          exit;
        end;

        FConta.ContaCliente.Venda.Desconto :=
          StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim);
        FConta.ContaCliente.Venda.Acrescimo := 0;
      end;

    { Acréscimo }
    1:
      begin
        if StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim) < 0 then
        begin
          Application.CreateForm(TFrmMensagem, FrmMensagem);
          FrmMensagem.FTipo := 0;
          FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
            ', o acréscimo não pode ser negativo.';
          FrmMensagem.FTitulo := 'Aviso!';
          FrmMensagem.ShowModal;
          FView.btnConfirmarDescAcresFinalizacao.Enabled := True;
          exit;
        end;

        FConta.ContaCliente.Venda.Acrescimo :=
          StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim);
        FConta.ContaCliente.Venda.Desconto := 0;
      end;
  end;

  addInformacoesFinalizacao;
  btnDesistirDescAcresFinalizacaoClick;
  FView.btnConfirmarDescAcresFinalizacao.Enabled := True;
end;

procedure TFrmComandaController.btnConfirmarLancPagParcialValorClick;
var
  PagamentoParcial: TPagamentoParcial;
  Value: Integer;
begin
  FView.btnConfirmarLancPagParcialValor.Enabled := False;

  if FView.EdtLancPagParcialValor.Text.Trim = EmptyStr then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', informe o valor do pagamento parcial.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.EdtLancPagParcialValor.SetFocus;

    FView.btnConfirmarLancPagParcialValor.Enabled := True;
    exit;
  end;

  if FFormaPagamentoSelecionado = nil then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', informe a forma de pagamento.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.btnConfirmarLancPagParcialValor.Enabled := True;
    exit;
  end;

  if (StrToCurr(stringreplace(FView.lblTotal.Text, '.', '', [rfReplaceAll,
    rfIgnoreCase])) - StrToCurr(stringreplace(FView.EdtLancPagParcialValor.Text,
    '.', '', [rfReplaceAll, rfIgnoreCase]))) < 0 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', essa comanda ficará com o valor total negativo.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.btnConfirmarLancPagParcialValor.Enabled := True;
    exit;
  end;

  Value := DMConexao.senha('liberar pagamento parcial.');

  if Value = 11 then
  begin
    PagamentoParcial := TPagamentoParcial.Create;
    PagamentoParcial.Valor := StrToCurr(FView.EdtLancPagParcialValor.Text);

    if FView.mmHistoricoPagamentoParcialValor.Text.Trim <> '' then
      PagamentoParcial.Historico :=
        FView.mmHistoricoPagamentoParcialValor.Text.Trim;

    PagamentoParcial.FormaPagamento :=
      FFormaPagamentoSelecionado.FormaPagamento;
    PagamentoParcial.CodigoContaCliente := FConta.ContaCliente.Codigo;

    TPagamentoParcialDAO.getInstancia.inserir(PagamentoParcial);
  end;

  btnDesistirLancPagamentoParcialVClick;

  addDados;

  FView.btnConfirmarLancPagParcialValor.Enabled := True;
end;

procedure TFrmComandaController.btnConfirmarObsCancelItemClick;
begin
  FView.btnConfirmarObsCancelItem.Enabled := False;

  if FView.mmObservacaoCancelItem.Text.Trim = '' then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', digite a observação de cancelamento do item.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.btnConfirmarObsCancelItem.Enabled := True;
    FView.mmObservacaoCancelItem.SetFocus;
    exit;
  end;

  CancelaItem;

  btnDesisitirObsCancelItemClick;

  FView.btnConfirmarObsCancelItem.Enabled := True;
end;

procedure TFrmComandaController.btnConfirmarpagamentoParcialProdutoClick;
var
  TemProduto: Boolean;
  I: Integer;
  TotalParcial: Currency;
begin
  FView.btnConfirmarpagamentoParcialProduto.Enabled := False;

  TotalParcial := 0;
  TemProduto := False;
  for I := 0 to FListaItemsParcialProduto.Count - 1 do
  begin
    if StrToInt(FListaItemsParcialProduto.Items[I].LQuantidade.Text.Trim) > 0
    then
    begin
      TemProduto := True;
      Break;
    end;
  end;

  for I := 0 to FListaItemsParcialProduto.Count - 1 do
    if StrToInt(FListaItemsParcialProduto.Items[I].LQuantidade.Text.Trim) > 0
    then
      TotalParcial := TotalParcial +
        (FListaItemsParcialProduto.Items[I].ItemContaCliente.Valor +
        (FListaItemsParcialProduto.Items[I].ItemContaCliente.totalAdicionais /
        FListaItemsParcialProduto.Items[I].ItemContaCliente.Quantidade)) *
        StrToInt(FListaItemsParcialProduto.Items[I].LQuantidade.Text.Trim);

  if not TemProduto then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', informe algum item para pagamento parcial.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.btnConfirmarpagamentoParcialProduto.Enabled := True;
    exit;
  end;

  FView.lblTotalFormasPagamentoParcialProduto.Text := 'Total: R$ ' +
    formatfloat('#,##0.00', TotalParcial);

  FView.retPagamentoParcialProduto.Enabled := False;

  FView.retFormasPagamentoParcialProduto.Position.X :=
    (FView.Width - FView.retFormasPagamentoParcialProduto.Width) / 2;
  FView.retFormasPagamentoParcialProduto.Position.Y :=
    (FView.Height - FView.retFormasPagamentoParcialProduto.Height) / 2;

  FView.retFormasPagamentoParcialProduto.Visible := True;

  addFormasPagamentoPacialProduto;

  FView.btnConfirmarpagamentoParcialProduto.Enabled := True;
end;

procedure TFrmComandaController.btnConfirmarQuantidadeTransferenciaClick;
begin
  FView.btnConfirmarQuantidadeTransferencia.Enabled := False;

  FItensTransferencia.Items[FItemTransferenciaSelecionado].selecao;
  FItensTransferencia.Items[FItemTransferenciaSelecionado].QuantidadeSelecionada
    := StrToCurr(stringreplace(FView.EdtQuantidadeProdutoTransferencia.Text,
    '.', '', [rfReplaceAll, rfIgnoreCase]));

  FView.retLancamentoQuantidadeTransferencia.Visible := False;
  FView.retTransferenciaComanda.Enabled := True;

  FView.btnConfirmarQuantidadeTransferencia.Enabled := True;
end;

procedure TFrmComandaController.btnConfirmarSelecaoFormaPagamentoClick;
var
  I: Integer;
  PagamentoParcial: TPagamentoParcial;
  TotalParcial: Currency;
begin
  FView.btnConfirmarSelecaoFormaPagamento.Enabled := False;

  if FFormaPagamentoSelecionado = nil then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', selecione uma forma de pagamento.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.btnConfirmarSelecaoFormaPagamento.Enabled := True;
    exit;
  end;

  TotalParcial := 0;

  for I := 0 to FListaItemsParcialProduto.Count - 1 do
    if StrToInt(FListaItemsParcialProduto.Items[I].LQuantidade.Text.Trim) > 0
    then
      TotalParcial := TotalParcial +
        (FListaItemsParcialProduto.Items[I].ItemContaCliente.Valor +
        (FListaItemsParcialProduto.Items[I].ItemContaCliente.totalAdicionais /
        FListaItemsParcialProduto.Items[I].ItemContaCliente.Quantidade)) *
        StrToInt(FListaItemsParcialProduto.Items[I].LQuantidade.Text.Trim);

  if (StrToCurr(stringreplace(FView.lblTotal.Text, '.', '', [rfReplaceAll,
    rfIgnoreCase])) - TotalParcial) < 0 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o total de(o) pagamento(s) parcial(is) irá(ão) deixar o valor da comanda negativo.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.btnConfirmarSelecaoFormaPagamento.Enabled := True;
    exit;
  end;

  for I := 0 to FListaItemsParcialProduto.Count - 1 do
  begin
    if StrToInt(FListaItemsParcialProduto.Items[I].LQuantidade.Text.Trim) > 0
    then
    begin
      PagamentoParcial := TPagamentoParcial.Create;
      PagamentoParcial.Codigo := FListaItemsParcialProduto.Items[I]
        .ItemContaCliente.Codigo;
      PagamentoParcial.Ordem := FListaItemsParcialProduto.Items[I]
        .ItemContaCliente.Ordem;
      PagamentoParcial.Valor :=
        (FListaItemsParcialProduto.Items[I].ItemContaCliente.Valor +
        (FListaItemsParcialProduto.Items[I].ItemContaCliente.totalAdicionais /
        FListaItemsParcialProduto.Items[I].ItemContaCliente.Quantidade)) *
        StrToInt(FListaItemsParcialProduto.Items[I].LQuantidade.Text.Trim);
      PagamentoParcial.FormaPagamento :=
        FFormaPagamentoSelecionado.FormaPagamento;

      TPagamentoParcialDAO.getInstancia.inserir(FListaItemsParcialProduto.Items
        [I].ItemContaCliente, PagamentoParcial);
    end;
  end;

  btnDesistirSelecaoFormaPagamentoClick;

  FView.btnConfirmarSelecaoFormaPagamento.Enabled := True;
end;

procedure TFrmComandaController.btnConfirmarValorClick;
var
  I: Integer;
  AdmCartao: TAdministradoraCartao;
  ContaReceberCartao: TContaReceberCartao;
begin
  FView.btnConfirmarValor.Enabled := False;

  if FView.EdtValorFormaPagamento.Text.Trim = '' then
    FView.EdtValorFormaPagamento.Text := '0,00';

  if (StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]))) < 0 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o valor da forma de pagamento deve ser maior que 0.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.btnConfirmarValor.Enabled := True;
    exit;
  end;

  if (StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]))) > 0 then
  begin
    if ((StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
      [rfReplaceAll, rfIgnoreCase]))) > FConta.ContaCliente.Venda.Total) then
    begin
      if FFormaPagamentoSelecionado.FormaPagamento.Tipo = 'DN' then
      begin
        if (not FFormaPagamentoSelecionado.Selecionado) then
        begin
          if not Assigned(FVendaFormaPagamento) then
            FVendaFormaPagamento := TVendaFormaPagamento.Create;

          FVendaFormaPagamento.FormaPagamento :=
            TFormaPagamentoDAO.getInstancia.buscaTroco;
          FVendaFormaPagamento.Valor :=
            (StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
            [rfReplaceAll, rfIgnoreCase]))) - FConta.ContaCliente.Venda.Total;
        end
        else
        begin
          FVendaFormaPagamento.Valor :=
            StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
            [rfReplaceAll, rfIgnoreCase])) - FFormaPagamentoSelecionado.Valor;

          if FVendaFormaPagamento.Valor < 0 then
            FVendaFormaPagamento.Valor := 0;
        end;
      end
      else
      begin
        if not FFormaPagamentoSelecionado.Selecionado then
        begin
          Application.CreateForm(TFrmMensagem, FrmMensagem);
          FrmMensagem.FTipo := 0;
          FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
            ', o valor da forma de pagamento não pode ultrapassar o total geral.';
          FrmMensagem.FTitulo := 'Atenção!';
          FrmMensagem.ShowModal;
          FView.btnConfirmarValor.Enabled := True;
          exit;
        end;

        if StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
          [rfReplaceAll, rfIgnoreCase])) > FConta.ContaCliente.Venda.Total +
          FFormaPagamentoSelecionado.Valor then
        begin
          Application.CreateForm(TFrmMensagem, FrmMensagem);
          FrmMensagem.FTipo := 0;
          FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
            ', o valor da forma de pagamento não pode ultrapassar o total geral.';
          FrmMensagem.FTitulo := 'Atenção!';
          FrmMensagem.ShowModal;
          FView.btnConfirmarValor.Enabled := True;
          exit;
        end;
      end;
    end;

    FFormaPagamentoSelecionado.Selecionado := True;

    if Assigned(FVendaFormaPagamento) then
      FFormaPagamentoSelecionado.Valor :=
        (StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
        [rfReplaceAll, rfIgnoreCase]))) - FVendaFormaPagamento.Valor
    else
      FFormaPagamentoSelecionado.Valor :=
        (StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
        [rfReplaceAll, rfIgnoreCase])));

    FFormaPagamentoSelecionado.Selecionado := True;
  end
  else
  begin

    if Assigned(FVendaFormaPagamento) then
      FVendaFormaPagamento := nil;

    FFormaPagamentoSelecionado.Valor := 0;
    FFormaPagamentoSelecionado.Selecionado := True;
    FFormaPagamentoSelecionado.shadow;
    FFormaPagamentoSelecionado.Selecionado := False;
  end;

  { REMOVO TODAS AS CONTAS A RECEBER CARTÃO ANTES DE LANÇAR }
  if not(FFormaPagamentoSelecionado.Selecionado) and
    (FFormaPagamentoSelecionado.Valor = StrToCurr
    (stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]))) then
  begin
    if Assigned(FConta.ContaCliente.Venda.ContasReceberCartao) then
    begin
      if FConta.ContaCliente.Venda.ContasReceberCartao.Count > 0 then
      begin

        ContaReceberCartao := buscaContaReceberCartaoVenda
          (FFormaPagamentoSelecionado.FormaPagamento);

        while ContaReceberCartao <> nil do
        begin
          FConta.ContaCliente.Venda.ContasReceberCartao.Extract
            (ContaReceberCartao);

          ContaReceberCartao := buscaContaReceberCartaoVenda
            (FFormaPagamentoSelecionado.FormaPagamento);
        end;

      end;
    end;
  end;
  { SE A FORMA FOR CARTÃO E O VALOR MAIOR QUE E NÃO ENVIA POS }
  if (FFormaPagamentoSelecionado.FormaPagamento.Tipo = 'CA') and
    (FFormaPagamentoSelecionado.Valor > 0) and
    (not DMConexao.Configuracao.ConsultaPagamentoPOS) then
  begin

    FListaAdministradorasCartao := TAdministradoraCartaoDAO.getInstancia.
      buscaTodos;

    FView.cbAdministradorasCartao.Items.Clear;

    for I := 0 to FListaAdministradorasCartao.Count - 1 do
    begin

      if I = 0 then
        AdmCartao := FListaAdministradorasCartao.Items[I];

      FView.cbAdministradorasCartao.Items.Add
        (IntToStr(FListaAdministradorasCartao.Items[I].Codigo) + ' - ' +
        FListaAdministradorasCartao.Items[I].Descricao);
    end;

    if FListaAdministradorasCartao.Count > 0 then
      FView.cbAdministradorasCartao.ItemIndex := 0;

    FView.cbBandeirasCartao.Items.Clear;
    if AdmCartao <> nil then
    begin
      for I := 0 to AdmCartao.BandeirasCartao.Count - 1 do
      begin
        FView.cbBandeirasCartao.Items.Add
          (IntToStr(AdmCartao.BandeirasCartao.Items[I].Codigo) + ' - ' +
          AdmCartao.BandeirasCartao.Items[I].Descricao);
      end;
      if AdmCartao.BandeirasCartao.Count > 0 then
        FView.cbBandeirasCartao.ItemIndex := 0;
    end;

    FView.EdtValorLancamentoCartao.Text :=
      formatfloat('#,##0.00', FFormaPagamentoSelecionado.Valor);

    FView.retLancamentoContasReceberCartao.Position.X :=
      (FView.Width - FView.retLancamentoContasReceberCartao.Width) / 2;
    FView.retLancamentoContasReceberCartao.Position.Y :=
      (FView.Height - FView.retLancamentoContasReceberCartao.Height) / 2;

    FView.retLancamentoContasReceberCartao.Visible := True;

    if FFormaPagamentoSelecionado.Valor = FConta.ContaCliente.Venda.
      totalContasAdmCartao(FFormaPagamentoSelecionado.FormaPagamento) then
      FView.btnConfirmaLancamentosCartao.Enabled := False
    else
      FView.btnConfirmaLancamentosCartao.Enabled := True;

    addItensLancamentoAdmCartao;

  end
  else
  begin
    addInformacoesFinalizacao;

    FFormaPagamentoSelecionado := nil;

    FView.retInserirValorFormaPagamento.Visible := False;

    FView.retFinalizacaoVenda.Enabled := True;

    FView.btnConfirmarValor.Enabled := True;
  end;
end;

procedure TFrmComandaController.btnDesbloquearMesaClick;
var
  Value: Integer;
begin

  if DMConexao.Configuracao.BloqueiaMesaComConferencia then
  begin

    FView.btnDesbloquearMesa.Enabled := False;

    Value := DMConexao.mensagem(DMConexao.Usuario.nome +
      ', uma Conferência já foi emitida para esta comanda. Deseja ' +
      'realmente desbloquear a comanda?', 1);

    if Value = 6 then
    begin

      Value := DMConexao.senha('liberar desbloqueio da comanda.');

      if Value = 11 then
      begin
        FConta.ContaCliente.ConferenciaEmitida := 'N';
        TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);

        atualizaMesa;
      end
      else
        FView.btnDesbloquearMesa.Enabled := True;
    end;

  end;

end;

procedure TFrmComandaController.btnDescontoFinalizacaoClick;
begin
  FView.btnDescontoFinalizacao.Enabled := False;

  FView.retFinalizacaoVenda.Enabled := False;

  FView.retLancamentoDescAcresFinalizacao.Position.X :=
    (FView.Width - FView.retLancamentoDescAcresFinalizacao.Width) / 2;
  FView.retLancamentoDescAcresFinalizacao.Position.Y :=
    (FView.Height - FView.retLancamentoDescAcresFinalizacao.Height) / 2;

  FView.Rectangle58.Fill.Color := TAlphaColors.Green;
  FView.Rectangle58.Stroke.Color := TAlphaColors.Green;

  FView.Label57.Text := 'Desconto';
  FView.Label57.Tag := 0;

  FView.EdtDescAcresFinalizacao.Text :=
    currtostrf(FConta.ContaCliente.Venda.Desconto, ffnumber, 2);

  FView.EdtDescAcresPercentualFinalizacao.Text :=
    currtostrf
    ((((FConta.ContaCliente.Total -
    StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim)) /
    FConta.ContaCliente.Total) - 1) * -100, ffnumber, 2);

  FView.EdtDescAcresFinalizacao.Align := TAlignLayout.Client;

  FView.retLancamentoDescAcresFinalizacao.Visible := True;

  FView.btnDescontoFinalizacao.Enabled := True;
end;

procedure TFrmComandaController.btnDesisitirObsCancelItemClick;
begin
  FView.btnDesisitirObsCancelItem.Enabled := False;

  FView.retObsCancelamentoItem.Visible := False;
  FView.retInformacoesItemConta.Enabled := True;

  FView.btnDesisitirObsCancelItem.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirAddAdicionalClick;
begin

  FView.btnDesistirAddAdicional.Enabled := False;

  FAdicionalSelecionado.select;

  FView.retAddAdicional.Visible := False;
  FAdicionalSelecionado := nil;

  FView.retLancamentoProduto.Enabled := True;

  FView.btnDesistirAddAdicional.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirBuscaProdutosClick;
begin
  FView.retConsultaProduto.Visible := False;
  FView.retModalLancProduto.Visible := False;
end;

procedure TFrmComandaController.btnDesistirCancelamentoMesaClick;
begin
  FView.btnDesistirCancelamentoMesa.Enabled := False;
  FView.retModalLancProduto.Visible := False;
  FView.retObsCancelaMesa.Visible := False;
  FView.btnDesistirCancelamentoMesa.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirClick;
begin

  FView.btnDesistir.Enabled := False;

  if FProdutoSelecionado <> nil then
    FProdutoSelecionado.removeSelecaoProduto;
  FView.retModalLancProduto.Visible := False;
  FView.retLancamentoProduto.Visible := False;
  FView.btnDesistir.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirDescAcresFinalizacaoClick;
begin
  FView.btnDesistirDescAcresFinalizacao.Enabled := False;

  FView.retLancamentoDescAcresFinalizacao.Visible := False;

  FView.EdtDescAcresFinalizacao.Text := '0,00';
  FView.EdtDescAcresPercentualFinalizacao.Text := '0,00';

  FView.retFinalizacaoVenda.Enabled := True;

  FView.btnDesistirDescAcresFinalizacao.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirFinalizacaoComandaClick;
var
  Value: Integer;
begin
  FView.btnDesistirFinalizacaoComanda.Enabled := False;

  Value := DMConexao.mensagem(DMConexao.Usuario.nome +
    ', deseja desistir da finalização de pagamento?', 1);

  if Value = 6 then
  begin
    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .imgFechar.Enabled := True;

    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .retFechar.Enabled := True;

    FView.retFinalizacaoVenda.Visible := False;
    FView.retModalLancProduto.Visible := False;

    limpaFormasPagamentoParcialValor;
    limpaItensFinalizacao;
    limpaItensLancamentoAdmCartao;
    limpaDadosLancamentoCartao;

    FConta.ContaCliente.Venda := nil;
  end;

  FView.btnDesistirFinalizacaoComanda.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirInformacaoItemClick;
begin

  FView.btnDesistirInformacaoItem.Enabled := False;

  limpaInformacoesProduto;
  limpaInformacoesProdutoAdicionais;

  ItemSelecionado := nil;

  FView.Label29.Text := '';

  FView.retModalLancProduto.Visible := False;
  FView.retInformacoesItemConta.Visible := False;

  FView.btnDesistirInformacaoItem.Enabled := True;

end;

procedure TFrmComandaController.btnDesistirLancamentoCartaoClick;
begin
  FView.btnDesistirLancamentoCartao.Enabled := False;

  if (FConta.ContaCliente.Venda.totalContasAdmCartao
    (FFormaPagamentoSelecionado.FormaPagamento) <
    FFormaPagamentoSelecionado.Valor) and DMConexao.Configuracao.ObrigarLancarParcelasCartao
  then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', lance as parcelas antes de fechar esta tela.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    FView.btnDesistirLancamentoCartao.Enabled := True;
    exit
  end;

  FView.retFinalizacaoVenda.Enabled := True;
  FView.retLancamentoContasReceberCartao.Visible := False;

  addInformacoesFinalizacao;

  FFormaPagamentoSelecionado := nil;

  FView.retInserirValorFormaPagamento.Visible := False;

  FView.retFinalizacaoVenda.Enabled := True;

  FView.btnConfirmarValor.Enabled := True;

  FView.btnConfirmaLancamentosCartao.Enabled := True;

  FView.btnDesistirLancamentoCartao.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirLancPagamentoParcialVClick;
begin
  FView.btnDesistirLancPagamentoParcialV.Enabled := False;

  FView.retLancPagamentoParcialValor.Visible := False;
  FView.retPagamentoParcialValor.Enabled := True;

  FFormaPagamentoSelecionado := nil;

  limpaFormasPagamentoParcialValor;

  addPagamentosPaciais;

  FView.btnDesistirLancPagamentoParcialV.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirPagamentoParcialProdutoClick;
begin
  FView.btnDesistirPagamentoParcialProduto.Enabled := False;

  FView.retPagamentoParcialProduto.Visible := False;
  FView.retModalLancProduto.Visible := False;

  limpaItemsPagamentoParcialProduto;

  FView.btnDesistirPagamentoParcialProduto.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirPagamentoParcialValorClick;
begin

  FView.btnDesistirPagamentoParcialValor.Enabled := False;

  FView.retPagamentoParcialValor.Visible := False;
  FView.retModalLancProduto.Visible := False;

  limpaPagamentosPaciais;

  FView.btnDesistirPagamentoParcialValor.Enabled := True;

end;

procedure TFrmComandaController.btnDesistirQuantidadeTransferenciaClick;
begin
  FView.btnDesistirQuantidadeTransferencia.Enabled := False;

  FView.retLancamentoQuantidadeTransferencia.Visible := False;
  FView.retTransferenciaComanda.Enabled := True;

  FView.btnDesistirQuantidadeTransferencia.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirRemoverPagamentoParcialClick;
begin
  FView.btnDesistirRemoverPagamentoParcial.Enabled := False;

  addDados;

  if FView.retPagamentoParcialValor.Visible then
    addPagamentosPaciais
  else if FView.retInformacoesItemConta.Visible then
  begin
    addPagamentosParciaisProduto;
    limpaInformacoesProduto;
    addInformacoesProduto;
    addItensComanda;

    FView.retInformacoesItemConta.Position.X :=
      (FView.Width - FView.retInformacoesItemConta.Width) / 2;
    FView.retInformacoesItemConta.Position.Y :=
      (FView.Height - FView.retInformacoesItemConta.Height) / 2;
  end;

  if FView.retPagamentoParcialValor.Visible then
    FView.retPagamentoParcialValor.Enabled := True
  else if FView.retInformacoesItemConta.Visible then
    FView.retInformacoesItemConta.Enabled := True;

  FView.retDeletaPagamentoParcial.Visible := False;

  FView.btnDesistirRemoverPagamentoParcial.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirSelecaoFormaPagamentoClick;
begin
  FView.retFormasPagamentoParcialProduto.Visible := False;
  FView.retPagamentoParcialProduto.Enabled := True;

  FFormaPagamentoSelecionado := nil;

  addDados;
  addItensComanda;
  addItemsPagamentoParcialProduto;
end;

procedure TFrmComandaController.btnDesistirSelecaoPagamentoClick;
begin
  FView.btnDesistirSelecaoPagamento.Enabled := False;

  FView.retSelecaoTipoPagamento.Visible := False;
  FView.retModalLancProduto.Visible := False;

  FView.btnDesistirSelecaoPagamento.Enabled := True;
end;

procedure TFrmComandaController.btnDesistirValorClick;
begin
  FView.btnDesistirValor.Enabled := False;

  FFormaPagamentoSelecionado.Selecionado := True;
  FFormaPagamentoSelecionado.shadow;
  FFormaPagamentoSelecionado.Selecionado := False;

  FFormaPagamentoSelecionado := nil;

  FView.retInserirValorFormaPagamento.Visible := False;

  FView.retFinalizacaoVenda.Enabled := True;

  FView.btnDesistirValor.Enabled := True;
end;

procedure TFrmComandaController.btnFinalizarComandaClick;
var
  I, Value, idPagamento, Iteracao: Integer;
  FormasPagamento: Boolean;
  VendaFormaPagamento: TVendaFormaPagamento;
  Y: Integer;
  ContasReceberCartao: TObjectList<TContaReceberCartao>;
  Confirmacao: Boolean;
  ContaReceberCartao: TContaReceberCartao;
begin
  FView.btnFinalizarComanda.Enabled := False;
  ContasReceberCartao := nil;
  Confirmacao := False;
  Iteracao := 0;

  if not TCaixaDAO.getInstancia.verificaCaixaAberto(DMConexao.Configuracao.Caixa)
  then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o caixa não está aberto! Abra-o antes de iniciar a movimentação.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    FView.btnFinalizarComanda.Enabled := True;
    exit;
  end;

  FConta.ContaCliente.Venda.CodificacaoFiscal := '59';

  DMConexao.FLabelStatusEnvioFiscal := FView.lblStatusEnvioFiscal;

  DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.nome +
    ', VALIDANDO INFORMAÇÕES DA VENDA, AGUARDE...';

  abreTelaStatusEnviaFiscal(True);

  try
    if DMConexao.Configuracao.Caixa.TipoCaixa = opMFE then
      if not FSat.IntegradorAtivo then
      begin
        FView.btnFinalizarComanda.Enabled := True;

        abreTelaStatusEnviaFiscal(False);
        exit;
      end;
  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := E.Message;
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;
      abreTelaStatusEnviaFiscal(False);
      FView.btnFinalizarComanda.Enabled := True;
    end;
  end;

  FormasPagamento := False;

  if Assigned(FListaFormasPagamento) then
    for I := 0 to FListaFormasPagamento.Count - 1 do
    begin
      if FListaFormasPagamento.Items[I].Selecionado then
      begin
        FormasPagamento := True;
        Break
      end;
    end;

  if not FormasPagamento then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', infome alguma forma de pagamento para prosseguir.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    FView.btnFinalizarComanda.Enabled := True;
    abreTelaStatusEnviaFiscal(False);
    exit
  end;

  if (FConta.ContaCliente.Venda.Total > 0.1) then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', informe todo o valor de pagamento nas formas de pagamento presentes.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.btnFinalizarComanda.Enabled := True;
    abreTelaStatusEnviaFiscal(False);
    exit;
  end;

  FConta.ContaCliente.Venda.FormasPagamento :=
    TObjectList<TVendaFormaPagamento>.Create();
  for I := 0 to FListaFormasPagamento.Count - 1 do
  begin
    if FListaFormasPagamento.Items[I].Selecionado then
    begin
      if FListaFormasPagamento.Items[I].Valor > 0 then
      begin
        VendaFormaPagamento := TVendaFormaPagamento.Create;
        VendaFormaPagamento.FormaPagamento := FListaFormasPagamento.Items[I]
          .FormaPagamento;
        VendaFormaPagamento.Valor := FListaFormasPagamento.Items[I].Valor;
        FConta.ContaCliente.Venda.FormasPagamento.Add(VendaFormaPagamento);
      end;
    end;
  end;

  if Assigned(FVendaFormaPagamento) then
    FConta.ContaCliente.Venda.FormasPagamento.Add(FVendaFormaPagamento)
  else
  begin
    VendaFormaPagamento := TVendaFormaPagamento.Create;
    VendaFormaPagamento.FormaPagamento :=
      TFormaPagamentoDAO.getInstancia.buscaTroco;
    VendaFormaPagamento.Valor := 0;
  end;

  if (FConta.ContaCliente.Venda.totalFormaPagamento('PR') > 0) and
    (FConta.ContaCliente.Venda.Cliente.Codigo = DMConexao.Configuracao.
    ClientePadrao.Codigo) then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o cliente da venda é o cliente padrão de vendas, ' +
      'e há forma(s) de pagamento do tipo promissoria. Informe um cliente. ';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    FView.btnFinalizarComanda.Enabled := True;
    abreTelaStatusEnviaFiscal(False);
    exit
  end;

  if (FConta.ContaCliente.Venda.totalFormaPagamento('PR') > 0) and
    ((FConta.ContaCliente.Venda.TipoVenda.Codigo = DMConexao.Configuracao.
    TipoVendaPadrao.Codigo) or (FConta.ContaCliente.Venda.TipoVenda.Avista))
  then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o tipo de venda informado é para vendas a vista, ' +
      'e há forma(s) de pagamento do tipo promissoria. Informe um tipo de venda para promissoria. ';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    FView.btnFinalizarComanda.Enabled := True;
    abreTelaStatusEnviaFiscal(False);
    exit
  end;

  FConta.ContaCliente.Venda.Total :=
    (StrToCurr(stringreplace(Trim(copy(FView.lblTotalPagoFinalizacao.Text, 4,
    FView.lblTotalPagoFinalizacao.Text.Length)), '.', '', [rfReplaceAll,
    rfIgnoreCase])));

  if (FConta.ContaCliente.Venda.totalFormaPagamento('PR') > 0) or
    (FConta.ContaCliente.Venda.totalFormaPagamento('CH') > 0) then
  begin

    if FConta.ContaCliente.Venda.Cliente.ControlaLimite then
    begin
      if FConta.ContaCliente.Venda.Cliente.saldoDevedor <
        FConta.ContaCliente.Venda.totalFormaPagamento('PR') then
      begin
        Application.CreateForm(TFrmMensagem, FrmMensagem);
        FrmMensagem.FTipo := 0;
        FrmMensagem.FProcedimento := DMConexao.Usuario.nome + ', O Cliente ' +
          FConta.ContaCliente.Venda.Cliente.NomeCliente + ' Está Configurado ' +
          'Para Controlar Limite de Crédito, Porém Ele Não Possui Limite Disponível Para o Valor Desta Compra.'
          + sLineBreak + sLineBreak +
          'Saldo do Cliente (Limite - Valor Devedor): ' +
          CurrToStr(FConta.ContaCliente.Venda.Cliente.saldoDevedor) + sLineBreak
          + 'Valor do Pagamento Com Promissoria: ' +
          CurrToStr(FConta.ContaCliente.Venda.totalFormaPagamento('PR')) +
          sLineBreak + sLineBreak +
          'Por Favor, Verifique Com a Gerência. Caso Seja Liberada a Venda Para o Cliente, '
          + 'Solicite ao Gerente de Caixa Para Efetuar a Liberação Com Sua Senha a Seguir.';
        FrmMensagem.FTitulo := 'Atenção!';
        FrmMensagem.ShowModal;
        FView.btnFinalizarComanda.Enabled := True;
        abreTelaStatusEnviaFiscal(False);
        exit;
      end;
    end;

    Application.ProcessMessages;

    Application.CreateForm(TFrmLancamentoContasReceber,
      FrmLancamentoContasReceber);
    TFrmLancamentoContasReceberController.FVenda := FConta.ContaCliente.Venda;
    FrmLancamentoContasReceber.ShowModal;

    FConta.ContaCliente.Venda.Cliente.ContasReceber :=
      DMConexao.FListaContasReceber;
  end;

  if DMConexao.Configuracao.ValorMaximoVendaSemCPF > 0 then
  begin
    if ((DMConexao.RemoveChar(FConta.ContaCliente.Venda.Cliente.Cnpj) = '') or
      (FConta.ContaCliente.Venda.Cliente.Cnpj.Trim.Length < 11)) or
      ((not(DMConexao.cpf(FConta.ContaCliente.Venda.Cliente.Cnpj))) or
      (DMConexao.Cnpj(DMConexao.RemoveChar(FConta.ContaCliente.Venda.Cliente.
      Cnpj)))) then
    begin

      if FConta.ContaCliente.Venda.Total > DMConexao.Configuracao.ValorMaximoVendaSemCPF
      then
      begin
        if ((DMConexao.RemoveChar(FConta.ContaCliente.Venda.Cliente.Cnpj) = '')
          or (FConta.ContaCliente.Venda.Cliente.Cnpj.Trim.Length < 11)) or
          ((not(DMConexao.cpf(FConta.ContaCliente.Venda.Cliente.Cnpj))) or
          (DMConexao.Cnpj(DMConexao.RemoveChar(FConta.ContaCliente.Venda.
          Cliente.Cnpj)))) then
        begin
          Application.CreateForm(TFrmMensagem, FrmMensagem);
          FrmMensagem.FTipo := 0;
          FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
            ', CPF ou CNPJ do Cliente Não Informado e o ' +
            'Valor Máximo da Venda Execede o Valor Máximo Permitido Para Vendas Sem '
            + 'Identificação do Cliente.' + sLineBreak + sLineBreak +
            'Para Continuar a Venda Sem a Identificação do Cliente, Informe a Senha do Gerente de Caixa.';
          FrmMensagem.FTitulo := 'Atenção!';
          FrmMensagem.ShowModal;

          Value := DMConexao.senha('Liberar venda sem cpf');

          if not(Value = 11) then
          begin
            FView.btnFinalizarComanda.Enabled := True;
            abreTelaStatusEnviaFiscal(False);
            exit;
          end;
        end;
      end;
    end;
  end;

  case DMConexao.Configuracao.Caixa.TipoCaixa of
    opECF, opMFE:
      begin

        if FConta.ContaCliente.Venda.totalFormaPagamento('CA') > 0 then
        begin
          if DMConexao.Configuracao.Caixa.TefCaixa = 'N' then
          begin
            if DMConexao.Empresa.ChaveAcessoVFPE.Trim <> '' then
            begin
              try
                Application.CreateForm(TFrmLancamentoPOS, FrmLancamentoPOS);
                TFrmLancamentoPOSController.FVenda := FConta.ContaCliente.Venda;
                FrmLancamentoPOS.ShowModal;

                Application.ProcessMessages;

                { if FConta.ContaCliente.Venda.totalFormaPagamento('CA') >
                  DMConexao.totalPOS then
                  begin
                  FView.btnFinalizarComanda.Enabled := True;
                  abreTelaStatusEnviaFiscal(False);
                  Application.ProcessMessages;
                  exit;
                  abort;
                  end;
                }
              except
                on E: Exception do
                begin

                  Application.CreateForm(TFrmMensagem, FrmMensagem);
                  FrmMensagem.FTipo := 0;
                  FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
                    ', Não foi possível iniciar o lançamento de POS. Mensagem retornada: '
                    + E.Message;
                  FrmMensagem.FTitulo := 'Atenção!';
                  FrmMensagem.ShowModal;

                  FView.btnFinalizarComanda.Enabled := True;
                  abreTelaStatusEnviaFiscal(False);
                  exit;
                end;
              end;

              Confirmacao := False;
              Iteracao := 0;

              if Assigned(DMConexao.FPagamentosPOS) then
                for I := 0 to DMConexao.FPagamentosPOS.Count - 1 do
                begin
                  try

                    Value := 6;
                    { enquanto não houver confirmação de pagamento faça }
                    while not Confirmacao do
                    begin
                      try
                        try
                          { se o value da tela de mensagem for 6 ele tenta enviar o pagamento }
                          if Value = 6 then
                          begin
                            try
                              DMConexao.FPagamentosPOS.Items[I].idPagamento :=
                                FSat.EnviarPagamento
                                (DMConexao.FPagamentosPOS.Items[I]);
                              Confirmacao := True;
                            except
                              on E: Exception do
                              begin
                                { se a iteração do laço for maior que 1 começa a mostrar mensagem de pagamento de cartão }
                                if Iteracao > 1 then
                                begin
                                  Application.CreateForm(TFrmMensagem,
                                    FrmMensagem);
                                  FrmMensagem.FTipo := 1;
                                  FrmMensagem.FProcedimento :=
                                    DMConexao.Usuario.nome +
                                    ', Não Foi Possível Enviar o Pagamento no Cartão. Mensagem Retornada: '
                                    + sLineBreak + E.Message + sLineBreak +
                                    'Deseja Enviar Novamente?';
                                  FrmMensagem.FTitulo := 'Atenção!';

                                  Value := FrmMensagem.ShowModal;
                                end;
                              end;
                            end;
                          end
                          else
                          begin
                            Break;
                          end;
                        except
                        end;
                      finally
                        Iteracao := Iteracao + 1;
                      end;

                    end;

                    { caso o usuario não deseje enviar o cartão novamente sair do laço de pagamento }
                    if Value <> 6 then
                      Break;

                    Iteracao := 0;
                    Confirmacao := False;

                    if DMConexao.Configuracao.ConsultaPagamentoPOS then
                    begin
                      if DMConexao.FPagamentosPOS.Items[I].idPagamento > 0 then
                      begin
                        while not Confirmacao do
                        begin

                          Value := 6;

                          if Iteracao <> 0 then
                          begin
                            Application.CreateForm(TFrmMensagem, FrmMensagem);
                            FrmMensagem.FTipo := 1;
                            FrmMensagem.FProcedimento := DMConexao.Usuario.nome
                              + ', o Pagamento no POS ' +
                              DMConexao.FPagamentosPOS.Items[I].nome +
                              ' Ainda Não Foi Confirmado. Deseja Verificar Novamente?';
                            FrmMensagem.FTitulo := 'Atenção!';

                            Value := FrmMensagem.ShowModal;

                            Iteracao := Iteracao + 1;
                          end;

                          if Value = 6 then
                          begin
                            for Y := 0 to DMConexao.Configuracao.
                              TimeOutConsultaPOS do
                            begin
                              sleep(1000);

                              ContasReceberCartao :=
                                FSat.VerificarStatusValidador
                                (DMConexao.FPagamentosPOS.Items[I].idPagamento,
                                FConta.ContaCliente.Venda);

                              if ContasReceberCartao <> nil then
                              begin
                                FConta.ContaCliente.Venda.ContasReceberCartao :=
                                  ContasReceberCartao;
                                Confirmacao := False;
                                Break;
                              end;
                            end;
                          end
                          else
                          begin
                            Break;
                          end;
                        end;
                      end;
                    end;
                  except
                    on E: Exception do
                    begin
                      Application.CreateForm(TFrmMensagem, FrmMensagem);
                      FrmMensagem.FTipo := 0;
                      FrmMensagem.FProcedimento := E.Message;
                      FrmMensagem.FTitulo := 'Atenção!';
                      FrmMensagem.ShowModal;
                    end;
                  end;

                end;
            end;
          end
          else
          begin
            { CODIGO CASO O CLIENTE USE TEF }
          end;
        end;

        Confirmacao := False;
        Iteracao := 0;
        Value := 6;

        while not Confirmacao do
        begin
          try
            try

              DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.nome +
                ', FECHANDO CUPOM FISCAL: ' + IntToStr(Iteracao + 1) +
                'º TENTATIVA, AGUARDE...';
              Application.ProcessMessages;

              FSat.FechaCupomFiscal(FConta.ContaCliente.Venda);
              Confirmacao := True;
              Continue;
            except
              on E: Exception do
              begin
                if Iteracao > 0 then
                begin
                  Application.CreateForm(TFrmMensagem, FrmMensagem);
                  FrmMensagem.FTipo := 1;
                  FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
                    ', Não Foi Possível Enviar o documento fiscal. ' +
                    'Abaixo está a lista do(s) erro(s) acontecido(s): ' +
                    sLineBreak + sLineBreak + E.Message + sLineBreak +
                    sLineBreak +
                    'Deseja Enviar Novamente? (Clique em SIM Para Enviar ou NÃO '
                    + 'Para Concluir a Venda e Enviar Posteriormente)';
                  FrmMensagem.FTitulo := 'Atenção!';
                  Value := FrmMensagem.ShowModal;

                  if Value <> 6 then
                  begin
                    Confirmacao := True;
                    Continue;
                  end;
                end;
              end;
            end;
          finally
            Iteracao := Iteracao + 1;
          end;
        end;

        TVendaDAO.getInstancia.inserir(FConta.ContaCliente.Venda);

        if Assigned(DMConexao.FPagamentosPOS) then
          for I := 0 to DMConexao.FPagamentosPOS.Count - 1 do
          begin
            Confirmacao := False;
            Iteracao := 0;
            Value := 6;
            try
              if Value = 6 then
              begin
                ContaReceberCartao := retornaContaReceberCartao
                  (FConta.ContaCliente.Venda.ContasReceberCartao,
                  DMConexao.FPagamentosPOS.Items[I].AdministradoraCartao);

                while not Confirmacao do
                begin
                  try
                    try
                      FSat.RespostaFiscal(FConta.ContaCliente.Venda,
                        DMConexao.FPagamentosPOS.Items[I], ContaReceberCartao);

                      Confirmacao := True;

                      TVendaDAO.getInstancia.inserirPOS
                        (FConta.ContaCliente.Venda,
                        DMConexao.FPagamentosPOS.Items[I], ContaReceberCartao);

                      Break;
                    except
                      on E: Exception do
                      begin
                        if Iteracao > 1 then
                        begin
                          Application.CreateForm(TFrmMensagem, FrmMensagem);
                          FrmMensagem.FTipo := 1;
                          FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
                            ', Não Foi Possível Enviar a resposta fiscal. ' +
                            'Abaixo está a lista do(s) erro(s) acontecido(s): '
                            + sLineBreak + sLineBreak + E.Message + sLineBreak +
                            sLineBreak + 'Deseja Enviar Novamente?';
                          FrmMensagem.FTitulo := 'Atenção!';
                          Value := FrmMensagem.ShowModal;
                        end;

                        if Value <> 6 then
                          Break;
                      end;
                    end;
                  finally
                    Iteracao := Iteracao + 1;
                  end;

                end;
              end;
            except
              on E: Exception do
              begin
                Application.CreateForm(TFrmMensagem, FrmMensagem);
                FrmMensagem.FTipo := 1;
                FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
                  ', Não Foi Possível Enviar a resposta fiscal. ' +
                  'Abaixo está a lista do(s) erro(s) acontecido(s): ' +
                  sLineBreak + sLineBreak + E.Message + sLineBreak + sLineBreak
                  + 'Deseja Enviar Novamente?';
                FrmMensagem.FTitulo := 'Atenção!';
                Value := FrmMensagem.ShowModal;

                if Value <> 6 then
                  Break;
              end;
            end;

          end;

        try
          { CASO O CUPOM SEJA ENVIADO ENTÃO IMPRIMIR O COMPROVATE FISCAL }
          if Value = 6 then
            FSat.FechaCupomFiscalImprimirCupomFiscal
              (FConta.ContaCliente.Venda, False);
        except
          on E: Exception do
          begin
            Application.CreateForm(TFrmMensagem, FrmMensagem);
            FrmMensagem.FTipo := 0;
            FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
              DMConexao.Usuario.nome;
            FrmMensagem.FTitulo := 'Atenção!';
            FrmMensagem.ShowModal;
          end;
        end;
      end;
    opNaoFiscal:
      TVendaDAO.getInstancia.inserir(FConta.ContaCliente.Venda);
  end;

  TVendaDAO.getInstancia.alterar(FConta.ContaCliente.Venda);

  if Assigned(FConta.ContaCliente.Venda.ContasReceberCartao) then
    for I := 0 to FConta.ContaCliente.Venda.ContasReceberCartao.Count - 1 do
      TContaReceberCartaoDAO.getInstancia.inserir
        (FConta.ContaCliente.Venda.ContasReceberCartao.Items[I],
        FConta.ContaCliente.Venda);

  if Assigned(FConta.ContaCliente.Venda.Cliente) then
  begin
    if Assigned(FConta.ContaCliente.Venda.Cliente.ContasReceber) then
    begin
      for I := 0 to FConta.ContaCliente.Venda.Cliente.ContasReceber.Count - 1 do
      begin
        with FConta.ContaCliente.Venda.Cliente.ContasReceber.Items[I] do
        begin
          CodigoVenda := FConta.ContaCliente.Venda.Codigo;
          NumeroDocumento := 'COO ' +
            IntToStr(FConta.ContaCliente.Venda.CupomFiscal);

          TContaReceberDAO.getInstancia.inserir
            (FConta.ContaCliente.Venda.Cliente.ContasReceber.Items[I]);
        end;
      end;
    end;
  end;

  FConta.ContaCliente.DataFechamento := Date;
  FConta.ContaCliente.HoraFechamento := Time;
  FConta.ContaCliente.Status := 1;

  TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);

  TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
    .imgFechar.Enabled := True;

  TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
    .retFechar.Enabled := True;

  FView.Label67.Visible := False;
  FView.lblValorTrocoFinalizacao.Visible := False;
  FView.lblValorTrocoFinalizacao.Text := 'R$ 0,00';

  sleep(500);

  FormClose;

  abreTelaStatusEnviaFiscal(False);
  FView.btnFinalizarComanda.Enabled := True;
end;

procedure TFrmComandaController.btnImprimeCozinhaBarClick;
begin

  FView.btnImprimeCozinhaBar.Enabled := False;

  if DMConexao.Configuracao.ImprimirComandaPorProduto then
    comandaProduto
  else
    comanda;

  addItensComanda;

  FView.btnImprimeCozinhaBar.Enabled := True;
end;

procedure TFrmComandaController.btnIndicadorClick;
var
  Indicador: TIndicador;
  I: Integer;
begin

  FView.btnIndicador.Enabled := False;

  TContaClienteDAO.getInstancia.buscarAtualizacao(FConta.ContaCliente);

  FView.retModalLancProduto.Visible := True;
  FView.retAddIndicador.Visible := True;

  if not Assigned(FConta.ContaCliente.Indicador) then
  begin
    FView.lblNomeIndicador.Text := 'Sem Indicador';
    FView.btnRemoverIndicador.Enabled := False;
  end
  else
  begin
    FView.lblNomeIndicador.Text := 'Indicador: ' +
      FConta.ContaCliente.Indicador.nome.Trim;
    FView.btnRemoverIndicador.Enabled := True;
  end;

  FView.retAddIndicador.Position.X :=
    (FView.Width - FView.retAddIndicador.Width) / 2;
  FView.retAddIndicador.Position.Y :=
    (FView.Height - FView.retAddIndicador.Height) / 2;

  FListaIndicador := TIndicadorDAO.getInstancia.buscarTodos;

  if Assigned(FConta.ContaCliente.Indicador) then
    Indicador := FConta.ContaCliente.Indicador
  else
  begin
    Indicador := TIndicador.Create;
    Indicador.Codigo := 1;
  end;

  FView.cbIndicadores.Items.Clear;

  for I := 0 to FListaIndicador.Count - 1 do
  begin
    FView.cbIndicadores.Items.Add(IntToStr(FListaIndicador.Items[I].Codigo) +
      ' - ' + FListaIndicador.Items[I].nome);
    if Indicador.Codigo = FListaIndicador.Items[I].Codigo then
      FView.cbIndicadores.ItemIndex := I;
  end;

  Indicador := nil;

  TContaClienteDAO.getInstancia.buscarAtualizacao(FConta.ContaCliente);

  // addDados;

  FView.btnIndicador.Enabled := True;
end;

procedure TFrmComandaController.btnInformacoesMesaClick;
begin
  FView.btnInformacoesMesa.Enabled := False;

  TContaClienteDAO.getInstancia.buscarAtualizacao(FConta.ContaCliente);
  addDados('N');

  FView.retInformacoes.Position.X :=
    (FView.Width - FView.retInformacoes.Width) / 2;
  FView.retInformacoes.Position.Y :=
    (FView.Height - FView.retInformacoes.Height) / 2;

  FView.retInformacoes.Visible := True;
  FView.retModalLancProduto.Visible := True;

  FView.btnInformacoesMesa.Enabled := True;
end;

procedure TFrmComandaController.btnItensComandaClick;
begin

  FView.btnItensComanda.Enabled := False;

  FView.retItensComandaInformacoes.Visible :=
    not FView.retItensComandaInformacoes.Visible;

  if FView.retItensComandaInformacoes.Visible then
    addItensComanda;

  FView.btnItensComanda.Enabled := True;
end;

procedure TFrmComandaController.btnPacialProdutoClick;
begin
  FView.btnPacialProduto.Enabled := False;

  FView.retPagamentoParcialProduto.Position.X :=
    (FView.Width - FView.retPagamentoParcialProduto.Width) / 2;
  FView.retPagamentoParcialProduto.Position.Y :=
    (FView.Height - FView.retPagamentoParcialProduto.Height) / 2;

  addItemsPagamentoParcialProduto;

  FView.retPagamentoParcialProduto.Visible := True;
  FView.retSelecaoTipoPagamento.Visible := False;

  FView.btnPacialProduto.Enabled := True;
end;

procedure TFrmComandaController.btnPacialValorClick;
begin
  FView.btnPacialValor.Enabled := False;

  FView.retPagamentoParcialValor.Position.X :=
    (FView.Width - FView.retPagamentoParcialValor.Width) / 2;
  FView.retPagamentoParcialValor.Position.Y :=
    (FView.Height - FView.retPagamentoParcialValor.Height) / 2;

  FView.retSelecaoTipoPagamento.Visible := False;
  FView.retPagamentoParcialValor.Visible := True;
  FView.retModalLancProduto.Visible := True;

  FView.EdtLancPagParcialValor.Text := '';

  addPagamentosPaciais;

  FView.btnPacialValor.Enabled := True;
end;

procedure TFrmComandaController.btnPagamentoClick;
var
  I: Integer;
  FAtualizaMesas: ITask;
begin
  FView.btnPagamento.Enabled := False;

  TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
    .imgFechar.Enabled := False;

  TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
    .retFechar.Enabled := False;

  { DEFINIÇÃO DE ACESSO }
  if not DMConexao.Usuario.buscaAcesso('M054') then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', Você não tem permissão para efetuar esta operação.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    FView.btnPagamento.Enabled := True;
    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .imgFechar.Enabled := True;

    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .retFechar.Enabled := True;
    exit;
  end;

  { VERIFICAR SE A COMANDA ESTÁ ZERADA }
  addDados('S');

  if (StrToCurr(stringreplace(FView.lblTotal.Text, '.', '', [rfReplaceAll,
    rfIgnoreCase]))) < 0 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', essa comanda está com o total zerado.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    FView.btnPagamento.Enabled := True;
    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .imgFechar.Enabled := True;

    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .retFechar.Enabled := True;
    exit;
  end;

  { CASO O PARAMETRO DE SAIDA COM ESTOQUE NEGATIVO ESTEJA DESMARCADO
    VERIFICAR SE HÁ PRODUTOS QUE IRÃO FICAR COM O SEU ESTOQUE NEGATIVO }
  if not DMConexao.Configuracao.SaidaEstoqueNegativo then
  begin
    for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
    begin
      if FConta.ContaCliente.ItensContaCliente.Items[I].Cancelado = 0 then
      begin
        if FConta.ContaCliente.ItensContaCliente.Items[I].Produto.ControlaEstoque
        then
        begin
          if FConta.ContaCliente.ItensContaCliente.Items[I]
            .Produto.QuantidadeComposicao > 0 then
          begin
            if not(DMConexao.Configuracao.EfetuarRegistroProducaoVenda) then
            begin
              if (FConta.ContaCliente.ItensContaCliente.Items[I].Produto.estoque
                (DMConexao.Configuracao.EstoquePadrao)) -
                (FConta.ContaCliente.ItensContaCliente.Items[I].Quantidade) < 0
              then
              begin
                Application.CreateForm(TFrmMensagem, FrmMensagem);
                FrmMensagem.FTipo := 0;
                FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
                  ', produto cód. ' +
                  IntToStr(FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Produto.Codigo) + ' e descrição: ' +
                  FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Produto.DescricaoCupom +
                  ' da comanda com estoque insuficiente.';
                FrmMensagem.FTitulo := 'Aviso!';
                FrmMensagem.ShowModal;

                FView.btnPagamento.Enabled := True;
                TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
                  .imgFechar.Enabled := True;

                TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
                  .retFechar.Enabled := True;
                exit;
                abort;
              end;
            end;
          end
          else
          begin
            Application.CreateForm(TFrmMensagem, FrmMensagem);
            FrmMensagem.FTipo := 0;
            FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
              ', produto cód. ' +
              IntToStr(FConta.ContaCliente.ItensContaCliente.Items[I]
              .Produto.Codigo) + ' e descrição: ' +
              FConta.ContaCliente.ItensContaCliente.Items[I]
              .Produto.DescricaoCupom + ' da comanda com estoque insuficiente.';
            FrmMensagem.FTitulo := 'Aviso!';
            FrmMensagem.ShowModal;

            FView.btnPagamento.Enabled := True;
            TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
              .imgFechar.Enabled := True;

            TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
              .retFechar.Enabled := True;
            exit;
            abort;
          end;

        end;

      end;
    end;
  end;

  if not TCaixaDAO.getInstancia.verificaCaixaAberto(DMConexao.Configuracao.Caixa)
  then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o caixa não está aberto! Abra-o antes de iniciar a movimentação.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    FView.btnPagamento.Enabled := True;
    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .imgFechar.Enabled := True;

    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .retFechar.Enabled := True;
    exit;
  end;

  FView.Label49.Text := 'Finalização da comanda: ' + TComprovante.FormataStringD
    (IntToStr(FConta.ContaCliente.Conta), '3', '0');

  FView.retFinalizacaoVenda.Position.X :=
    (FView.Width - FView.retFinalizacaoVenda.Width) / 2;
  FView.retFinalizacaoVenda.Position.Y :=
    (FView.Height - FView.retFinalizacaoVenda.Height) / 2;

  FView.retFinalizacaoVenda.Visible := True;
  FView.retModalLancProduto.Visible := True;

  FView.btnPagamento.Enabled := True;
  IniciaVenda;
  IniciaProdutosVenda;
  addFormasPagamentoFinalizacao;
  addInformacoesFinalizacao;

end;

procedure TFrmComandaController.btnPagamentoParcialClick;
begin
  FView.btnPagamentoParcial.Enabled := False;

  TContaClienteDAO.getInstancia.buscarParciais(FConta.ContaCliente);

  if not TCaixaDAO.getInstancia.verificaCaixaAberto(DMConexao.Configuracao.Caixa)
  then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o caixa não está aberto! Abra-o antes de iniciar a movimentação.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    FView.btnPagamentoParcial.Enabled := True;
    exit;
  end;

  FView.retSelecaoTipoPagamento.Position.X :=
    (FView.Width - FView.retSelecaoTipoPagamento.Width) / 2;
  FView.retSelecaoTipoPagamento.Position.Y :=
    (FView.Height - FView.retSelecaoTipoPagamento.Height) / 2;

  FView.retSelecaoTipoPagamento.Visible := True;
  FView.retModalLancProduto.Visible := True;

  FView.btnPagamentoParcial.Enabled := True;
end;

procedure TFrmComandaController.btnRecarregaInformacoesClick;
begin
  FView.btnRecarregaInformacoes.Enabled := False;

  addDados;

  addItensComanda;

  FView.btnRecarregaInformacoes.Enabled := True;
end;

procedure TFrmComandaController.btnRemoveAdicionalClick;
begin

  FView.btnRemoveAdicional.Enabled := False;

  if StrToInt(FView.EdtQuantidadeAdicional.Text) > 1 then
  begin
    FView.EdtQuantidadeAdicional.Text :=
      CurrToStr((StrToCurr(FView.EdtQuantidadeAdicional.Text.Trim) - 1));

    FView.lblTotalAdicional.Text := 'Total: R$ ' + formatfloat('#,##0.00',
      FAdicionalSelecionado.Produto.PrecoVista *
      StrToCurr(FView.EdtQuantidadeAdicional.Text.Trim));
  end;

  FView.btnRemoveAdicional.Enabled := True;
end;

procedure TFrmComandaController.btnRemoveParcelasClick;
begin
  FView.btnRemoveParcelas.Enabled := False;

  FView.lblParcelasCartao.Text := stringreplace(FView.lblParcelasCartao.Text,
    '.', '', [rfReplaceAll, rfIgnoreCase]);

  if StrToInt(FView.lblParcelasCartao.Text.Trim) > 1 then
    FView.lblParcelasCartao.Text :=
      CurrToStr((StrToInt(FView.lblParcelasCartao.Text.Trim) - 1));

  FView.btnRemoveParcelas.Enabled := True;
end;

procedure TFrmComandaController.btnRemoveQuantidadeClick;
begin

  FView.btnRemoveQuantidade.Enabled := False;

  FView.EdtValorProduto.Text := stringreplace(FView.EdtValorProduto.Text, '.',
    '', [rfReplaceAll, rfIgnoreCase]);

  FView.EdtQuantidadeProduto.Text :=
    stringreplace(FView.EdtQuantidadeProduto.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]);

  if StrToCurr(FView.EdtQuantidadeProduto.Text.Trim) > 1 then
    FView.EdtQuantidadeProduto.Text :=
      CurrToStr((StrToCurr(FView.EdtQuantidadeProduto.Text.Trim) - 1));

  FView.EdtValorProduto.Text :=
    currtostrf(StrToCurr(FView.EdtQuantidadeProduto.Text) *
    FProdutoSelecionado.Produto.PrecoVista, ffnumber, 2);

  FView.EdtQuantidadeProduto.Text :=
    currtostrf(StrToCurr(FView.EdtQuantidadeProduto.Text), ffnumber, 2);

  FView.btnRemoveQuantidade.Enabled := True;

end;

procedure TFrmComandaController.btnRemoveQuantidadeProdutoTransferencia;
var
  Quantidade: Currency;
begin
  FView.btnRemoveQuantidadeProdutoTransferencia.Enabled := False;

  Quantidade := StrToCurr
    (stringreplace(FView.EdtQuantidadeProdutoTransferencia.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]));

  if Quantidade - 1 > 0 then
  begin
    Quantidade := Quantidade - 1;
  end;

  FView.EdtQuantidadeProdutoTransferencia.Text :=
    formatfloat('#,##0.00', Quantidade);

  FView.btnRemoveQuantidadeProdutoTransferencia.Enabled := True;
end;

procedure TFrmComandaController.btnRemoverIndicadorClick;
var
  Value: Integer;
begin

  FView.btnRemoverIndicador.Enabled := False;

  Value := DMConexao.mensagem(DMConexao.Usuario.nome +
    ', deseja remover o indicador da comanda?', 1);

  if Value = 6 then
  begin
    FConta.ContaCliente.Indicador := nil;
    TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);
  end;

  btnCancelarIndicadorClick;

  FView.btnRemoverIndicador.Enabled := True;

end;

procedure TFrmComandaController.btnRemoverPagamentoParcialClick;
var
  Value: Integer;
begin
  FView.btnRemoverPagamentoParcial.Enabled := False;

  Value := DMConexao.mensagem(DMConexao.Usuario.nome +
    ', confirma exclusão do pagamento parcial?', 1);

  if Value = 6 then
  begin

    Value := DMConexao.senha('liberar exclusão de pagamento parcial.');

    if Value = 11 then
    begin
      if FView.retPagamentoParcialValor.Visible then
        TPagamentoParcialDAO.getInstancia.excluir
          (FPagamentoParcialSelecionado.PagamentoParcial, nil)
      else if FView.retInformacoesItemConta.Visible then
        TPagamentoParcialDAO.getInstancia.excluir
          (FPagamentoParcialSelecionado.PagamentoParcial, ItemSelecionado)

    end;
  end;

  btnDesistirRemoverPagamentoParcialClick;

  FView.btnRemoverPagamentoParcial.Enabled := True;
end;

procedure TFrmComandaController.btnRetiraTaxaServicoClick;
begin

  FView.btnRetiraTaxaServico.Enabled := False;

  // TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

  if FConta.ContaCliente.DispensarTaxaServico = 'N' then
    FConta.ContaCliente.DispensarTaxaServico := 'S'
  else
    FConta.ContaCliente.DispensarTaxaServico := 'N';

  TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);

  if FConta.ContaCliente.DispensarTaxaServico = 'N' then
    FView.btnRetiraTaxaServico.Text := 'Retirar Taxa Serviço'
  else
    FView.btnRetiraTaxaServico.Text := 'Cobrar Taxa Serviço';

  // TContaClienteDAO.getInstancia.buscarAtualizacao(FConta.ContaCliente);

  // addDados('N');

  FView.btnRetiraTaxaServico.Enabled := True;
end;

procedure TFrmComandaController.btnSairInformacoesMesaClick;
begin
  FView.btnSairInformacoesMesa.Enabled := False;

  FView.retModalLancProduto.Visible := False;
  FView.retInformacoes.Visible := False;

  FView.btnSairInformacoesMesa.Enabled := True;
end;

procedure TFrmComandaController.btnSelecionarIndicadorClick;
begin

  FView.btnSelecionarIndicador.Enabled := False;

  FConta.ContaCliente.Indicador :=
    buscaIndicador
    (StrToInt(copy(FView.cbIndicadores.Items[FView.cbIndicadores.ItemIndex], 1,
    pos(' ', FView.cbIndicadores.Items[FView.cbIndicadores.ItemIndex]) - 1)));
  TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);

  btnCancelarIndicadorClick;
  FView.btnSelecionarIndicador.Enabled := True;

end;

procedure TFrmComandaController.btnSelecionarMesaTransferenciaClick;
var
  Value: Integer;
begin

  FView.btnSelecionarMesaTransferencia.Enabled := False;

  if FView.EdtMesaTransferencia.Text.Trim = '' then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', Informe um número válido.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.EdtMesaTransferencia.Text := '';
    FView.EdtMesaTransferencia.SetFocus;
    FView.btnSelecionarMesaTransferencia.Enabled := True;
    exit;
  end;

  if FView.EdtMesaTransferencia.Text.Trim.Length > 9 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', Informe um número válido.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.EdtMesaTransferencia.Text := '';
    FView.EdtMesaTransferencia.SetFocus;
    FView.btnSelecionarMesaTransferencia.Enabled := True;
    exit;
  end;

  if (FView.EdtMesaTransferencia.Text.Trim <> '') and
    (StrToInt(FView.EdtMesaTransferencia.Text) > 0) then
  begin

    if Assigned(FContaTransferencia) then
    begin
      FContaTransferencia := nil;
      FView.EdtMesaTransferencia.Enabled := True;
      FView.btnSelecionarMesaTransferencia.Text := 'Selecionar comanda';
      FView.Rectangle4.Enabled := False;
    end
    else
    begin

      if not(TContaClienteDAO.getInstancia.existeMesaAberta
        (StrToInt(FView.EdtMesaTransferencia.Text.Trim),
        DMConexao.Empresa.Codigo)) then
      begin

        Value := DMConexao.mensagem(DMConexao.Usuario.nome +
          ', deseja abrir a comanda de destino?', 1);

        if Value = 6 then
        begin
          FContaTransferencia := TContaCliente.Create;
          FContaTransferencia.Conta :=
            StrToInt(FView.EdtMesaTransferencia.Text.Trim);
          FContaTransferencia.Empresa := DMConexao.Empresa;
          FContaTransferencia.Caixa := DMConexao.Configuracao.Caixa;
          TContaClienteDAO.getInstancia.inserir(FContaTransferencia);

          FView.Rectangle4.Enabled := True;

          FView.EdtMesaTransferencia.Enabled := False;
          FView.btnSelecionarMesaTransferencia.Text := 'Remover comanda';
        end;

      end
      else
      begin

        FContaTransferencia := TContaCliente.Create;
        FContaTransferencia.Conta :=
          StrToInt(FView.EdtMesaTransferencia.Text.Trim);
        FContaTransferencia.Status := 0;
        FContaTransferencia.Empresa := DMConexao.Empresa;

        TContaClienteDAO.getInstancia.buscar(FContaTransferencia);

        FView.Rectangle4.Enabled := True;
        FView.EdtMesaTransferencia.Enabled := False;
        FView.btnSelecionarMesaTransferencia.Text := 'Remover comanda';
      end;

    end;
  end
  else
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', informe o número da comanda.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    FView.EdtMesaTransferencia.SetFocus;
  end;

  FView.btnSelecionarMesaTransferencia.Enabled := True;
end;

procedure TFrmComandaController.btnTransferenciaMesaClick;
begin

  FView.btnTransferenciaMesa.Enabled := False;

  if not DMConexao.Usuario.buscaAcesso('M055') then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', Você não tem permissão para efetuar esta operação.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    FView.btnTransferenciaMesa.Enabled := True;
    exit;
  end;

  FView.retModalLancProduto.Visible := True;
  FView.retTransferenciaComanda.Visible := True;
  FView.Label16.Text := 'Transferência da comanda: ' +
    TComprovante.FormataStringD(IntToStr(FConta.ContaCliente.Conta), '3', '0');

  FView.retTransferenciaComanda.Position.X :=
    (FView.Width - FView.retTransferenciaComanda.Width) / 2;
  FView.retTransferenciaComanda.Position.Y :=
    (FView.Height - FView.retTransferenciaComanda.Height) / 2;

  TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

  addItensTransferencia;

  FView.Rectangle4.Enabled := False;

  FView.btnTransferenciaMesa.Enabled := True;

end;

procedure TFrmComandaController.btnTransferirItensClick;
var
  Value, I: Integer;
  ItensSelecionadosTransferencia: TObjectList<TItemContaCliente>;
begin

  FView.btnTransferirItens.Enabled := False;

  Value := DMConexao.mensagem(DMConexao.Usuario.nome +
    ', Confirma a transferência dos itens?', 1);

  if Value = 6 then
  begin
    ItensSelecionadosTransferencia := TObjectList<TItemContaCliente>.Create;

    for I := 0 to FItensTransferencia.Count - 1 do
    begin
      if FItensTransferencia.Items[I].Selecionado then
      begin
        FItensTransferencia.Items[I].ItemContaCliente.QuantidadeTransferencia :=
          FItensTransferencia.Items[I].QuantidadeSelecionada;
        ItensSelecionadosTransferencia.Add(FItensTransferencia.Items[I]
          .ItemContaCliente);
      end;
    end;

    TContaClienteDAO.getInstancia.transferirItens(FConta.ContaCliente,
      FContaTransferencia, ItensSelecionadosTransferencia);

    btnCancelarTransferenciaClick;
    FormClose;
  end;

  FView.btnTransferirItens.Enabled := True;
end;

procedure TFrmComandaController.btnTransferirTodosItensClick;
var
  I: Integer;
begin

  FView.btnTransferirTodosItens.Enabled := False;

  for I := 0 to FItensTransferencia.Count - 1 do
  begin
    if not FItensTransferencia.Items[I].Selecionado then
    begin
      FItensTransferencia.Items[I].selecao;
      FItensTransferencia.Items[I].QuantidadeSelecionada :=
        FItensTransferencia.Items[I].ItemContaCliente.Quantidade;
    end;
  end;

  btnTransferirItensClick;
  FView.btnTransferirTodosItens.Enabled := True;
end;

function TFrmComandaController.buscaGarcom(Codigo: Integer): TVendedor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FListaGarcom.Count - 1 do
  begin
    if FListaGarcom.Items[I].Codigo = Codigo then
    begin
      Result := FListaGarcom.Items[I];
      Break;
    end;
  end;
end;

function TFrmComandaController.buscaIndicador(Codigo: Integer): TIndicador;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FListaIndicador.Count - 1 do
  begin
    if FListaIndicador.Items[I].Codigo = Codigo then
    begin
      Result := FListaIndicador.Items[I];
      Break;
    end;
  end;
end;

function TFrmComandaController.buscaObservacao(Codigo: Integer)
  : TObservacaoView;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FListaObservacoes.Count - 1 do
  begin
    if FListaObservacoes.Items[I].Observacao.Codigo = Codigo then
    begin
      Result := FListaObservacoes.Items[I];
      Break;
    end;
  end;
end;

function TFrmComandaController.buscaProduto(Codigo: Integer): TProdutoView;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FListaProdutos.Count - 1 do
  begin
    if FListaProdutos.Items[I].Produto.Codigo = Codigo then
    begin
      Result := FListaProdutos.Items[I];
      Break;
    end;
  end;
end;

function TFrmComandaController.buscarProduto(Codigo: Integer;
  ItensContaClienteAgrupado: TObjectList<TItemContaCliente>): TItemContaCliente;
var
  I: Integer;
begin
  Result := nil;
  if Assigned(ItensContaClienteAgrupado) then
  begin
    for I := 0 to ItensContaClienteAgrupado.Count - 1 do
    begin
      if Codigo = ItensContaClienteAgrupado.Items[I].Produto.Codigo then
      begin
        Result := ItensContaClienteAgrupado.Items[I];
        Break;
      end;
    end;
  end;
end;

function TFrmComandaController.buscaSecao(Codigo: Integer): TSecaoView;
var
  I: Integer;
begin
  Result := nil;
  if Codigo <> 0 then
  begin
    for I := 0 to FListaSecoes.Count - 1 do
    begin
      if FListaSecoes.Items[I].Retangulo.Tag <> 0 then
      begin
        if FListaSecoes.Items[I].Secao.Codigo = Codigo then
        begin
          Result := FListaSecoes.Items[I];
          Break;
        end;
      end;
    end;
  end
  else
  begin
    for I := 0 to FListaSecoes.Count - 1 do
    begin
      if FListaSecoes.Items[I].Retangulo.Tag = 0 then
      begin
        Result := FListaSecoes.Items[I];
        Break;
      end;
    end;
  end;
end;

procedure TFrmComandaController.CancelaItem;
var
  Value: Integer;
  I: Integer;
begin

  if ((FConta.ContaCliente.TotalMesa - FConta.ContaCliente.ValorPacial) -
    ItemSelecionado.TotalItem) < 0 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', não é possível cancelar o item, pois existe(m) ' +
      IntToStr(FConta.ContaCliente.PagamentosParciais.Count) +
      ' pagamento(s) parcial(is) e o valor da comanda ficará negativa.' +
      ' Cancele o(s) pagamento(s) para cancelar este item.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    exit;
  end;

  Value := DMConexao.mensagem(DMConexao.Usuario.nome +
    ', confirma o cancelamento do item?', 1);

  if Value = 6 then
  begin
    Value := DMConexao.senha('liberar cancelamento do item.');

    if Value = 11 then
    begin

      ItemSelecionado.Cancelado := 1;
      ItemSelecionado.MotivoCancelamento := FView.mmObservacaoCancelItem.Text;
      ItemSelecionado.DataHoraCancelamento := now;

      for I := 0 to ItemSelecionado.Adicionais.Count - 1 do
      begin

        ItemSelecionado.Adicionais.Items[I].Cancelado := 1;
        ItemSelecionado.Adicionais.Items[I].MotivoCancelamento :=
          FView.mmObservacaoCancelItem.Text;
        ItemSelecionado.Adicionais.Items[I].DataHoraCancelamento := now;

        TItemContaClienteDAO.getInstancia.alterar
          (ItemSelecionado.Adicionais.Items[I]);

      end;

      TItemContaClienteDAO.getInstancia.alterar(ItemSelecionado);

    end;

    // addDados;

    if DMConexao.Configuracao.ImprimirComandaPorProduto then
      ImprimirItemCanceladoProduto
    else
      ImprimirItemCancelado;

  end;

  addItensComanda;

  btnDesisitirObsCancelItemClick;
  btnDesistirInformacaoItemClick;
end;

procedure TFrmComandaController.cancelaMesa;
var
  Value: Integer;
begin

  Value := DMConexao.senha('liberar cancelamento da comanda.');

  if Value = 11 then
  begin
    FConta.ContaCliente.DataHoraCancelamento := now;
    FConta.ContaCliente.DataFechamento := Date;
    FConta.ContaCliente.HoraFechamento := Time;

    FConta.ContaCliente.Status := 2;

    if FView.mmObservacao.Text.Trim <> EmptyStr then
      FConta.ContaCliente.MotivoCancelamento := FView.mmObservacao.Text.Trim;

    TContaClienteDAO.getInstancia.alterar(FConta.ContaCliente);

    FormClose;
  end;
end;

procedure TFrmComandaController.cbAdministradorasCartaoChange;
var
  I: Integer;
  AdmCartao: TAdministradoraCartao;
begin

  AdmCartao := buscaAdministradoraCartao
    (StrToInt(copy(FView.cbAdministradorasCartao.Items
    [FView.cbAdministradorasCartao.ItemIndex], 1,
    pos(' ', FView.cbAdministradorasCartao.Items
    [FView.cbAdministradorasCartao.ItemIndex]) - 1)));

  FView.cbBandeirasCartao.Clear;

  for I := 0 to AdmCartao.BandeirasCartao.Count - 1 do
  begin
    FView.cbBandeirasCartao.Items.Add
      (IntToStr(AdmCartao.BandeirasCartao.Items[I].Codigo) + ' - ' +
      AdmCartao.BandeirasCartao.Items[I].Descricao);
  end;

  FView.cbBandeirasCartao.ItemIndex := 0;

end;

procedure TFrmComandaController.addDados(const atualiza: String);
begin

  if atualiza = 'S' then
    TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

  FView.lblMesa.Text := TComprovante.FormataStringD
    (IntToStr(FConta.ContaCliente.Conta), '3', '0');
  FView.lblContadorMesa.Text := IntToStr(FConta.ContaCliente.ContadorConta);

  if FConta.ContaCliente.DescricaoMesa <> '' then
  begin
    FView.Label17.Visible := True;
    FView.lblDescricaoMesa.Visible := True;
    FView.lblDescricaoMesa.Text := FConta.ContaCliente.DescricaoMesa;
  end;

  FView.lblAbertura.Text := DateToStr(FConta.ContaCliente.DataAbertura) + ' ' +
    TimeToStr(FConta.ContaCliente.HoraAbertura);

  FView.lblTotalLiquido.Text :=
    currtostrf((FConta.ContaCliente.Total +
    FConta.ContaCliente.totalAdicionais), ffnumber, 2);

  FView.lblTotalParcial.Text := currtostrf(FConta.ContaCliente.ValorPacial,
    ffnumber, 2);

  if FConta.ContaCliente.DispensarTaxaServico = 'N' then
  begin
    FView.lblTaxaServico.Text :=
      currtostrf(DMConexao.CalcularTaxaServico((FConta.ContaCliente.Total +
      FConta.ContaCliente.totalAdicionais) - FConta.ContaCliente.ValorPacial,
      FConta.ContaCliente), ffnumber, 2);
  end
  else
  begin
    FView.lblTaxaServico.Text := '0,00';
  end;

  if Assigned(FConta.ContaCliente.Indicador) then
    FView.lblNomeIndicadorStatus.Text := FConta.ContaCliente.Indicador.nome
  else
    FView.lblNomeIndicadorStatus.Text := 'Sem indicador.';

  FView.lblTotalPessoas.Text := IntToStr(FConta.ContaCliente.NumeroPessoas);

  FView.lblTotal.TextSettings.Font.Style := [TFontStyle.fsBold];

  FView.lblTotal.Text := formatfloat('#,##0.00', FConta.ContaCliente.Total +
    FConta.ContaCliente.totalAdicionais +
    StrToCurr(stringreplace(FView.lblTaxaServico.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase])) - FConta.ContaCliente.ValorPacial);

end;

procedure TFrmComandaController.addFormasPagamentoFinalizacao;
var
  I: Integer;
  X, Y: Single;
  Retangulo: TRectangle;
  FormasPagamento: TObjectList<TFormaPagamento>;
begin

  limpaFormasPagamentoParcialValor;

  FormasPagamento := TFormaPagamentoDAO.getInstancia.buscaTodos;

  X := 8;
  Y := 8;

  for I := 0 to FormasPagamento.Count - 1 do
  begin
    Retangulo := TRectangle.Create(FView.vRetFormasPagamentoFinalizacao);
    Retangulo.Parent := FView.vRetFormasPagamentoFinalizacao;
    Retangulo.Position.X := X;
    Retangulo.Position.Y := Y;
    Retangulo.Fill.Color := $FFE0E0E0;
    Retangulo.Stroke.Color := $FFE0E0E0;
    Retangulo.Height := 45;
    Retangulo.Width := 207;
    Retangulo.Tag := I;
    Retangulo.OnClick := onClickFormasPagamentoFinalizacao;

    Y := Y + 55;

    FListaFormasPagamento.Add(TFormaPagamentoView.Create(FormasPagamento.Items
      [I], Retangulo));
  end;

end;

procedure TFrmComandaController.addFormasPagamentoPacialProduto;
var
  I: Integer;
  X, Y: Single;
  Retangulo: TRectangle;
  FormasPagamento: TObjectList<TFormaPagamento>;
begin

  limpaFormasPagamentoParcialValor;

  FormasPagamento := TFormaPagamentoDAO.getInstancia.buscaTodos;

  X := 8;
  Y := 8;

  for I := 0 to FormasPagamento.Count - 1 do
  begin
    Retangulo := TRectangle.Create(FView.vRetFormasPagamento);
    Retangulo.Parent := FView.vRetFormasPagamento;
    Retangulo.Position.X := X;
    Retangulo.Position.Y := Y;
    Retangulo.Fill.Color := $FFE0E0E0;
    Retangulo.Stroke.Color := $FFE0E0E0;
    Retangulo.Height := 45;
    Retangulo.Width := 207;
    Retangulo.Tag := I;
    Retangulo.OnClick := onClickFormasPagamento;

    Y := Y + 55;

    FListaFormasPagamento.Add(TFormaPagamentoView.Create(FormasPagamento.Items
      [I], Retangulo));
  end;

end;

procedure TFrmComandaController.addFormasPagamentoPacialValor;
var
  I: Integer;
  X, Y: Single;
  Retangulo: TRectangle;
  FormasPagamento: TObjectList<TFormaPagamento>;
begin

  limpaFormasPagamentoParcialValor;

  FormasPagamento := TFormaPagamentoDAO.getInstancia.buscaTodos;

  X := 8;
  Y := 8;

  for I := 0 to FormasPagamento.Count - 1 do
  begin
    Retangulo := TRectangle.Create(FView.vRetAdicionaisInfoProduto);
    Retangulo.Parent := FView.vRetAdicionaisInfoProduto;
    Retangulo.Position.X := X;
    Retangulo.Position.Y := Y;
    Retangulo.Fill.Color := $FFE0E0E0;
    Retangulo.Stroke.Color := $FFE0E0E0;
    Retangulo.Height := 45;
    Retangulo.Width := 207;
    Retangulo.Tag := I;
    Retangulo.OnClick := onClickFormasPagamento;

    Y := Y + 55;

    FListaFormasPagamento.Add(TFormaPagamentoView.Create(FormasPagamento.Items
      [I], Retangulo));
  end;

end;

procedure TFrmComandaController.addItemsPagamentoParcialProduto;
var
  I: Integer;
  X, Y: Single;
  Retangulo: TRectangle;
begin
  limpaItemsPagamentoParcialProduto;

  TContaClienteDAO.getInstancia.buscar(FConta.ContaCliente);

  X := 16;
  Y := 8;

  for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
  begin
    if FConta.ContaCliente.ItensContaCliente.Items[I].Cancelado = 0 then
    begin
      if FConta.ContaCliente.ItensContaCliente.Items[I].TotalItem > 0 then
      begin
        Retangulo := TRectangle.Create(FView.vRetProdutosParcial);
        Retangulo.Parent := FView.vRetProdutosParcial;
        Retangulo.Fill.Color := TAlphaColors.Whitesmoke;
        Retangulo.Stroke.Color := TAlphaColors.Gray;
        Retangulo.Width := 105;
        Retangulo.Height := 105;
        Retangulo.Position.X := X;
        Retangulo.Position.Y := Y;
        Retangulo.OnClick := onClickItemPagamentoParcial;
        Retangulo.Tag := FConta.ContaCliente.ItensContaCliente.Items[I].Ordem;

        if (X + 115) > (FView.vRetProdutosParcial.Width - 115) then
          X := 16
        else
          X := X + 115;

        if (X = 16) then
          Y := Y + 115;

        FListaItemsParcialProduto.Add(TProdutoView.Create(Retangulo,
          FConta.ContaCliente.ItensContaCliente.Items[I].Produto,
          FConta.ContaCliente.ItensContaCliente.Items[I]));

      end;
    end;
  end;

  FView.retBottomPagamentoParcialProduto.Width :=
    FView.vRetProdutosParcial.Width - 10;
  FView.retBottomPagamentoParcialProduto.Position.X := 2;
  FView.retBottomPagamentoParcialProduto.Position.Y := Y + 65;
  FView.retBottomPagamentoParcialProduto.Margins.Top := 1;
  FView.retBottomPagamentoParcialProduto.Margins.Left := 1;
  FView.retBottomPagamentoParcialProduto.Margins.Right := 1;
  FView.retBottomPagamentoParcialProduto.Margins.Bottom := 1;
end;

procedure TFrmComandaController.addItensComanda;
var
  I: Integer;
  LItem: TListViewItem;
  ItemContaCliente: TItemContaCliente;
begin

  TItemContaClienteDAO.getInstancia.selItens(FConta.ContaCliente);

  if FConta.ContaCliente.ItensContaCliente <> nil then
  begin
    limpaItensComanda;

    if FConta.ContaCliente.ItensContaCliente.Count = 0 then
      exit;

    FView.listItensComanda.BeginUpdate;

    for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
    begin
      LItem := FView.listItensComanda.Items.Add;

      ItemContaCliente := FConta.ContaCliente.ItensContaCliente.Items[I];

      LItem.Tag := ItemContaCliente.Ordem;

      LItem.Data['Text1'] := UpperCase(ItemContaCliente.Produto.DescricaoCupom);

      LItem.Data['Text2'] := 'Ordem: ' + IntToStr(ItemContaCliente.Ordem);

      LItem.Data['Text3'] := 'Valor: ' + formatfloat('#,##0.00',
        ItemContaCliente.Valor);

      LItem.Data['Text5'] := 'Quantidade: ' +
        CurrToStr(ItemContaCliente.Quantidade);

      LItem.Data['Text6'] := 'Total: ' + CurrToStr(ItemContaCliente.TotalItem);

      if ItemContaCliente.Cancelado = 1 then
        LItem.Data['Text4'] := '2'
      else if ItemContaCliente.Impresso = 'S' then
        LItem.Data['Text4'] := '1'
      else
        LItem.Data['Text4'] := '0';

    end;
    FView.listItensComanda.EndUpdate;
  end;
end;

procedure TFrmComandaController.addItensFinalizacao;
begin

end;

procedure TFrmComandaController.addItensImpressos;
var
  I: Integer;
begin
  if Assigned(FListaItensComanda) then
    for I := 0 to FListaItensComanda.Count - 1 do
      FListaItensComanda.Items[I].Impresso;
end;

procedure TFrmComandaController.addItensLancamentoAdmCartao;
var
  I: Integer;
  Retangulo: TRectangle;
  X, Y: Single;
begin

  limpaItensLancamentoAdmCartao;

  Y := 8;

  for I := 0 to FConta.ContaCliente.Venda.ContasReceberCartao.Count - 1 do
  begin
    Retangulo := TRectangle.Create(FView.vRetLancamentosCartoes);
    Retangulo.Parent := FView.vRetLancamentosCartoes;
    Retangulo.Position.X := 8;
    Retangulo.Position.Y := Y;
    Retangulo.Fill.Color := TAlphaColors.White;
    Retangulo.Stroke.Color := TAlphaColors.Black;
    Retangulo.Tag := I;
    Retangulo.OnClick := OnClickLancamentoAdmCartao;
    Retangulo.Height := 80;
    Retangulo.Width := 200;

    Y := Y + 90;

    FListaLancamentosAdmCartao.Add
      (TLancamentoCartaoView.Create
      (FConta.ContaCliente.Venda.ContasReceberCartao.Items[I], Retangulo,
      buscarBandeiraCartao(FConta.ContaCliente.Venda.ContasReceberCartao.Items
      [I].BandeiraCartao)));

  end;
end;

procedure TFrmComandaController.Clean;
begin
  limpaProdutos;
  limpaSecoes;
  limpaObservacoes;
  limpaItensTransferencia;
  limpaAdicionais;
  limpaItensComanda;
  limpaItemsPagamentoParcialProduto;

  if Assigned(FProdutoSelecionado) then
  begin
    FProdutoSelecionado.removeSelecaoProduto;
    FProdutoSelecionado := nil;
  end;

  FContaTransferencia := nil;

  FView.retModalLancProduto.Parent := FView.retFrmComanda;

  FView.retAddIndicador.Visible := False;
  FView.retAddIndicador.Parent := FView.retFrmComanda;

  FView.retLancamentoProduto.Visible := False;
  FView.retLancamentoProduto.Parent := FView.retFrmComanda;

  FView.retModalLancProduto.Visible := False;
  FView.retModalLancProduto.Parent := FView.retFrmComanda;

  FView.retObsCancelaMesa.Visible := False;
  FView.retObsCancelaMesa.Parent := FView.retFrmComanda;

  FView.retTransferenciaComanda.Visible := False;
  FView.retTransferenciaComanda.Parent := FView.retFrmComanda;

  FView.retAddAdicional.Visible := False;
  FView.retAddAdicional.Parent := FView.retFrmComanda;

  FView.retInformacoesItemConta.Visible := False;
  FView.retInformacoesItemConta.Parent := FView.retFrmComanda;

  FView.retObsCancelamentoItem.Visible := False;
  FView.retObsCancelamentoItem.Parent := FView.retFrmComanda;

  FView.retSelecaoTipoPagamento.Visible := False;
  FView.retSelecaoTipoPagamento.Parent := FView.retFrmComanda;

  FView.retPagamentoParcialValor.Visible := False;
  FView.retPagamentoParcialValor.Parent := FView.retFrmComanda;

  FView.retLancPagamentoParcialValor.Visible := False;
  FView.retLancPagamentoParcialValor.Parent := FView.retFrmComanda;

  FView.retDeletaPagamentoParcial.Visible := False;
  FView.retDeletaPagamentoParcial.Parent := FView.retFrmComanda;

  FView.retPagamentoParcialProduto.Visible := False;
  FView.retPagamentoParcialProduto.Parent := FView.retFrmComanda;

  FView.retFormasPagamentoParcialProduto.Visible := False;
  FView.retFormasPagamentoParcialProduto.Parent := FView.retFrmComanda;

  FView.retInformacoes.Visible := False;
  FView.retInformacoes.Parent := FView.retFrmComanda;

  FView.retFinalizacaoVenda.Visible := False;
  FView.retFinalizacaoVenda.Parent := FView.retFrmComanda;

  FView.retLancamentoDescAcresFinalizacao.Visible := False;
  FView.retLancamentoDescAcresFinalizacao.Parent := FView.retFrmComanda;

  FView.retAlteraInformacoesMesa.Visible := False;
  FView.retAlteraInformacoesMesa.Parent := FView.retFrmComanda;

  FView.retInserirValorFormaPagamento.Visible := False;
  FView.retInserirValorFormaPagamento.Parent := FView.retFrmComanda;

  FView.retLancamentoContasReceberCartao.Visible := False;
  FView.retLancamentoContasReceberCartao.Parent := FView.retFrmComanda;

  FView.retStatusEnvioFiscal.Visible := False;
  FView.retStatusEnvioFiscal.Parent := FView.retFrmComanda;

  FView.retLancamentoQuantidadeTransferencia.Visible := False;
  FView.retLancamentoQuantidadeTransferencia.Parent := FView.retFrmComanda;

  FView.retConsultaProduto.Visible := False;
  FView.retConsultaProduto.Parent := FView.retFrmComanda;
end;

procedure TFrmComandaController.Clear;
begin
end;

procedure TFrmComandaController.onClickAdicional(Sender: TObject);
begin

  if Sender is TRectangle then
    if Assigned(FListaProdutosAdicionais) then
      FAdicionalSelecionado := FListaProdutosAdicionais.Items
        [TRectangle(Sender).Tag];

  if Sender is TLabel then
    if Assigned(FListaProdutosAdicionais) then
      FAdicionalSelecionado := FListaProdutosAdicionais.Items
        [TLabel(Sender).Tag];

  if not FAdicionalSelecionado.Selecionado then
  begin

    FAdicionalSelecionado.select;

    FView.lblNomeAdicional.Text := 'Adicional: ' +
      FAdicionalSelecionado.Produto.DescricaoCupom;

    FView.EdtQuantidadeAdicional.Text := '1';

    FView.lblTotalAdicional.Text := 'Total: R$ ' + formatfloat('#,##0.00',
      FAdicionalSelecionado.Produto.PrecoVista *
      StrToCurr(FView.EdtQuantidadeAdicional.Text.Trim));

    FView.retLancamentoProduto.Enabled := False;

    FView.retAddAdicional.Visible := True;

    FView.retAddAdicional.Position.X :=
      (FView.Width - FView.retAddAdicional.Width) / 2;
    FView.retAddAdicional.Position.Y :=
      (FView.Height - FView.retAddAdicional.Height) / 2;
  end
  else
  begin
    FAdicionalSelecionado.select;

    FView.lblNomeAdicionalTotal.Text := 'Adicionais: R$ ' +
      formatfloat('#,##0.00', totalAdicionais);
  end;
end;

procedure TFrmComandaController.onClickFormasPagamento(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to FListaFormasPagamento.Count - 1 do
    if FListaFormasPagamento.Items[I].Selecionado then
      FListaFormasPagamento.Items[I].seleciona;

  FListaFormasPagamento.Items[TRectangle(Sender).Tag].seleciona;

  FFormaPagamentoSelecionado := FListaFormasPagamento.Items
    [TRectangle(Sender).Tag];
end;

procedure TFrmComandaController.onClickFormasPagamentoFinalizacao
  (Sender: TObject);
begin
  FFormaPagamentoSelecionado := FListaFormasPagamento.Items
    [TRectangle(Sender).Tag];

  if FFormaPagamentoSelecionado.Selecionado then
  begin
    if (FFormaPagamentoSelecionado.FormaPagamento.Tipo = 'DN') and
      (Assigned(FVendaFormaPagamento)) then
      FView.EdtValorFormaPagamento.Text :=
        currtostrf(FFormaPagamentoSelecionado.Valor +
        FVendaFormaPagamento.Valor, ffnumber, 2)
    else
      FView.EdtValorFormaPagamento.Text :=
        currtostrf(FFormaPagamentoSelecionado.Valor, ffnumber, 2);
  end
  else
  begin
    FView.EdtValorFormaPagamento.Text :=
      currtostrf(FConta.ContaCliente.Venda.Total, ffnumber, 2);

    FFormaPagamentoSelecionado.shadow;
  end;

  FView.retFinalizacaoVenda.Enabled := False;

  FView.Label62.Text := FFormaPagamentoSelecionado.FormaPagamento.Descricao;

  FView.retInserirValorFormaPagamento.Position.X :=
    (FView.Width - FView.retAddAdicional.Width) / 2;
  FView.retInserirValorFormaPagamento.Position.Y :=
    (FView.Height - FView.retAddAdicional.Height) / 2;

  FView.retInserirValorFormaPagamento.Visible := True;

end;

procedure TFrmComandaController.onClickObItemTransferencia(Sender: TObject);
begin

  FItemTransferenciaSelecionado := TRectangle(Sender).Tag;

  FView.retLancamentoQuantidadeTransferencia.Position.X :=
    (FView.Width - FView.retAddAdicional.Width) / 2;
  FView.retLancamentoQuantidadeTransferencia.Position.Y :=
    (FView.Height - FView.retAddAdicional.Height) / 2;

  FView.retLancamentoQuantidadeTransferencia.Visible := True;
  FView.retTransferenciaComanda.Enabled := False;

  FView.Label83.Text := FItensTransferencia.Items[FItemTransferenciaSelecionado]
    .ItemContaCliente.Produto.DescricaoCupom;
  FView.EdtQuantidadeProdutoTransferencia.Text :=
    formatfloat('#,##0.00', FItensTransferencia.Items
    [FItemTransferenciaSelecionado].ItemContaCliente.Quantidade);
end;

procedure TFrmComandaController.onClickObs(Sender: TObject);
var
  ObservacaoView: TObservacaoView;
begin
  ObservacaoView := buscaObservacao(TRectangle(Sender).Tag);
  if Assigned(ObservacaoView) then
  begin
    if ObservacaoView.Selecionado then
      ObservacaoView.removeSelecao
    else
      ObservacaoView.seleciona;
  end;
end;

procedure TFrmComandaController.comanda;
begin
  TContaClienteDAO.getInstancia.buscarConferencia(FConta.ContaCliente);

  if DMConexao.Configuracao.ImprimeCozinha then
  begin
    imprimeComprovanteComanda('COZINHA');
  end;

  if DMConexao.Configuracao.ImprimeBalcao then
  begin
    imprimeComprovanteComanda('BALCAO');
  end;

  atualizaProdutosImpressos;
end;

procedure TFrmComandaController.comandaProduto;
var
  I, Y, Z, M: Integer;
  ItensContaCliente: TObjectList<TItemContaCliente>;
  comprovante: TComprovante;
  sItem, sDescricaoProduto, sQuantidadeProduto: String;
  sDescricaoProdutoAdicional, sQuantidadeProdutoAdicional: String;
begin
  TContaClienteDAO.getInstancia.buscarConferencia(FConta.ContaCliente);

  for I := 0 to Impressoras.Count - 1 do
  begin
    ItensContaCliente := retornaProdutosComandaImpressora(Impressoras.Items[I]);
    if ItensContaCliente.Count > 0 then
    begin
      for Y := 0 to Impressoras.Items[I].CaminhosImpressora.Count - 1 do
      begin
        comprovante := TComprovante.Create;
        comprovante.Cabecalho := False;
        comprovante.usaTitulo := False;

        { Configura Impressora }
        comprovante.abreComprovante(True,
          IntToStr(Impressoras.Items[I].CaminhosImpressora.Items[Y].Modelo),
          IntToStr(Impressoras.Items[I].CaminhosImpressora.Items[Y]
          .PaginaCodigo), Impressoras.Items[I].CaminhosImpressora.Items[Y]
          .Porta, DMConexao.DesCriptografa(Impressoras.Items[I]
          .CaminhosImpressora.Items[Y].ParametroString),
          IntToStr(Impressoras.Items[I].CaminhosImpressora.Items[Y].Colunas),
          IntToStr(Impressoras.Items[I].CaminhosImpressora.Items[Y]
          .EspacoEntreLinhas), Impressoras.Items[I].CaminhosImpressora.Items[Y]
          .ControlaPorta, Impressoras.Items[I].CaminhosImpressora.Items[Y]
          .CortaPapel);

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        if comprovante.NumeroColunas < 40 then
          comprovante.imprimeTextoComprovante
            (comprovante.boldText('COMANDA ' + Impressoras.Items[I].Descricao),
            'E', False)
        else
          comprovante.imprimeTextoComprovante
            (comprovante.expandedText(comprovante.boldText('COMANDA ' +
            Impressoras.Items[I].Descricao)), 'C', False);

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);
        if DMConexao.Configuracao.ModeloComanda = 0 then
        begin
          comprovante.imprimeTextoComprovante
            ('MESA: ' + IntToStr(FConta.ContaCliente.Conta), 'E', False);

          if FConta.ContaCliente.DescricaoMesa.Trim <> '' then
            comprovante.imprimeTextoComprovante
              ('DESC. COMANDA: ' + FConta.ContaCliente.DescricaoMesa.Trim,
              'E', False);

          comprovante.imprimeTextoComprovante
            ('GARCOM: ' + ItensContaCliente.Items[0].Garcom.nome, 'E', False);

          comprovante.imprimeTextoComprovante('DATA: ' + DateToStr(Date),
            'E', False);

          comprovante.imprimeTextoComprovante('HORA: ' + TimeToStr(Time),
            'E', False);
        end
        else if DMConexao.Configuracao.ModeloComanda = 1 then
        begin
          comprovante.imprimeTextoComprovante
            (comprovante.boldText(comprovante.expandedText('GARCOM: ' +
            ItensContaCliente.Items[0].Garcom.nome)), 'C', False);

          comprovante.imprimeTextoComprovante('DATA: ' + DateToStr(Date),
            'C', False);

          comprovante.imprimeTextoComprovante('HORA: ' + TimeToStr(Time),
            'C', False);
        end;

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
        if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
        begin
          if comprovante.NumeroColunas < 40 then
            comprovante.imprimeTextoComprovanteEspaco('ITEM    DESC', 'QTD')
          else
            comprovante.imprimeTextoComprovanteEspaco
              ('ITEM    DESCRICAO', 'QTD');
        end
        else
        begin
          if comprovante.NumeroColunas < 40 then
            comprovante.imprimeTextoComprovanteEspaco('DESC', 'QTD')
          else
            comprovante.imprimeTextoComprovanteEspaco('DESCRICAO', 'QTD');
        end;

        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        for Z := 0 to ItensContaCliente.Count - 1 do
        begin
          if ItensContaCliente.Items[Z].Produto.Referencia.Trim = '' then
            sItem := comprovante.FormataStringE
              (ItensContaCliente.Items[Z].Produto.CodigoBarras.Trim, '8', ' ')
          else
            comprovante.FormataStringE(ItensContaCliente.Items[Z]
              .Produto.Referencia.Trim, '8', ' ');

          sDescricaoProduto := ItensContaCliente.Items[Z]
            .Produto.DescricaoCupom.Trim;

          sQuantidadeProduto :=
            CurrToStr(ItensContaCliente.Items[Z].Quantidade);

          { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
          if DMConexao.Configuracao.ModeloComanda = 0 then
          begin
            if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
            begin
              if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar then
                comprovante.imprimeTextoComprovanteValor
                  (sItem + sDescricaoProduto, sQuantidadeProduto, 'N', True)
              else
                comprovante.imprimeTextoComprovanteValor
                  (sItem + copy(sDescricaoProduto, 1,
                  (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                  sQuantidadeProduto);
            end
            else
            begin
              if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar then
                comprovante.imprimeTextoComprovanteValor(sDescricaoProduto,
                  sQuantidadeProduto, 'N', True)
              else
                comprovante.imprimeTextoComprovanteValor
                  (copy(sDescricaoProduto, 1, (comprovante.NumeroColunas) - 4),
                  sQuantidadeProduto);
            end;
          end
          else if DMConexao.Configuracao.ModeloComanda = 1 then
          begin
            if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
            begin
              if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar then
                comprovante.imprimeTextoComprovanteValor
                  (sItem + sDescricaoProduto, sQuantidadeProduto, 'E', True)
              else
                comprovante.imprimeTextoComprovanteValor
                  (sItem + copy(sDescricaoProduto, 1,
                  (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                  sQuantidadeProduto, 'E');
            end
            else
            begin
              if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar then
                comprovante.imprimeTextoComprovanteValor(sDescricaoProduto,
                  sQuantidadeProduto, 'E', True)
              else
                comprovante.imprimeTextoComprovanteValor
                  (copy(sDescricaoProduto, 1, (comprovante.NumeroColunas) - 4),
                  sQuantidadeProduto, 'E');
            end;
          end;

          { Imprime Adicionais }
          for M := 0 to ItensContaCliente.Items[Z].Adicionais.Count - 1 do
          begin
            sDescricaoProdutoAdicional := ItensContaCliente.Items[Z]
              .Adicionais.Items[M].Produto.DescricaoCupom.Trim;

            sQuantidadeProdutoAdicional :=
              CurrToStr(ItensContaCliente.Items[Z].Adicionais.Items[M]
              .Quantidade);

            comprovante.imprimeTextoComprovanteValor(sDescricaoProdutoAdicional,
              sQuantidadeProdutoAdicional);
          end;

          { Imprime Observação do Item }
          if ItensContaCliente.Items[Z].Observacao.Trim <> '' then
            if DMConexao.Configuracao.ImprimirObsComandaCozinha then
              comprovante.imprimeTextoComprovante
                ('OBS: ' + ItensContaCliente.Items[Z].Observacao.Trim,
                'E', True);

          if (DMConexao.Configuracao.ModeloComanda = 1) and
            (DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar) then
            comprovante.imprimeTextoComprovante(comprovante.linhaSimples);
        end;

        if not((DMConexao.Configuracao.ModeloComanda = 1) and
          (DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar)) then
          comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

        if DMConexao.Configuracao.ModeloComanda = 1 then
          comprovante.imprimeTextoComprovante
            (comprovante.boldText(comprovante.expandedText('COMANDA: ' +
            IntToStr(FConta.ContaCliente.Conta))), 'C', False);

        if DMConexao.Configuracao.ImprimirSetorCozinhaBalcao then
          comprovante.imprimeTextoComprovante
            ('SETOR: ' + DMConexao.Empresa.Fantasia);

        comprovante.fechaComprovante(False, False, 8, True);
      end;
    end;
  end;

  atualizaProdutosImpressos;
end;

constructor TFrmComandaController.Create(view: TFrmComanda);
begin
  if not Assigned(FView) then
    FView := view;

  if not Assigned(FSat) then
    FSat := TSat.Create;

  if FListaSecoes = nil then
    FListaSecoes := TObjectList<TSecaoView>.Create;

  if FListaProdutos = nil then
    FListaProdutos := TObjectList<TProdutoView>.Create(False);

end;

procedure TFrmComandaController.addObservacoes(Produto: TProduto);
var
  X: Single;
  Local: TRectangle;
  I: Integer;
  Observacoes: TObjectList<TObservacao>;
begin

  X := 10;

  Observacoes := TObservacaoDAO.getInstancia.buscarTodos(Produto.Secao);

  FListaObservacoes := TObjectList<TObservacaoView>.Create;

  for I := 0 to Observacoes.Count - 1 do
  begin
    Local := TRectangle.Create(FView.vRetObservacoes);
    Local.Parent := FView.vRetObservacoes;
    Local.Fill.Color := TAlphaColors.Lightgray;
    Local.Stroke.Color := TAlphaColors.Lightgray;
    Local.Cursor := crHandPoint;
    Local.OnDblClick := onClickObs;
    Local.Tag := Observacoes.Items[I].Codigo;
    Local.Height := 60;
    Local.Width := 60;

    if I <> 0 then
      X := X + 65;

    Local.Position.X := X;
    Local.Position.Y := 8;

    FListaObservacoes.Add(TObservacaoView.Create(Local, Observacoes.Items[I]));
  end;

end;

destructor TFrmComandaController.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TFrmComandaController.EdtValorFormaPagamentoClick;
begin
  DMConexao.mostraTeclado(FView, FView.EdtValorFormaPagamento, True, 2);
end;

procedure TFrmComandaController.EdtValorLancamentoCartaoClick;
begin
  FView.EdtValorLancamentoCartao.Text :=
    stringreplace(FView.EdtValorLancamentoCartao.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]);

  DMConexao.mostraTeclado(FView, FView.EdtValorLancamentoCartao, True, 2);
end;

procedure TFrmComandaController.EdtValorProdutoClick;
begin
  FView.EdtValorProduto.Text := stringreplace(FView.EdtValorProduto.Text, '.',
    '', [rfReplaceAll, rfIgnoreCase]);

  DMConexao.mostraTeclado(FView, FView.EdtValorProduto, True, 2);
end;

procedure TFrmComandaController.EdtValorProdutoExit;
begin
  FView.EdtValorProduto.Text := stringreplace(FView.EdtValorProduto.Text, '.',
    '', [rfReplaceAll, rfIgnoreCase]);

  FView.EdtValorProduto.Text :=
    currtostrf(StrToCurr(FView.EdtValorProduto.Text), ffnumber, 2);
end;

procedure TFrmComandaController.evento(evento: String; mesa: TContaView);
begin
  case AnsiIndexStr(evento, ['FormShow']) of
    0:
      IniciaComanda(mesa);
  end;
end;

procedure TFrmComandaController.evento(evento: String; Sender: TObject);
begin
  case AnsiIndexStr(evento, ['listItensComandaItemClick']) of
    0:
      listItensComandaItemClick(Sender);
  end;
end;

procedure TFrmComandaController.evento(evento: String);
begin

  try
    case AnsiIndexStr(evento, ['FormShow', 'FormClose', 'btnDesistirClick',
      'btnAddQuantidadeClick', 'btnRemoveQuantidadeClick', 'btnConfirmarClick',
      'btnDesbloquearMesaClick', 'btnConferenciaResumidaClick',
      'btnImprimeCozinhaBarClick', 'btnIndicadorClick',
      'btnCancelarIndicadorClick', 'btnRemoverIndicadorClick',
      'btnSelecionarIndicadorClick', 'btnConferenciaDetalhadaClick',
      'EdtValorProdutoExit', 'btnCancelarMesaClick',
      'btnConfirmarCancelamentoMesaClick', 'btnDesistirCancelamentoMesaClick',
      'mmObservacaoClick', 'EdtQuantidadeClick', 'EdtValorProdutoClick',
      'btnRetiraTaxaServicoClick', 'btnTransferenciaMesaClick',
      'btnCancelarTransferenciaClick', 'btnSelecionarMesaTransferenciaClick',
      'btnTransferirTodosItensClick', 'btnTransferirItensClick',
      'Rectangle17Click', 'btnAlteraInformacoesMesaClick',
      'btnConfirmarAlteraInformacoesClick', 'btnCancelarAlteraInformacoesClick',
      'EdtDescricaoMesaClick', 'EdtQuantidadePessoasClick',
      'btnAddAdicionalClick', 'btnRemoveAdicionalClick',
      'btnConfirmarAddAdicionalClick', 'btnDesistirAddAdicionalClick',
      'btnRecarregaInformacoesClick', 'btnCancelarItemClick',
      'btnDesistirInformacaoItemClick', 'btnConfirmarObsCancelItemClick',
      'btnDesisitirObsCancelItemClick', 'mmObservacaoCancelItemClick',
      'btnPagamentoParcialClick', 'btnPacialValorClick',
      'btnDesistirPagamentoParcialValorClick', 'Rectangle12Click',
      'btnConfirmarLancPagParcialValorClick',
      'btnDesistirLancPagamentoParcialVClick', 'Rectangle43Click',
      'btnDesistirSelecaoPagamentoClick', 'btnRemoverPagamentoParcialClick',
      'btnDesistirRemoverPagamentoParcialClick', 'btnPacialProdutoClick',
      'btnDesistirPagamentoParcialProdutoClick',
      'mmHistoricoPagamentoParcialValorClick',
      'btnConfirmarpagamentoParcialProdutoClick',
      'btnConfirmarSelecaoFormaPagamentoClick',
      'btnDesistirSelecaoFormaPagamentoClick', 'btnInformacoesMesaClick',
      'btnSairInformacoesMesaClick', 'btnPagamentoClick',
      'btnDesistirFinalizacaoComandaClick', 'EdtQuantidadeProdutoExit',
      'EdtMesaTransferenciaClick', 'btnDescontoFinalizacaoClick',
      'btnDesistirDescAcresFinalizacaoClick', 'btnAcrecimoFinalizacaoClick',
      'btnConfirmarDescAcresFinalizacaoClick', 'EdtDescAcresFinalizacaoClick',
      'btnAlterarInformacoesFinalizacaoClick',
      'EdtDescAcresPercentualFinalizacaoExit',
      'EdtDescAcresPercentualFinalizacaoClick', 'EdtDescAcresFinalizacaoExit',
      'btnFinalizarComandaClick', 'btnDesistirValorClick',
      'EdtValorFormaPagamentoClick', 'btnConfirmarValorClick',
      'cbAdministradorasCartaoChange', 'EdtValorLancamentoCartaoClick',
      'EdtNumeroAutorizacaoClick', 'mmObservacaoLancamentoCartaoClick',
      'btnConfirmaLancamentosCartaoClick', 'btnAddParcelasClick',
      'btnRemoveParcelasClick', 'btnDesistirLancamentoCartaoClick',
      'btnAlterarDadosVendaFinalizacaoClick', 'btnItensComandaClick',
      'btnAddQuantidadeProdutoTransferenciaClick',
      'btnRemoveQuantidadeProdutoTransferencia',
      'btnConfirmarQuantidadeTransferenciaClick',
      'btnDesistirQuantidadeTransferenciaClick',
      'EdtQuantidadeProdutoTransferenciaClick', 'btnBuscarProdutosClick',
      'btnDesistirBuscaProdutosClick', 'EdtBuscaProdutoClick']) of
      0:
        FormShow;
      1:
        FormClose;
      2:
        btnDesistirClick;
      3:
        btnAddQuantidadeClick;
      4:
        btnRemoveQuantidadeClick;
      5:
        btnConfirmarClick;
      6:
        btnDesbloquearMesaClick;
      7:
        btnConferenciaResumidaClick;
      8:
        btnImprimeCozinhaBarClick;
      9:
        btnIndicadorClick;
      10:
        btnCancelarIndicadorClick;
      11:
        btnRemoverIndicadorClick;
      12:
        btnSelecionarIndicadorClick;
      13:
        btnConferenciaDetalhadaClick;
      14:
        EdtValorProdutoExit;
      15:
        btnCancelarMesaClick;
      16:
        btnConfirmarCancelamentoMesaClick;
      17:
        btnDesistirCancelamentoMesaClick;
      18:
        mmObservacaoClick;
      19:
        EdtQuantidadeClick;
      20:
        EdtValorProdutoClick;
      21:
        btnRetiraTaxaServicoClick;
      22:
        btnTransferenciaMesaClick;
      23:
        btnCancelarTransferenciaClick;
      24:
        btnSelecionarMesaTransferenciaClick;
      25:
        btnTransferirTodosItensClick;
      26:
        btnTransferirItensClick;
      27:
        Rectangle17Click;
      28:
        btnAlteraInformacoesMesaClick;
      29:
        btnConfirmarAlteraInformacoesClick;
      30:
        btnCancelarAlteraInformacoesClick;
      31:
        EdtDescricaoMesaClick;
      32:
        EdtQuantidadePessoasClick;
      33:
        btnAddAdicionalClick;
      34:
        btnRemoveAdicionalClick;
      35:
        btnConfirmarAddAdicionalClick;
      36:
        btnDesistirAddAdicionalClick;
      37:
        btnRecarregaInformacoesClick;
      38:
        btnCancelarItemClick;
      39:
        btnDesistirInformacaoItemClick;
      40:
        btnConfirmarObsCancelItemClick;
      41:
        btnDesisitirObsCancelItemClick;
      42:
        mmObservacaoCancelItemClick;
      43:
        btnPagamentoParcialClick;
      44:
        btnPacialValorClick;
      45:
        btnDesistirPagamentoParcialValorClick;
      46:
        Rectangle12Click;
      47:
        btnConfirmarLancPagParcialValorClick;
      48:
        btnDesistirLancPagamentoParcialVClick;
      49:
        Rectangle43Click;
      50:
        btnDesistirSelecaoPagamentoClick;
      51:
        btnRemoverPagamentoParcialClick;
      52:
        btnDesistirRemoverPagamentoParcialClick;
      53:
        btnPacialProdutoClick;
      54:
        btnDesistirPagamentoParcialProdutoClick;
      55:
        mmHistoricoPagamentoParcialValorClick;
      56:
        btnConfirmarpagamentoParcialProdutoClick;
      57:
        btnConfirmarSelecaoFormaPagamentoClick;
      58:
        btnDesistirSelecaoFormaPagamentoClick;
      59:
        btnInformacoesMesaClick;
      60:
        btnSairInformacoesMesaClick;
      61:
        btnPagamentoClick;
      62:
        btnDesistirFinalizacaoComandaClick;
      63:
        EdtQuantidadeProdutoExit;
      64:
        EdtMesaTransferenciaClick;
      65:
        btnDescontoFinalizacaoClick;
      66:
        btnDesistirDescAcresFinalizacaoClick;
      67:
        btnAcrecimoFinalizacaoClick;
      68:
        btnConfirmarDescAcresFinalizacaoClick;
      69:
        EdtDescAcresFinalizacaoClick;
      70:
        btnAlterarInformacoesFinalizacaoClick;
      71:
        EdtDescAcresPercentualFinalizacaoExit;
      72:
        EdtDescAcresPercentualFinalizacaoClick;
      73:
        EdtDescAcresFinalizacaoExit;
      74:
        btnFinalizarComandaClick;
      75:
        btnDesistirValorClick;
      76:
        EdtValorFormaPagamentoClick;
      77:
        btnConfirmarValorClick;
      78:
        cbAdministradorasCartaoChange;
      79:
        EdtValorLancamentoCartaoClick;
      80:
        EdtNumeroAutorizacaoClick;
      81:
        mmObservacaoLancamentoCartaoClick;
      82:
        btnConfirmaLancamentosCartaoClick;
      83:
        btnAddParcelasClick;
      84:
        btnRemoveParcelasClick;
      85:
        btnDesistirLancamentoCartaoClick;
      86:
        btnAlterarDadosVendaFinalizacaoClick;
      87:
        btnItensComandaClick;
      88:
        btnAddQuantidadeProdutoTransferenciaClick;
      89:
        btnRemoveQuantidadeProdutoTransferencia;
      90:
        btnConfirmarQuantidadeTransferenciaClick;
      91:
        btnDesistirQuantidadeTransferenciaClick;
      92:
        EdtQuantidadeProdutoTransferenciaClick;
      93:
        btnBuscarProdutosClick;
      94:
        btnDesistirBuscaProdutosClick;
      95:
        EdtBuscaProdutoClick;
    end;

  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
        ', não foi possível realizar a ação. Mensagem retornada: ' + E.Message;
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;

      botoes(True);

      exit;
    end;
  end;
end;

procedure TFrmComandaController.FormClose;
var
  NovaListaProduto: TListView;
  I: Integer;
begin
  try
    TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
      .lblNomeComanda.Visible := False;

    DMConexao.FTempoAtualizaMesas := True;

    limpaProdutos;
    limpaSecoes;
    limpaObservacoes;
    limpaInformacoesProduto;
    limpaInformacoesProdutoAdicionais;
    limpaItensComanda;
    limpaItensTransferencia;
    limpaAdicionais;
    limpaFormasPagamentoParcialValor;
    limpaPagamentosPaciais;
    limpaItemsPagamentoParcialProduto;
    limpaItensFinalizacao;

    if Assigned(FProdutoSelecionado) then
      FProdutoSelecionado := nil;

    FView.retAddIndicador.Visible := False;
    FView.retAlteraInformacoesMesa.Visible := False;
    FView.retLancamentoProduto.Visible := False;
    FView.retModalLancProduto.Visible := False;
    FView.retObsCancelaMesa.Visible := False;
    FView.retTransferenciaComanda.Visible := False;
    FView.retAddAdicional.Visible := False;
    FView.retAddIndicador.Visible := False;
    FView.retLancamentoProduto.Visible := False;

    FView.Visible := False;

    TFrmMesas(FView.Parent).retPanel.Visible := True;
    TFrmMesas(FView.Parent).btnAplicarClick(TFrmMesas(FView.Parent));
  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
        ', não foi possível realizar a ação. Mensagem retornada: ' + E.Message;
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;

      FView.Visible := False;

      exit;
    end;
  end;
end;

procedure TFrmComandaController.FormShow;
var
  FAtualizaMesas: ITask;
begin

  if DMConexao.Configuracao.ImprimirComandaPorProduto then
  begin
    if Impressoras = nil then
    begin
      if DMConexao.Configuracao.UsaSetorImpressora then
        Impressoras := TImpressoraDAO.getInstancia.buscarTodos(TSetor.Create)
      else
        Impressoras := TImpressoraDAO.getInstancia.buscarTodos;
    end;
  end;

  FListaGarcom := TVendedorDAO.getInstancia.buscarTodos;

  if DMConexao.Configuracao.EscondeItensComanda then
    FView.retItensComandaInformacoes.Visible := False
  else
    FView.retItensComandaInformacoes.Visible := True;

  if DMConexao.Configuracao.ExisteModuloFiscal then
  begin
    FView.Rectangle3.Height := 135;
    FView.Rectangle3.Visible := True;
  end
  else
  begin
    FView.Rectangle3.Height := 0;
    FView.Rectangle3.Visible := False;
  end;

  FView.GridPanelLayout1.Visible := False;

  FView.retSecoes.Height := 195;
  FView.retProdutos.Height := 270;
  FView.retLocalSecaoProdutos.Height := 455;

  FView.Visible := True;

  addSecoes;

  if not DMConexao.Configuracao.EscondeItensComanda then
    addItensComanda;

  if FConta.ContaCliente.DispensarTaxaServico = 'N' then
    FView.btnRetiraTaxaServico.Text := 'Retirar Taxa Serviço'
  else
    FView.btnRetiraTaxaServico.Text := 'Cobrar Taxa Serviço';

  FView.GridPanelLayout1.ControlCollection.AddControl
    (FView.btnCancelarMesa, 0, 4);

  FView.GridPanelLayout1.ControlCollection.AddControl
    (FView.btnRetiraTaxaServico, 1, 4);

  FView.GridPanelLayout1.ControlCollection.AddControl
    (FView.btnAlteraInformacoesMesa, 0, 5);

  FView.GridPanelLayout1.ControlCollection.AddControl
    (FView.btnRecarregaInformacoes, 1, 5);

  FView.GridPanelLayout1.ControlCollection.AddControl
    (FView.btnInformacoesMesa, 0, 6);

  FView.GridPanelLayout1.ControlCollection.AddControl
    (FView.btnItensComanda, 1, 6);

  FView.GridPanelLayout1.Visible := True;

end;

procedure TFrmComandaController.imprimeComprovanteComanda(Local: String);
var
  comprovante: TComprovante;
  fecha: Boolean;
  I, Y: Integer;
  sItem, sDescricaoProduto, sQuantidadeProduto: String;
  sDescricaoProdutoAdicional, sQuantidadeProdutoAdicional: String;
begin
  try
    try
      FView.btnImprimeCozinhaBar.Enabled := False;
      fecha := False;
      comprovante := TComprovante.Create;
      comprovante.Cabecalho := False;
      comprovante.usaTitulo := False;
      comprovante.Impressora := Local;
      comprovante.abreComprovante;

      comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

      if comprovante.NumeroColunas < 40 then
        comprovante.imprimeTextoComprovante
          (comprovante.boldText('COMANDA ' + Local), 'E', False)
      else
        comprovante.imprimeTextoComprovante
          (comprovante.expandedText(comprovante.boldText('COMANDA ' + Local)),
          'C', False);

      comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

      if DMConexao.Configuracao.ModeloComanda = 0 then
      begin

        comprovante.imprimeTextoComprovante
          ('COMANDA: ' + IntToStr(FConta.ContaCliente.Conta), 'E', False);

        if FConta.ContaCliente.DescricaoMesa.Trim <> '' then
          comprovante.imprimeTextoComprovante('DESC. COMANDA: ' +
            FConta.ContaCliente.DescricaoMesa.Trim, 'E', False);

        if FConta.ContaCliente.ItensContaCliente.Count > 0 then
          comprovante.imprimeTextoComprovante
            ('GARCOM: ' + FConta.ContaCliente.ItensContaCliente.Items[0]
            .Garcom.nome, 'E', False);

        comprovante.imprimeTextoComprovante('DATA: ' + DateToStr(Date),
          'E', False);

        comprovante.imprimeTextoComprovante('HORA: ' + TimeToStr(Time),
          'E', False);

      end
      else if DMConexao.Configuracao.ModeloComanda = 1 then
      begin

        if FConta.ContaCliente.ItensContaCliente.Count > 0 then
          comprovante.imprimeTextoComprovante
            ('GARCOM: ' + FConta.ContaCliente.ItensContaCliente.Items[0]
            .Garcom.nome, 'C', False);

        comprovante.imprimeTextoComprovante('DATA: ' + DateToStr(Date),
          'C', False);

        comprovante.imprimeTextoComprovante('HORA: ' + TimeToStr(Time),
          'C', False);
      end;

      comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

      { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
      if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
      begin
        if comprovante.NumeroColunas < 40 then
          comprovante.imprimeTextoComprovanteEspaco('ITEM    DESC', 'QTD')
        else
          comprovante.imprimeTextoComprovanteEspaco('ITEM    DESCRICAO', 'QTD');
      end
      else
      begin
        if comprovante.NumeroColunas < 40 then
          comprovante.imprimeTextoComprovanteEspaco('DESC', 'QTD')
        else
          comprovante.imprimeTextoComprovanteEspaco('DESCRICAO', 'QTD');
      end;

      comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

      for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
      begin
        if FConta.ContaCliente.ItensContaCliente.Items[I].Cancelado = 0 then
        begin
          if FConta.ContaCliente.ItensContaCliente.Items[I].Impresso = 'N' then
          begin
            if Local = 'COZINHA' then
            begin
              if FConta.ContaCliente.ItensContaCliente.Items[I]
                .Produto.CozinhaBalcao = 'S' then
              begin

                fecha := True;
                if FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Produto.Referencia.Trim = '' then
                  sItem := comprovante.FormataStringE
                    (FConta.ContaCliente.ItensContaCliente.Items[I]
                    .Produto.CodigoBarras.Trim, '8', ' ')
                else
                  sItem := comprovante.FormataStringE
                    (FConta.ContaCliente.ItensContaCliente.Items[I]
                    .Produto.Referencia.Trim, '8', ' ');

                sDescricaoProduto := FConta.ContaCliente.ItensContaCliente.Items
                  [I].Produto.DescricaoCupom.Trim;

                sQuantidadeProduto :=
                  CurrToStr(FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Quantidade);

                { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
                if DMConexao.Configuracao.ModeloComanda = 0 then
                begin
                  if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha
                  then
                  begin
                    if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
                    then
                      comprovante.imprimeTextoComprovanteValor
                        (sItem + sDescricaoProduto, sQuantidadeProduto,
                        'N', True)
                    else
                      comprovante.imprimeTextoComprovanteValor
                        (sItem + copy(sDescricaoProduto, 1,
                        (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                        sQuantidadeProduto);
                  end
                  else
                  begin
                    if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
                    then
                      comprovante.imprimeTextoComprovanteValor
                        (sDescricaoProduto, sQuantidadeProduto, 'N', True)
                    else
                      comprovante.imprimeTextoComprovanteValor
                        (copy(sDescricaoProduto, 1, (comprovante.NumeroColunas)
                        - 4), sQuantidadeProduto);
                  end;
                end
                else if DMConexao.Configuracao.ModeloComanda = 1 then
                begin
                  if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha
                  then
                  begin
                    if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
                    then
                      comprovante.imprimeTextoComprovanteValor
                        (sItem + copy(sDescricaoProduto, 1,
                        (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                        sQuantidadeProduto, 'E', True)
                    else
                      comprovante.imprimeTextoComprovanteValor
                        (sItem + copy(sDescricaoProduto, 1,
                        (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                        sQuantidadeProduto, 'E');
                  end
                  else
                  begin
                    if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
                    then
                      comprovante.imprimeTextoComprovanteValor
                        (copy(sDescricaoProduto, 1, (comprovante.NumeroColunas)
                        - 4), sQuantidadeProduto, 'E', True)
                    else
                      comprovante.imprimeTextoComprovanteValor
                        (copy(sDescricaoProduto, 1, (comprovante.NumeroColunas)
                        - 4), sQuantidadeProduto, 'E');
                  end;
                end;

                { Imprime Adicionais }

                for Y := 0 to FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Adicionais.Count - 1 do
                begin
                  sDescricaoProdutoAdicional :=
                    FConta.ContaCliente.ItensContaCliente.Items[I]
                    .Adicionais.Items[Y].Produto.DescricaoCupom.Trim;

                  sQuantidadeProdutoAdicional :=
                    CurrToStr(FConta.ContaCliente.ItensContaCliente.Items[I]
                    .Adicionais.Items[Y].Quantidade);

                  comprovante.imprimeTextoComprovanteValor
                    (sDescricaoProdutoAdicional, sQuantidadeProdutoAdicional);
                end;

                { Imprime Observação do Item }
                if FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Observacao.Trim <> '' then
                begin
                  if DMConexao.Configuracao.ImprimirObsComandaCozinha then
                  begin
                    comprovante.imprimeTextoComprovante
                      ('OBSERVACAO: ' + FConta.ContaCliente.ItensContaCliente.
                      Items[I].Observacao.Trim, 'E', True);
                  end;
                end;

              end;
            end;
            if Local = 'BALCAO' then
            begin
              if FConta.ContaCliente.ItensContaCliente.Items[I]
                .Produto.ImprimeBalcao = 'S' then
              begin

                fecha := True;
                if FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Produto.Referencia.Trim = '' then
                  sItem := comprovante.FormataStringE
                    (FConta.ContaCliente.ItensContaCliente.Items[I]
                    .Produto.CodigoBarras.Trim, '8', ' ')
                else
                  sItem := comprovante.FormataStringE
                    (FConta.ContaCliente.ItensContaCliente.Items[I]
                    .Produto.Referencia.Trim, '8', ' ');

                sDescricaoProduto := FConta.ContaCliente.ItensContaCliente.Items
                  [I].Produto.DescricaoCupom.Trim;

                sQuantidadeProduto :=
                  CurrToStr(FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Quantidade);

                { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
                if DMConexao.Configuracao.ModeloComanda = 0 then
                begin
                  if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha
                  then
                  begin
                    if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
                    then
                      comprovante.imprimeTextoComprovanteValor
                        (sItem + sDescricaoProduto, sQuantidadeProduto,
                        'N', True)
                    else
                      comprovante.imprimeTextoComprovanteValor
                        (sItem + copy(sDescricaoProduto, 1,
                        (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                        sQuantidadeProduto);
                  end
                  else
                  begin
                    if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
                    then
                      comprovante.imprimeTextoComprovanteValor
                        (sDescricaoProduto, sQuantidadeProduto, 'N', True)
                    else
                      comprovante.imprimeTextoComprovanteValor
                        (copy(sDescricaoProduto, 1, (comprovante.NumeroColunas)
                        - 4), sQuantidadeProduto);
                  end;
                end
                else if DMConexao.Configuracao.ModeloComanda = 1 then
                begin
                  if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha
                  then
                  begin
                    if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
                    then
                      comprovante.imprimeTextoComprovanteValor
                        (sItem + sDescricaoProduto, sQuantidadeProduto,
                        'E', True)
                    else
                      comprovante.imprimeTextoComprovanteValor
                        (sItem + copy(sDescricaoProduto, 1,
                        (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                        sQuantidadeProduto, 'E');
                  end
                  else
                  begin
                    if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
                    then
                      comprovante.imprimeTextoComprovanteValor
                        (sDescricaoProduto, sQuantidadeProduto, 'E', True)
                    else
                      comprovante.imprimeTextoComprovanteValor
                        (copy(sDescricaoProduto, 1, (comprovante.NumeroColunas)
                        - 4), sQuantidadeProduto, 'E');
                  end;
                end;

                { Imprime Adicionais }

                for Y := 0 to FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Adicionais.Count - 1 do
                begin
                  sDescricaoProdutoAdicional :=
                    FConta.ContaCliente.ItensContaCliente.Items[I]
                    .Adicionais.Items[Y].Produto.DescricaoCupom.Trim;

                  sQuantidadeProdutoAdicional :=
                    CurrToStr(FConta.ContaCliente.ItensContaCliente.Items[I]
                    .Adicionais.Items[Y].Quantidade);

                  comprovante.imprimeTextoComprovanteValor
                    (sDescricaoProdutoAdicional, sQuantidadeProdutoAdicional);
                end;

                { Imprime Observação do Item }
                if FConta.ContaCliente.ItensContaCliente.Items[I]
                  .Observacao.Trim <> '' then
                begin
                  if DMConexao.Configuracao.ImprimirObsComandaCozinha then
                  begin
                    comprovante.imprimeTextoComprovante
                      ('OBSERVACAO: ' + FConta.ContaCliente.ItensContaCliente.
                      Items[I].Observacao.Trim, 'E', True);
                  end;
                end;
              end;
            end;

            if (DMConexao.Configuracao.ModeloComanda = 1) and
              (DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar) then
              comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

          end;
        end;
      end;

      if not((DMConexao.Configuracao.ModeloComanda = 1) and
        (DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar)) then
        comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

      if DMConexao.Configuracao.ImprimirSetorCozinhaBalcao then
        comprovante.imprimeTextoComprovante
          ('SETOR: ' + DMConexao.Empresa.Fantasia.Trim, 'E', False);
    except
      on E: Exception do
      begin
        Application.CreateForm(TFrmMensagem, FrmMensagem);
        FrmMensagem.FTipo := 0;
        FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
          ', não foi possível imprimir a comanda ' + Local +
          '. Mensagem retornada: ' + E.Message;
        FrmMensagem.FTitulo := 'Atenção!';
        FrmMensagem.ShowModal;
        fecha := False;
      end;
    end;
  finally
    comprovante.fechaComprovante(False, False, 8, fecha);
    FView.btnImprimeCozinhaBar.Enabled := True;
  end;

end;

procedure TFrmComandaController.ImprimirItemCancelado;
var
  comprovante: TComprovante;
  sItem: String;
begin
  { SE O PARAMETRO COZINHA NO INI ESTIVER MARCADO "S" }
  if DMConexao.Configuracao.ImprimeCozinha then
  begin
    { SE O ITEM ESTIVER CANCELADO }
    if ItemSelecionado.Cancelado = 1 then
    begin
      { SE O ITEM JÁ FOI IMPRESSO NA IMPRESSORA DA COZINHA }
      if ItemSelecionado.Impresso = 'S' then
      begin
        { SE O PRODUTO IMPRIMIR NA COZINHA BALCAO }
        if ItemSelecionado.Produto.CozinhaBalcao = 'S' then
        begin

          comprovante := TComprovante.Create;
          comprovante.Cabecalho := False;
          comprovante.usaTitulo := False;
          comprovante.Impressora := 'COZINHA';
          comprovante.abreComprovante;
          comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

          if comprovante.NumeroColunas < 40 then
            comprovante.imprimeTextoComprovante
              (comprovante.boldText('CANCELAMENTO DE ITEM - COZINHA'),
              'E', False)
          else
            comprovante.imprimeTextoComprovante
              (comprovante.boldText('CANCELAMENTO DE ITEM - COZINHA'),
              'C', False);

          comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

          comprovante.imprimeTextoComprovante
            ('BALCAO: ' + DMConexao.Configuracao.Caixa.DescricaoCaixa,
            'E', False);

          comprovante.imprimeTextoComprovante
            ('COMANDA: ' + IntToStr(FConta.ContaCliente.Conta), 'E', False);

          comprovante.imprimeTextoComprovante
            ('GARCOM: ' + ItemSelecionado.Garcom.nome, 'E', False);

          comprovante.imprimeTextoComprovante('DATA: ' + DateToStr(Date),
            'E', False);

          comprovante.imprimeTextoComprovante('HORA: ' + TimeToStr(Time),
            'E', False);

          comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

          { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
          if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
            comprovante.imprimeTextoComprovanteEspaco
              ('ITEM    DESCRICAO', 'QTD')
          else
            comprovante.imprimeTextoComprovanteEspaco('DESCRICAO', 'QTD');

          if Trim(ItemSelecionado.Produto.Referencia) = '' then
            sItem := ItemSelecionado.Produto.CodigoBarras
          else
            sItem := ItemSelecionado.Produto.Referencia;

          { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
          if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
            if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar then
              comprovante.imprimeTextoComprovanteValor
                (comprovante.FormataStringE(sItem, '8', ' ') +
                Trim(ItemSelecionado.Produto.DescricaoCupom),
                CurrToStr(ItemSelecionado.Quantidade), 'N', True)
            else
              comprovante.imprimeTextoComprovanteValor
                (comprovante.FormataStringE(sItem, '8', ' ') +
                copy(Trim(ItemSelecionado.Produto.DescricaoCupom), 1,
                (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                CurrToStr(ItemSelecionado.Quantidade))
          else if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha
          then
            comprovante.imprimeTextoComprovanteValor
              (Trim(ItemSelecionado.Produto.DescricaoCupom),
              CurrToStr(ItemSelecionado.Quantidade), 'N', True)
          else
            comprovante.imprimeTextoComprovanteValor
              (copy(Trim(ItemSelecionado.Produto.DescricaoCupom), 1,
              (comprovante.NumeroColunas) - 4),
              CurrToStr(ItemSelecionado.Quantidade));

          if comprovante.NumeroColunas < 40 then
            comprovante.imprimeTextoComprovante
              (comprovante.boldText('######## ITEM CANCELADO ########'),
              'E', False)
          else
            comprovante.imprimeTextoComprovante
              (comprovante.boldText('######## ITEM CANCELADO ########'),
              'C', False);

          comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

          if DMConexao.Configuracao.ImprimirSetorCozinhaBalcao then
            comprovante.imprimeTextoComprovante
              ('SETOR: ' + DMConexao.Configuracao.Empresa.Fantasia, 'E', False);

          comprovante.fechaComprovante(False, False, 8);
        end;
      end;
    end;
  end;
end;

procedure TFrmComandaController.ImprimirItemCanceladoProduto;
var
  I: Integer;
  comprovante: TComprovante;
  sItem: String;
begin
  { SE O ITEM ESTIVER CANCELADO }
  if ItemSelecionado.Cancelado = 1 then
  begin
    { SE O ITEM JÁ FOI IMPRESSO NA IMPRESSORA DA COZINHA }
    if ItemSelecionado.Impresso = 'S' then
    begin
      { SE O PRODUTO IMPRIMIR NA COZINHA BALCAO }
      if ItemSelecionado.Produto.CozinhaBalcao = 'S' then
      begin

        for I := 0 to ItemSelecionado.Produto.Impressora.CaminhosImpressora.
          Count - 1 do
        begin

          with ItemSelecionado.Produto.Impressora.CaminhosImpressora.Items[I] do
          begin

            comprovante := TComprovante.Create;
            comprovante.Cabecalho := False;
            comprovante.usaTitulo := False;

            comprovante.abreComprovante(True, IntToStr(Modelo),
              IntToStr(PaginaCodigo), Porta,
              DMConexao.DesCriptografa(ParametroString), IntToStr(Colunas),
              IntToStr(EspacoEntreLinhas), ControlaPorta, CortaPapel);

            comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

            if comprovante.NumeroColunas < 40 then
              comprovante.imprimeTextoComprovante
                (comprovante.boldText('CANCELAMENTO DE ITEM - COZINHA'),
                'E', False)
            else
              comprovante.imprimeTextoComprovante
                (comprovante.boldText('CANCELAMENTO DE ITEM - COZINHA'),
                'C', False);

            comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

            comprovante.imprimeTextoComprovante
              ('BALCAO: ' + DMConexao.Configuracao.Caixa.DescricaoCaixa,
              'E', False);

            comprovante.imprimeTextoComprovante
              ('COMANDA: ' + IntToStr(FConta.ContaCliente.Conta), 'E', False);

            comprovante.imprimeTextoComprovante
              ('GARCOM: ' + ItemSelecionado.Garcom.nome, 'E', False);

            comprovante.imprimeTextoComprovante('DATA: ' + DateToStr(Date),
              'E', False);

            comprovante.imprimeTextoComprovante('HORA: ' + TimeToStr(Time),
              'E', False);

            comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

            { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
            if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
              comprovante.imprimeTextoComprovanteEspaco
                ('ITEM    DESCRICAO', 'QTD')
            else
              comprovante.imprimeTextoComprovanteEspaco('DESCRICAO', 'QTD');

            if Trim(ItemSelecionado.Produto.Referencia) = '' then
              sItem := ItemSelecionado.Produto.CodigoBarras
            else
              sItem := Trim(ItemSelecionado.Produto.Referencia);

            { IMPRESSÃO DA REFERENCIA NO COMPROVANTE }
            if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
              if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar then
                comprovante.imprimeTextoComprovanteValor
                  (comprovante.FormataStringE(sItem, '8', ' ') +
                  Trim(ItemSelecionado.Produto.DescricaoCupom),
                  CurrToStr(ItemSelecionado.Quantidade), 'N', True)
              else
                comprovante.imprimeTextoComprovanteValor
                  (comprovante.FormataStringE(sItem, '8', ' ') +
                  copy(Trim(ItemSelecionado.Produto.DescricaoCupom), 1,
                  (comprovante.NumeroColunas) - Length('ITEM    ') - 4),
                  CurrToStr(ItemSelecionado.Quantidade))
            else if DMConexao.Configuracao.ImprimirNomeTodoProdutoCozinhaBar
            then
              comprovante.imprimeTextoComprovanteValor
                (Trim(ItemSelecionado.Produto.DescricaoCupom),
                CurrToStr(ItemSelecionado.Quantidade), 'N', True)
            else
              comprovante.imprimeTextoComprovanteValor
                (copy(Trim(ItemSelecionado.Produto.DescricaoCupom), 1,
                (comprovante.NumeroColunas) - 4),
                CurrToStr(ItemSelecionado.Quantidade));

            if comprovante.NumeroColunas < 40 then
              comprovante.imprimeTextoComprovante
                (comprovante.boldText('######## ITEM CANCELADO ########'),
                'E', False)
            else
              comprovante.imprimeTextoComprovante
                (comprovante.boldText('######## ITEM CANCELADO ########'),
                'C', False);

            comprovante.imprimeTextoComprovante(comprovante.linhaSimples);

            if DMConexao.Configuracao.ImprimirSetorCozinhaBalcao then
              comprovante.imprimeTextoComprovante
                ('SETOR: ' + DMConexao.Configuracao.Empresa.Fantasia,
                'E', False);

            comprovante.fechaComprovante(False, False, 8);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmComandaController.IniciaComanda(mesa: TContaView);
var
  FAtualizaMesas: ITask;
begin
  try
    DMConexao.FTempoAtualizaMesas := False;
    Clean;

    FConta := mesa;

    if Assigned(FConta) then
    begin
      TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
        .lblNomeComanda.Text := 'COMANDA: ' + TComprovante.FormataStringD
        (IntToStr(FConta.ContaCliente.Conta), '3', '0') + ' - CODIGO: ' +
        IntToStr(FConta.ContaCliente.Codigo);
      TFrmPrincipal(TRectangle(TFrmMesas(FView.Parent).Parent).Parent)
        .lblNomeComanda.Visible := True;
    end;

    atualizaMesa;
    FormShow;

  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
        ', não foi possível realizar a ação. Mensagem retornada: ' + E.Message;
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;

      botoes(True);

      exit;
    end;
  end;
end;

procedure TFrmComandaController.IniciaProdutosVenda;
var
  I, Ordem: Integer;
  FItemVenda: TItemVenda;
  Y: Integer;
begin
  if Assigned(FConta.ContaCliente.Venda) then
  begin
    for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
    begin
      if FConta.ContaCliente.ItensContaCliente.Items[I].Cancelado = 0 then
      begin
        FItemVenda := TItemVenda.Create;
        FItemVenda.Codigo := FConta.ContaCliente.Venda.Codigo;
        FItemVenda.Ordem := FConta.ContaCliente.ItensContaCliente.Items
          [I].Ordem;
        FItemVenda.Produto := FConta.ContaCliente.ItensContaCliente.Items
          [I].Produto;
        FItemVenda.Empresa := DMConexao.Empresa;
        FItemVenda.Vendedor := FConta.ContaCliente.ItensContaCliente.Items
          [I].Garcom;
        FItemVenda.Cfop := FConta.ContaCliente.ItensContaCliente.Items[I]
          .Produto.Cfop;
        FItemVenda.Quantidade := FConta.ContaCliente.ItensContaCliente.Items[I]
          .Quantidade;

        if FConta.ContaCliente.ItensContaCliente.Items[I].Produto.Promocao > 0
        then
          FItemVenda.Promocao := True
        else
          FItemVenda.Promocao := False;

        FItemVenda.Valor := FConta.ContaCliente.ItensContaCliente.Items
          [I].Valor;
        FItemVenda.ValorCusto := FConta.ContaCliente.ItensContaCliente.Items[I]
          .Produto.PrecoCusto;
        FItemVenda.Desconto := 0;
        FItemVenda.Acrescimo := 0;
        FItemVenda.Total := FConta.ContaCliente.ItensContaCliente.Items
          [I].Total;
        FItemVenda.GrupoIcms := FConta.ContaCliente.ItensContaCliente.Items[I]
          .Produto.GrupoIcms;
        FItemVenda.GrupoPis := FConta.ContaCliente.ItensContaCliente.Items[I]
          .Produto.GrupoPis;
        FItemVenda.GrupoCofins := FConta.ContaCliente.ItensContaCliente.Items[I]
          .Produto.GrupoCofins;
        FItemVenda.Cancelado := 0;
        FItemVenda.VendaCancelada := 0;

        FItemVenda.Observacao := FConta.ContaCliente.ItensContaCliente.Items[I]
          .Observacao;

        FConta.ContaCliente.Venda.ItensVenda.Add(FItemVenda);

        for Y := 0 to FConta.ContaCliente.ItensContaCliente.Items[I]
          .Adicionais.Count - 1 do
        begin
          FItemVenda := TItemVenda.Create;
          FItemVenda.Codigo := FConta.ContaCliente.Venda.Codigo;
          FItemVenda.Ordem := FConta.ContaCliente.ItensContaCliente.Items[I]
            .Adicionais.Items[Y].Ordem;
          FItemVenda.Produto := FConta.ContaCliente.ItensContaCliente.Items[I]
            .Adicionais.Items[Y].Produto;
          FItemVenda.Empresa := DMConexao.Empresa;
          FItemVenda.Vendedor := FConta.ContaCliente.ItensContaCliente.Items[I]
            .Adicionais.Items[Y].Garcom;
          FItemVenda.Cfop := FConta.ContaCliente.ItensContaCliente.Items[I]
            .Adicionais.Items[Y].Produto.Cfop;
          FItemVenda.Quantidade := FConta.ContaCliente.ItensContaCliente.Items
            [I].Adicionais.Items[Y].Quantidade;

          if FConta.ContaCliente.ItensContaCliente.Items[I].Adicionais.Items[Y]
            .Produto.Promocao > 0 then
            FItemVenda.Promocao := True
          else
            FItemVenda.Promocao := False;

          FItemVenda.Valor := FConta.ContaCliente.ItensContaCliente.Items[I]
            .Adicionais.Items[Y].Valor;
          FItemVenda.ValorCusto := FConta.ContaCliente.ItensContaCliente.Items
            [I].Adicionais.Items[Y].Produto.PrecoCusto;
          FItemVenda.Desconto := 0;
          FItemVenda.Acrescimo := 0;
          FItemVenda.Total := FConta.ContaCliente.ItensContaCliente.Items[I]
            .Adicionais.Items[Y].Total;
          FItemVenda.GrupoIcms := FConta.ContaCliente.ItensContaCliente.Items[I]
            .Adicionais.Items[Y].Produto.GrupoIcms;
          FItemVenda.GrupoPis := FConta.ContaCliente.ItensContaCliente.Items[I]
            .Adicionais.Items[Y].Produto.GrupoPis;
          FItemVenda.GrupoCofins := FConta.ContaCliente.ItensContaCliente.Items
            [I].Adicionais.Items[Y].Produto.GrupoCofins;
          FItemVenda.Cancelado := 0;
          FItemVenda.VendaCancelada := 0;

          FItemVenda.Observacao := FConta.ContaCliente.ItensContaCliente.Items
            [I].Adicionais.Items[Y].Observacao;

          FConta.ContaCliente.Venda.ItensVenda.Add(FItemVenda);
        end;
      end;
    end;

    if ((DMConexao.Configuracao.TaxaRestaurante > 0) and
      (Assigned(DMConexao.Configuracao.ProdutoPadraoRestaurante)) and
      (FConta.ContaCliente.DispensarTaxaServico = 'N')) then
    begin
      FItemVenda := TItemVenda.Create;
      FItemVenda.Codigo := FConta.ContaCliente.Venda.Codigo;
      FItemVenda.Ordem := FConta.ContaCliente.ItensContaCliente.Items
        [FConta.ContaCliente.ItensContaCliente.Count - 1].Ordem + 1;
      FItemVenda.Produto := DMConexao.Configuracao.ProdutoPadraoRestaurante;
      FItemVenda.Empresa := DMConexao.Empresa;
      FItemVenda.Vendedor := DMConexao.Configuracao.VendedorPadrao;
      FItemVenda.Cfop := DMConexao.Configuracao.ProdutoPadraoRestaurante.Cfop;
      FItemVenda.Quantidade := 1;

      FItemVenda.Promocao := False;

      FItemVenda.Valor := DMConexao.CalcularTaxaServico
        (FConta.ContaCliente.TotalMesa, FConta.ContaCliente);
      FItemVenda.ValorCusto := 0;
      FItemVenda.Desconto := 0;
      FItemVenda.Acrescimo := 0;
      FItemVenda.Total := 0;
      FItemVenda.GrupoIcms :=
        DMConexao.Configuracao.ProdutoPadraoRestaurante.GrupoIcms;
      FItemVenda.GrupoPis :=
        DMConexao.Configuracao.ProdutoPadraoRestaurante.GrupoPis;
      FItemVenda.GrupoCofins := DMConexao.Configuracao.ProdutoPadraoRestaurante.
        GrupoCofins;
      FItemVenda.Cancelado := 0;
      FItemVenda.VendaCancelada := 0;

      FItemVenda.Observacao := '';

      FConta.ContaCliente.Venda.ItensVenda.Add(FItemVenda);
    end;

  end;
end;

procedure TFrmComandaController.IniciaVenda;
begin
  FConta.ContaCliente.Venda := TVenda.Create;
  FConta.ContaCliente.Venda.Data := Date;
  FConta.ContaCliente.Venda.Empresa := DMConexao.Empresa;
  FConta.ContaCliente.Venda.Caixa := DMConexao.Configuracao.Caixa;
  FConta.ContaCliente.Venda.DataHora := now;
  FConta.ContaCliente.Venda.Usuario := DMConexao.Usuario;
  FConta.ContaCliente.Venda.CupomFiscal := 0;

  if Assigned(FConta.ContaCliente.Indicador) then
    FConta.ContaCliente.Venda.Indicador := FConta.ContaCliente.Indicador
  else
    FConta.ContaCliente.Venda.Indicador := nil;

  FConta.ContaCliente.Venda.Cliente := DMConexao.Configuracao.ClientePadrao;
  FConta.ContaCliente.Venda.Vendedor := DMConexao.Configuracao.VendedorPadrao;
  FConta.ContaCliente.Venda.Cancelada := 0;
  FConta.ContaCliente.Venda.UsuarioAuditoria := DMConexao.Usuario;
  FConta.ContaCliente.Venda.Parcial := FConta.ContaCliente.ValorPacial;
  FConta.ContaCliente.Venda.TipoVenda := DMConexao.Configuracao.TipoVendaPadrao;
  FConta.ContaCliente.Venda.Usuario := DMConexao.Usuario;
end;

procedure TFrmComandaController.EdtBuscaProdutoClick;
begin
  DMConexao.mostraTeclado(FView, FView.EdtBuscaProduto,
    FView.btnBuscarProdutos);
end;

procedure TFrmComandaController.EdtDescAcresFinalizacaoClick;
begin
  DMConexao.mostraTeclado(FView, FView.EdtDescAcresFinalizacao, True, 2);
end;

procedure TFrmComandaController.EdtDescAcresFinalizacaoExit;
begin
  if FView.EdtDescAcresFinalizacao.Text.Trim = '' then
    FView.EdtDescAcresFinalizacao.Text := '0,00';

  if StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim) < 0 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o valor não pode ser negativo';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    exit;
  end;

  case FView.Label57.Tag of
    0:
      begin
        FView.EdtDescAcresPercentualFinalizacao.Text :=
          currtostrf
          ((((FConta.ContaCliente.Total -
          StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim)) /
          FConta.ContaCliente.Total) - 1) * -100, ffnumber, 2);
      end;
    1:
      begin
        FView.EdtDescAcresPercentualFinalizacao.Text :=
          currtostrf
          ((((FConta.ContaCliente.Total +
          StrToCurr(FView.EdtDescAcresFinalizacao.Text.Trim)) /
          FConta.ContaCliente.Total) - 1) * 100, ffnumber, 2);
      end;
  end;

end;

procedure TFrmComandaController.EdtDescAcresPercentualFinalizacaoClick;
begin
  DMConexao.mostraTeclado(FView,
    FView.EdtDescAcresPercentualFinalizacao, True, 2);
end;

procedure TFrmComandaController.EdtDescAcresPercentualFinalizacaoExit;
begin

  if FView.EdtDescAcresPercentualFinalizacao.Text.Trim = '' then
    FView.EdtDescAcresPercentualFinalizacao.Text := '0,00';

  if StrToCurr(FView.EdtDescAcresPercentualFinalizacao.Text.Trim) < 0 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', o percentual não pode ser negativo';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;

    exit;
  end;

  FView.EdtDescAcresFinalizacao.Text :=
    currtostrf(((FConta.ContaCliente.Total) *
    StrToCurr(FView.EdtDescAcresPercentualFinalizacao.Text)) / 100,
    ffnumber, 2);
end;

procedure TFrmComandaController.EdtDescricaoMesaClick;
begin
  DMConexao.mostraTeclado(FView, FView.EdtDescricaoMesa,
    FView.EdtQuantidadePessoas);
end;

procedure TFrmComandaController.EdtMesaTransferenciaClick;
begin
  DMConexao.mostraTeclado(FView, FView.EdtMesaTransferencia, False, 0);
end;

procedure TFrmComandaController.EdtNumeroAutorizacaoClick;
begin

  FView.EdtNumeroAutorizacao.Text :=
    stringreplace(FView.EdtNumeroAutorizacao.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase]);

  DMConexao.mostraTeclado(FView, FView.EdtNumeroAutorizacao, False, 0);
end;

procedure TFrmComandaController.EdtQuantidadeClick;
begin
  DMConexao.mostraTeclado(FView, FView.EdtQuantidadeProduto, True, 3);
end;

procedure TFrmComandaController.EdtQuantidadePessoasClick;
begin
  DMConexao.mostraTeclado(FView, FView.EdtQuantidadePessoas, False, 0);
end;

procedure TFrmComandaController.EdtQuantidadeProdutoExit;
begin

  FView.EdtValorProduto.Text := stringreplace(FView.EdtValorProduto.Text, '.',
    '', [rfReplaceAll, rfIgnoreCase]);

  FView.EdtValorProduto.Text :=
    currtostrf(StrToCurr(FView.EdtQuantidadeProduto.Text) *
    FProdutoSelecionado.Produto.PrecoVista, ffnumber, 2);

  FView.EdtQuantidadeProduto.Text :=
    currtostrf(StrToCurr(FView.EdtQuantidadeProduto.Text), ffnumber, 3);

end;

procedure TFrmComandaController.EdtQuantidadeProdutoTransferenciaClick;
begin
  DMConexao.mostraTeclado(FView,
    FView.EdtQuantidadeProdutoTransferencia, True, 2);
end;

procedure TFrmComandaController.limpaAdicionais;
var
  I: Integer;
begin
  if Assigned(FListaProdutosAdicionais) then
    for I := 0 to FListaProdutosAdicionais.Count - 1 do
      FListaProdutosAdicionais.Items[I].Retangulo.Free;

  FListaProdutosAdicionais := nil;
end;

procedure TFrmComandaController.limpaDadosLancamentoCartao;
begin
  if FView.cbAdministradorasCartao.Count > 0 then
    FView.cbAdministradorasCartao.ItemIndex := 0;

  if FView.cbBandeirasCartao.Count > 0 then
    FView.cbBandeirasCartao.ItemIndex := 0;
  FView.lblParcelasCartao.Text := '1';
  if Assigned(FFormaPagamentoSelecionado) then
    FView.EdtValorLancamentoCartao.Text :=
      formatfloat('#,##0.00', FFormaPagamentoSelecionado.Valor -
      FConta.ContaCliente.Venda.totalContasAdmCartao
      (FFormaPagamentoSelecionado.FormaPagamento));

  FView.EdtNumeroAutorizacao.Text := '';
  FView.mmObservacaoLancamentoCartao.Text := '';
end;

procedure TFrmComandaController.limpaFormasPagamentoParcialValor;
var
  I: Integer;
begin
  if Assigned(FListaFormasPagamento) then
    for I := 0 to FListaFormasPagamento.Count - 1 do
      with FListaFormasPagamento.Items[I] do
        Retangulo.Free;

  FListaFormasPagamento := TObjectList<TFormaPagamentoView>.Create;
end;

procedure TFrmComandaController.limpaInformacoesProduto;
begin

  limpaInformacoesProdutoAdicionais;
  FView.lblInfoGarcom.Text := '';
  FView.lblInfoHoraLancamento.Text := '';
  FView.lblInfoItem.Text := '';
  FView.lblInfoObservacao.Text := '';
  FView.lblInfoProduto.Text := '';
  FView.lblInfoQuantidade.Text := '';
  FView.lblInfoReferencia.Text := '';
  FView.lblInfoTotal.Text := '';
  FView.lblInfoValor.Text := '';
  FView.Label29.Text := '';
  FView.lblInfoTotalAdicional.Text := '';
  FView.lblInfoTotalGeral.Text := '';
  FView.Rectangle39.Visible := False;
  FView.Rectangle49.Visible := False;

  if Assigned(ItemSelecionado) then
    if (ItemSelecionado.Adicionais.Count <= 0) and
      (FListaPagamentosParciais.Count <= 0) then
      FView.retInformacoesItemConta.Width := 409;

  if Assigned(ItemSelecionado) then
    if (ItemSelecionado.Adicionais.Count <= 0) and
      (FListaPagamentosParciais.Count > 0) then
    begin
      FView.Rectangle49.Visible := True;
      FView.retInformacoesItemConta.Width := 617;
    end;

  if Assigned(ItemSelecionado) then
    if (ItemSelecionado.Adicionais.Count > 0) and
      (FListaPagamentosParciais.Count <= 0) then
    begin
      FView.Rectangle39.Visible := True;
      FView.retInformacoesItemConta.Width := 617;
    end;

  if Assigned(ItemSelecionado) then
    if (ItemSelecionado.Adicionais.Count > 0) and
      (FListaPagamentosParciais.Count > 0) then
    begin
      FView.Rectangle39.Visible := True;
      FView.Rectangle49.Visible := True;
      FView.retInformacoesItemConta.Width := 761;
    end;

  FView.btnDesistirInformacaoItem.Position.X :=
    ((FView.Rectangle35.Width - FView.btnDesistirInformacaoItem.Width)
    / 2) - 55;
  FView.btnDesistirInformacaoItem.Position.Y :=
    (FView.Rectangle35.Height - FView.btnDesistirInformacaoItem.Height) / 2;

  FView.btnCancelarItem.Position.X :=
    ((FView.Rectangle35.Width - FView.btnCancelarItem.Width) / 2) + 55;
  FView.btnCancelarItem.Position.Y :=
    (FView.Rectangle35.Height - FView.btnCancelarItem.Height) / 2;
end;

procedure TFrmComandaController.limpaInformacoesProdutoAdicionais;
var
  I: Integer;
begin
  if Assigned(FListaInfoProdutosAdicionais) then
    for I := 0 to FListaInfoProdutosAdicionais.Count - 1 do
      FListaInfoProdutosAdicionais.Items[I].Free;

  FListaInfoProdutosAdicionais := TObjectList<TAdicionalView>.Create;
end;

procedure TFrmComandaController.limpaItemsPagamentoParcialProduto;
var
  I: Integer;
begin
  if Assigned(FListaItemsParcialProduto) then
    for I := 0 to FListaItemsParcialProduto.Count - 1 do
      FListaItemsParcialProduto.Items[I].Local.Free;

  FListaItemsParcialProduto := TObjectList<TProdutoView>.Create;
end;

procedure TFrmComandaController.limpaItensComanda;
var
  I: Integer;
begin
  FView.listItensComanda.Items.Clear;
end;

procedure TFrmComandaController.limpaItensFinalizacao;
begin

end;

procedure TFrmComandaController.limpaItensLancamentoAdmCartao;
var
  I: Integer;
begin
  if Assigned(FListaLancamentosAdmCartao) then
    for I := 0 to FListaLancamentosAdmCartao.Count - 1 do
      FListaLancamentosAdmCartao.Items[I].Retangulo.Free;

  FListaLancamentosAdmCartao := TObjectList<TLancamentoCartaoView>.Create;
end;

procedure TFrmComandaController.limpaItensTransferencia;
var
  I: Integer;
begin
  if Assigned(FItensTransferencia) then
    for I := 0 to FItensTransferencia.Count - 1 do
      if Assigned(FItensTransferencia.Items[I].Retangulo) then
        FItensTransferencia.Items[I].Retangulo.Free;

  FItensTransferencia := TObjectList<TItemTransferenciaView>.Create;
end;

procedure TFrmComandaController.limpaObservacoes;
var
  I: Integer;
begin

  if Assigned(FListaObservacoes) then
    for I := 0 to FListaObservacoes.Count - 1 do
      with FListaObservacoes.Items[I] do
        Local.Free;

  FListaObservacoes := TObjectList<TObservacaoView>.Create;
end;

procedure TFrmComandaController.limpaPagamentosPaciais;
var
  I: Integer;
begin
  if Assigned(FListaPagamentosParciais) then
    for I := 0 to FListaPagamentosParciais.Count - 1 do
      with FListaPagamentosParciais.Items[I] do
        Retangulo.Free;

  FListaPagamentosParciais := TObjectList<TPagamentoParcialView>.Create;
end;

procedure TFrmComandaController.limpaPagamentosPaciaisProduto;
begin

end;

procedure TFrmComandaController.limpaProdutos;
var
  I: Integer;
begin
  if FListaProdutos <> nil then
    for I := 0 to FListaProdutos.Count - 1 do
      FListaProdutos.Items[I].Local.Free;

  FListaProdutos := TObjectList<TProdutoView>.Create(False);
end;

procedure TFrmComandaController.limpaSecoes;
var
  I: Integer;
begin

  FView.retSelected.Visible := False;
  FView.retSelected.Parent := FView.vRetSecoes;

  if Assigned(FListaSecoes) then
    for I := 0 to FListaSecoes.Count - 1 do
      if Assigned(FListaSecoes.Items[I]) then
        FListaSecoes.Items[I].Retangulo.Free;

  FListaSecoes := TObjectList<TSecaoView>.Create;
end;

procedure TFrmComandaController.listItensComandaItemClick(Sender: TObject);
var
  AItem: TListViewItem;
begin
  AItem := TListViewItem(Sender);
  if AItem.Objects.FindObjectT<TListItemText>('Text4').Text <> '2' then
  begin
    ItemSelecionado := TItemContaCliente.Create;
    ItemSelecionado.Codigo := FConta.ContaCliente.Codigo;
    ItemSelecionado.Ordem := TListViewItem(Sender).Tag;

    TItemContaClienteDAO.getInstancia.buscar(ItemSelecionado);

    addPagamentosParciaisProduto;
    limpaInformacoesProduto;
    addInformacoesProduto;

    FView.retInformacoesItemConta.Position.X :=
      (FView.Width - FView.retInformacoesItemConta.Width) / 2;
    FView.retInformacoesItemConta.Position.Y :=
      (FView.Height - FView.retInformacoesItemConta.Height) / 2;

    FView.retModalLancProduto.Visible := True;
    FView.retInformacoesItemConta.Visible := True;
  end;

end;

procedure TFrmComandaController.mmHistoricoPagamentoParcialValorClick;
begin
  DMConexao.mostraTeclado(FView, FView.mmHistoricoPagamentoParcialValor,
    FView.btnConfirmarLancPagParcialValor);
end;

procedure TFrmComandaController.mmObservacaoCancelItemClick;
begin
  DMConexao.mostraTeclado(FView, FView.mmObservacaoCancelItem,
    FView.btnConfirmarObsCancelItem);
end;

procedure TFrmComandaController.mmObservacaoClick;
begin
  DMConexao.mostraTeclado(FView, FView.mmObservacao,
    FView.btnConfirmarCancelamentoMesa);
end;

procedure TFrmComandaController.mmObservacaoLancamentoCartaoClick;
begin
  DMConexao.mostraTeclado(FView, FView.mmObservacaoLancamentoCartao,
    FView.btnConfirmarCancelamentoMesa);
end;

procedure TFrmComandaController.onClickItem(Sender: TObject);
begin

end;

procedure TFrmComandaController.onClickItemPagamentoParcial(Sender: TObject);
begin

end;

procedure TFrmComandaController.OnClickLancamentoAdmCartao(Sender: TObject);
begin

end;

procedure TFrmComandaController.onClickP(Sender: TObject);
var
  Produto: TProdutoView;
  Item: TItemContaCliente;
  Garcom: TVendedor;
  I: Integer;
begin

  if FConta.ContaCliente.ConferenciaEmitida = 'S' then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
      ', Faça o desbloqueio da comanda para inserir novos itens.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    exit;
  end;

  Produto := buscaProduto(TRectangle(Sender).Tag);

  FProdutoSelecionado := Produto;
  FProdutoSelecionado.selecionaProduto;

  // TProdutoDao.getInstancia.buscar(FProdutoSelecionado.Produto);

  FView.lblNomeProduto.Text := Produto.Produto.DescricaoCupom;

  FView.EdtQuantidadeProduto.Text := '1,00';

  FView.lblNomeAdicionalTotal.Text := 'Adicionais: R$ 0,00';

  FView.EdtValorProduto.Text :=
    currtostrf(FProdutoSelecionado.Produto.PrecoVista, ffnumber, 2);

  if FConta.ContaCliente.ItensContaCliente.Count > 0 then
    Garcom := FConta.ContaCliente.ItensContaCliente
      [FConta.ContaCliente.ItensContaCliente.Count - 1].Garcom
  else
  begin
    Garcom := TVendedor.Create;
    Garcom.Codigo := DMConexao.Configuracao.VendedorPadrao.Codigo;
  end;

  FView.cbGarcom.Items.Clear;

  for I := 0 to FListaGarcom.Count - 1 do
  begin
    FView.cbGarcom.Items.Add(IntToStr(FListaGarcom.Items[I].Codigo) + ' - ' +
      FListaGarcom.Items[I].nome);
    if Garcom.Codigo = FListaGarcom.Items[I].Codigo then
      FView.cbGarcom.ItemIndex := I;
  end;

  limpaObservacoes;
  addObservacoes(FProdutoSelecionado.Produto);

  FView.retLancamentoProduto.Height := 315;

  FView.Label21.Align := TAlignLayout.None;
  FView.retObservacoes.Align := TAlignLayout.None;

  FView.Label21.Visible := True;
  FView.retObservacoes.Visible := True;

  if FListaObservacoes.Count = 0 then
  begin
    FView.retObservacoes.Visible := False;
    FView.Label21.Visible := False;
    FView.retLancamentoProduto.Height := 220;
  end;

  FView.retObservacoes.Align := TAlignLayout.Bottom;
  FView.Label21.Align := TAlignLayout.Bottom;

  limpaAdicionais;
  addAdicionais;

  if Assigned(FListaProdutosAdicionais) then
  begin
    if FListaProdutosAdicionais.Count = 0 then
    begin
      FView.retAddAdicionais.Visible := False;
      FView.retLancamentoProduto.Width := 497;
    end
    else
    begin
      FView.retAddAdicionais.Visible := True;
      FView.retLancamentoProduto.Width := 761;
    end;
  end
  else
  begin
    FView.retAddAdicionais.Visible := False;
    FView.retLancamentoProduto.Width := 497;
  end;

  FView.retLancamentoProduto.Position.X :=
    (FView.Width - FView.retLancamentoProduto.Width) / 2;
  FView.retLancamentoProduto.Position.Y :=
    (FView.Height - FView.retLancamentoProduto.Height) / 2;

  FView.retModalLancProduto.Visible := True;
  FView.retLancamentoProduto.Visible := True;

  Garcom := nil;

end;

procedure TFrmComandaController.onClickPagamentoParcial(Sender: TObject);
begin

  FPagamentoParcialSelecionado := FListaPagamentosParciais.Items
    [TRectangle(Sender).Tag];

  FView.retDeletaPagamentoParcial.Position.X :=
    (FView.Width - FView.retDeletaPagamentoParcial.Width) / 2;
  FView.retDeletaPagamentoParcial.Position.Y :=
    (FView.Height - FView.retDeletaPagamentoParcial.Height) / 2;

  FView.retDeletaPagamentoParcial.Visible := True;

  if FView.retPagamentoParcialValor.Visible then
    FView.retPagamentoParcialValor.Enabled := False
  else if FView.retInformacoesItemConta.Visible then
    FView.retInformacoesItemConta.Enabled := False;
end;

procedure TFrmComandaController.onClickS(Sender: TObject);
begin
  try

    FListaSecoes.Items[FListaSecoes.Count - 1].seleciona(False);

    if TRectangle(Sender).Tag <> 0 then
    begin
      buscaSecao(FView.retSelected.Parent.Tag).seleciona(False);
      FView.retSelected.Parent := TRectangle(Sender);
      buscaSecao(FView.retSelected.Parent.Tag).seleciona(True);
    end
    else
    begin
      buscaSecao(FView.retSelected.Parent.Tag).seleciona(False);
      FView.retSelected.Parent := TRectangle(Sender);
      buscaSecao(FView.retSelected.Parent.Tag).seleciona(True);
    end;

    addProdutos;
  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := DMConexao.Usuario.nome +
        ', não foi possível realizar a ação. Mensagem retornada: ' + E.Message +
        '. Class name: ' + E.ClassName;
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;
    end;
  end;
end;

procedure TFrmComandaController.onClickSecaoAddProduto(Sender: TObject);
var
  SecaoView: TSecaoView;
  I: Integer;
begin

  for I := 0 to FListaSecoes.Count - 1 do
    FListaSecoes.Items[I].seleciona(False);

  SecaoView := FListaSecoes.Items[FListaSecoes.Count - 1];
  SecaoView.seleciona(False);
  FView.retSelected.Parent := TRectangle(Sender);
  SecaoView.seleciona(True);

  limpaProdutos;
  FView.EdtBuscaProduto.Text := '';

  FView.retConsultaProduto.Position.X :=
    (FView.Width - FView.retConsultaProduto.Width) / 2;
  FView.retConsultaProduto.Position.Y :=
    (FView.Height - FView.retConsultaProduto.Height) / 2;

  FView.retConsultaProduto.Visible := True;
  FView.retModalLancProduto.Visible := True;

end;

procedure TFrmComandaController.Rectangle12Click;
begin
  FView.Rectangle12.Enabled := False;

  addFormasPagamentoPacialValor;

  FView.retLancPagamentoParcialValor.Position.X :=
    (FView.Width - FView.retLancPagamentoParcialValor.Width) / 2;
  FView.retLancPagamentoParcialValor.Position.Y :=
    (FView.Height - FView.retLancPagamentoParcialValor.Height) / 2;

  FView.retLancPagamentoParcialValor.Visible := True;
  FView.retPagamentoParcialValor.Enabled := False;

  FView.EdtLancPagParcialValor.Text := '';

  FView.Rectangle12.Enabled := True;
end;

procedure TFrmComandaController.Rectangle17Click;
begin
  DMConexao.mostraTeclado(FView, FView.EdtMesaTransferencia, False, 0);
end;

procedure TFrmComandaController.Rectangle43Click;
begin
  DMConexao.mostraTeclado(FView, FView.EdtLancPagParcialValor, True, 2);
end;

function TFrmComandaController.buscaAdministradoraCartao(Codigo: Integer)
  : TAdministradoraCartao;
var
  I: Integer;
begin
  Result := nil;

  if Assigned(FListaAdministradorasCartao) then
    for I := 0 to FListaAdministradorasCartao.Count - 1 do
      if FListaAdministradorasCartao.Items[I].Codigo = Codigo then
      begin
        Result := FListaAdministradorasCartao.Items[I];
        Break;
      end;
end;

function TFrmComandaController.buscaContaReceberCartaoVenda(FormaPagamento
  : TFormaPagamento): TContaReceberCartao;
var
  I: Integer;
begin

  Result := nil;

  if Assigned(FConta.ContaCliente.Venda) then
    if Assigned(FConta.ContaCliente.Venda.ContasReceberCartao) then
      for I := 0 to FConta.ContaCliente.Venda.ContasReceberCartao.Count - 1 do
        if FConta.ContaCliente.Venda.ContasReceberCartao.Items[I]
          .FormaPagamento.Codigo = FormaPagamento.Codigo then
        begin
          Result := FConta.ContaCliente.Venda.ContasReceberCartao.Items[I];
          Break;
        end;

end;

function TFrmComandaController.buscarBandeiraCartao(BandeiraCartao
  : TBandeiraCartao): TAdministradoraCartao;
var
  AdministradorasCartao: TObjectList<TAdministradoraCartao>;
  Y, I: Integer;
begin

  Result := nil;

  AdministradorasCartao := TAdministradoraCartaoDAO.getInstancia.buscaTodos;

  for I := 0 to AdministradorasCartao.Count - 1 do
  begin
    for Y := 0 to AdministradorasCartao.Items[I].BandeirasCartao.Count - 1 do
    begin
      if AdministradorasCartao.Items[I].BandeirasCartao.Items[Y]
        .Codigo = BandeiraCartao.Codigo then
      begin
        Result := AdministradorasCartao.Items[I];
        exit;
      end;
    end;
  end;

end;

function TFrmComandaController.retornaContaReceberCartao(ContasReceberCartao
  : TObjectList<TContaReceberCartao>;
  AdministradoraCartao: TAdministradoraCartao): TContaReceberCartao;
var
  I, Y: Integer;
begin
  Result := nil;
  for I := 0 to ContasReceberCartao.Count - 1 do
  begin
    for Y := 0 to AdministradoraCartao.BandeirasCartao.Count - 1 do
    begin
      if ContasReceberCartao.Items[I].BandeiraCartao.Codigo =
        AdministradoraCartao.BandeirasCartao.Items[Y].Codigo then
      begin
        Result := ContasReceberCartao.Items[I];
        Break;
      end;

    end;

    if Result <> nil then
      Break;
  end;
end;

function TFrmComandaController.retornaObservacao: String;
var
  I: Integer;
  Observacao: String;
begin
  Observacao := '';
  if Assigned(FListaObservacoes) then
    for I := 0 to FListaObservacoes.Count - 1 do
      if FListaObservacoes.Items[I].Selecionado then
        Observacao := Observacao + FListaObservacoes.Items[I]
          .Observacao.Descricao + '; ';

  Observacao := copy(Observacao, 1, Observacao.Length - 2);
  Result := Observacao;
end;

function TFrmComandaController.retornaProdutosComandaImpressora
  (Impressora: TImpressora): TObjectList<TItemContaCliente>;
var
  ItensContaCliente: TObjectList<TItemContaCliente>;
  I: Integer;
begin
  ItensContaCliente := TObjectList<TItemContaCliente>.Create;

  for I := 0 to FConta.ContaCliente.ItensContaCliente.Count - 1 do
  begin
    if FConta.ContaCliente.ItensContaCliente.Items[I].Cancelado = 0 then
    begin
      if FConta.ContaCliente.ItensContaCliente.Items[I].Impresso = 'N' then
      begin
        if FConta.ContaCliente.ItensContaCliente.Items[I]
          .Produto.Impressora.Codigo = Impressora.Codigo then
          ItensContaCliente.Add(FConta.ContaCliente.ItensContaCliente.Items[I]);
      end;
    end;
  end;

  Result := ItensContaCliente;
end;

procedure TFrmComandaController.addSecaoMaisUsado;
var
  Retangulo: TRectangle;
  SecaoView: TSecaoView;
begin
  Retangulo := TRectangle.Create(FView);
  Retangulo.Parent := FView.vRetSecoes;
  Retangulo.Fill.Color := TAlphaColors.White;
  Retangulo.Stroke.Color := TAlphaColors.White;
  Retangulo.Cursor := crHandPoint;
  Retangulo.Height := 60;
  Retangulo.Width := 120;
  Retangulo.Position.X := 1;
  Retangulo.Position.Y := 1;
  Retangulo.OnClick := onClickS;
  Retangulo.Tag := 0;
  FView.retSelected.Parent := Retangulo;
  FView.retSelected.Visible := True;
  SecaoView := TSecaoView.Create;
  SecaoView.Retangulo := Retangulo;

  SecaoView.Linha := TLine.Create(Retangulo);
  SecaoView.Linha.Align := TAlignLayout.Bottom;
  SecaoView.Linha.Parent := Retangulo;
  SecaoView.Linha.Size.Height := 1;
  SecaoView.Linha.Stroke.Color := TAlphaColors.Lightgray;

  SecaoView.LinhaDir := TLine.Create(Retangulo);
  SecaoView.LinhaDir.Align := TAlignLayout.Right;
  SecaoView.LinhaDir.Parent := Retangulo;
  SecaoView.LinhaDir.Size.Width := 1;
  SecaoView.LinhaDir.Stroke.Color := TAlphaColors.Lightgray;

  SecaoView.Effect := TInnerGlowEffect.Create(Retangulo);
  SecaoView.Effect.Parent := Retangulo;
  SecaoView.Effect.GlowColor := TAlphaColors.Black;
  SecaoView.Effect.Opacity := 0;
  SecaoView.Effect.Softness := 0;

  // SecaoView.seleciona(True);

  SecaoView.nome := TLabel.Create(Retangulo);
  SecaoView.nome.Parent := Retangulo;
  SecaoView.nome.Align := TAlignLayout.Client;
  SecaoView.nome.StyledSettings := [];
  SecaoView.nome.WordWrap := True;
  SecaoView.nome.Text := 'MAIS USADOS';
  SecaoView.nome.TextSettings.HorzAlign := TTextAlign.Center;
  SecaoView.nome.Cursor := crHandPoint;
  SecaoView.nome.TextSettings.FontColor := TAlphaColors.Black;
  SecaoView.nome.Tag := 0;
  SecaoView.nome.OnClick := Retangulo.OnClick;

  FView.vRetSecoes.AddObject(Retangulo);
  FListaSecoes.Add(SecaoView);
end;

procedure TFrmComandaController.addSecaoProdutoSelecionado(X, Y: Single);
var
  Retangulo: TRectangle;
  SecaoView: TSecaoView;
begin
  Retangulo := TRectangle.Create(FView);
  Retangulo.Parent := FView.vRetSecoes;
  Retangulo.Fill.Color := TAlphaColors.White;
  Retangulo.Stroke.Color := TAlphaColors.White;
  Retangulo.Cursor := crHandPoint;
  Retangulo.Height := 60;
  Retangulo.Width := 120;
  Retangulo.Position.X := X;
  Retangulo.Position.Y := Y;
  Retangulo.OnClick := onClickSecaoAddProduto;
  Retangulo.Tag := 0;
  SecaoView := TSecaoView.Create;
  SecaoView.Retangulo := Retangulo;

  SecaoView.Linha := TLine.Create(Retangulo);
  SecaoView.Linha.Align := TAlignLayout.Bottom;
  SecaoView.Linha.Parent := Retangulo;
  SecaoView.Linha.Size.Height := 1;
  SecaoView.Linha.Stroke.Color := TAlphaColors.Lightgray;

  SecaoView.LinhaDir := TLine.Create(Retangulo);
  SecaoView.LinhaDir.Align := TAlignLayout.Right;
  SecaoView.LinhaDir.Parent := Retangulo;
  SecaoView.LinhaDir.Size.Width := 1;
  SecaoView.LinhaDir.Stroke.Color := TAlphaColors.Lightgray;

  SecaoView.Effect := TInnerGlowEffect.Create(Retangulo);
  SecaoView.Effect.Parent := Retangulo;
  SecaoView.Effect.GlowColor := TAlphaColors.Black;
  SecaoView.Effect.Opacity := 0;
  SecaoView.Effect.Softness := 0;

  SecaoView.nome := TLabel.Create(Retangulo);
  SecaoView.nome.Parent := Retangulo;
  SecaoView.nome.Align := TAlignLayout.Client;
  SecaoView.nome.StyledSettings := [];
  SecaoView.nome.WordWrap := True;
  SecaoView.nome.Text := 'BUSCAR PRODUTO';
  SecaoView.nome.TextSettings.HorzAlign := TTextAlign.Center;
  SecaoView.nome.Cursor := crHandPoint;
  SecaoView.nome.TextSettings.FontColor := TAlphaColors.Black;
  SecaoView.nome.Tag := 0;
  SecaoView.nome.OnClick := Retangulo.OnClick;

  FView.vRetSecoes.AddObject(Retangulo);
  FListaSecoes.Add(SecaoView);
end;

function TFrmComandaController.totalAdicionais: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FListaProdutosAdicionais.Count - 1 do
    if FListaProdutosAdicionais.Items[I].Selecionado then
      Result := Result + (FListaProdutosAdicionais.Items[I].Produto.PrecoVista *
        FListaProdutosAdicionais.Items[I].Quantidade);
end;

end.
