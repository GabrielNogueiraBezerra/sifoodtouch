unit uConfiguracao;

interface

uses
  System.SysUtils, System.Classes, uCaixa, uEmpresa, IniFiles,
  FireDAC.Comp.Client, uProduto, uLocalEstoque, uTipoVenda,
  uVendedor, uCliente, uConexaoFiredac;

type
{$TYPEINFO ON}
  TConfiguracao = class
  private
    { Private declarations }

    FConnection: TConexaoFiredac;

    FHostBanco: String;
    FCaminhoBanco: String;
    FPortaBanco: String;
    FCaixa: TCaixa;
    FEmpresa: TEmpresa;
    FUsuario: String;
    FLocalAplicacao: String;
    FAcionarGuilhotina: Boolean;
    FImprimeCozinha: Boolean;
    FImprimeBalcao: Boolean;
    FItemConferenciaMesaEmUmaLinha: Boolean;
    FNomeArquivoIni: String;
    FBloqueiaMesaComConferencia: Boolean;
    FTaxaRestaurante: Currency;
    FValorTaxaEntregaRestaurante: Currency;
    FProdutoPadraoRestaurante: TProduto;
    FImprimirComandaPorProduto: Boolean;
    FImprimirObsComandaCozinha: Boolean;
    FImprimirObsComandaBalcao: Boolean;
    FImprimirReferenciaItemComandaCozinha: Boolean;
    FImprimirSetorCozinhaBalcao: Boolean;
    FImprimirNomeTodoProdutoCozinhaBar: Boolean;
    FModeloComanda: Integer;
    FUsaSetorImpressora: Boolean;
    FNomeGarcomConferenciaDetalhada: Boolean;
    FDiscriminarValorPorAdicionalRestante: Boolean;
    FSolicitaObsCancelComanda: Boolean;
    FVersaoSoftware: String;
    FSaidaEstoqueNegativo: Boolean;
    FEstoquePadrao: TLocalEstoque;
    FExisteModuloFiscal: Boolean;
    FLiberarMovimentacaoAposAbertura: Boolean;
    FClientePadrao: TCliente;
    FTipoVendaPadrao: TTipoVenda;
    FVendedorPadrao: TVendedor;
    FLiberaSistemaMensagensConfirmacao: Boolean;
    FLimpaMemoriaResidual: Boolean;
    FObrigarLancarNumeroAutorizacao: Boolean;
    FObrigarLancarParcelasCartao: Boolean;
    FTimeOutConsultaPOS: Integer;
    FConsultaPagamentoPOS: Boolean;
    FImprimirNomeOperador: Boolean;
    FInformarObservacaoVendaECF: Boolean;
    FImprimeNomeFantasiaExtratoCFE: Boolean;
    FImprimeRazaoSocialExtratoCFe: Boolean;
    FHomologacaoSI: Boolean;
    FCodigoCobranca: Integer;
    FDiasCarencia: Integer;
    FJurosAtraso: Currency;
    FValorMaximoVendaSemCPF: Currency;
    FUsaDadosMemoria: Boolean;
    FArredondaSimple: Boolean;
    FEscondeItensComanda: Boolean;
    FTempoAtualizarMesas: Integer;
    FCodigoClassificacao: Integer;
    FAdicionaMesCompletoGeracaoParcelas: Boolean;
    FLiberarTotalContasReceber: Boolean;
    FEfetuarRegistroProducaoVenda: Boolean;
    FLocalArquivosMfe: String;
    procedure SetCaixa(const Value: TCaixa);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetAcionarGuilhotina(const Value: Boolean);
    procedure SetImprimeCozinha(const Value: Boolean);
    procedure SetImprimeBalcao(const Value: Boolean);
    procedure SetItemConferenciaMesaEmUmaLinha(const Value: Boolean);
    procedure SetUsuario(const Value: String);
    procedure SetBloqueiaMesaComConferencia(const Value: Boolean);
    procedure SetProdutoPadraoRestaurante(const Value: TProduto);
    procedure SetTaxaRestaurante(const Value: Currency);
    procedure SetValorTaxaEntregaRestaurante(const Value: Currency);
    procedure SetImprimirComandaPorProduto(const Value: Boolean);
    procedure SeFModeloComanda(const Value: Integer);
    procedure SetImprimirNomeTodoProdutoCozinhaBar(const Value: Boolean);
    procedure SetImprimirObsComandaBalcao(const Value: Boolean);
    procedure SetImprimirObsComandaCozinha(const Value: Boolean);
    procedure SetImprimirReferenciaItemComandaCozinha(const Value: Boolean);
    procedure SetImprimirSetorCozinhaBalcao(const Value: Boolean);
    procedure SetUsaSetorImpressora(const Value: Boolean);
    procedure SetNomeGarcomConferenciaDetalhada(const Value: Boolean);
    procedure SetDiscriminarValorPorAdicionalRestante(const Value: Boolean);
    procedure SetSolicitaOBsCancelComanda(const Value: Boolean);
    procedure SetLocalAplicacao(const Value: String);
    procedure SetVersaoSoftware(const Value: String);
    procedure SetSaidaEstoqueNegativo(const Value: Boolean);
    procedure SetEstoquePadrao(const Value: TLocalEstoque);
    procedure SetExisteModuloFiscal(const Value: Boolean);
    procedure SetLiberarMovimentacaoAposAbertura(const Value: Boolean);
    procedure SetClientePadrao(const Value: TCliente);
    procedure SetTipoVendaPadrao(const Value: TTipoVenda);
    procedure SetVendedorPadrao(const Value: TVendedor);
    procedure SetLiberaSistemaMensagensConfirmacao(const Value: Boolean);
    procedure SetLimpaMemoriaResidual(const Value: Boolean);
    procedure SetObrigarLancarNumeroAutorizacao(const Value: Boolean);
    procedure SetObrigarLancarParcelasCartao(const Value: Boolean);
    procedure SetTimeOutConsultaPOS(const Value: Integer);
    procedure SetConsultaPagamentoPOS(const Value: Boolean);
    procedure SetImprimirNomeOperador(const Value: Boolean);
    procedure SetInformarObservacaoVendaECF(const Value: Boolean);
    procedure SetImprimeNomeFantasiaExtratoCFE(const Value: Boolean);
    procedure SetImprimeRazaoSocialExtratoCFe(const Value: Boolean);
    procedure SetHomologacaoSI(const Value: Boolean);
    procedure SetCodigoCobranca(const Value: Integer);
    procedure SetDiasCarencia(const Value: Integer);
    procedure SetJurosAtraso(const Value: Currency);
    procedure SetValorMaximoVendaSemCPF(const Value: Currency);
    procedure SetUsaDadosMemoria(const Value: Boolean);
    procedure SetFArredondaSimple(const Value: Boolean);
    procedure SetEscondeItensComanda(const Value: Boolean);
    procedure SetTempoAtualizarMesas(const Value: Integer);
    procedure SetCodigoClassificacao(const Value: Integer);
    procedure SetAdicionaMesCompletoGeracaoParcelas(const Value: Boolean);
    procedure SetLiberarTotalContasReceber(const Value: Boolean);
    procedure SetEfetuarRegistroProducaoVenda(const Value: Boolean);
    procedure setLocalArquivosMfe(const Value: String);
  protected
    { protected declarations }
  public
    { Public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;
    procedure GravaIni(sSecao, sVariavel, sValor: string);
    procedure ConectaBancoDados;
    procedure CarregaParametros(Empresa: TEmpresa);

    function LeIni(sSecao, sVariavel: string): string;
    function StrToBool(sString, sCompara: String): Boolean;
    function ExistePalavra(Texto: String; palavra: String): Boolean;

  published
    { published declarations }
    property HostBanco: String read FHostBanco;
    property VersaoSoftware: String read FVersaoSoftware
      write SetVersaoSoftware;
    property LocalAplicacao: String read FLocalAplicacao
      write SetLocalAplicacao;
    property Caixa: TCaixa read FCaixa write SetCaixa;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property Usuario: String read FUsuario write SetUsuario;
    property AcionarGuilhotina: Boolean read FAcionarGuilhotina
      write SetAcionarGuilhotina;
    property ImprimeCozinha: Boolean read FImprimeCozinha
      write SetImprimeCozinha;
    property ImprimeBalcao: Boolean read FImprimeBalcao write SetImprimeBalcao;
    property ItemConferenciaMesaEmUmaLinha: Boolean
      read FItemConferenciaMesaEmUmaLinha
      write SetItemConferenciaMesaEmUmaLinha;
    property BloqueiaMesaComConferencia: Boolean
      read FBloqueiaMesaComConferencia write SetBloqueiaMesaComConferencia;
    property TaxaRestaurante: Currency read FTaxaRestaurante
      write SetTaxaRestaurante;
    property ValorTaxaEntregaRestaurante: Currency
      read FValorTaxaEntregaRestaurante write SetValorTaxaEntregaRestaurante;
    property ProdutoPadraoRestaurante: TProduto read FProdutoPadraoRestaurante
      write SetProdutoPadraoRestaurante;
    property ImprimirComandaPorProduto: Boolean read FImprimirComandaPorProduto
      write SetImprimirComandaPorProduto;
    property ImprimirObsComandaCozinha: Boolean read FImprimirObsComandaCozinha
      write SetImprimirObsComandaCozinha;
    property ImprimirObsComandaBalcao: Boolean read FImprimirObsComandaBalcao
      write SetImprimirObsComandaBalcao;
    property ImprimirReferenciaItemComandaCozinha: Boolean
      read FImprimirReferenciaItemComandaCozinha
      write SetImprimirReferenciaItemComandaCozinha;
    property ImprimirSetorCozinhaBalcao: Boolean
      read FImprimirSetorCozinhaBalcao write SetImprimirSetorCozinhaBalcao;
    property ImprimirNomeTodoProdutoCozinhaBar: Boolean
      read FImprimirNomeTodoProdutoCozinhaBar
      write SetImprimirNomeTodoProdutoCozinhaBar;
    property ModeloComanda: Integer read FModeloComanda write SeFModeloComanda;
    property UsaSetorImpressora: Boolean read FUsaSetorImpressora
      write SetUsaSetorImpressora;
    property NomeGarcomConferenciaDetalhada: Boolean
      read FNomeGarcomConferenciaDetalhada
      write SetNomeGarcomConferenciaDetalhada;
    property DiscriminarValorPorAdicionalRestante: Boolean
      read FDiscriminarValorPorAdicionalRestante
      write SetDiscriminarValorPorAdicionalRestante;
    property SolicitaObsCancelComanda: Boolean read FSolicitaObsCancelComanda
      write SetSolicitaOBsCancelComanda;
    property SaidaEstoqueNegativo: Boolean read FSaidaEstoqueNegativo
      write SetSaidaEstoqueNegativo;
    property EstoquePadrao: TLocalEstoque read FEstoquePadrao
      write SetEstoquePadrao;
    property ExisteModuloFiscal: Boolean read FExisteModuloFiscal
      write SetExisteModuloFiscal;
    property LiberarMovimentacaoAposAbertura: Boolean
      read FLiberarMovimentacaoAposAbertura
      write SetLiberarMovimentacaoAposAbertura;
    property ClientePadrao: TCliente read FClientePadrao write SetClientePadrao;
    property TipoVendaPadrao: TTipoVenda read FTipoVendaPadrao
      write SetTipoVendaPadrao;
    property VendedorPadrao: TVendedor read FVendedorPadrao
      write SetVendedorPadrao;
    property LiberaSistemaMensagensConfirmacao: Boolean
      read FLiberaSistemaMensagensConfirmacao
      write SetLiberaSistemaMensagensConfirmacao;
    property LimpaMemoriaResidual: Boolean read FLimpaMemoriaResidual
      write SetLimpaMemoriaResidual;
    property ObrigarLancarNumeroAutorizacao: Boolean
      read FObrigarLancarNumeroAutorizacao
      write SetObrigarLancarNumeroAutorizacao;
    property ObrigarLancarParcelasCartao: Boolean
      read FObrigarLancarParcelasCartao write SetObrigarLancarParcelasCartao;
    property TimeOutConsultaPOS: Integer read FTimeOutConsultaPOS
      write SetTimeOutConsultaPOS;
    property ConsultaPagamentoPOS: Boolean read FConsultaPagamentoPOS
      write SetConsultaPagamentoPOS;
    property ImprimirNomeOperador: Boolean read FImprimirNomeOperador
      write SetImprimirNomeOperador;
    property InformarObservacaoVendaECF: Boolean
      read FInformarObservacaoVendaECF write SetInformarObservacaoVendaECF;
    property ImprimeNomeFantasiaExtratoCFE: Boolean
      read FImprimeNomeFantasiaExtratoCFE
      write SetImprimeNomeFantasiaExtratoCFE;
    property ImprimeRazaoSocialExtratoCFe: Boolean
      read FImprimeRazaoSocialExtratoCFe write SetImprimeRazaoSocialExtratoCFe;
    property HomologacaoSI: Boolean read FHomologacaoSI write SetHomologacaoSI;
    property CodigoCobranca: Integer read FCodigoCobranca
      write SetCodigoCobranca;
    property CodigoClassificacao: Integer read FCodigoClassificacao
      write SetCodigoClassificacao;
    property DiasCarencia: Integer read FDiasCarencia write SetDiasCarencia;
    property JurosAtraso: Currency read FJurosAtraso write SetJurosAtraso;
    property ValorMaximoVendaSemCPF: Currency read FValorMaximoVendaSemCPF
      write SetValorMaximoVendaSemCPF;
    property UsaDadosMemoria: Boolean read FUsaDadosMemoria
      write SetUsaDadosMemoria;
    property ArredondaSimple: Boolean read FArredondaSimple
      write SetFArredondaSimple;
    property EscondeItensComanda: Boolean read FEscondeItensComanda
      write SetEscondeItensComanda;
    property TempoAtualizarMesas: Integer read FTempoAtualizarMesas
      write SetTempoAtualizarMesas;
    property AdicionaMesCompletoGeracaoParcelas: Boolean
      read FAdicionaMesCompletoGeracaoParcelas
      write SetAdicionaMesCompletoGeracaoParcelas;
    property LiberarTotalContasReceber: Boolean read FLiberarTotalContasReceber
      write SetLiberarTotalContasReceber;
    property EfetuarRegistroProducaoVenda: Boolean
      read FEfetuarRegistroProducaoVenda write SetEfetuarRegistroProducaoVenda;
    property LocalArquivosMfe: String read FLocalArquivosMfe
      write setLocalArquivosMfe;
  end;

implementation

uses
  Vcl.Forms, uProdutoDAO, uLocalEstoqueDAO, uTipoVendaDAO, uVendedorDAO,
  uClienteDAO;

{ TConfiguracao }

procedure TConfiguracao.CarregaParametros(Empresa: TEmpresa);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        (' SELECT P.BLOQ_MESA_EMITIR_CONFERENCIA, P.TAXA_RESTAURANTE, P.VL_TAXA_ENTREGA_RESTAURANTE, '
        + 'P.COD_PROD_PADRAO, P.USAR_IMP_PROD_COMANDA_COZINHA, P.IMPRIMIR_OBS_COMANDA_COZINHA, '
        + 'P.IMPRIMIR_OBS_COMANDA_BALCAO, P.IMP_REF_ITEM_COMANDA_COZINHA, ' +
        'P.IMPRIME_SETOR_COZINHA_BALCAO, P.IMPRIME_NOME_TD_PRODUTO_COZ_BAR, ' +
        'P.MODELO_COMANDA, P.USAR_SETOR_COMANDAS_REST, P.IMP_NOME_GARCON_CONF_DETALHADA, '
        + 'P.DISCRIMINAR_VALOR_POR_ADIC_REST, P.SOLICITAR_OBS_CANCEL_COMANDA, P.SAIDAS_ESTOQUE_NEGATIVO,  '
        + 'P.CODIGO_LOCAL_ESTOQUE_VENDAS, P.VENDEDOR_PADRAO_VENDA, P.TIPO_VENDA_PADRAO_VENDA, '
        + 'P.CLIENTE_PADRAO_VENDA, P.NUM_AUT_CARTAO_OBRIGATORIO, P.OBRIGAR_LANC_PARC_ADM, '
        + 'P.IMPRIMIR_NOME_OPERADOR, P.INFORMAR_OBS_VENDA_ECF, P.CODIGO_COBRANCA, P.DIAS_CARENCIA '
        + ', P.JUROS_ATRASO, P.VALOR_MAX_VENDA_SEM_CPF, P.COD_CLA_PADRAO_CAD_CLI, '
        + 'P.ADIC_MES_COMPLETO_GERACAO_PARC, P.LIBERAR_CAMP_TOT_CONTAS_REC_SAT, '
        + 'P.EFETUAR_REG_PROD_VENDA FROM PARAMETROS P WHERE P.COD_EMP = :CODEMP ');
      FDQuery.ParamByName('CODEMP').AsInteger := Empresa.Codigo;
      FDQuery.Open;
      with FDQuery do
      begin
        FBloqueiaMesaComConferencia :=
          StrToBool(FieldByName('BLOQ_MESA_EMITIR_CONFERENCIA').AsString, 'S');

        FEfetuarRegistroProducaoVenda :=
          StrToBool(FieldByName('EFETUAR_REG_PROD_VENDA').AsString, 'S');

        FTaxaRestaurante := FieldByName('TAXA_RESTAURANTE').AsCurrency;
        FValorTaxaEntregaRestaurante :=
          FieldByName('VL_TAXA_ENTREGA_RESTAURANTE').AsCurrency;

        FProdutoPadraoRestaurante := TProduto.Create;
        FProdutoPadraoRestaurante.Codigo := FieldByName('COD_PROD_PADRAO')
          .AsInteger;
        TProdutoDAO.getInstancia.buscar(FProdutoPadraoRestaurante);

        FImprimirComandaPorProduto :=
          StrToBool(FieldByName('USAR_IMP_PROD_COMANDA_COZINHA').AsString, 'S');

        FImprimirObsComandaCozinha :=
          StrToBool(FieldByName('IMPRIMIR_OBS_COMANDA_COZINHA').AsString, 'S');

        FImprimirObsComandaBalcao :=
          StrToBool(FieldByName('IMPRIMIR_OBS_COMANDA_BALCAO').AsString, 'S');

        FImprimirReferenciaItemComandaCozinha :=
          StrToBool(FieldByName('IMP_REF_ITEM_COMANDA_COZINHA').AsString, 'S');

        FImprimirSetorCozinhaBalcao :=
          StrToBool(FieldByName('IMPRIME_SETOR_COZINHA_BALCAO').AsString, 'S');

        FImprimirNomeTodoProdutoCozinhaBar :=
          StrToBool(FieldByName('IMPRIME_NOME_TD_PRODUTO_COZ_BAR')
          .AsString, 'S');

        FModeloComanda := FieldByName('MODELO_COMANDA').AsInteger;

        FNomeGarcomConferenciaDetalhada :=
          StrToBool(FieldByName('IMP_NOME_GARCON_CONF_DETALHADA')
          .AsString, 'S');

        FDiscriminarValorPorAdicionalRestante :=
          StrToBool(FieldByName('DISCRIMINAR_VALOR_POR_ADIC_REST')
          .AsString, 'N');

        FSolicitaObsCancelComanda :=
          StrToBool(FieldByName('SOLICITAR_OBS_CANCEL_COMANDA').AsString, 'S');

        FSaidaEstoqueNegativo :=
          StrToBool(FieldByName('SAIDAS_ESTOQUE_NEGATIVO').AsString, 'S');

        FEstoquePadrao.Codigo := FieldByName('CODIGO_LOCAL_ESTOQUE_VENDAS')
          .AsInteger;

        TLocalEstoqueDAO.getInstancia.buscar(FEstoquePadrao);

        FClientePadrao.Codigo := FieldByName('CLIENTE_PADRAO_VENDA').AsInteger;
        TClienteDAO.getInstancia.buscar(FClientePadrao);

        FTipoVendaPadrao.Codigo := FieldByName('TIPO_VENDA_PADRAO_VENDA')
          .AsInteger;

        FVendedorPadrao.Codigo := FieldByName('VENDEDOR_PADRAO_VENDA')
          .AsInteger;

        TTipoVendaDAO.getInstancia.buscar(FTipoVendaPadrao);

        TVendedorDAO.getInstancia.buscar(FVendedorPadrao);
        FObrigarLancarNumeroAutorizacao :=
          StrToBool(FieldByName('NUM_AUT_CARTAO_OBRIGATORIO').AsString, 'S');

        FObrigarLancarParcelasCartao :=
          StrToBool(FieldByName('OBRIGAR_LANC_PARC_ADM').AsString, 'S');

        FImprimirNomeOperador := StrToBool(FieldByName('IMPRIMIR_NOME_OPERADOR')
          .AsString, 'S');

        FInformarObservacaoVendaECF :=
          StrToBool(FieldByName('INFORMAR_OBS_VENDA_ECF').AsString, 'S');

        FCodigoCobranca := FieldByName('CODIGO_COBRANCA').AsInteger;
        FCodigoClassificacao := FieldByName('COD_CLA_PADRAO_CAD_CLI').AsInteger;

        FDiasCarencia := FieldByName('DIAS_CARENCIA').AsInteger;
        FJurosAtraso := FieldByName('JUROS_ATRASO').AsCurrency;
        FValorMaximoVendaSemCPF := FieldByName('VALOR_MAX_VENDA_SEM_CPF')
          .AsCurrency;

        FAdicionaMesCompletoGeracaoParcelas :=
          StrToBool(FieldByName('ADIC_MES_COMPLETO_GERACAO_PARC')
          .AsString, 'S');

        FLiberarTotalContasReceber :=
          StrToBool(FieldByName('LIBERAR_CAMP_TOT_CONTAS_REC_SAT')
          .AsString, 'S');

      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
  end;
end;

procedure TConfiguracao.Clear;
begin
  FHostBanco := '';
  FCaminhoBanco := '';
  FPortaBanco := '';
  FreeAndNil(FCaixa);
  FreeAndNil(FEmpresa);
  FUsuario := '';
  FAcionarGuilhotina := false;
  FImprimeCozinha := false;
  FImprimeCozinha := false;
  FItemConferenciaMesaEmUmaLinha := false;
  FNomeArquivoIni := '';
  FLocalAplicacao := '';
  FVersaoSoftware := '';
end;

procedure TConfiguracao.ConectaBancoDados;
begin
  try
    FConnection.getInstancia.functionGetConfiguration('FB', 'ReadWrite',
      FHostBanco, FCaminhoBanco, 'SYSDBA', 'masterkey',
      StrtoIntDef(FPortaBanco, 3050));
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;

end;

constructor TConfiguracao.Create;
begin

  FConnection := TConexaoFiredac.getInstancia;

  Clear;

  FVersaoSoftware := '19.3';

  { Nome do meu arquivo de configuração }
  FNomeArquivoIni := '\CnfComercio.ini';

  { pasta da minha aplicação }
  FLocalAplicacao := ExtractFilePath(Application.ExeName);

  { Busco as informações inerentes a conexão com o banco de dados }
  FHostBanco := LeIni('ConfiguracaoLocal', 'HostBanco');
  FCaminhoBanco := LeIni('ConfiguracaoLocal', 'CaminhoBanco');
  FPortaBanco := LeIni('ConfiguracaoLocal', 'PortaBanco');

  try
    FAcionarGuilhotina := self.StrToBool(LeIni('ConfiguracaoLocal',
      'AcionarGuilhotina'), 'S');
  except
    FAcionarGuilhotina := false;
    GravaIni('ConfiguracaoLocal', 'AcionarGuilhotina', 'N');
  end;

  try
    FImprimeCozinha := self.StrToBool(LeIni('ConfiguracaoLocal',
      'ImprimeCozinha'), 'S');
  except
    FImprimeCozinha := false;
    GravaIni('ConfiguracaoLocal', 'ImprimeCozinha', 'N');
  end;

  try
    FImprimeBalcao := self.StrToBool(LeIni('ConfiguracaoLocal',
      'ImprimeBalcao'), 'S');
  except
    FImprimeBalcao := false;
    GravaIni('ConfiguracaoLocal', 'ImprimeBalcao', 'N');
  end;

  try
    FLiberaSistemaMensagensConfirmacao :=
      self.StrToBool(LeIni('ConfiguracaoLocal',
      'LiberaSistemaMensagensConfirmacao'), 'S');
  except
    FLiberaSistemaMensagensConfirmacao := false;
    GravaIni('ConfiguracaoLocal', 'LiberaSistemaMensagensConfirmacao', 'N');
  end;

  try
    FLiberarMovimentacaoAposAbertura :=
      self.StrToBool(LeIni('ConfiguracaoLocal',
      'LiberarMovAposAbertCaixa'), '1');
  except
    FLiberarMovimentacaoAposAbertura := false;
    GravaIni('ConfiguracaoLocal', 'LiberarMovAposAbertCaixa', '0');
  end;

  try
    FLimpaMemoriaResidual := self.StrToBool(LeIni('ConfiguracaoLocal',
      'LimpaMemoriaResidual'), '1');
  except
    FLimpaMemoriaResidual := false;
    GravaIni('ConfiguracaoLocal', 'LimpaMemoriaResidual', '0');
  end;

  try
    FItemConferenciaMesaEmUmaLinha :=
      self.StrToBool(LeIni('ConfiguracaoLocal',
      'ItemConferenciaMesaEmUmaLinha'), '1');
  except
    FItemConferenciaMesaEmUmaLinha := false;
    GravaIni('ConfiguracaoLocal', 'ItemConferenciaMesaEmUmaLinha', '0');
  end;

  try
    FExisteModuloFiscal := self.StrToBool(LeIni('ConfiguracaoLocal',
      'ExisteImagemModuloFiscal'), 'S');
  except
    FExisteModuloFiscal := false;
    GravaIni('ConfiguracaoLocal', 'ExisteImagemModuloFiscal', 'N');
  end;

  { Adição da empreasa e caixa no sistema }
  FCaixa := TCaixa.Create;
  FCaixa.Codigo := StrToInt(LeIni('ConfiguracaoLocal', 'Caixa'));
  FUsuario := LeIni('ConfiguracaoLocal', 'Usuario');

  try
    FTimeOutConsultaPOS :=
      StrToInt(LeIni('CONFIGURACOES_POS', 'TIMEOUT_CONSULTA'));
  except
    FTimeOutConsultaPOS := 10;
    GravaIni('CONFIGURACOES_POS', 'TIMEOUT_CONSULTA', '10');
  end;

  try
    FConsultaPagamentoPOS := self.StrToBool(LeIni('CONFIGURACOES_POS',
      'CONSULTA_PAGAMENTO'), 'S');
  except
    FConsultaPagamentoPOS := false;
    GravaIni('CONFIGURACOES_POS', 'CONSULTA_PAGAMENTO', 'N');
  end;

  try
    FImprimeNomeFantasiaExtratoCFE :=
      self.StrToBool(LeIni('ConfiguracaoLocal',
      'ImprimirNomeFantasiaExtratoCFe'), '1');
  except
    FConsultaPagamentoPOS := false;
    GravaIni('ConfiguracaoLocal', 'ImprimirNomeFantasiaExtratoCFe', '0');
  end;

  try
    FHomologacaoSI := self.StrToBool(LeIni('ConfiguracaoLocal',
      'HomologacaoSI'), '1');
  except
    FHomologacaoSI := false;
    GravaIni('ConfiguracaoLocal', 'HomologacaoSI', '0');
  end;

  try
    FImprimeRazaoSocialExtratoCFe :=
      self.StrToBool(LeIni('ConfiguracaoLocal',
      'ImprimirRazaoSocialExtratoCFe'), '1');
  except
    FImprimeRazaoSocialExtratoCFe := false;
    GravaIni('ConfiguracaoLocal', 'ImprimirRazaoSocialExtratoCFe', '0');
  end;

  try
    FUsaDadosMemoria := self.StrToBool(LeIni('ConfiguracaoLocal',
      'UsaDadosMemoria'), 'S');
  except
    FUsaDadosMemoria := false;
    GravaIni('ConfiguracaoLocal', 'UsaDadosMemoria', 'N');
  end;

  try
    FArredondaSimple := self.StrToBool(LeIni('ConfiguracaoLocal',
      'ArredondaSimple'), 'S');
  except
    FArredondaSimple := false;
    GravaIni('ConfiguracaoLocal', 'ArredondaSimple', 'N');
  end;

  try
    FEscondeItensComanda := self.StrToBool(LeIni('ConfiguracaoLocal',
      'EscondeItensComanda'), 'S');
  except
    FEscondeItensComanda := false;
    GravaIni('ConfiguracaoLocal', 'EscondeItensComanda', 'N');
  end;

  try
    FTempoAtualizarMesas :=
      StrToInt(LeIni('ConfiguracaoLocal', 'TempoAtualizarMesas'));
  except
    FTempoAtualizarMesas := 30;
    GravaIni('ConfiguracaoLocal', 'TempoAtualizarMesas', '30');
  end;

  try
    FLocalArquivosMfe := LeIni('ConfiguracaoLocal', 'LocalArquivosMFe');
  except
    FLocalArquivosMfe := ExtractFilePath(ParamStr(0));
  end;

  FEstoquePadrao := TLocalEstoque.Create;

  FTipoVendaPadrao := TTipoVenda.Create;
  FVendedorPadrao := TVendedor.Create;
  FClientePadrao := TCliente.Create;
end;

destructor TConfiguracao.Destroy;
begin
  inherited;
  self.Clear;
end;

function TConfiguracao.ExistePalavra(Texto, palavra: String): Boolean;
var
  I: Integer;
  reg: String;
begin
  for I := 1 to Length(Texto) do
  begin
    if reg = palavra then
    begin
      Break;
      Result := True;
    end;
    reg := reg + Texto[I];
    if Texto[I] = ' ' then
      reg := '';
  end;
  if reg = palavra then
    Result := True
  else
    Result := false;
end;

procedure TConfiguracao.GravaIni(sSecao, sVariavel, sValor: string);
var
  ArqIni: TIniFile;
begin
  ArqIni := TIniFile.Create(FLocalAplicacao + FNomeArquivoIni);

  try
    ArqIni.WriteString(sSecao, sVariavel, sValor);
  finally
    ArqIni.Free;
  end;
end;

function TConfiguracao.LeIni(sSecao, sVariavel: string): string;
var
  ArqIni: TIniFile;
  sString: string;
begin
  ArqIni := TIniFile.Create(FLocalAplicacao + FNomeArquivoIni);

  try
    Result := trim(ArqIni.ReadString(sSecao, sVariavel, sString));
  finally
    ArqIni.Free;
  end;
end;

procedure TConfiguracao.SeFModeloComanda(const Value: Integer);
begin
  FModeloComanda := Value;
end;

procedure TConfiguracao.SetAcionarGuilhotina(const Value: Boolean);
begin
  FAcionarGuilhotina := Value;
end;

procedure TConfiguracao.SetAdicionaMesCompletoGeracaoParcelas
  (const Value: Boolean);
begin
  FAdicionaMesCompletoGeracaoParcelas := Value;
end;

procedure TConfiguracao.SetBloqueiaMesaComConferencia(const Value: Boolean);
begin
  FBloqueiaMesaComConferencia := Value;
end;

procedure TConfiguracao.SetCaixa(const Value: TCaixa);
begin
  FCaixa := Value;
end;

procedure TConfiguracao.SetClientePadrao(const Value: TCliente);
begin
  FClientePadrao := Value;
end;

procedure TConfiguracao.SetCodigoClassificacao(const Value: Integer);
begin
  FCodigoClassificacao := Value;
end;

procedure TConfiguracao.SetCodigoCobranca(const Value: Integer);
begin
  FCodigoCobranca := Value;
end;

procedure TConfiguracao.SetConsultaPagamentoPOS(const Value: Boolean);
begin
  FConsultaPagamentoPOS := Value;
end;

procedure TConfiguracao.SetDiasCarencia(const Value: Integer);
begin
  FDiasCarencia := Value;
end;

procedure TConfiguracao.SetDiscriminarValorPorAdicionalRestante
  (const Value: Boolean);
begin
  FDiscriminarValorPorAdicionalRestante := Value;
end;

procedure TConfiguracao.SetEfetuarRegistroProducaoVenda(const Value: Boolean);
begin
  FEfetuarRegistroProducaoVenda := Value;
end;

procedure TConfiguracao.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TConfiguracao.SetEscondeItensComanda(const Value: Boolean);
begin
  FEscondeItensComanda := Value;
end;

procedure TConfiguracao.SetEstoquePadrao(const Value: TLocalEstoque);
begin
  FEstoquePadrao := Value;
end;

procedure TConfiguracao.SetExisteModuloFiscal(const Value: Boolean);
begin
  FExisteModuloFiscal := Value;
end;

procedure TConfiguracao.SetFArredondaSimple(const Value: Boolean);
begin
  FArredondaSimple := Value;
end;

procedure TConfiguracao.SetHomologacaoSI(const Value: Boolean);
begin
  FHomologacaoSI := Value;
end;

procedure TConfiguracao.SetImprimeBalcao(const Value: Boolean);
begin
  FImprimeBalcao := Value;
end;

procedure TConfiguracao.SetImprimeCozinha(const Value: Boolean);
begin
  FImprimeCozinha := Value;
end;

procedure TConfiguracao.SetImprimeNomeFantasiaExtratoCFE(const Value: Boolean);
begin
  FImprimeNomeFantasiaExtratoCFE := Value;
end;

procedure TConfiguracao.SetImprimeRazaoSocialExtratoCFe(const Value: Boolean);
begin
  FImprimeRazaoSocialExtratoCFe := Value;
end;

procedure TConfiguracao.SetImprimirComandaPorProduto(const Value: Boolean);
begin
  FImprimirComandaPorProduto := Value;
end;

procedure TConfiguracao.SetImprimirNomeOperador(const Value: Boolean);
begin
  FImprimirNomeOperador := Value;
end;

procedure TConfiguracao.SetImprimirNomeTodoProdutoCozinhaBar
  (const Value: Boolean);
begin
  FImprimirNomeTodoProdutoCozinhaBar := Value;
end;

procedure TConfiguracao.SetImprimirObsComandaBalcao(const Value: Boolean);
begin
  FImprimirObsComandaBalcao := Value;
end;

procedure TConfiguracao.SetImprimirObsComandaCozinha(const Value: Boolean);
begin
  FImprimirObsComandaCozinha := Value;
end;

procedure TConfiguracao.SetImprimirReferenciaItemComandaCozinha
  (const Value: Boolean);
begin
  FImprimirReferenciaItemComandaCozinha := Value;
end;

procedure TConfiguracao.SetImprimirSetorCozinhaBalcao(const Value: Boolean);
begin
  FImprimirSetorCozinhaBalcao := Value;
end;

procedure TConfiguracao.SetInformarObservacaoVendaECF(const Value: Boolean);
begin
  FInformarObservacaoVendaECF := Value;
end;

procedure TConfiguracao.SetItemConferenciaMesaEmUmaLinha(const Value: Boolean);
begin
  FItemConferenciaMesaEmUmaLinha := Value;
end;

procedure TConfiguracao.SetJurosAtraso(const Value: Currency);
begin
  FJurosAtraso := Value;
end;

procedure TConfiguracao.SetLiberarMovimentacaoAposAbertura
  (const Value: Boolean);
begin
  FLiberarMovimentacaoAposAbertura := Value;
end;

procedure TConfiguracao.SetLiberarTotalContasReceber(const Value: Boolean);
begin
  FLiberarTotalContasReceber := Value;
end;

procedure TConfiguracao.SetLiberaSistemaMensagensConfirmacao
  (const Value: Boolean);
begin
  FLiberaSistemaMensagensConfirmacao := Value;
end;

procedure TConfiguracao.SetLimpaMemoriaResidual(const Value: Boolean);
begin
  FLimpaMemoriaResidual := Value;
end;

procedure TConfiguracao.SetLocalAplicacao(const Value: String);
begin
  FLocalAplicacao := Value;
end;

procedure TConfiguracao.setLocalArquivosMfe(const Value: String);
begin
  FLocalArquivosMfe := Value;
end;

procedure TConfiguracao.SetNomeGarcomConferenciaDetalhada(const Value: Boolean);
begin
  FNomeGarcomConferenciaDetalhada := Value;
end;

procedure TConfiguracao.SetObrigarLancarNumeroAutorizacao(const Value: Boolean);
begin
  FObrigarLancarNumeroAutorizacao := Value;
end;

procedure TConfiguracao.SetObrigarLancarParcelasCartao(const Value: Boolean);
begin
  FObrigarLancarParcelasCartao := Value;
end;

procedure TConfiguracao.SetProdutoPadraoRestaurante(const Value: TProduto);
begin
  FProdutoPadraoRestaurante := Value;
end;

procedure TConfiguracao.SetSaidaEstoqueNegativo(const Value: Boolean);
begin
  FSaidaEstoqueNegativo := Value;
end;

procedure TConfiguracao.SetSolicitaOBsCancelComanda(const Value: Boolean);
begin
  FSolicitaObsCancelComanda := Value;
end;

procedure TConfiguracao.SetTaxaRestaurante(const Value: Currency);
begin
  FTaxaRestaurante := Value;
end;

procedure TConfiguracao.SetTempoAtualizarMesas(const Value: Integer);
begin
  FTempoAtualizarMesas := Value;
end;

procedure TConfiguracao.SetTimeOutConsultaPOS(const Value: Integer);
begin
  FTimeOutConsultaPOS := Value;
end;

procedure TConfiguracao.SetTipoVendaPadrao(const Value: TTipoVenda);
begin
  FTipoVendaPadrao := Value;
end;

procedure TConfiguracao.SetUsaDadosMemoria(const Value: Boolean);
begin
  FUsaDadosMemoria := Value;
end;

procedure TConfiguracao.SetUsaSetorImpressora(const Value: Boolean);
begin
  FUsaSetorImpressora := Value;
end;

procedure TConfiguracao.SetUsuario(const Value: String);
begin
  FUsuario := Value;
end;

procedure TConfiguracao.SetValorMaximoVendaSemCPF(const Value: Currency);
begin
  FValorMaximoVendaSemCPF := Value;
end;

procedure TConfiguracao.SetValorTaxaEntregaRestaurante(const Value: Currency);
begin
  FValorTaxaEntregaRestaurante := Value;
end;

procedure TConfiguracao.SetVendedorPadrao(const Value: TVendedor);
begin
  FVendedorPadrao := Value;
end;

procedure TConfiguracao.SetVersaoSoftware(const Value: String);
begin
  FVersaoSoftware := Value;
end;

function TConfiguracao.StrToBool(sString, sCompara: String): Boolean;
begin
  Result := false;
  if sString = sCompara then
    Result := True;
end;

end.
