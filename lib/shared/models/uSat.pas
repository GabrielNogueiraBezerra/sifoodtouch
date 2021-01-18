unit uSat;

interface

uses
  uContaReceberCartao, uPos, pcnVFPe, uClass, uVenda, pcnConversao, uEmpresa,
  System.Generics.Collections;

type
{$TYPEINFO ON}
  TSat = class(TObject)
  private
    { private declarations }
    Enviou: Boolean;
    procedure FechaCupomFiscalDadosCliente(Venda: TVenda);
    procedure FechaCupomFiscalItensVenda(Venda: TVenda);
    procedure FechaCupomFiscalFormasPagamento(Venda: TVenda);
    procedure FechaCupomFiscalEnviarDadosVenda(Venda: TVenda);
    procedure FechaCupomFiscalAtualizaVenda(Venda: TVenda);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;

    function EnviarPagamento(Pos: TPos): Integer;
    function VerificarStatusValidador(CodigoPagamento: Integer; Venda: TVenda)
      : TObjectList<TContaReceberCartao>;
    function FechaCupomFiscal(Venda: TVenda): Boolean;
    function IntegradorAtivo: Boolean;
    function RespostaFiscal(Venda: TVenda; Pos: TPos;
      ContaReceberCartao: TContaReceberCartao): Boolean;
    procedure FechaCupomFiscalImprimirCupomFiscal(Venda: TVenda;
      NovaImpressao: Boolean);
    procedure CancelaCupomFiscal(Venda: TVenda);
  published
    { published declarations }

  end;

implementation

uses
  uDMConexao, System.SysUtils, ACBrSATMFe_integrador, uContaReceberCartaoDAO,
  uBandeiraCartaoDAO, System.Math, System.StrUtils, uFormaPagamento, UVendaDAO,
  System.DateUtils, Winapi.Windows, FMX.Forms;

{ TSat }

procedure TSat.CancelaCupomFiscal(Venda: TVenda);
var
  CaminhoArquivo: String;
  sXMLSATCanc: AnsiString;
begin

  { SE O CAIXA FOR SAT OU MFE COM COMUNICAÇÃO COM INTEGRADOR }
  if ((DMConexao.Configuracao.Caixa.TipoCaixa = opSAT) or
    ((DMConexao.Configuracao.Caixa.TipoCaixa = opMFE) and
    (DMConexao.Configuracao.Caixa.ComunicaIntegracaoCaixa))) then
  begin

    DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
      ', GERANDO XML DE CANCELAMENTO, AGUARDE...';

    Application.ProcessMessages;

    CaminhoArquivo := DMConexao.ACBrSAT.ConfigArquivos.PastaCFeVenda + '\' +
      copy(Venda.ChaveAcessoCfeNfce, 7, 14) + '\' +
      copy(formatDateTime('yyyy', Date), 1, 2) + copy(Venda.ChaveAcessoCfeNfce,
      3, 4) + '\AD' + Venda.ChaveAcessoCfeNfce + '.xml';

    if FileExists(CaminhoArquivo) then
    begin
      with DMConexao.ACBrSAT do
      begin
        cfe.LoadFromFile(CaminhoArquivo);
        CFe2CFeCanc;

        sXMLSATCanc := CFeCanc.GerarXML(True);

        Venda.ChaveAcessoCancelCfeNfce := CFeCanc.infCFe.chCanc;

        if Venda.ChaveAcessoCancelCfeNfce = '' then
        begin
          CFeCanc.AsXMLString := sXMLSATCanc;
          Venda.ChaveAcessoCancelCfeNfce := CFeCanc.infCFe.chCanc;
        end;

        DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
          ', CANCELANDO DOCUMENTO FISCAL, AGUARDE...';

        Application.ProcessMessages;

        CancelarUltimaVenda(Venda.ChaveAcessoCancelCfeNfce, sXMLSATCanc);

        if Resposta.codigoDeRetorno = 7000 then
        begin
          Venda.ChaveAcessoCancelCfeNfce := CFeCanc.infCFe.ID;

          DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
            ', IMPRIMINDO EXTRATO DO DOCUMENTO FISCAL DE CANCELAMENTO, AGUARDE...';

          Application.ProcessMessages;

          try
            DMConexao.configuraImpressora('PADRAO');

            if DMConexao.Configuracao.ImprimeNomeFantasiaExtratoCFE then
              cfe.Emit.xFant := DMConexao.Empresa.Fantasia;

            if DMConexao.Configuracao.ImprimeRazaoSocialExtratoCFe then
              cfe.Emit.xNome := DMConexao.Empresa.Razao;

            ImprimirExtratoCancelamento;
            DMConexao.FACBrPosPrinter.Desativar;
          except
            on E: Exception do
            begin
              raise Exception.Create
                ('Não Foi Possível Imprimir o Extrato de Cancelamento do Documento Fiscal.'
                + sLineBreak + 'Mensagem Retornada: ' + E.message + sLineBreak);
            end;
          end;

        end
        else
        begin
          raise Exception.Create
            ('Não Foi Possível Cancelar o Documento Fiscal. ' +
            'Abaixo está a lista do(s) erro(s) acontecido(s)' + sLineBreak +
            sLineBreak + Resposta.mensagemRetorno);
        end;
      end;
    end
    else
    begin
      raise Exception.Create('Arquivo XML do CF-e ' + Venda.ChaveAcessoCfeNfce +
        ' Não Encontrado!');
    end;
  end;
end;

constructor TSat.Create;
begin

end;

function TSat.EnviarPagamento(Pos: TPos): Integer;
var
  PagamentoMFe: TEnviarPagamento;
  RespostaPagamentoMFe: TRespostaPagamento;
begin

  Result := -1;

  { SE O SAT ESTIVER COM O INTEGRADOR }
  if (DMConexao.ACBrSAT.Integrador = DMConexao.ACBrIntegrador) then
  begin
    { SE O CAIXA FOR SAT OU MFE COM COMUNICAÇÃO COM INTEGRADOR }
    if ((DMConexao.Configuracao.Caixa.TipoCaixa = opSAT) or
      ((DMConexao.Configuracao.Caixa.TipoCaixa = opMFE) and
      (DMConexao.Configuracao.Caixa.ComunicaIntegracaoCaixa))) then
    begin
      PagamentoMFe := TEnviarPagamento.Create;

      try
        with PagamentoMFe do
        begin
          Clear;
          ChaveAcessoValidador := DMConexao.Empresa.ChaveAcessoVFPE;
          ChaveRequisicao := Pos.AdministradoraCartao.ChaveRequisicaoVFPE;
          Estabelecimento := '10';
          SerialPOS := Pos.Serial;
          CNPJ := DMConexao.Empresa.CNPJ;
          IcmsBase := Pos.Total;
          ValorTotalVenda := Pos.Total;
          HabilitarMultiplosPagamentos := True;
          HabilitarControleAntiFraude := False;
          CodigoMoeda := 'BRL';
          EmitirCupomNFCE := False;
          OrigemPagamento := 'Mesa 999';
        end;

        try
          RespostaPagamentoMFe := TACBrSATMFe_integrador_XML
            (DMConexao.ACBrSAT.SAT).EnviarPagamento(PagamentoMFe);

          if RespostaPagamentoMFe <> nil then
            if RespostaPagamentoMFe.IDPagamento > 0 then
              Result := RespostaPagamentoMFe.IDPagamento
            else if RespostaPagamentoMFe.IntegradorResposta.Valor.Trim = '' then
              raise Exception.Create
                ('Sem Resposta do Integrador Para o Envio do Pagamento')
            else
              raise Exception.Create
                (RespostaPagamentoMFe.IntegradorResposta.Valor);
        except
          on E: Exception do
          begin
            DMConexao.ACBrSAT.Inicializado := False;
            DMConexao.ACBrSAT.Inicializado := True;

            if DMConexao.Configuracao.ExistePalavra(E.message, 'Access') then
              raise Exception.Create
                ('Sem Resposta do Integrador Para o Envio do Pagamento')
            else
              raise Exception.Create(E.message);

          end;
        end;
      finally
        PagamentoMFe.Free;
      end;
    end;
  end;
end;

procedure TSat.FechaCupomFiscalDadosCliente(Venda: TVenda);
begin
  with DMConexao.ACBrSAT.cfe do
  begin
    if Venda.Cliente.NomeCliente <> '' then
    begin
      if ((DMConexao.RemoveChar(Venda.Cliente.CNPJ).Trim <> '') or
        (Length(DMConexao.RemoveChar(Venda.Cliente.CNPJ).Trim) > 11)) or
        ((DMConexao.cpf(DMConexao.RemoveChar(Venda.Cliente.CNPJ))) or
        (not DMConexao.CNPJ(DMConexao.RemoveChar(Venda.Cliente.CNPJ)))) then
      begin
        Dest.CNPJCPF := DMConexao.RemoveChar(Venda.Cliente.CNPJ.Trim);
        Dest.xNome := Venda.Cliente.NomeCliente.Trim;

        try
          Entrega.xLgr := Venda.Cliente.Endereco;
          Entrega.nro := Venda.Cliente.Numero;
          Entrega.xCpl := '';
          Entrega.xBairro := Venda.Cliente.Bairro;
          Entrega.xMun := Venda.Cliente.Cidade;
          Entrega.UF := Venda.Cliente.UF;
        except
        end;

      end;
    end;
  end;
end;

procedure TSat.FechaCupomFiscalEnviarDadosVenda(Venda: TVenda);
var
  Error: Boolean;
  sXMLSAT: AnsiString;
  CodigoDeRetornoPassado: Integer;
  Arquivo: String;
begin

  // DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
  // ', ENVIANDO O DOCUMENTO FISCAL, AGUARDE...';

  Application.ProcessMessages;

  Enviou := False;
  Error := False;
  CodigoDeRetornoPassado := 0;
  Arquivo := '';

  with DMConexao.ACBrSAT do
  begin
    while not Enviou do
    begin

      if (not Error) then
      begin
        sXMLSAT := cfe.GerarXML(True);

        try
          EnviarDadosVenda(sXMLSAT);
        except
        end;
      end;

      if Venda.NumeroSessao = 0 then
        Venda.NumeroSessao := DMConexao.NumeroSessao;

      { CASO O ENVIO SEJA EFETUADO COM SUCESSO ATUALIZO OS
        DADOS DA VENDA E MANDO SALVAR NO BANCO DE DADO D }
      if (DMConexao.ACBrSAT.Resposta.codigoDeRetorno = 6000) or
        (Trim(DMConexao.ACBrSAT.cfe.infCFe.ID) <> '') then
      begin
        FechaCupomFiscalAtualizaVenda(Venda);
        Enviou := True;
        break;
      end;

      if Error then
      begin
        if DMConexao.Configuracao.Caixa.TipoCaixa = opMFE then
          if Resposta.mensagemRetorno <> '' then
            raise Exception.Create(Resposta.mensagemRetorno)
          else
            raise Exception.Create
              ('Integrador Fiscal Não Responde. Verifique se o mesmo está ' +
              'aberto e operacional')
        else if Resposta.mensagemRetorno <> '' then
          raise Exception.Create(Resposta.mensagemRetorno)
        else
          raise Exception.Create('SAT Não Responde. Verifique se o mesmo está '
            + 'conectado ao computador ou se está operacional');
        break;
      end;

      if (DMConexao.ACBrSAT.Resposta.codigoDeRetorno = 6010) and
        (CodigoDeRetornoPassado = 0) then
      begin
        DMConexao.ACBrSAT.cfe.Pagto.Items[0].vMP := cfe.Pagto.Items[0]
          .vMP + 0.01;
        CodigoDeRetornoPassado := Resposta.codigoDeRetorno;
      end
      else if (Venda.NumeroSessao > 0) and (not Error) then
      begin
        try
          try
            ConsultarNumeroSessao(Venda.NumeroSessao);
          except
          end;
        finally
          Error := True;
          CodigoDeRetornoPassado := 0;
        end;

        continue;
      end;

      if (Resposta.codigoDeRetorno <> 6000) and
        (Resposta.codigoDeRetorno <> 6010) then
      begin

        Arquivo := DMConexao.RetornaUltimoArquivo(ConfigArquivos.PastaCFeVenda +
          '\' + Trim(Config.emit_CNPJ) + '\' + formatDateTime('yyyymm', Date) +
          '\', 'xml');

        if Arquivo <> '' then
        begin
          if FileExists(ConfigArquivos.PastaCFeVenda + '\' +
            Trim(Config.emit_CNPJ) + '\' + formatDateTime('yyyymm', Date) + '\'
            + copy(Arquivo, 21)) then
          begin
            if SecondsBetween(Now, StrToDateTime(Trim(copy(Arquivo, 1, 21)))) <= 60
            then
            begin

              cfe.LoadFromFile(ConfigArquivos.PastaCFeVenda + '\' +
                Trim(Config.emit_CNPJ) + '\' + formatDateTime('yyyymm', Date) +
                '\' + copy(Arquivo, 21));

              if Venda.TotalVenda = cfe.Total.vCFe then
              begin
                FechaCupomFiscalAtualizaVenda(Venda);
                Enviou := True;
              end;
            end
            else
              Error := True;
          end;
        end;
      end;
    end;
  end;
end;

procedure TSat.FechaCupomFiscalFormasPagamento(Venda: TVenda);
var
  I: Integer;
begin
  with DMConexao.ACBrSAT.cfe do
  begin
    if Assigned(Venda.FormasPagamento) then
    begin
      for I := 0 to Venda.FormasPagamento.Count - 1 do
      begin
        if Venda.FormasPagamento.Items[I].FormaPagamento.Tipo <> 'TR' then
        begin
          with Pagto.Add do
          begin
            case AnsiIndexStr(Venda.FormasPagamento.Items[I]
              .FormaPagamento.Tipo, ['DN', 'CH', 'CA', 'TI', 'CC', 'CV']) of
              0:
                cMP := mpDinheiro;
              1:
                cMP := mpCheque;
              2:
                begin
                  if Venda.FormasPagamento.Items[I].FormaPagamento.TipoCartao = opDebito
                  then
                    cMP := mpCartaodeDebito
                  else
                    cMP := mpCartaodeCredito;
                end;
              3:
                cMP := mpValeAlimentacao;
              4:
                cMP := mpCreditoLoja;
              5:
                cMP := mpValeAlimentacao;
            else
              cMP := mpOutros;
            end;

            vMP := Venda.FormasPagamento.Items[I].Valor;
          end;
        end;
      end;
    end
    else
    begin
      with Pagto.Add do
      begin
        cMP := mpDinheiro;
        vMP := Venda.Total;
      end;
    end;
  end;
end;

function TSat.FechaCupomFiscal(Venda: TVenda): Boolean;
begin
  try
    if (DMConexao.Configuracao.Caixa.TipoCaixa = opSAT) or
      ((DMConexao.Configuracao.Caixa.TipoCaixa = opMFE) and
      (DMConexao.Configuracao.Caixa.ComunicaIntegracaoCaixa)) then
    begin

      // DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
      // ', GERANDO XML DO DOCUMENTO FISCAL, AGUARDE...';

      Application.ProcessMessages;

      DMConexao.ACBrSAT.cfe.IdentarXML := True;
      DMConexao.ACBrSAT.cfe.TamanhoIdentacao := 3;

      DMConexao.ACBrSAT.InicializaCFe;

      DMConexao.ACBrSAT.cfe.ide.numeroCaixa :=
        DMConexao.Configuracao.Caixa.NumeroCaixaSat;

      FechaCupomFiscalDadosCliente(Venda);
      FechaCupomFiscalItensVenda(Venda);
      FechaCupomFiscalFormasPagamento(Venda);
      FechaCupomFiscalEnviarDadosVenda(Venda);

      DMConexao.ACBrSAT.cfe.InfAdic.infCpl := Venda.Mensagem;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.message);
    end;
  end;
end;

procedure TSat.FechaCupomFiscalAtualizaVenda(Venda: TVenda);
begin
  with DMConexao.ACBrSAT do
  begin
    Venda.CodigoNumericoCfe := cfe.ide.cNF;
    Venda.ChaveAcessoCfeNfce := cfe.infCFe.ID;
    Venda.NumeroSessaoSat := Resposta.NumeroSessao;
    Venda.DataHoraCfe := StrToDateTime(DateTimeToStr(cfe.ide.dEmi) + ' ' +
      TimeToStr(cfe.ide.hEmi));
    Venda.CupomFiscal := cfe.ide.nCFe;

    if (DMConexao.Empresa.TipoEmpresa = opLucroReal) or
      (DMConexao.Empresa.TipoEmpresa = opLucroPresumido) then
      Venda.CodificacaoFiscal := '59'
    else if DMConexao.Empresa.TipoEmpresa = opSimplesNacionalEx then
      Venda.CodificacaoFiscal := '65';
  end;

end;

procedure TSat.FechaCupomFiscalImprimirCupomFiscal(Venda: TVenda;
  NovaImpressao: Boolean);
begin
  try

    DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
      ', IMPRIMINDO O EXTRATO DO DOCUMENTO FISCAL, AGUARDE...';

    Application.ProcessMessages;

    with DMConexao.ACBrSAT do
    begin

      if NovaImpressao then
        cfe.LoadFromFile(DMConexao.ACBrSAT.ConfigArquivos.PastaCFeVenda + '\' +
          copy(Venda.ChaveAcessoCfeNfce, 7, 14) + '\' +
          copy(formatDateTime('yyyy', Date), 1, 2) +
          copy(Venda.ChaveAcessoCfeNfce, 3, 4) + '\AD' +
          Venda.ChaveAcessoCfeNfce + '.xml');

      if DMConexao.Configuracao.ImprimeNomeFantasiaExtratoCFE then
        cfe.Emit.xFant := DMConexao.Empresa.Fantasia;

      if DMConexao.Configuracao.ImprimeRazaoSocialExtratoCFe then
        cfe.Emit.xNome := DMConexao.Empresa.Razao;

      ImprimirExtrato;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Não Foi Possível Imprimir o Extrato do CF-e.' +
        sLineBreak + 'Mensagem Retornada: ' + E.message + sLineBreak +
        'Para Completar Sua Impressao, Vá a Tela de Gerenciamento CF-e-MFE!');
    end;
  end;
end;

procedure TSat.FechaCupomFiscalItensVenda(Venda: TVenda);
var
  I, Item: Integer;
  OrigemCSTCSOSN: String;
  OK: Boolean;
begin
  Item := 1;
  with DMConexao.ACBrSAT.cfe do
  begin
    for I := 0 to Venda.ItensVenda.Count - 1 do
    begin
      with Det.Add do
      begin
        if Venda.ItensVenda.Items[I].Cancelado = 0 then
        begin

          NItem := Item;
          Item := Item + 1;

          if DMConexao.Configuracao.ImprimirReferenciaItemComandaCozinha then
          begin
            if Venda.ItensVenda.Items[I].Produto.Referencia.Trim <> '' then
              Prod.cProd := Venda.ItensVenda.Items[I].Produto.Referencia.Trim
            else
              Prod.cProd := IntToStr(Venda.ItensVenda.Items[I].Produto.Codigo);
          end
          else
            Prod.cProd := IntToStr(Venda.ItensVenda.Items[I].Produto.Codigo);

          if Venda.ItensVenda.Items[I].Produto.CodigoBarras.Length > 7 then
          begin
            if DMConexao.validaGTIN(Venda.ItensVenda.Items[I]
              .Produto.CodigoBarras) then
              Prod.cEAN := Venda.ItensVenda.Items[I].Produto.CodigoBarras
            else
              Prod.cEAN := '';
          end
          else
            Prod.cEAN := '';

          Prod.xProd := Venda.ItensVenda.Items[I].Produto.DescricaoCupom.Trim;
          Prod.NCM := Venda.ItensVenda.Items[I].Produto.NCM;
          Prod.CEST := Venda.ItensVenda.Items[I].Produto.CEST;

          if Venda.ItensVenda.Items[I].Cfop > 0 then
            Prod.Cfop := IntToStr(Venda.ItensVenda.Items[I].Cfop)
          else
            Prod.Cfop := IntToStr(Venda.ItensVenda.Items[I].Produto.Cfop);

          Prod.uCom := Venda.ItensVenda.Items[I]
            .Produto.UnidadeMedida.Descricao;
          Prod.indRegra := irArredondamento;
          Prod.vUnCom := Venda.ItensVenda.Items[I].Valor;
          Prod.qcom := Venda.ItensVenda.Items[I].Quantidade;
          Prod.vDesc := Venda.ItensVenda.Items[I].Desconto;
          Prod.vOutro := Venda.ItensVenda.Items[I].Acrescimo;

          OrigemCSTCSOSN :=
            IntToStr(Venda.ItensVenda.Items[I].GrupoIcms.Origem);

          Imposto.ICMS.orig := strtoorig(OK, OrigemCSTCSOSN);

          if DMConexao.ACBrSAT.Config.emit_cRegTrib = RTRegimeNormal then
          begin

            if (Venda.ItensVenda.Items[I].Produto.GrupoIcms.CSTCSOSN.Trim =
              '10') or (Venda.ItensVenda.Items[I].Produto.GrupoIcms.CSTCSOSN.
              Trim = '70') then
              Imposto.ICMS.CST := StrToCSTICMS(OK, '00')
            else if (Venda.ItensVenda.Items[I].Produto.GrupoIcms.CSTCSOSN.Trim =
              '30') or (Venda.ItensVenda.Items[I].Produto.GrupoIcms.CSTCSOSN.
              Trim = '50') then
              Imposto.ICMS.CST := StrToCSTICMS(OK, '40')
            else
              Imposto.ICMS.CST :=
                StrToCSTICMS(OK, Venda.ItensVenda.Items[I].GrupoIcms.CSTCSOSN);

            Imposto.ICMS.pICMS := Venda.ItensVenda.Items[I].GrupoIcms.Aliquota;

          end
          else
          begin
            if (Venda.ItensVenda.Items[I].GrupoIcms.CSTCSOSN.Trim = '103') or
              (Venda.ItensVenda.Items[I].GrupoIcms.CSTCSOSN.Trim = '101') or
              (Venda.ItensVenda.Items[I].GrupoIcms.CSTCSOSN.Trim = '201') or
              (Venda.ItensVenda.Items[I].GrupoIcms.CSTCSOSN.Trim = '202') or
              (Venda.ItensVenda.Items[I].GrupoIcms.CSTCSOSN.Trim = '203') or
              (Venda.ItensVenda.Items[I].GrupoIcms.CSTCSOSN.Trim = '400') then
              Imposto.ICMS.CSOSN := StrToCSOSNIcms(OK, '102')
            else
              Imposto.ICMS.CSOSN :=
                StrToCSOSNIcms(OK, Venda.ItensVenda.Items[I]
                .GrupoIcms.CSTCSOSN.Trim);
          end;

          if DMConexao.ACBrSAT.Config.emit_cRegTrib = RTSimplesNacional then
            Imposto.PIS.CST := StrToCSTPIS(OK, '49')
          else
            Imposto.PIS.CST :=
              StrToCSTPIS(OK, Venda.ItensVenda.Items[I].GrupoPis.CST);

          case Imposto.PIS.CST of
            pis01, pis02, pis05:
              begin
                Imposto.PIS.vBC :=
                  ((Prod.qcom * Prod.vUnCom) - Prod.vDesc + Prod.vOutro);
                Imposto.PIS.pPIS := Venda.ItensVenda.Items[I].GrupoPis.Aliquota;
              end;
            pis03:
              begin
                Imposto.PIS.qBCProd := Prod.qcom;
                Imposto.PIS.vAliqProd := Venda.ItensVenda.Items[I]
                  .GrupoPis.Aliquota;
              end;
            pis04, pis06, pis07, pis08, pis09, pis49:
              begin
                // nenhuma informacao
              end;
          else
            Imposto.PIS.vBC := ((Prod.qcom * Prod.vUnCom) - Prod.vDesc +
              Prod.vOutro);
            Imposto.PIS.pPIS := Venda.ItensVenda.Items[I]
              .GrupoPis.Aliquota / 100;
          end;

          if DMConexao.ACBrSAT.Config.emit_cRegTrib = RTSimplesNacional then
            Imposto.COFINS.CST := StrToCSTCOFINS(OK, '49')
          else
            Imposto.COFINS.CST :=
              StrToCSTCOFINS(OK, Venda.ItensVenda.Items[I].GrupoCofins.CST);

          case Imposto.COFINS.CST of
            cof01, cof02, cof05:
              begin
                Imposto.COFINS.vBC :=
                  ((Prod.qcom * Prod.vUnCom) - Prod.vDesc + Prod.vOutro);
                Imposto.COFINS.pCOFINS := Venda.ItensVenda.Items[I]
                  .GrupoCofins.Aliquota / 100;
              end;
            cof03:
              begin
                Imposto.COFINS.qBCProd := Prod.qcom;
                Imposto.COFINS.vAliqProd := Venda.ItensVenda.Items[I]
                  .GrupoCofins.Aliquota;
              end;
            cof04, cof06, cof07, cof08, cof09, cof49:
              begin
                // nenhuma informacao
              end;
          else
            Imposto.COFINS.vBC :=
              ((Prod.qcom * Prod.vUnCom) - Prod.vDesc + Prod.vOutro);
            Imposto.COFINS.pCOFINS := Venda.ItensVenda.Items[I]
              .GrupoCofins.Aliquota / 100;
          end;

          Imposto.vItem12741 :=
            RoundTO(((Venda.ItensVenda.Items[I].totalItem *
            Venda.ItensVenda.Items[I].Produto.IBTP.AliquotaNacional) / 100) +
            ((Venda.ItensVenda.Items[I].totalItem * Venda.ItensVenda.Items[I]
            .Produto.IBTP.AliquotaEstadual) / 100) +
            ((Venda.ItensVenda.Items[I].totalItem * Venda.ItensVenda.Items[I]
            .Produto.IBTP.AliquotaMunicipal) / 100), -2);

          Venda.ItensVenda.Items[I].ValorImpostoAproximado :=
            Imposto.vItem12741;
        end;
      end;
    end;

    if Venda.Desconto <= 0 then
      Total.DescAcrEntr.vAcresSubtot := Venda.Desconto
    else
      Total.DescAcrEntr.vAcresSubtot := Venda.Acrescimo;

    Total.vCFeLei12741 := Venda.totalValorImpostoAproximado;
  end;
end;

function TSat.IntegradorAtivo: Boolean;
begin
  if DMConexao.Configuracao.Caixa.ComunicaIntegracaoCaixa then
    Result := True
  else
  begin

    Result := (FindWindow(nil, 'Integrador') > 0);

    if not Result then
      raise Exception.Create(DMConexao.Usuario.Nome +
        ', o Integrador Fiscal Não Está Em Execução! Por Favor, Abra-o ' +
        'Para Iniciar a Movimentação Fiscal!');

  end;
end;

function TSat.RespostaFiscal(Venda: TVenda; Pos: TPos;
  ContaReceberCartao: TContaReceberCartao): Boolean;
var
  RespostaFiscal: TRespostaFiscal;
  RetornoRespostaFiscal: TRetornoRespostaFiscal;
begin
  Result := False;

  { SE O SAT ESTIVER COM O INTEGRADOR }
  if (DMConexao.ACBrSAT.Integrador = DMConexao.ACBrIntegrador) then
  begin
    { SE O CAIXA FOR SAT OU MFE COM COMUNICAÇÃO COM INTEGRADOR }
    if ((DMConexao.Configuracao.Caixa.TipoCaixa = opSAT) or
      ((DMConexao.Configuracao.Caixa.TipoCaixa = opMFE) and
      (DMConexao.Configuracao.Caixa.ComunicaIntegracaoCaixa))) then
    begin

      DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
        ', ENVIANDO RESPOSTA FISCAL, AGUARDE...';

      Application.ProcessMessages;

      RespostaFiscal := TRespostaFiscal.Create;

      try

        with RespostaFiscal do
        begin
          Clear;
          ChaveAcessoValidador := DMConexao.Empresa.ChaveAcessoVFPE;
          IDFila := Pos.IDPagamento;
          ChaveAcesso := Venda.ChaveAcessoCfeNfce;
          Nsu := ContaReceberCartao.CodigoPagamento;
          NumerodeAprovacao := ContaReceberCartao.NumeroAutorizacao;
          Bandeira := ContaReceberCartao.BandeiraCartao.Descricao;
          Adquirente := ContaReceberCartao.InstituicaoFinanceira;
          ImpressaoFiscal := IntToStr(Venda.CupomFiscal);
          NumeroDocumento := ContaReceberCartao.Bin;
          CNPJ := DMConexao.Empresa.CNPJ;
        end;

        try

          RetornoRespostaFiscal := TACBrSATMFe_integrador_XML
            (DMConexao.ACBrSAT.SAT).RespostaFiscal(RespostaFiscal);

          if Assigned(RetornoRespostaFiscal) then
          begin
            if not(RetornoRespostaFiscal.IdRespostaFiscal.Trim <> '') then
              raise Exception.Create
                ('Sem Reposta do Integrador Para Resposta Fiscal');
          end;
        except
          on E: Exception do
          begin
            DMConexao.ACBrSAT.Inicializado := False;
            DMConexao.ACBrSAT.Inicializado := True;

            if DMConexao.Configuracao.ExistePalavra(E.message, 'Access') then
              raise Exception.Create
                ('Sem Resposta do Integrador Para a Resposta Fiscal')
            else
              raise Exception.Create(E.message);
          end;
        end;
      finally
        RespostaFiscal.Free;
      end;
    end;
  end;
end;

function TSat.VerificarStatusValidador(CodigoPagamento: Integer; Venda: TVenda)
  : TObjectList<TContaReceberCartao>;
var
  VerificarStatusValidador: TVerificarStatusValidador;
  RespostaVerificarStatusValidador: TRespostaVerificarStatusValidador;
  ContaReceberCartao: TContaReceberCartao;
  I: Integer;
begin

  Result := TObjectList<TContaReceberCartao>.Create;

  { SE O SAT ESTIVER COM O INTEGRADOR }
  if (DMConexao.ACBrSAT.Integrador = DMConexao.ACBrIntegrador) then
  begin
    { SE O CAIXA FOR SAT OU MFE COM COMUNICAÇÃO COM INTEGRADOR }
    if ((DMConexao.Configuracao.Caixa.TipoCaixa = opSAT) or
      ((DMConexao.Configuracao.Caixa.TipoCaixa = opMFE) and
      (DMConexao.Configuracao.Caixa.ComunicaIntegracaoCaixa))) then
    begin

      VerificarStatusValidador := TVerificarStatusValidador.Create;

      try
        with VerificarStatusValidador do
        begin
          Clear;
          ChaveAcessoValidador := DMConexao.Empresa.ChaveAcessoVFPE;
          IDFila := CodigoPagamento;
          CNPJ := DMConexao.Empresa.CNPJ;
        end;

        try
          RespostaVerificarStatusValidador := TACBrSATMFe_integrador_XML
            (DMConexao.ACBrSAT.SAT).VerificarStatusValidador
            (VerificarStatusValidador);

          if RespostaVerificarStatusValidador <> nil then
          begin
            if RespostaVerificarStatusValidador.CodigoAutorizacao.Trim <> ''
            then
            begin
              for I := 0 to RespostaVerificarStatusValidador.Parcelas do
              begin
                ContaReceberCartao := TContaReceberCartao.Create;
                ContaReceberCartao.BandeiraCartao.Descricao :=
                  RespostaVerificarStatusValidador.Tipo;
                ContaReceberCartao.Codigo := 0;

                TBandeiraCartaoDAO.getInstancia.buscar
                  (ContaReceberCartao.BandeiraCartao);

                if ContaReceberCartao.BandeiraCartao.TipoCartao = 'D' then
                  ContaReceberCartao.Vencimento := ContaReceberCartao.Emissao +
                    (I * ContaReceberCartao.BandeiraCartao.DiasDebito)
                else if ContaReceberCartao.BandeiraCartao.TipoCartao = 'C' then
                  ContaReceberCartao.Vencimento := ContaReceberCartao.Emissao +
                    (I * ContaReceberCartao.BandeiraCartao.DiasCredito)
                else if ContaReceberCartao.BandeiraCartao.TipoCartao = 'A' then
                  ContaReceberCartao.Vencimento := ContaReceberCartao.Emissao;

                if ContaReceberCartao.BandeiraCartao.TipoCartao = 'D' then
                  ContaReceberCartao.Taxa :=
                    ContaReceberCartao.BandeiraCartao.TaxaDebito
                else if ContaReceberCartao.BandeiraCartao.TipoCartao = 'C' then
                  ContaReceberCartao.Taxa :=
                    ContaReceberCartao.BandeiraCartao.TaxaCredito
                else if ContaReceberCartao.BandeiraCartao.TipoCartao = 'A' then
                  ContaReceberCartao.Taxa := 0;

                ContaReceberCartao.Tipo :=
                  RespostaVerificarStatusValidador.Tipo;

                ContaReceberCartao.Emissao := Date;
                ContaReceberCartao.Caixa := DMConexao.Configuracao.Caixa;
                ContaReceberCartao.Empresa := DMConexao.Empresa;

                ContaReceberCartao.CodigoPagamento :=
                  RespostaVerificarStatusValidador.CodigoPagamento;

                ContaReceberCartao.Valor :=
                  RespostaVerificarStatusValidador.ValorPagamento /
                  RespostaVerificarStatusValidador.Parcelas;

                try
                  ContaReceberCartao.UltimosQuatroDigitos :=
                    RespostaVerificarStatusValidador.UltimosQuatroDigitos;
                except
                end;

                ContaReceberCartao.CodigoAutorizacaoVFPe :=
                  RespostaVerificarStatusValidador.CodigoAutorizacao;

                TContaReceberCartaoDAO.getInstancia.inserir
                  (ContaReceberCartao, Venda);

                Result.Add(ContaReceberCartao);
              end;
            end;
          end
          else
          begin
            Result := nil;
            raise Exception.Create
              ('Sem Resposta do Integrador Para o Status do Pagamento');
          end;
        except
          on E: Exception do
          begin
            Result := nil;
            DMConexao.ACBrSAT.Inicializado := False;
            DMConexao.ACBrSAT.Inicializado := True;

            if DMConexao.Configuracao.ExistePalavra(E.message, 'Access') then
              raise Exception.Create
                ('Sem Resposta do Integrador Para o Status do Pagamento')
            else
              raise Exception.Create(E.message);
          end;
        end;
      finally
        VerificarStatusValidador.Free;
      end;
    end;
  end;
end;

end.
