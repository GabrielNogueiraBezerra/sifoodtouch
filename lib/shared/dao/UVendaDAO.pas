unit UVendaDAO;

interface

uses
  uVenda, uContaReceberCartao, uPos, uConexaoFiredac;

type
{$TYPEINFO ON}
  TVendaDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TVendaDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TVendaDAO;
    procedure buscar(Venda: TVenda);
    procedure buscarInf(Venda: TVenda);
    procedure inserir(Venda: TVenda);
    procedure inserirPOS(Venda: TVenda; Pos: TPos;
      ContaReceberCartao: TContaReceberCartao);
    procedure alterar(Venda: TVenda);
  published
    { published declarations }
  end;

implementation

uses
  System.Generics.Collections, FireDAC.Comp.Client, uDMConexao, System.SysUtils,
  uEmpresaDAO, uCaixaDAO,
  uClienteDAO, uTipoVendaDAO, uUsuarioDAO, uVendedorDAO, uIndicadorDAO,
  uLocalEstoqueDAO, uItemVenda, uItemVendaDAO, System.Variants,
  uContaReceberCartaoDAO, System.Math, uVendaFormaPagamento,
  uFormaPagamentoDAO;

{ TVendaDAO }

procedure TVendaDAO.alterar(Venda: TVenda);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(Venda) then
      begin
        FDQuery := FConnection.prepareStatement
          ('update VENDAS V set V.DATA_VEN = :DATA, ' +
          'V.COD_EMP = :CODEMP, V.COD_CAI = :CODCAI, ' +
          'V.DATA_HORA_VEN = :DATAHORA, ' + 'V.COD_USU = :CODUSU, ' +
          'V.CUPOM_FISCAL_VEN = :CUPOM, ' + 'V.COD_CLI = :CODCLI, ' +
          'V.COD_VEND = :CODVEND, ' + 'V.COD_IND = :CODIND, ' +
          'V.COD_TPV = :CODTPV, ' + 'V.CODIFICACAO_FISCAL = :CODFISCAL, ' +
          'V.SERIE_NOTA_FISCAL = :SERIE, ' + 'V.NUMERO_NOTA_FISCAL = :NUMERO, '
          + 'V.CANCELADA_VEN = :CANCELADA, ' + 'V.R04_CCF = :CCF, ' +
          'V.CER = :CER, ' + 'V.EAD = :EAD, ' + 'V.COD_USU_AUD = :CODUSUAUD, ' +
          'V.OBSERVACAO = :OBSERVACAO, ' +
          'V.VENDA_RETAGUARDA = :VENDA_RETAGUARDA, ' +
          'V.CODIGO_LOCAL_ESTOQUE = :CODIGOLOCALESTOQUE, ' +
          'V.VALOR_PARCIAL = :VALOR_PARCIAL, ' +
          'V.VENDA_EXTERNA = :VENDA_EXTERNA, V.TOTAL_VEN = :TOTAL_VEN, V.DESCONTO_VEN = :DESCONTO_VEN, '
          + 'V.ACRESCIMO_VEN = :ACRESCIMO_VEN, V.TOTAL_VEN_AUX = :TOTAL_VEN_AUX, '
          + 'V.CHAVE_ACESSO_CFE_NFCE = :CHAVE_ACESSO_CFE_NFCE, ' +
          'V.PROTOCOLO_CFE_NFCE = :PROTOCOLO_CFE_NFCE, ' +
          'V.NUMERO_SESSAO_SAT = :NUMERO_SESSAO_SAT, ' +
          'V.CHAVE_ACESSO_CANC_CFE_NFCE = :CHAVE_ACESSO_CANC_CFE_NFCE, ' +
          'V.JUSTIFICATIVA_CANCEL_NFCE = :JUSTIFICATIVA_CANCEL_NFCE, ' +
          'V.CODIGO_NUMERICO_CFE = :CODIGO_NUMERICO_CFE, ' +
          'V.DATA_HORA_CFE = :DATA_HORA_CFE where V.COD_VEN = :CODIGO  ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := Venda.Codigo;
          ParamByName('DATA').AsDate := Venda.Data;
          ParamByName('CODEMP').AsInteger := Venda.Empresa.Codigo;
          ParamByName('CODCAI').AsInteger := Venda.Caixa.Codigo;
          ParamByName('DATAHORA').ASDateTime := Venda.DataHora;
          ParamByName('CODUSU').AsInteger := Venda.Usuario.Codigo;
          ParamByName('CUPOM').AsInteger := Venda.CupomFiscal;
          ParamByName('CODCLI').AsInteger := Venda.Cliente.Codigo;
          ParamByName('CODVEND').AsInteger := Venda.Vendedor.Codigo;
          ParamByName('CODTPV').AsInteger := Venda.TipoVenda.Codigo;
          ParamByName('CODFISCAL').AsString := Venda.CodificacaoFiscal;
          ParamByName('SERIE').AsString := Venda.Serie;
          ParamByName('NUMERO').AsInteger := Venda.Numero;
          ParamByName('CANCELADA').AsInteger := Venda.Cancelada;
          ParamByName('CCF').AsInteger := 0;
          ParamByName('CER').AsInteger := 0;
          ParamByName('EAD').AsString := '';
          ParamByName('CHAVE_ACESSO_CFE_NFCE').AsString :=
            Venda.ChaveAcessoCfeNfce;
          ParamByName('PROTOCOLO_CFE_NFCE').AsString := Venda.ProtocoloCfeNfce;
          ParamByName('NUMERO_SESSAO_SAT').AsInteger := Venda.NumeroSessaoSat;
          ParamByName('CHAVE_ACESSO_CANC_CFE_NFCE').AsString :=
            Venda.ChaveAcessoCancelCfeNfce;
          ParamByName('JUSTIFICATIVA_CANCEL_NFCE').AsString :=
            Venda.JustificativaCancelNfce;
          ParamByName('CODIGO_NUMERICO_CFE').AsInteger :=
            Venda.CodigoNumericoCfe;
          ParamByName('DATA_HORA_CFE').ASDateTime := Venda.DataHoraCfe;

          if Assigned(Venda.Indicador) then
            if Venda.Indicador.Codigo > 0 then
              ParamByName('CODIND').AsInteger := Venda.Indicador.Codigo
            else
              ParamByName('CODIND').Value := null
          else
            ParamByName('CODIND').Value := null;

          if Assigned(Venda.UsuarioAuditoria) then
            ParamByName('CODUSUAUD').AsInteger := Venda.UsuarioAuditoria.Codigo
          else
            ParamByName('CODUSUAUD').Value := null;

          ParamByName('VALOR_PARCIAL').AsCurrency := Venda.Parcial;
          ParamByName('VENDA_EXTERNA').AsString := 'N';

          ParamByName('OBSERVACAO').AsString := Venda.Observacao;
          ParamByName('VENDA_RETAGUARDA').AsString := 'N';
          ParamByName('TOTAL_VEN').AsCurrency := Venda.Total;
          ParamByName('DESCONTO_VEN').AsCurrency := Venda.Desconto;
          ParamByName('ACRESCIMO_VEN').AsCurrency := Venda.Acrescimo;
          ParamByName('TOTAL_VEN_AUX').AsCurrency := Venda.Total;

          if Assigned(Venda.LocalEstoque) then
            ParamByName('CODIGOLOCALESTOQUE').AsInteger :=
              Venda.LocalEstoque.Codigo
          else
            ParamByName('CODIGOLOCALESTOQUE').Value := null;

          ParamByName('VENDA_EXTERNA').AsString := 'N';

          ExecSQL;
        end;
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

procedure TVendaDAO.buscar(Venda: TVenda);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemVenda: TItemVenda;
  ContaReceberCartao: TContaReceberCartao;
  VendaFormaPagamento: TVendaFormaPagamento;
begin
  if Assigned(Venda) then
  begin
    try
      try

        FDQuery := FConnection.prepareStatement
          (' select V.ACRESCIMO_VEN, V.MOTIVO_CANCELAMENTO_VEN, V.DESCONTO_VEN, V.DATA_HORA_VEN, V.CUPOM_FISCAL_VEN, '
          + 'V.CODIGO_NUMERICO_CFE, V.DATA_VEN_CANCEL, V.COD_VEN, V.TOTAL_VEN, V.CODIGO_LOCAL_ESTOQUE, '
          + 'V.COD_USU_CANCELAMENTO_VEN, V.COD_IND, V.COD_VEND, V.COD_CAI, V.CANCELADA_VEN, V.COD_EMP, '
          + 'V.COD_USU_AUD, V.COD_CLI, V.COD_USU, V.DATA_VEN, V.CANCELADA_VEN_RETAGUARDA, V.COD_TPV, '
          + 'V.VALOR_PARCIAL, V.CUPOM_FISCAL_VEN, V.NUMERO_NOTA_FISCAL, V.SERIE_NOTA_FISCAL, '
          + 'V.CHAVE_ACESSO_CFE_NFCE, V.PROTOCOLO_CFE_NFCE, V.NUMERO_SESSAO_SAT, '
          + 'V.CHAVE_ACESSO_CANC_CFE_NFCE, V.JUSTIFICATIVA_CANCEL_NFCE, V.CODIGO_NUMERICO_CFE, '
          + 'V.DATA_HORA_CFE from VENDAS  V where V.COD_VEN = :CODIGO   ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := Venda.Codigo;
          Open;

          if RecordCount > 0 then
          begin
            Venda.Codigo := FieldByName('COD_VEN').AsInteger;
            Venda.Data := FieldByName('DATA_VEN').ASDateTime;
            Venda.DataHora := FieldByName('DATA_HORA_VEN').ASDateTime;

            Venda.Empresa.Codigo := FieldByName('COD_EMP').AsInteger;
            TEmpresaDAO.getInstancia.buscar(Venda.Empresa);

            Venda.Caixa.Codigo := FieldByName('COD_CAI').AsInteger;
            Venda.Caixa.Empresa := Venda.Empresa;
            TCaixaDAO.getInstancia.buscar(Venda.Caixa);

            Venda.Cliente.Codigo := FieldByName('COD_CLI').AsInteger;
            TClienteDAO.getInstancia.buscar(Venda.Cliente);

            Venda.TipoVenda.Codigo := FieldByName('COD_TPV').AsInteger;
            TTipoVendaDAO.getInstancia.buscar(Venda.TipoVenda);

            Venda.Usuario.Codigo := FieldByName('COD_USU').AsInteger;
            TUsuarioDAO.getInstancia.buscar(Venda.Usuario);

            if not FieldByName('COD_USU_CANCELAMENTO_VEN').isNull then
            begin
              Venda.UsuarioCancelamento.Codigo :=
                FieldByName('COD_USU_CANCELAMENTO_VEN').AsInteger;
              TUsuarioDAO.getInstancia.buscar(Venda.UsuarioCancelamento);
            end;

            Venda.Vendedor.Codigo := FieldByName('COD_VEND').AsInteger;
            TVendedorDAO.getInstancia.buscar(Venda.Vendedor);
            if not FieldByName('COD_IND').isNull then
            begin
              Venda.Indicador.Codigo := FieldByName('COD_IND').AsInteger;
              TIndicadorDAO.getInstancia.buscar(Venda.Indicador);
            end;

            Venda.LocalEstoque.Codigo := FieldByName('CODIGO_LOCAL_ESTOQUE')
              .AsInteger;
            TLocalEstoqueDAO.getInstancia.buscar(Venda.LocalEstoque);

            Venda.Desconto := FieldByName('DESCONTO_VEN').AsCurrency;
            Venda.Acrescimo := FieldByName('ACRESCIMO_VEN').AsCurrency;
            Venda.Total := (FieldByName('TOTAL_VEN').AsCurrency);
            Venda.CupomFiscal := FieldByName('CUPOM_FISCAL_VEN').AsInteger;
            Venda.CodigoNumericoCfe := FieldByName('CODIGO_NUMERICO_CFE')
              .AsInteger;
            Venda.Cancelada := FieldByName('CODIGO_NUMERICO_CFE').AsInteger;
            Venda.CanceladaRetaguarda := FieldByName('CANCELADA_VEN_RETAGUARDA')
              .AsInteger;
            Venda.MotivoCancelamento :=
              FieldByName('MOTIVO_CANCELAMENTO_VEN').AsString;
            Venda.DataCancelado := FieldByName('DATA_VEN_CANCEL').ASDateTime;
            Venda.Parcial := FieldByName('VALOR_PARCIAL').AsCurrency;

            Venda.Serie := FieldByName('SERIE_NOTA_FISCAL').AsString;
            Venda.Numero := FieldByName('NUMERO_NOTA_FISCAL').AsInteger;
            Venda.ChaveAcessoCfeNfce :=
              FieldByName('CHAVE_ACESSO_CFE_NFCE').AsString;
            Venda.ProtocoloCfeNfce := FieldByName('PROTOCOLO_CFE_NFCE')
              .AsString;
            Venda.NumeroSessaoSat := FieldByName('NUMERO_SESSAO_SAT').AsInteger;
            Venda.ChaveAcessoCancelCfeNfce :=
              FieldByName('CHAVE_ACESSO_CANC_CFE_NFCE').AsString;
            Venda.JustificativaCancelNfce :=
              FieldByName('JUSTIFICATIVA_CANCEL_NFCE').AsString;
            Venda.DataHoraCfe := FieldByName('DATA_HORA_CFE').ASDateTime;

            Venda.UsuarioAuditoria.Codigo := FieldByName('COD_USU_AUD')
              .AsInteger;
            TUsuarioDAO.getInstancia.buscar(Venda.UsuarioAuditoria);

            Venda.ItensVenda := TObjectList<TItemVenda>.Create;

            Venda.Total := 0;

            FDAux := FConnection.prepareStatement
              ('select IV.COD_VEN, IV.ORDEM  from ITENS_VENDA IV where IV.COD_VEN = :CODIGO     ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := Venda.Codigo;
              Open;

              while not FDAux.Eof do
              begin
                ItemVenda := TItemVenda.Create;
                ItemVenda.Codigo := FDAux.FieldByName('COD_VEN').AsInteger;
                ItemVenda.Ordem := FDAux.FieldByName('ORDEM').AsInteger;

                TItemVendaDAO.getInstancia.buscar(ItemVenda);

                Venda.Total := Venda.Total + ItemVenda.Total;

                Venda.ItensVenda.Add(ItemVenda);
                FDAux.Next;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            Venda.FormasPagamento := TObjectList<TVendaFormaPagamento>.Create;

            FDAux := FConnection.prepareStatement
              (' select VFP.COD_FORMA, VFP.VALOR  ' +
              'from VENDAS_FORMAS_PAGAMENTO VFP ' +
              'where VFP.COD_VENDA = :CODIGO     ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := Venda.Codigo;
              Open;

              while not FDAux.Eof do
              begin

                VendaFormaPagamento := TVendaFormaPagamento.Create;
                VendaFormaPagamento.FormaPagamento.Codigo :=
                  FDAux.FieldByName('COD_FORMA').AsInteger;
                VendaFormaPagamento.Valor := FDAux.FieldByName('VALOR')
                  .AsCurrency;

                TFormaPagamentoDAO.getInstancia.buscar
                  (VendaFormaPagamento.FormaPagamento);

                Venda.FormasPagamento.Add(VendaFormaPagamento);

                FDAux.Next;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            if DMConexao.Configuracao.ArredondaSimple then
              Venda.Total := SimpleRoundTo(Venda.Total + Venda.Acrescimo -
                Venda.Desconto, -2)
            else
              Venda.Total := RoundTo(Venda.Total + Venda.Acrescimo -
                Venda.Desconto, -2);

            Venda.ContasReceberCartao :=
              TObjectList<TContaReceberCartao>.Create;

            FDAux := FConnection.prepareStatement
              (' select CRAC.CODIGO from CONTAS_RECEBER_ADM_CARTAO CRAC ' +
              'where CRAC.COD_VEN = :CODIGO    ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := Venda.Codigo;
              Open;

              while not FDAux.Eof do
              begin
                ContaReceberCartao := TContaReceberCartao.Create;
                ContaReceberCartao.Codigo := FDAux.FieldByName('CODIGO')
                  .AsInteger;

                TContaReceberCartaoDAO.getInstancia.buscar(ContaReceberCartao);

                Venda.ContasReceberCartao.Add(ContaReceberCartao);
                FDAux.Next;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

          end;
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
end;

procedure TVendaDAO.buscarInf(Venda: TVenda);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemVenda: TItemVenda;
  ContaReceberCartao: TContaReceberCartao;
begin
  if Assigned(Venda) then
  begin
    try
      try

        FDQuery := FConnection.prepareStatement
          (' select V.ACRESCIMO_VEN, V.MOTIVO_CANCELAMENTO_VEN, V.DESCONTO_VEN, V.DATA_HORA_VEN, V.CUPOM_FISCAL_VEN, '
          + 'V.CODIGO_NUMERICO_CFE, V.DATA_VEN_CANCEL, V.COD_VEN, V.TOTAL_VEN, V.CODIGO_LOCAL_ESTOQUE, '
          + 'V.COD_USU_CANCELAMENTO_VEN, V.COD_IND, V.COD_VEND, V.COD_CAI, V.CANCELADA_VEN, V.COD_EMP, '
          + 'V.COD_USU_AUD, V.COD_CLI, V.COD_USU, V.DATA_VEN, V.CANCELADA_VEN_RETAGUARDA, V.COD_TPV, '
          + 'V.VALOR_PARCIAL, V.CUPOM_FISCAL_VEN, V.NUMERO_NOTA_FISCAL, V.SERIE_NOTA_FISCAL, '
          + 'V.CHAVE_ACESSO_CFE_NFCE, V.PROTOCOLO_CFE_NFCE, V.NUMERO_SESSAO_SAT, '
          + 'V.CHAVE_ACESSO_CANC_CFE_NFCE, V.JUSTIFICATIVA_CANCEL_NFCE, V.CODIGO_NUMERICO_CFE, '
          + 'V.DATA_HORA_CFE from VENDAS  V where V.COD_VEN = :CODIGO   ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := Venda.Codigo;
          Open;

          if RecordCount > 0 then
          begin
            Venda.Codigo := FieldByName('COD_VEN').AsInteger;
            Venda.Data := FieldByName('DATA_VEN').ASDateTime;
            Venda.DataHora := FieldByName('DATA_HORA_VEN').ASDateTime;

            Venda.Cliente.Codigo := FieldByName('COD_CLI').AsInteger;
            TClienteDAO.getInstancia.buscar(Venda.Cliente);

            Venda.Desconto := FieldByName('DESCONTO_VEN').AsCurrency;
            Venda.Acrescimo := FieldByName('ACRESCIMO_VEN').AsCurrency;
            Venda.Total := (FieldByName('TOTAL_VEN').AsCurrency);
            Venda.CupomFiscal := FieldByName('CUPOM_FISCAL_VEN').AsInteger;
            Venda.CodigoNumericoCfe := FieldByName('CODIGO_NUMERICO_CFE')
              .AsInteger;
            Venda.Cancelada := FieldByName('CODIGO_NUMERICO_CFE').AsInteger;
            Venda.CanceladaRetaguarda := FieldByName('CANCELADA_VEN_RETAGUARDA')
              .AsInteger;
            Venda.MotivoCancelamento :=
              FieldByName('MOTIVO_CANCELAMENTO_VEN').AsString;
            Venda.DataCancelado := FieldByName('DATA_VEN_CANCEL').ASDateTime;
            Venda.Parcial := FieldByName('VALOR_PARCIAL').AsCurrency;

            Venda.Serie := FieldByName('SERIE_NOTA_FISCAL').AsString;
            Venda.Numero := FieldByName('NUMERO_NOTA_FISCAL').AsInteger;
            Venda.ChaveAcessoCfeNfce :=
              FieldByName('CHAVE_ACESSO_CFE_NFCE').AsString;
            Venda.ProtocoloCfeNfce := FieldByName('PROTOCOLO_CFE_NFCE')
              .AsString;
            Venda.NumeroSessaoSat := FieldByName('NUMERO_SESSAO_SAT').AsInteger;
            Venda.ChaveAcessoCancelCfeNfce :=
              FieldByName('CHAVE_ACESSO_CANC_CFE_NFCE').AsString;
            Venda.JustificativaCancelNfce :=
              FieldByName('JUSTIFICATIVA_CANCEL_NFCE').AsString;
            Venda.DataHoraCfe := FieldByName('DATA_HORA_CFE').ASDateTime;

            if DMConexao.Configuracao.ArredondaSimple then
              Venda.Total := SimpleRoundTo(Venda.Total + Venda.Acrescimo -
                Venda.Desconto, -2)
            else
              Venda.Total := RoundTo(Venda.Total + Venda.Acrescimo -
                Venda.Desconto, -2);

          end;
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
end;

constructor TVendaDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TVendaDAO.getInstancia: TVendaDAO;
begin
  if FInstancia = nil then
    FInstancia := TVendaDAO.Create;

  Result := FInstancia;
end;

procedure TVendaDAO.inserir(Venda: TVenda);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  I: Integer;
begin
  try
    try
      if Assigned(Venda) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select * from SP_INICIA_VENDA(:DATA, :CODEMP, :CODCAI, :DATAHORA, '
          + ':CODUSU, :CUPOM, :CODCLI, :CODVEND, :CODINDIC, :CODTPV, :CODFISCAL, '
          + ':SERIE, :NUMERO, :CANCELADA, :CCF, :CER, :EAD, :CODUSUAUD)    ');

        with FDQuery do
        begin

          ParamByName('DATA').AsDate := Venda.Data;
          ParamByName('CODEMP').AsInteger := Venda.Empresa.Codigo;
          ParamByName('CODCAI').AsInteger := Venda.Caixa.Codigo;
          ParamByName('DATAHORA').ASDateTime := Venda.DataHora;
          ParamByName('CODUSU').AsInteger := Venda.Usuario.Codigo;
          ParamByName('CUPOM').AsInteger := Venda.CupomFiscal;
          ParamByName('CODCLI').AsInteger := Venda.Cliente.Codigo;
          ParamByName('CODVEND').AsInteger := Venda.Vendedor.Codigo;

          if Assigned(Venda.Indicador) then
            ParamByName('CODINDIC').AsInteger := Venda.Indicador.Codigo
          else
            ParamByName('CODINDIC').Value := null;
          ParamByName('CODTPV').AsInteger := Venda.TipoVenda.Codigo;
          ParamByName('CODFISCAL').AsString := '';
          ParamByName('SERIE').AsString := '';
          ParamByName('NUMERO').AsInteger := 0;
          ParamByName('CANCELADA').AsInteger := Venda.Cancelada;
          ParamByName('CCF').AsInteger := 0;
          ParamByName('CER').AsInteger := 0;
          ParamByName('EAD').AsString := '';
          ParamByName('CODUSUAUD').AsInteger := Venda.UsuarioAuditoria.Codigo;
          Open;

          Venda.Codigo := FieldByName('CODVEN').AsInteger;

          for I := 0 to Venda.ItensVenda.Count - 1 do
          begin
            Venda.ItensVenda.Items[I].Codigo := Venda.Codigo;
            TItemVendaDAO.getInstancia.inserir(Venda.ItensVenda.Items[I]);
          end;

          for I := 0 to Venda.FormasPagamento.Count - 1 do
          begin

            FDAux := FConnection.prepareStatement
              ('  insert into VENDAS_FORMAS_PAGAMENTO (COD_VENDA, ' +
              'COD_FORMA, VALOR) values (:COD_VENDA, :COD_FORMA, :VALOR)   ');

            with FDAux do
            begin
              ParamByName('COD_VENDA').AsInteger := Venda.Codigo;
              ParamByName('COD_FORMA').AsInteger := Venda.FormasPagamento.Items
                [I].FormaPagamento.Codigo;
              ParamByName('VALOR').AsCurrency :=
                Venda.FormasPagamento.Items[I].Valor;
              ExecSQL;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);
          end;

          TVendaDAO.getInstancia.alterar(Venda);
        end;
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

procedure TVendaDAO.inserirPOS(Venda: TVenda; Pos: TPos;
  ContaReceberCartao: TContaReceberCartao);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  I: Integer;
begin
  try
    try

      if Assigned(Venda) then
      begin
        FDQuery := FConnection.prepareStatement
          ('INSERT INTO VENDAS_POS_PAGAMENTO (COD_VENDA, COD_POS, ' +
          'VALOR_POS, BIN_CARTAO, DONO_CARTAO, DATA_EXPIRACAO, INST_FINANC, ' +
          'NUM_PARC, ULT_QUATRO_DIG, NSU, VALOR_PAGTO, TIPO_PAGTO, CODIGO_AUTORIZACAO, '
          + 'ID_PAGAMENTO) VALUES ' +
          '(:CODVEN, :CODPOS, :VALORPOS, :BIN, :DONO, :DATA, :INST, :NUMPARC, :ULTQUATRODIG, '
          + ':NSU, :VALORPAGTO, :TIPOPAGTO, :CODAUT, :IDPAGTO)');

        with FDQuery do
        begin

          ParamByName('codven').AsInteger := Venda.Codigo;
          ParamByName('codpos').AsInteger := Pos.Codigo;
          ParamByName('valorpos').AsCurrency := Pos.Total;
          ParamByName('bin').AsString := ContaReceberCartao.Bin;
          ParamByName('dono').AsString := ContaReceberCartao.DonoCartao;
          ParamByName('data').AsString := ContaReceberCartao.DataExpiracao;
          ParamByName('inst').AsString :=
            ContaReceberCartao.InstituicaoFinanceira;
          ParamByName('numparc').AsInteger := ContaReceberCartao.Parcelas;
          ParamByName('ultquatrodig').AsInteger :=
            ContaReceberCartao.UltimosQuatroDigitos;
          ParamByName('nsu').AsString := ContaReceberCartao.CodigoPagamento;
          ParamByName('valorpagto').AsCurrency := Pos.Total;
          ParamByName('tipopagto').AsString :=
            ContaReceberCartao.BandeiraCartao.Descricao;
          ParamByName('codaut').AsString :=
            ContaReceberCartao.NumeroAutorizacao;
          ParamByName('idpagto').AsString := IntToStr(Pos.IdPagamento);
          ExecSQL;
        end;
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

end.
