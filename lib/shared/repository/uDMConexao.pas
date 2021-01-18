unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt, Data.DB,
  FireDAC.Comp.Client, uConfiguracao, uUsuario, FMX.ListBox,
  uEmpresa, DateUtils, ACBrBase, ACBrPosPrinter, uContaCliente,
  uFrmTecladoAlphaNumeric, uFrmTecladoNumeric, System.Threading, Vcl.AppEvnts,
  ACBrNFeDANFeESCPOS, ACBrDFeReport, ACBrDFeDANFeReport, ACBrNFeDANFEClass,
  ACBrDANFCeFortesFr, ACBrDFe, ACBrNFe, ACBrIntegrador,
  ACBrSATExtratoReportClass, ACBrSATExtratoFortesFr, ACBrSATExtratoClass,
  ACBrSATExtratoESCPOS, ACBrSAT, uClass, ACBrUtil, ACBrBAL,
  uProduto, System.Generics.Collections, uPOS, FMX.Objects, FMX.StdCtrls,
  Vcl.ExtCtrls, uContaReceber, uCliente, uObservable, uObserver;

type
  TDMConexao = class(TDataModule, ITObservable)
    FAcbrPosPrinter: TACBrPosPrinter;
    ACBrNFe: TACBrNFe;
    ACBrNFeDANFeESCPOS: TACBrNFeDANFeESCPOS;
    ACBrSAT: TACBrSAT;
    ACBrSATExtratoESCPOS: TACBrSATExtratoESCPOS;
    ACBrBAL: TACBrBAL;
    ACBrSATExtratoFortes: TACBrSATExtratoFortes;
    ACBrIntegrador: TACBrIntegrador;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ACBrSATGetNumeroSessao(var NumeroSessao: Integer);
    procedure ACBrSATGetcodigoDeAtivacao(var Chave: AnsiString);
    procedure ACBrSATGetsignAC(var Chave: AnsiString);
  private
    { Private declarations }
    FConfiguracao: TConfiguracao;
    FUsuario: TUsuario;
    FEmpresa: TEmpresa;
    FLimpaMemoriaResidual: ITask;
    FTempoMemoriaResidual: Boolean;
    FCarregaProdutos: ITask;
    FNumeroSessao: Integer;
    FTimer: TTimer;
    FObservers: TList<ITObserver>;

    procedure NotifyAll;

    procedure SetConfiguracao(const Value: TConfiguracao);
    procedure SetUsuario(const Value: TUsuario);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure TrimAppMemorySize;
    procedure SetNumeroSessao(const Value: Integer);
    function GetBuildInfo: string;
    function GetFileList(const Path: string): TStringList;
    function GetFileDate(Arquivo: String): String;
    function LeIniSat(sSecao, sVariavel: string): string;
    procedure SetTimer(const Value: TTimer);

  public
    { Public declarations }
    FTempoAtualizaMesas: Boolean;
    FSistemaAberto: Boolean;

    procedure Attach(Observer: ITObserver);
    procedure Dettach(Observer: ITObserver);
    procedure AbreTela(Tela: String);

    function Criptografa(palavra: string): string;
    function DesCriptografa(palavra: string): string;
    function calculatempo(DataInicial: TDateTime; DataFinal: TDateTime): String;
    function RemoveChar(const Texto: string): string;
    function CalcularTaxaServico(cTotalMesa: currency; Fconta: TContaCliente)
      : currency;
    function mensagem(mensagem: String; Tipo: Integer): Integer;
    function senha(mensagem: String): Integer;
    function cpf(num: String): Boolean;
    function cnpj(s: String): Boolean;
    function validaGTIN(AGTIN: String): Boolean;
    function RemoveAcento(Str: String): String;
    function RetornaUltimoArquivo(const Path, Extensao: String): String;
    function adicionaMes(Const dData: TDateTime; const Months: Extended)
      : TDateTime;

    procedure addListEmpresasUsuario(listaEmpresas: TListBox);
    procedure selecionaEmpresa(ItemIndex: Integer);
    procedure configuraFiscal;
    procedure entrar(Nome, senha: String);
    procedure carregaParametros;
    procedure carregaProdutos;
    procedure mostraTeclado(Tela: TObject; Campo: TObject;
      CampoProximo: TObject); overload;
    procedure mostraTeclado(Tela: TObject; Campo: TObject; UsaVirgula: Boolean;
      QuantidadePosVirgula: Integer); overload;
    procedure configuraImpressora(sImpressora: String);

    function totalPOS: currency;

    function IsInteger(Value: String): Boolean;

  class var
    TecladoAlphaNumeric: TFrmTecladoAlphaNumeric;
    TecladoNumeric: TFrmTecladoNumeric;
    FProdutos: TObjectList<TProduto>;
    FPagamentosPOS: TObjectList<TPOS>;
    FLabelStatusEnvioFiscal: TLabel;
    FListaContasReceber: TObjectList<TContaReceber>;
    FCliente: TCliente;
  published
    { published declarations }
    property Configuracao: TConfiguracao read FConfiguracao
      write SetConfiguracao;
    property Usuario: TUsuario read FUsuario write SetUsuario;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property NumeroSessao: Integer read FNumeroSessao write SetNumeroSessao;
    property Timer: TTimer read FTimer write SetTimer;
  end;

var
  DMConexao: TDMConexao;

const
  Caractere: array [1 .. 106] of Char = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
    'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '!', '#',
    '$', '%', '&', '/', '(', ')', '=', '?', '>', '^', '@', '£', '§', '{', '[',
    ']', '}', '´', '<', '~', '+', '*', '`', '''', 'ª', 'º', '¢', '-', '_', ',',
    '.', ';', ':', '|', '\', '¹', '²', '³', '¬', '°', '¨', ' ', 'a', 'b', 'c',
    'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
    's', 't', 'u', 'v', 'w', 'x', 'y', 'z');

const
  Subst: array [1 .. 106] of string = ('!9@8', '@7!7', '#4$5', '$5%4', '%8$8',
    '^1%1', '&3^5', '*7&6', '(6*6', ')3(3', '-2)8', '=1-7', '+0-9', '/0@1',
    '\9$7', '!3@2', '@3&6', '#1*4', '$2#4', '%6(8', '^9!5', '&4=4', '*3@4',
    '(8*4', ')4!7', '-0^5', '=1@9', '+2!0', '/8%2', '\7@5', '!3@7', '@4!8',
    '#7&4', '$6$3', '%2&7', '^1*3', '&1@0', '*3$9', '#3^1', '!4-2', '&6(5',
    '!5@8', ')7!8', '4&1-', 'a2$1', '*9z6', '@7c3', '1%^5', '0&*6', '$5^6',
    '!18)', '(38)', '@30&', '#69]', '[70]', '{26}', '-93#', 'l52h', 'h71i',
    'w80&', '%50%', '#401', '@87-', 'b46x', 'r55^', '!2*2', 'o08y', '&89)',
    '%03%', '\59q', 't85*', '^29-', '@02%', '#99)', '#255', '@23~', '~91t',
    '6%4n', '~5a1', '0=+0', 'Za*a', '%yB-', 'Xc#C', 'wl#d', 'V*@e', '&UF)',
    '!tG$', '-sh@', '%rij', '%QJ)', '%pk&', '@oL*', '!nm=', '!MN*', '@lO-',
    '$kpy', 'Ojq;', ':Ir-', 'h:;s', 'Gx%T', 'f}{U', 'E#tv', 'd1W+', '&cxk',
    'pby$', 'aZ()');

implementation

uses
  uUsuarioDAO, FMX.Forms, uFrmMensagem, uCaixaDAO, Winapi.Windows,
  uFrmLiberaSenha, ACBrSATClass, pcnConversao, System.IniFiles, uProdutoDAO,
  Vcl.Dialogs;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDMConexao }

procedure TDMConexao.AbreTela(Tela: String);
begin

end;

procedure TDMConexao.ACBrSATGetcodigoDeAtivacao(var Chave: AnsiString);
begin
  Chave := Configuracao.Caixa.CodigoAtivacaoSat;
end;

procedure TDMConexao.ACBrSATGetNumeroSessao(var NumeroSessao: Integer);
begin
  FNumeroSessao := NumeroSessao;
end;

procedure TDMConexao.ACBrSATGetsignAC(var Chave: AnsiString);
begin
  Chave := Configuracao.Caixa.AssinaturaSWHouseSat;
end;

procedure TDMConexao.addListEmpresasUsuario(listaEmpresas: TListBox);
var
  I: Integer;
begin
  listaEmpresas.Clear;
  if Assigned(FUsuario) then
  begin
    FUsuario.Empresas.First;
    for I := 0 to FUsuario.Empresas.Count - 1 do
      listaEmpresas.Items.Add(FUsuario.Empresas.Items[I].Fantasia);
  end;
end;

function TDMConexao.adicionaMes(const dData: TDateTime; const Months: Extended)
  : TDateTime;
  function IsBisexto(ano: word): Boolean;
  begin
    Result := (ano mod 4 = 0) and ((ano mod 100 <> 0) or (ano mod 400 = 0));
  end;

var
  Dia, mes, ano: word;
  iMes: Integer;
begin
  DecodeDate(dData, ano, mes, Dia);
  iMes := mes + Trunc(Months);

  if iMes > 12 then
  begin
    ano := ano + (iMes - 1) div 12;
    iMes := iMes mod 12;
    if iMes = 0 then
      iMes := 12;
  end
  else if iMes < 1 then
  begin
    ano := ano + (iMes div 12) - 1;
    iMes := 12 - Abs(iMes) mod 12;
  end;
  mes := iMes;

  // Ensure Day of Month is valid
  if mes = 2 then
  begin
    if IsBisexto(ano) and (Dia > 29) then
      Dia := 29
    else if not IsBisexto(ano) and (Dia > 28) then
      Dia := 28;
  end
  else if (mes in [9, 4, 6, 11]) and (Dia = 31) then
    Dia := 30;

  if Months < 0 then
    Result := encodedate(ano, mes, Dia) - Frac(Abs(Months)) * 30 - Frac(dData)
  else
    Result := encodedate(ano, mes, Dia) + Frac(Months) * 30 + Frac(dData);
end;

procedure TDMConexao.Attach(Observer: ITObserver);
begin
  if Assigned(Observer) then
  begin
    if not(Assigned(FObservers)) then
      FObservers := TList<ITObserver>.create;

    FObservers.Add(Observer);
  end;
end;

function TDMConexao.CalcularTaxaServico(cTotalMesa: currency;
  Fconta: TContaCliente): currency;
var
  cTaxaServico: currency;
  iServicoPadrao: Integer;
begin
  Result := 0;
  cTaxaServico := 0;
  iServicoPadrao := 0;

  if cTotalMesa > 0 then
  begin
    if Fconta.VendaDelivery.Trim = 'S' then
    begin
      if Fconta.TaxaServicoCobrada > 0 then
        cTaxaServico := Fconta.TaxaServicoCobrada
      else
        cTaxaServico := DMConexao.Configuracao.ValorTaxaEntregaRestaurante;

      iServicoPadrao := DMConexao.Configuracao.ProdutoPadraoRestaurante.Codigo;

      if (cTaxaServico > 0) and (iServicoPadrao > 0) then
        Result := cTaxaServico;
    end
    else
    begin
      cTaxaServico := DMConexao.Configuracao.TaxaRestaurante;
      iServicoPadrao := DMConexao.Configuracao.ProdutoPadraoRestaurante.Codigo;

      if (cTaxaServico > 0) and (iServicoPadrao > 0) then
        Result := cTotalMesa * (cTaxaServico / 100)
    end;
  end;
end;

function TDMConexao.calculatempo(DataInicial, DataFinal: TDateTime): String;
var
  valor, dias, horas, minutos, segundos: Integer;
begin
  valor := (SecondsBetween(DataInicial, DataFinal));
  horas := valor div 3600;
  minutos := valor div 60 - horas * 60;
  segundos := (valor - (horas * 3600 + minutos * 60)) + 1;

  dias := horas div 24;
  horas := horas mod 24;

  if dias > 0 then
    Result := Format('%0.2d %0.2d:%0.2d', [dias, horas, minutos])
  else
    Result := Format('%0.2d:%0.2d', [horas, minutos])

end;

procedure TDMConexao.carregaParametros;
begin
  Configuracao.carregaParametros(Empresa);

  carregaProdutos;

end;

procedure TDMConexao.carregaProdutos;
begin
  if DMConexao.Configuracao.UsaDadosMemoria then
    FProdutos := TProdutoDAO.getInstancia.buscarTodos;
end;

function TDMConexao.cnpj(s: String): Boolean;
var
  soma, dg1, dg2: Integer;
  X: shortint;
  aux: string[1];
  aux_cnpj: string[14];
begin
  if (s = '') or (s = '  .   .   /    -  ') then
  begin
    Result := True;
    exit;
  end
  else if (s = '00000000000000') then
  begin
    Result := false;
    exit;
  end;

  X := 1;
  aux_cnpj := '';
  while X < 19 do
  begin
    aux := copy(s, X, 1);
    if ((aux <> '.') and (aux <> '/') and (aux <> '-')) then
      aux_cnpj := aux_cnpj + aux;
    X := X + 1;
  end;
  s := aux_cnpj;
  soma := 0;
  inc(soma, (strtointdef(s[1], 0) * 5));
  inc(soma, (strtointdef(s[2], 0) * 4));
  inc(soma, (strtointdef(s[3], 0) * 3));
  inc(soma, (strtointdef(s[4], 0) * 2));
  inc(soma, (strtointdef(s[5], 0) * 9));
  inc(soma, (strtointdef(s[6], 0) * 8));
  inc(soma, (strtointdef(s[7], 0) * 7));
  inc(soma, (strtointdef(s[8], 0) * 6));
  inc(soma, (strtointdef(s[9], 0) * 5));
  inc(soma, (strtointdef(s[10], 0) * 4));
  inc(soma, (strtointdef(s[11], 0) * 3));
  inc(soma, (strtointdef(s[12], 0) * 2));

  dg1 := soma - ((soma div 11) * 11);

  if dg1 <= 1 then
    dg1 := 0
  else
    dg1 := 11 - dg1;

  soma := 0;
  soma := soma + strtointdef(s[1], 0) * 6;
  soma := soma + strtointdef(s[2], 0) * 5;
  soma := soma + strtointdef(s[3], 0) * 4;
  soma := soma + strtointdef(s[4], 0) * 3;
  soma := soma + strtointdef(s[5], 0) * 2;
  soma := soma + strtointdef(s[6], 0) * 9;
  soma := soma + strtointdef(s[7], 0) * 8;
  soma := soma + strtointdef(s[8], 0) * 7;
  soma := soma + strtointdef(s[9], 0) * 6;
  soma := soma + strtointdef(s[10], 0) * 5;
  soma := soma + strtointdef(s[11], 0) * 4;
  soma := soma + strtointdef(s[12], 0) * 3;
  soma := soma + 2 * dg1;

  dg2 := soma - ((soma div 11) * 11);

  if dg2 <= 1 then
    dg2 := 0
  else
    dg2 := 11 - dg2;

  if (inttostr(dg1) = s[13]) and (inttostr(dg2) = s[14]) then
    Result := True
  else
    Result := false;
end;

procedure TDMConexao.configuraFiscal;
var
  listaArq: TStringList;
  I: Integer;
  dataArq: String;
  wideChars: array [0 .. 11] of WideChar;
begin

  case Configuracao.Caixa.TipoCaixa of
    opSAT:
      begin
        with ACBrSAT do
        begin
          Modelo := TACBrSATModelo(strtoint(LeIniSat('SAT', 'Ligacao')));
          ArqLOG := Configuracao.LocalArquivosMfe + '\Retorno\SatLog.log';
          NomeDLL := LeIniSat('SAT', 'NomeDLL');
          Config.ide_numeroCaixa := Configuracao.Caixa.NumeroCaixa;

          if Configuracao.Caixa.AmbienteSat = opHomologacao then
          begin
            Config.ide_CNPJ := '10615281000140';
            // Desenvolvimento
            Config.emit_CNPJ := '30832338000170'; // Desenvolvimento
            Config.emit_IE := '1234567890'; // Desenvolvimento
            Config.emit_IM := '111111'; // Desenvolvimento
          end
          else
          begin
            Config.ide_CNPJ := '12509168000106';
            Config.emit_CNPJ := Configuracao.Caixa.R01CnpjUsuario;
            Config.emit_IE := Configuracao.Caixa.R01IeUsuario;

            if Config.emit_CNPJ.Trim = '' then
              Config.emit_CNPJ := Configuracao.Empresa.cnpj;

            if Config.emit_IE.Trim = '' then
              Config.emit_IE := Configuracao.Empresa.InscricaoEstadual;

            Config.emit_IM := Configuracao.Empresa.InscricaoMunicipal;
          end;

          if (Configuracao.Empresa.TipoEmpresa = opLucroReal) or
            (Configuracao.Empresa.TipoEmpresa = opLucroPresumido) then
            Config.emit_cRegTrib := RTRegimeNormal
          else
            Config.emit_cRegTrib := RTSimplesNacional;

          Config.emit_cRegTribISSQN :=
            TpcnRegTribISSQN(Configuracao.Empresa.RegimeTributadoISSQN);

          Config.emit_indRatISSQN :=
            TpcnindRatISSQN(Configuracao.Empresa.IndiceRatISSQN);

          Config.PaginaDeCodigo := 65001;
          Config.EhUTF8 := True;
          Config.infCFe_versaoDadosEnt :=
            StringToFloat(Configuracao.Caixa.VersaoSat);

          ConfigArquivos.SalvarCFe := True;
          ConfigArquivos.PastaCFeVenda := Configuracao.LocalArquivosMfe +
            '\Retorno\CFeVenda';
          ConfigArquivos.SalvarCFeCanc := True;
          ConfigArquivos.PastaCFeCancelamento := Configuracao.LocalArquivosMfe +
            '\Retorno\CFeCancelamento';
          ConfigArquivos.SalvarEnvio := True;
          ConfigArquivos.PastaEnvio := Configuracao.LocalArquivosMfe +
            '\Retorno\CFeEnvio';
          ConfigArquivos.SepararPorCNPJ := True;
          ConfigArquivos.SepararPorMes := True;

          if Trim(LeIniSat('Fortes', 'UsarForts')) = 'S' then
          begin
            ACBrSAT.Extrato := ACBrSATExtratoFortes;
            ACBrSATExtratoFortes.LarguraBobina :=
              strtoint(LeIniSat('Fortes', 'Largura'));
            ACBrSATExtratoFortes.MargemSuperior :=
              strtoint(LeIniSat('Fortes', 'MargemTopo'));
            ACBrSATExtratoFortes.MargemInferior :=
              strtoint(LeIniSat('Fortes', 'MargemFundo'));
            ACBrSATExtratoFortes.MargemEsquerda :=
              strtoint(LeIniSat('Fortes', 'MargemEsquerda'));
            ACBrSATExtratoFortes.MargemDireita :=
              strtoint(LeIniSat('Fortes', 'MargemDireita'));
            ACBrSATExtratoFortes.MostraPreview :=
              Trim(LeIniSat('Fortes', 'Preview')) = 'S';

            try
              if Trim(LeIniSat('Fortes', 'Name')) <> '' then
                ACBrSATExtratoFortes.NomeDocumento :=
                  Trim(LeIniSat('Fortes', 'Name'));
            except
            end;
          end
          else
          begin
            ACBrSAT.Extrato := ACBrSATExtratoESCPOS;
            ACBrSATExtratoESCPOS.ImprimeEmUmaLinha :=
              Trim(LeIniSat('PosPrinter', 'ImprimirItemUmaLinha')) = 'S';
          end;

          ACBrSAT.Extrato.PictureLogo.LoadFromFile
            (Trim(LeIniSat('Empresa', 'LogoMarca')));

          if Trim(LeIniSat('Empresa', 'LogoMarca')) = '' then
            ACBrSAT.Extrato.ImprimeLogoLateral := false
          else
            ACBrSAT.Extrato.ImprimeLogoLateral := True;

          ACBrSAT.Extrato.ImprimeQRCode :=
            Trim(LeIniSat('Empresa', 'ImprimeQRCode')) = 'S';
          ACBrSAT.Extrato.ImprimeQRCodeLateral :=
            Trim(LeIniSat('Empresa', 'ImprimeQRCodeLateral')) = 'S';
          ACBrSAT.Extrato.Sistema := 'SIFOODT ' + GetBuildInfo;
        end;
      end;
    opNFCe:
      begin
      end;
    opMFE:
      begin
        if Configuracao.HomologacaoSI then
          Configuracao.Caixa.AssinaturaSWHouseSat :=
            'CODIGO DE VINCULACAO AC DO MFE-CFE';
        with ACBrSAT do
        begin
          if TACBrSATModelo(strtoint(LeIniSat('SAT', 'Ligacao'))) = mfe_Integrador_XML
          then
          begin
            Integrador := ACBrIntegrador;
            ACBrIntegrador.ArqLOG := Configuracao.LocalArquivosMfe +
              '\Retorno\MFELog.log';
            ACBrIntegrador.PastaInput :=
              Trim(Configuracao.Caixa.CaminhoInputMfe);
            ACBrIntegrador.PastaOutput :=
              Trim(Configuracao.Caixa.CaminhoOutputMfe);
            ACBrIntegrador.Timeout := 10;
          end;

          Modelo := TACBrSATModelo(strtoint(LeIniSat('SAT', 'Ligacao')));
          NomeDLL := LeIniSat('SAT', 'NomeDLL');
          ArqLOG := Configuracao.LocalArquivosMfe + '\Retorno\MFELog.log';
          Config.ide_numeroCaixa := Configuracao.Caixa.NumeroCaixa;

          if fileexists(ACBrIntegrador.ArqLOG) then
            deletefile(StringToWideChar(ACBrIntegrador.ArqLOG, wideChars, 12));

          if fileexists(ArqLOG) then
            deletefile(StringToWideChar(ArqLOG, wideChars, 12));

          if Configuracao.Caixa.AmbienteSat = opProducao then
            Config.ide_tpAmb := taProducao
          else
            Config.ide_tpAmb := taHomologacao;

          if Configuracao.HomologacaoSI then
          begin
            Config.ide_CNPJ := '10615281000140';
            // Desenvolvimento
            Config.emit_CNPJ := '30832338000170'; // Desenvolvimento
            Config.emit_IE := '1234567890'; // Desenvolvimento
            Config.emit_IM := '111111'; // Desenvolvimento
          end
          else
          begin
            Config.ide_CNPJ := '12509168000106';

            Config.emit_CNPJ := Configuracao.Caixa.R01CnpjUsuario;
            Config.emit_IE := Configuracao.Caixa.R01IeUsuario;

            if Trim(Config.emit_CNPJ) = '' then
              Config.emit_CNPJ := Configuracao.Empresa.cnpj;

            if Trim(Config.emit_IE) = '' then
              Config.emit_IE := Configuracao.Empresa.InscricaoEstadual;

            Config.emit_IM := Configuracao.Empresa.InscricaoMunicipal;
          end;

          if Configuracao.Empresa.TipoEmpresa in [opLucroReal, opLucroPresumido]
          then
            Config.emit_cRegTrib := RTRegimeNormal
          else
            Config.emit_cRegTrib := RTSimplesNacional;

          Config.emit_cRegTribISSQN :=
            TpcnRegTribISSQN(Configuracao.Empresa.RegimeTributadoISSQN);
          Config.emit_indRatISSQN :=
            TpcnindRatISSQN(Configuracao.Empresa.IndiceRatISSQN);
          Config.PaginaDeCodigo := 65001;
          Config.EhUTF8 := True;
          Config.infCFe_versaoDadosEnt :=
            StringToFloat(Trim(Configuracao.Caixa.VersaoSat));

          ACBrSAT.ConfigArquivos.SalvarCFe := True;
          ACBrSAT.ConfigArquivos.PastaCFeVenda := Configuracao.LocalArquivosMfe
            + 'Retorno\CFeVenda';
          ConfigArquivos.SalvarCFeCanc := True;
          ACBrSAT.ConfigArquivos.PastaCFeCancelamento :=
            Configuracao.LocalArquivosMfe + 'Retorno\CFeCancelamento';
          ConfigArquivos.SalvarEnvio := True;
          ConfigArquivos.PastaEnvio := Configuracao.LocalArquivosMfe +
            'Retorno\CFeEnvio';
          ConfigArquivos.SepararPorCNPJ := True;
          ConfigArquivos.SepararPorMes := True;

          if Trim(LeIniSat('Fortes', 'UsarFortes')) = 'S' then
          begin
            Extrato := ACBrSATExtratoFortes;
            ACBrSATExtratoFortes.ACBrSAT := ACBrSAT;
            ACBrSATExtratoFortes.LarguraBobina :=
              strtoint(LeIniSat('Fortes', 'Largura'));
            ACBrSATExtratoFortes.MargemSuperior :=
              strtoint(LeIniSat('Fortes', 'MargemTopo'));
            ACBrSATExtratoFortes.MargemInferior :=
              strtoint(LeIniSat('Fortes', 'MargemFundo'));
            ACBrSATExtratoFortes.MargemEsquerda :=
              strtoint(LeIniSat('Fortes', 'MargemEsquerda'));
            ACBrSATExtratoFortes.MargemDireita :=
              strtoint(LeIniSat('Fortes', 'MargemDireita'));
            ACBrSATExtratoFortes.MostraPreview :=
              Trim(LeIniSat('Fortes', 'Preview')) = 'S';

            try
              if Trim(LeIniSat('Fortes', 'Name')) <> '' then
                ACBrSATExtratoFortes.NomeDocumento :=
                  Trim(LeIniSat('Fortes', 'Name'));
            except
            end;
          end
          else
          begin
            Extrato := ACBrSATExtratoESCPOS;
            ACBrSATExtratoESCPOS.ACBrSAT := ACBrSAT;
            ACBrSATExtratoESCPOS.ImprimeQRCode := True;
            ACBrSATExtratoESCPOS.ImprimeEmUmaLinha :=
              Trim(LeIniSat('PosPrinter', 'ImprimirItemUmaLinha')) = 'S';
          end;

          ACBrSAT.Extrato.ImprimeQRCode :=
            Trim(LeIniSat('Empresa', 'ImprimeQRCode')) = 'S';
          ACBrSAT.Extrato.ImprimeQRCodeLateral :=
            Trim(LeIniSat('Empresa', 'ImprimeQRCodeLateral')) = 'S';

          if Trim(LeIniSat('Empresa', 'LogoMarca')) = '' then
            ACBrSAT.Extrato.ImprimeLogoLateral := false
          else
            ACBrSAT.Extrato.ImprimeLogoLateral := True;

          if ACBrSAT.Extrato.ImprimeLogoLateral then
            Extrato.PictureLogo.LoadFromFile
              (Trim(LeIniSat('Empresa', 'LogoMarca')));

          Extrato.Sistema := 'SIFOODT ' + GetBuildInfo;
        end;

        { Prepara Lista de Arquivos }
        listaArq := TStringList.create;
        listaArq := GetFileList(Configuracao.Caixa.PastaOutputMFE + '\*.xml');

        for I := 0 to listaArq.Count - 1 do
        begin
          dataArq := GetFileDate(Configuracao.Caixa.PastaOutputMFE + '\' +
            listaArq[I]);
          dataArq := FormatDateTime('dd/mm/yyyy', StrToDateTime(dataArq));
          if StrToDate(dataArq) < date then
          begin
            deletefile(PChar(Configuracao.Caixa.PastaOutputMFE + '\' +
              listaArq[I]));
          end;
        end;
      end;
  end;

  configuraImpressora('PADRAO');

  if not(Configuracao.Empresa.TipoEmpresa in [opLucroReal, opSimplesNacional,
    opSimplesNacionalEx, opLucroPresumido]) then
  begin
    raise Exception.create('Inconsistência no arquivo de configuração!' + #13 +
      'Por favor, entre em contato com o suporte técnico.');
    Application.Terminate;
  end;

  if (Configuracao.Caixa.TipoCaixa = opSAT) or
    ((Configuracao.Caixa.TipoCaixa = opMFE) and
    Configuracao.Caixa.ComunicaIntegracaoCaixa) then
  begin

    try
      ACBrSAT.Inicializado := True;
    except
      on E: Exception do
      begin

        showmessage(E.Message);
        if Assigned(Usuario) then
          raise Exception.create(Usuario.Nome +
            ', Não Foi Possível Conectar com o SAT/MFE.' + slinebreak +
            'Mensagem Retornada: ' + E.Message)
        else
          raise Exception.create('Não Foi Possível Conectar com o SAT / MFE.' +
            slinebreak + 'Mensagem Retornada: ' + E.Message);
      end;
    end;
  end;
end;

procedure TDMConexao.configuraImpressora(sImpressora: String);
begin
  Try
    if Trim(sImpressora) = 'PADRAO' then // Configuração do Criptografa
    begin
      FAcbrPosPrinter.Desativar;
      FAcbrPosPrinter.Modelo := TACBrPosPrinterModelo
        (strtoint(LeIniSat('PosPrinter', 'Modelo')));

      FAcbrPosPrinter.PaginaDeCodigo :=
        TACBrPosPaginaCodigo(strtoint(LeIniSat('PosPrinter',
        'PaginaDeCodigo')));
      FAcbrPosPrinter.Porta := Trim(LeIniSat('PosPrinter', 'Porta'));
      FAcbrPosPrinter.Device.ParamsString :=
        LeIniSat('PosPrinter', 'ParamsString');
      FAcbrPosPrinter.ColunasFonteNormal :=
        strtoint(LeIniSat('PosPrinter', 'Colunas'));
      FAcbrPosPrinter.LinhasEntreCupons :=
        strtoint(LeIniSat('PosPrinter', 'LinhasEntreCupons'));
      FAcbrPosPrinter.EspacoEntreLinhas :=
        strtoint(LeIniSat('PosPrinter', 'EspacoLinhas'));
      FAcbrPosPrinter.LinhasBuffer := 0;
      FAcbrPosPrinter.ControlePorta :=
        Trim(LeIniSat('PosPrinter', 'ControlePorta')) = 'S';
      FAcbrPosPrinter.TraduzirTags := True;
      FAcbrPosPrinter.IgnorarTags :=
        Trim(LeIniSat('PosPrinter', 'IgnorarTagsFormatacao')) = 'S';
      FAcbrPosPrinter.IgnorarTags := false;
      FAcbrPosPrinter.ConfigBarras.MostrarCodigo := false;
      FAcbrPosPrinter.ConfigBarras.LarguraLinha := 0;
      FAcbrPosPrinter.ConfigBarras.Altura := 0;
      FAcbrPosPrinter.ConfigQRCode.Tipo := 2;
      FAcbrPosPrinter.ConfigQRCode.LarguraModulo := 4;
      FAcbrPosPrinter.ConfigQRCode.ErrorLevel := 0;
      FAcbrPosPrinter.ConfigLogo.KeyCode1 := 48;
      FAcbrPosPrinter.ConfigLogo.KeyCode2 := 48;
      FAcbrPosPrinter.ConfigLogo.FatorX := 1;
      FAcbrPosPrinter.ConfigLogo.FatorY := 1;

      FAcbrPosPrinter.CortaPapel :=
        Trim(LeIniSat('PosPrinter', 'CortarPapel')) = 'S';

      FAcbrPosPrinter.ConfigGaveta.SinalInvertido :=
        Configuracao.StrToBool(Configuracao.Caixa.SinalInvertidoGaveta, 'S');

    end
    else // Configuração do ConfiguraIMP
    begin
      FAcbrPosPrinter.Desativar;

      FAcbrPosPrinter.Modelo := TACBrPosPrinterModelo
        (strtoint(Configuracao.LeIni('Impressora' + sImpressora, 'Modelo')));

      FAcbrPosPrinter.PaginaDeCodigo :=
        TACBrPosPaginaCodigo
        (strtoint(Configuracao.LeIni('Impressora' + sImpressora,
        'PaginaDeCodigo')));

      FAcbrPosPrinter.Porta :=
        Trim(Configuracao.LeIni('Impressora' + sImpressora, 'Porta'));

      FAcbrPosPrinter.Device.ParamsString :=
        DesCriptografa(Configuracao.LeIni('Impressora' + sImpressora,
        'ParamsString'));

      FAcbrPosPrinter.ColunasFonteNormal :=
        strtoint(Configuracao.LeIni('Impressora' + sImpressora, 'Colunas'));

      FAcbrPosPrinter.EspacoEntreLinhas :=
        strtoint(Configuracao.LeIni('Impressora' + sImpressora,
        'EspacoEntreLinhas'));

      FAcbrPosPrinter.ControlePorta :=
        Trim(Configuracao.LeIni('Impressora' + sImpressora,
        'ControlePorta')) = '1';

      FAcbrPosPrinter.CortaPapel :=
        Trim(Configuracao.LeIni('Impressora' + sImpressora,
        'CortarPapel')) = '1';
    end;
  Except

  End;

end;

function TDMConexao.cpf(num: String): Boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9: Integer;
  d1, d2: Integer;
  digitado, calculado: string;
begin
  if Trim(num) = '' then
  begin
    Result := false;
    exit;
  end
  else if (num = '00000000000') then
  begin
    Result := false;
    exit;
  end;

  n1 := strtoint(num[1]);
  n2 := strtoint(num[2]);
  n3 := strtoint(num[3]);
  n4 := strtoint(num[4]);
  n5 := strtoint(num[5]);
  n6 := strtoint(num[6]);
  n7 := strtoint(num[7]);
  n8 := strtoint(num[8]);
  n9 := strtoint(num[9]);
  d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 * 9
    + n1 * 10;
  d1 := 11 - (d1 mod 11);
  if d1 >= 10 then
    d1 := 0;
  d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 +
    n2 * 10 + n1 * 11;
  d2 := 11 - (d2 mod 11);
  if d2 >= 10 then
    d2 := 0;
  calculado := inttostr(d1) + inttostr(d2);
  digitado := num[10] + num[11];
  if calculado = digitado then
    Result := True
  else
    Result := false;
end;

function TDMConexao.Criptografa(palavra: string): string;
var
  I, Y: Integer;
  PalavraCriptografada: string; // variável auxiliar
begin
  Y := 0;
  I := 0;
  PalavraCriptografada := '';
  for I := 1 to length(palavra) do
    for Y := 1 to 106 do
      if (palavra[I] = Caractere[Y]) then
        PalavraCriptografada := PalavraCriptografada + Subst[Y];
  Result := PalavraCriptografada;
end;

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  FTempoMemoriaResidual := True;
  FConfiguracao := TConfiguracao.create;
  FreeAndNil(FUsuario);
  TecladoAlphaNumeric := nil;
  TecladoNumeric := nil;
  FSistemaAberto := True;

  FLimpaMemoriaResidual := TTask.create(
    procedure
    begin
      while FTempoMemoriaResidual do
      begin
        sleep(1000);
        TrimAppMemorySize;
      end;
    end);

  if FConfiguracao.LimpaMemoriaResidual then
    FLimpaMemoriaResidual.Start;

  try
    FConfiguracao.ConectaBancoDados;
  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTitulo := 'Conexão ao banco de dados';
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := 'Não foi possível iniciar o sistema! ' + #13
        + 'Verifique as seguintes opções: ' + #13 +
        'O computador está conectado a alguma rede?' + #13 +
        'O computador está conectado na mesma rede do servidor?' + #13 +
        'O computador servidor está ativo?' + #13 +
        'Em caso de duvidas entre em contato com o suporte técnico através dos números: (88) 3423-5757 / (88) 99746-4056 / (88) 99854-1085'
        + #13 + 'O sistema será encerrado.';
      FrmMensagem.ShowModal;
      Application.Terminate;
      exit;
    end;
  end;

  try
    TCaixaDAO.getInstancia.buscarCaixaCadastrado(FConfiguracao.Caixa);
  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTitulo := 'Configuração de caixa';
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := 'O seu caixa não está cadastrado!' + #13 +
        'Entre em contato com o setor de suporte para configurar o caixa.';
      FrmMensagem.ShowModal;
      Application.Terminate;
      exit;
    end;
  end;

  { if TEmpresaDAO.getInstancia.versaoSistema <> FConfiguracao.VersaoSoftware then
    begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTitulo := 'Versão do Sistema';
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento :=
    'A versão da aplicação não é compatível com a versão do banco de dados! '
    + #13 + 'Versão atual do banco de dados: ' +
    TEmpresaDAO.getInstancia.versaoSistema + #13 +
    'Versão solicitada pelo sistema: ' + FConfiguracao.VersaoSoftware + #13 +
    'Para continuar usando o sistema, por favor atualize o sistema ou entre em '
    + 'contato com o suporte técnico através dos números abaixo: ' + #13 +
    '(88) 3423-5596 / (88) 99746-4056 / (88) 99854-1085 / (88) 99987-0918';
    FrmMensagem.ShowModal;
    Application.Terminate;
    exit;
    end; }

end;

procedure TDMConexao.DataModuleDestroy(Sender: TObject);
begin
  FTempoMemoriaResidual := false;
  FSistemaAberto := false;

  if Assigned(FUsuario) then
    Configuracao.GravaIni('ConfiguracaoLocal', 'Usuario', FUsuario.Nome);
end;

function TDMConexao.DesCriptografa(palavra: string): string;
var
  I, Y, iProximoGrupoPalavras: Integer;
  PalavraDescriptografada: string;
begin
  Result := '';
  Y := 0;
  iProximoGrupoPalavras := 0;
  I := 0;
  PalavraDescriptografada := '';
  for I := 1 to length(palavra) do
  begin
    for Y := 1 to 106 do
      if (copy(palavra, iProximoGrupoPalavras + 1, 4) = Subst[Y]) then
        PalavraDescriptografada := PalavraDescriptografada + Caractere[Y];
    inc(iProximoGrupoPalavras, 4);
  end;
  Result := PalavraDescriptografada;
end;

procedure TDMConexao.Dettach(Observer: ITObserver);
var
  I, Posicao: Integer;
begin
  if (Assigned(Observer)) and (Assigned(FObservers)) then
  begin
    FObservers.Remove(Observer);

    if FObservers.Count = 0 then
      FreeAndNil(FObservers);
  end;
end;

procedure TDMConexao.entrar(Nome, senha: String);
begin
  if Assigned(FUsuario) then
    FUsuario := nil;

  FUsuario := TUsuario.create;
  FUsuario.Nome := Nome;
  FUsuario.senha := senha;

  FUsuario := TUsuarioDAO.getInstancia.buscar(FUsuario);

  if FUsuario = nil then
    raise Exception.create('Usuário ou senha incorretos.');

  NotifyAll;
end;

function TDMConexao.GetBuildInfo: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: word;
  Prog: string;
begin
  Prog := ParamStr(0);
  VerInfoSize := GetFileVersionInfoSize(PChar(Prog), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(Prog), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);

  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;

  FreeMem(VerInfo, VerInfoSize);
  Result := copy(inttostr(100 + V1), 3, 2) + '.' + copy(inttostr(100 + V2), 3,
    2) + '.' + copy(inttostr(100 + V3), 3, 2) + '.' +
    copy(inttostr(100 + V4), 3, 2);
end;

function TDMConexao.GetFileDate(Arquivo: String): String;
var
  FHandle: Integer;
begin
  FHandle := FileOpen(Arquivo, 0);
  try
    Result := DateTimeToStr(FileDateToDateTime(FileGetDate(FHandle)));
  finally
    FileClose(FHandle);
  end;
end;

function TDMConexao.GetFileList(const Path: string): TStringList;
var
  I: Integer;
  SearchRec: TSearchRec;
begin
  Result := TStringList.create;
  try
    I := FindFirst(Path, 0, SearchRec);
    while I = 0 do
    begin
      Result.Add(SearchRec.Name);
      I := FindNext(SearchRec);
      Application.ProcessMessages;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TDMConexao.IsInteger(Value: String): Boolean;
var
  nr: Integer;
  c: Integer;
begin
  val(Value, nr, c);
  if c = 0 then
    Result := True
  else
    Result := false;
end;

function TDMConexao.LeIniSat(sSecao, sVariavel: string): string;
var
  ArqIni: tIniFile;
  sString: string;
begin

  ArqIni := tIniFile.create(ExtractFilePath(ParamStr(0)) + 'SAT.SI');

  try
    Result := DesCriptografa(ArqIni.ReadString(sSecao, sVariavel, sString));
  finally
    ArqIni.Free;
  end;
end;

function TDMConexao.mensagem(mensagem: String; Tipo: Integer): Integer;
var
  Value: Integer;
begin

  if Configuracao.LiberaSistemaMensagensConfirmacao then
    Result := 6
  else
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := Tipo;
    FrmMensagem.FProcedimento := mensagem;
    FrmMensagem.FTitulo := 'Atenção!';
    Value := FrmMensagem.ShowModal;

    Result := Value;
  end;
end;

procedure TDMConexao.mostraTeclado(Tela, Campo: TObject; UsaVirgula: Boolean;
QuantidadePosVirgula: Integer);
begin

  if Assigned(TecladoAlphaNumeric) then
  begin
    TecladoAlphaNumeric.close;
    TecladoAlphaNumeric := nil;
  end;

  if Assigned(TecladoNumeric) then
  begin
    TecladoNumeric.close;
    TecladoNumeric := nil;
  end;

  TecladoNumeric := TFrmTecladoNumeric.create(nil);
  TecladoNumeric.FEditor := Campo;
  TecladoNumeric.FTela := Tela;
  TecladoNumeric.FUsaVirgula := UsaVirgula;
  TecladoNumeric.FNumeroVirgula := QuantidadePosVirgula;
  if Tela is TForm then
    TecladoNumeric.parent := TForm(Tela)
  else if Tela is TFrame then
    TecladoNumeric.parent := TFrame(Tela).parent;

  TecladoNumeric.show;
end;

procedure TDMConexao.NotifyAll;
var
  I: Integer;
begin
  if Assigned(FObservers) then
    for I := 0 to FObservers.Count - 1 do
      FObservers.Items[I].Update;
end;

procedure TDMConexao.mostraTeclado(Tela, Campo, CampoProximo: TObject);
begin

  if Assigned(TecladoAlphaNumeric) then
  begin
    TecladoAlphaNumeric.close;
    TecladoAlphaNumeric := nil;
  end;

  if Assigned(TecladoNumeric) then
  begin
    TecladoNumeric.close;
    TecladoNumeric := nil;
  end;

  TecladoAlphaNumeric := TFrmTecladoAlphaNumeric.create(nil);
  TecladoAlphaNumeric.FEditor := Campo;
  TecladoAlphaNumeric.FTela := Tela;
  if Tela is TForm then
    TecladoAlphaNumeric.parent := TForm(Tela)
  else if Tela is TFrame then
    TecladoAlphaNumeric.parent := TFrame(Tela).parent;

  TecladoAlphaNumeric.FEditorProximo := CampoProximo;

  TecladoAlphaNumeric.show;
end;

function TDMConexao.RemoveAcento(Str: String): String;
const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  X: Integer;
begin
  for X := 1 to length(Str) do
    if POS(Str[X], ComAcento) <> 0 then
      Str[X] := SemAcento[POS(Str[X], ComAcento)];
  Result := Str;
end;

function TDMConexao.RemoveChar(const Texto: string): string;
var
  I: Integer;
  Resultado: String;
begin

  Resultado := '';

  for I := 1 to length(Texto) do
  begin
    if (Texto[I] in ['0' .. '9']) then
    begin
      Resultado := Resultado + copy(Texto, I, 1);
    end;
  end;

  Result := Resultado;

end;

function TDMConexao.RetornaUltimoArquivo(const Path, Extensao: String): String;
  function FileTimeToDTime(FTime: TFileTime): TDateTime;
  var
    LocalFTime: TFileTime;
    STime: TSystemTime;
  begin
    FileTimeToLocalFileTime(FTime, LocalFTime);
    FileTimeToSystemTime(LocalFTime, STime);
    Result := SystemTimeToDateTime(STime);
  end;

var
  I, j: Integer;
  SearchRec: TSearchRec;
  dataCriacao: TDateTime;
  StringList: TStringList;
  PathArq: String;
begin
  Result := '';
  StringList := TStringList.create;
  try
    try

      PathArq := Path + '*.' + Extensao;

      StringList.Sorted := True;
      I := FindFirst(PathArq, 0, SearchRec);
      while I = 0 do
      begin
        dataCriacao := FileTimeToDTime(SearchRec.FindData.ftLastWriteTime);
        StringList.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss', dataCriacao) + ' '
          + SearchRec.Name);
        I := FindNext(SearchRec);
      end;
      StringList.Sorted := false;
    except
      StringList.Free;
      raise;
    end;
  finally
    Result := StringList[StringList.Count - 1];
  end;

end;

procedure TDMConexao.selecionaEmpresa(ItemIndex: Integer);
var
  I: Integer;
begin

  Configuracao.Empresa := FUsuario.Empresas.Items[ItemIndex];
  FEmpresa := Configuracao.Empresa;
  Configuracao.Caixa.Empresa := Configuracao.Empresa;
  I := FEmpresa.Codigo;

  try
    TCaixaDAO.getInstancia.buscar(FConfiguracao.Caixa);

    if FConfiguracao.Caixa.TipoCaixa <> opNaoFiscal then
      configuraFiscal;

  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTitulo := 'Configuração de caixa';
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := 'Empresa sem caixa cadastrado, !' + #13 +
        '- Não deixe de cadastrar o(s) caixas para esta empresa.' + #13 +
        '- Não esqueça das configurações.';
      FrmMensagem.ShowModal;
      Application.Terminate;
      exit;
    end;
  end;

  try
    configuraFiscal;
  except
    on E: Exception do
      raise Exception.create(E.Message);
  end;

end;

function TDMConexao.senha(mensagem: String): Integer;
begin
  if Configuracao.LiberaSistemaMensagensConfirmacao then
    Result := 11
  else
  begin
    Application.CreateForm(TFrmLiberaSenha, FrmLiberaSenha);
    FrmLiberaSenha.FTitulo := mensagem;
    Result := FrmLiberaSenha.ShowModal;
  end;

end;

procedure TDMConexao.SetConfiguracao(const Value: TConfiguracao);
begin
  FConfiguracao := Value;
end;

procedure TDMConexao.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TDMConexao.SetNumeroSessao(const Value: Integer);
begin
  FNumeroSessao := Value;
end;

procedure TDMConexao.SetTimer(const Value: TTimer);
begin
  FTimer := Value;
end;

procedure TDMConexao.SetUsuario(const Value: TUsuario);
begin
  FUsuario := Value;
end;

function TDMConexao.totalPOS: currency;
var
  I: Integer;
begin
  Result := 0;

  if Assigned(FPagamentosPOS) then
    for I := 0 to FPagamentosPOS.Count - 1 do
      Result := Result + FPagamentosPOS.Items[I].Total;

end;

procedure TDMConexao.TrimAppMemorySize;
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  except
  end;
  Application.ProcessMessages;
end;

function TDMConexao.validaGTIN(AGTIN: String): Boolean;
var
  I, soma, Resultado, base10: Integer;
begin
  if copy(AGTIN, 1, 3) = '789' then
  begin

    // Verifica se todos os caracteres de AGTIN são números
    for I := 1 to length(AGTIN) do
      if not(AGTIN[I] in ['0' .. '9']) then
      begin
        Result := false;
        exit;
      end;
    // Verifica se AGTIN tem o tamanho necessário
    if length(AGTIN) in [8, 12, 13, 14] then
    begin
      soma := 0;
      for I := 1 to (length(AGTIN) - 1) do
      begin
        if length(AGTIN) = 13 then
        begin
          if Odd(I) then
            soma := soma + (strtoint(AGTIN[I]) * 1)
          else
            soma := soma + (strtoint(AGTIN[I]) * 3);
        end
        else
        begin
          if Odd(I) then
            soma := soma + (strtoint(AGTIN[I]) * 3)
          else
            soma := soma + (strtoint(AGTIN[I]) * 1);
        end;
      end;
      base10 := soma;
      // Verifica se base10 é múltiplo de 10
      if not(base10 mod 10 = 0) then
      begin
        while not(base10 mod 10 = 0) do
        begin
          base10 := base10 + 1;
        end;
      end;
      Resultado := base10 - soma;
      // Verifica se o resultado encontrado é igual ao caractere de controle
      if Resultado = strtoint(AGTIN[length(AGTIN)]) then
        Result := True
      else
        Result := false;
    end
    else
      Result := false;
  end
  else
    Result := false;
end;

end.
