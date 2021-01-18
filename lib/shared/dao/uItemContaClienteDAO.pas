unit uItemContaClienteDAO;

interface

uses
  uItemContaCliente, uContaCliente, System.Generics.Collections,
  uConexaoFiredac;

type
{$TYPEINFO ON}
  TItemContaClienteDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TItemContaClienteDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TItemContaClienteDAO;
    procedure selItens(ContaCliente: TContaCliente);
    procedure buscar(ItemContaCliente: TItemContaCliente);
    procedure inserir(ItemContaCliente: TItemContaCliente);
    procedure alterar(ItemContaCliente: TItemContaCliente);
    procedure excluir(ItemContaCliente: TItemContaCliente);
    function buscaTodos(ContaCliente: TContaCliente)
      : TObjectList<TItemContaCliente>;
    function buscaTodosConferencia(ContaCliente: TContaCliente)
      : TObjectList<TItemContaCliente>;
  published
    { published declarations }
  end;

implementation

uses
  uDMConexao, System.SysUtils, uProdutoDAO, uVendedorDAO, uEmpresaDAO,
  FMX.Forms, uCaixaDAO, FireDAC.Comp.Client, System.Variants,
  uPagamentoParcial, uFormaPagamentoDAO;

{ TItemContaClienteDAO }

procedure TItemContaClienteDAO.alterar(ItemContaCliente: TItemContaCliente);
var
  FDQuery: TFDQuery;
begin
  if Assigned(ItemContaCliente) then
  begin
    try
      try
        FDQuery := FConnection.prepareStatement
          ('update ITENS_CONTA_CLIENTE set COD_PRO = :COD_PRO, ' +
          'COD_VEND = :COD_VEND, QUANT = :QUANT, VALOR = :VALOR, ' +
          'COD_EMP = :COD_EMP, IMPRESSO = :IMPRESSO, HORA = :HORA, ' +
          'OBSERVACAO = :OBSERVACAO, CANCELADO = :CANCELADO, ' +
          'MOTIVO_CANCELAMENTO = :MOTIVO_CANCELAMENTO, ' +
          'DATA_HORA_CANCELAMENTO = :DATA_HORA_CANCELAMENTO ' +
          'where CODIGO = :CODIGO and ORDEM = :ORDEM   ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := ItemContaCliente.Codigo;
          ParamByName('ORDEM').AsInteger := ItemContaCliente.Ordem;
          ParamByName('COD_PRO').AsInteger := ItemContaCliente.Produto.Codigo;
          ParamByName('COD_VEND').AsInteger := ItemContaCliente.Garcom.Codigo;
          ParamByName('COD_EMP').AsInteger := ItemContaCliente.Empresa.Codigo;
          ParamByName('QUANT').AsCurrency := ItemContaCliente.Quantidade;
          ParamByName('VALOR').AsCurrency := ItemContaCliente.Valor;
          ParamByName('IMPRESSO').AsString := ItemContaCliente.Impresso;
          ParamByName('CANCELADO').AsInteger := ItemContaCliente.Cancelado;
          ParamByName('HORA').AsDateTime := ItemContaCliente.Hora;
          ParamByName('OBSERVACAO').AsString := ItemContaCliente.Observacao;

          if ItemContaCliente.DataHoraCancelamento <= 0 then
            ParamByName('DATA_HORA_CANCELAMENTO').Value := null
          else
            ParamByName('DATA_HORA_CANCELAMENTO').AsDateTime :=
              ItemContaCliente.DataHoraCancelamento;

          ParamByName('MOTIVO_CANCELAMENTO').AsString :=
            ItemContaCliente.MotivoCancelamento;

          ExecSQL;
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

procedure TItemContaClienteDAO.buscar(ItemContaCliente: TItemContaCliente);
var
  Adicional: TItemContaCliente;
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  TotalAdicional: Currency;
  PagamentoParcial: TPagamentoParcial;
begin
  if Assigned(ItemContaCliente) then
  begin
    try
      try
        FDQuery := FConnection.prepareStatement
          ('select ICC.CODIGO, ICC.ORDEM, ICC.COD_PRO, ICC.COD_VEND, ICC.VALOR, '
          + 'ICC.CONTA_ORIGEM, ICC.CANCELADO, ICC.COD_EMP, ICC.QUANT, ICC.TOTAL, '
          + 'ICC.IMPRESSO, ICC.HORA, ICC.OBSERVACAO, ICC.ORDEM_PAR_PIZZA, ' +
          'ICC.FEITO, ICC.AVISADO, ICC.MOTIVO_CANCELAMENTO, ' +
          'ICC.DATA_HORA_CANCELAMENTO, ICC.OBS_PIZZA, ICC.ORDEM_ITEM_PRINCIPAL '
          + 'from ITENS_CONTA_CLIENTE ICC where ICC.CODIGO = :CODIGO and ICC.ORDEM = :ORDEM ');

        FDQuery.ParamByName('CODIGO').AsInteger := ItemContaCliente.Codigo;
        FDQuery.ParamByName('ORDEM').AsInteger := ItemContaCliente.Ordem;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            ItemContaCliente.Produto.Codigo := FieldByName('COD_PRO').AsInteger;
            ItemContaCliente.Garcom.Codigo := FieldByName('COD_VEND').AsInteger;
            ItemContaCliente.Valor := FieldByName('VALOR').AsCurrency;
            ItemContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM')
              .AsInteger;
            ItemContaCliente.Cancelado := FieldByName('CANCELADO').AsInteger;
            ItemContaCliente.Empresa.Codigo := FieldByName('COD_EMP').AsInteger;
            ItemContaCliente.Quantidade := FieldByName('QUANT').AsCurrency;
            ItemContaCliente.Total :=
              (FieldByName('QUANT').AsCurrency * FieldByName('VALOR')
              .AsCurrency);
            ItemContaCliente.Impresso := FieldByName('IMPRESSO').AsString;
            ItemContaCliente.Hora := FieldByName('HORA').AsDateTime;
            ItemContaCliente.Observacao := FieldByName('OBSERVACAO').AsString;
            ItemContaCliente.OrdemParPizza := FieldByName('ORDEM_PAR_PIZZA')
              .AsInteger;
            ItemContaCliente.Feito := FieldByName('FEITO').AsString;
            ItemContaCliente.Avisado := FieldByName('AVISADO').AsString;
            ItemContaCliente.MotivoCancelamento :=
              FieldByName('MOTIVO_CANCELAMENTO').AsString;
            ItemContaCliente.DataHoraCancelamento :=
              FieldByName('DATA_HORA_CANCELAMENTO').AsDateTime;
            ItemContaCliente.ObservacaoPizza :=
              FieldByName('OBS_PIZZA').AsString;
            ItemContaCliente.OrdemItemPrincipal :=
              FieldByName('ORDEM_ITEM_PRINCIPAL').AsInteger;

            if ItemContaCliente.OrdemItemPrincipal <= 0 then
            begin
              TotalAdicional := 0;

              FDAux := FConnection.prepareStatement
                (' select ICC.CODIGO, ICC.ORDEM, ICC.COD_PRO, ICC.COD_VEND, ICC.VALOR, '
                + 'ICC.CONTA_ORIGEM, ICC.CANCELADO, ICC.COD_EMP, ICC.QUANT, ICC.TOTAL, '
                + 'ICC.IMPRESSO, ICC.HORA, ICC.OBSERVACAO, ICC.ORDEM_PAR_PIZZA, '
                + 'ICC.FEITO, ICC.AVISADO, ICC.MOTIVO_CANCELAMENTO, ' +
                'ICC.DATA_HORA_CANCELAMENTO, ICC.OBS_PIZZA, ICC.ORDEM_ITEM_PRINCIPAL '
                + 'from ITENS_CONTA_CLIENTE ICC where ICC.ORDEM_ITEM_PRINCIPAL = :CODIGO and '
                + 'ICC.CODIGO = :CONTA ');
              FDAux.ParamByName('CODIGO').AsInteger := ItemContaCliente.Ordem;
              FDAux.ParamByName('CONTA').AsInteger := ItemContaCliente.Codigo;
              FDAux.Open;

              with FDAux do
              begin

                ItemContaCliente.Adicionais :=
                  TObjectList<TItemContaCliente>.Create;

                while not FDAux.Eof do
                begin
                  Adicional := TItemContaCliente.Create;
                  Adicional.Codigo := FDAux.FieldByName('CODIGO').AsInteger;
                  Adicional.Ordem := FDAux.FieldByName('ORDEM').AsInteger;

                  TItemContaClienteDAO.getInstancia.buscar(Adicional);

                  ItemContaCliente.Adicionais.Add(Adicional);

                  TotalAdicional := TotalAdicional + Adicional.Total;

                  FDAux.Next;
                  Application.processMessages;
                end;
              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);

              FDAux := FConnection.prepareStatement
                (' select coalesce(sum(PFG.VALOR), 0) as TOTAL_PARCIAL_ITEM ' +
                'from PARCIAL_FORMAS_PAG PFG inner join PARCIAL_FORMAS_PAG_ITEM_CC '
                + 'PFGICC on PFGICC.COD_PARC_FORMA_PAG = PFG.COD_PARC where ' +
                'PFGICC.COD_CONTA_CLIENTE = :CODIGO and PFGICC.ORDEM = :ORDEM ');

              FDAux.ParamByName('CODIGO').AsInteger := ItemContaCliente.Codigo;
              FDAux.ParamByName('ORDEM').AsInteger := ItemContaCliente.Ordem;
              FDAux.Open;
              with FDAux do
              begin

                ItemContaCliente.ValorParcial :=
                  FDAux.FieldByName('TOTAL_PARCIAL_ITEM').AsCurrency;
              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);

              FDAux := FConnection.prepareStatement
                (' select PFG.COD_PARC as CODIGO, PFG.ORDEM_PAG_PARC as ORDEM, PFG.VALOR, '
                + 'PFG.COD_FORMA_PARC, PFG.DATA_HORA_PAG_PARC, PFG.HISTORICO, 0 as STATUS from '
                + 'PARCIAL_FORMAS_PAG PFG inner join PARCIAL_FORMAS_PAG_ITEM_CC PFPICC on '
                + 'PFPICC.COD_PARC_FORMA_PAG = PFG.COD_PARC where PFPICC.COD_CONTA_CLIENTE = :CODIGO and '
                + 'PFPICC.ORDEM = :ORDEM    ');

              FDAux.ParamByName('CODIGO').AsInteger := ItemContaCliente.Codigo;
              FDAux.ParamByName('ORDEM').AsInteger := ItemContaCliente.Ordem;
              FDAux.Open;
              { pagamentos parciais }
              with FDAux do
              begin
                DisableControls;
                Last;
                First;

                ItemContaCliente.PagamentosParciais :=
                  TObjectList<TPagamentoParcial>.Create;

                while not FDAux.Eof do
                begin
                  PagamentoParcial := TPagamentoParcial.Create;
                  PagamentoParcial.Codigo := FDAux.FieldByName('CODIGO')
                    .AsInteger;
                  PagamentoParcial.Ordem := FDAux.FieldByName('ORDEM')
                    .AsInteger;
                  PagamentoParcial.Valor := FDAux.FieldByName('VALOR')
                    .AsCurrency;
                  PagamentoParcial.FormaPagamento.Codigo :=
                    FDAux.FieldByName('COD_FORMA_PARC').AsInteger;
                  PagamentoParcial.DataHora :=
                    FDAux.FieldByName('DATA_HORA_PAG_PARC').AsDateTime;
                  PagamentoParcial.Historico :=
                    FDAux.FieldByName('HISTORICO').AsString;
                  PagamentoParcial.Status := FDAux.FieldByName('STATUS')
                    .AsInteger;

                  TFormaPagamentoDAO.getInstancia.buscar
                    (PagamentoParcial.FormaPagamento);

                  ItemContaCliente.PagamentosParciais.Add(PagamentoParcial);

                  FDAux.Next;
                end;

                EnableControls;

              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);

            end;

            if DMConexao.Configuracao.DiscriminarValorPorAdicionalRestante then
              ItemContaCliente.TotalAdicional := TotalAdicional;

            TProdutoDAO.getInstancia.buscar(ItemContaCliente.Produto);
            TVendedorDAO.getInstancia.buscar(ItemContaCliente.Garcom);
            TEmpresaDAO.getInstancia.buscar(ItemContaCliente.Empresa);
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

function TItemContaClienteDAO.buscaTodos(ContaCliente: TContaCliente)
  : TObjectList<TItemContaCliente>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  Adicional: TItemContaCliente;
  TotalAdicional: Currency;
  PagamentoParcial: TPagamentoParcial;
begin
  Result := TObjectList<TItemContaCliente>.Create;
  try
    try

      FDQuery := FConnection.prepareStatement
        ('select * from SP_BUSCA_ITENS_CONTA_CLIENTE(:codigoconta)');

      FDQuery.ParamByName('codigoconta').AsInteger := ContaCliente.Codigo;
      FDQuery.Open;
      with FDQuery do
      begin
        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            ItemContaCliente := TItemContaCliente.Create;
            ItemContaCliente.Produto.Codigo := FieldByName('COD_PRO').AsInteger;
            ItemContaCliente.Ordem := FieldByName('ORDEM').AsInteger;
            ItemContaCliente.Garcom.Codigo := FieldByName('COD_VEND').AsInteger;
            ItemContaCliente.Valor := FieldByName('VALOR').AsCurrency;
            ItemContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM')
              .AsInteger;
            ItemContaCliente.Cancelado := FieldByName('CANCELADO').AsInteger;
            ItemContaCliente.Empresa.Codigo := FieldByName('COD_EMP').AsInteger;
            ItemContaCliente.Quantidade := FieldByName('QUANT').AsCurrency;
            ItemContaCliente.Total := FieldByName('TOTAL').AsCurrency;
            ItemContaCliente.Impresso := FieldByName('IMPRESSO').AsString;
            ItemContaCliente.Hora := FieldByName('HORA').AsDateTime;
            ItemContaCliente.Observacao := FieldByName('OBSERVACAO').AsString;
            ItemContaCliente.OrdemParPizza := FieldByName('ORDEM_PAR_PIZZA')
              .AsInteger;
            ItemContaCliente.Feito := FieldByName('FEITO').AsString;
            ItemContaCliente.Avisado := FieldByName('AVISADO').AsString;
            ItemContaCliente.MotivoCancelamento :=
              FieldByName('MOTIVO_CANCELAMENTO').AsString;
            ItemContaCliente.DataHoraCancelamento :=
              FieldByName('DATA_HORA_CANCELAMENTO').AsDateTime;
            ItemContaCliente.ObservacaoPizza :=
              FieldByName('OBS_PIZZA').AsString;
            ItemContaCliente.OrdemItemPrincipal :=
              FieldByName('ORDEM_ITEM_PRINCIPAL').AsInteger;

            ItemContaCliente.ValorParcial := FieldByName('VALOR_PARCIAL')
              .AsCurrency;

            if FieldByName('TOTAL_ADICIONAL').AsInteger > 0 then
            begin
              TotalAdicional := 0;

              FDAux := FConnection.prepareStatement
                (' select ICC.CODIGO, ICC.ORDEM, ICC.COD_PRO, ICC.COD_VEND, ICC.VALOR, '
                + 'ICC.CONTA_ORIGEM, ICC.CANCELADO, ICC.COD_EMP, ICC.QUANT, ICC.TOTAL, '
                + 'ICC.IMPRESSO, ICC.HORA, ICC.OBSERVACAO, ICC.ORDEM_PAR_PIZZA, '
                + 'ICC.FEITO, ICC.AVISADO, ICC.MOTIVO_CANCELAMENTO, ' +
                'ICC.DATA_HORA_CANCELAMENTO, ICC.OBS_PIZZA, ICC.ORDEM_ITEM_PRINCIPAL '
                + 'from ITENS_CONTA_CLIENTE ICC where ICC.ORDEM_ITEM_PRINCIPAL = :CODIGO and '
                + 'ICC.CODIGO = :CONTA ');

              FDAux.ParamByName('CODIGO').AsInteger := ItemContaCliente.Ordem;
              FDAux.ParamByName('CONTA').AsInteger := ItemContaCliente.Codigo;
              FDAux.Open;
              with FDAux do
              begin
                ItemContaCliente.Adicionais :=
                  TObjectList<TItemContaCliente>.Create;

                while not FDAux.Eof do
                begin
                  Adicional := TItemContaCliente.Create;
                  Adicional.Codigo := FDAux.FieldByName('CODIGO').AsInteger;
                  Adicional.Ordem := FDAux.FieldByName('ORDEM').AsInteger;

                  TItemContaClienteDAO.getInstancia.buscar(Adicional);

                  ItemContaCliente.Adicionais.Add(Adicional);

                  TotalAdicional := TotalAdicional + Adicional.Total;

                  FDAux.Next;
                  Application.processMessages;
                end;
              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);
            end;

            if ItemContaCliente.ValorParcial > 0 then
            begin

              FDAux := FConnection.prepareStatement
                (' select PFG.COD_PARC as CODIGO, PFG.ORDEM_PAG_PARC as ORDEM, PFG.VALOR, '
                + 'PFG.COD_FORMA_PARC, PFG.DATA_HORA_PAG_PARC, PFG.HISTORICO, 0 as STATUS from '
                + 'PARCIAL_FORMAS_PAG PFG inner join PARCIAL_FORMAS_PAG_ITEM_CC PFPICC on '
                + 'PFPICC.COD_PARC_FORMA_PAG = PFG.COD_PARC where PFPICC.COD_CONTA_CLIENTE = :CODIGO and '
                + 'PFPICC.ORDEM = :ORDEM    ');

              FDAux.ParamByName('CODIGO').AsInteger := ItemContaCliente.Codigo;
              FDAux.ParamByName('ORDEM').AsInteger := ItemContaCliente.Ordem;
              FDAux.Open;
              { pagamentos parciais }
              with FDAux do
              begin
                DisableControls;
                Last;
                First;

                ItemContaCliente.PagamentosParciais :=
                  TObjectList<TPagamentoParcial>.Create;

                while not FDAux.Eof do
                begin
                  PagamentoParcial := TPagamentoParcial.Create;
                  PagamentoParcial.Codigo := FDAux.FieldByName('CODIGO')
                    .AsInteger;
                  PagamentoParcial.Ordem := FDAux.FieldByName('ORDEM')
                    .AsInteger;
                  PagamentoParcial.Valor := FDAux.FieldByName('VALOR')
                    .AsCurrency;
                  PagamentoParcial.FormaPagamento.Codigo :=
                    FDAux.FieldByName('COD_FORMA_PARC').AsInteger;
                  PagamentoParcial.DataHora :=
                    FDAux.FieldByName('DATA_HORA_PAG_PARC').AsDateTime;
                  PagamentoParcial.Historico :=
                    FDAux.FieldByName('HISTORICO').AsString;
                  PagamentoParcial.Status := FDAux.FieldByName('STATUS')
                    .AsInteger;

                  TFormaPagamentoDAO.getInstancia.buscar
                    (PagamentoParcial.FormaPagamento);

                  ItemContaCliente.PagamentosParciais.Add(PagamentoParcial);

                  FDAux.Next;
                end;

                EnableControls;

              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);
            end;

            if DMConexao.Configuracao.DiscriminarValorPorAdicionalRestante then
              ItemContaCliente.TotalAdicional := TotalAdicional;

            TProdutoDAO.getInstancia.buscar(ItemContaCliente.Produto);
            TVendedorDAO.getInstancia.buscar(ItemContaCliente.Garcom);
            TEmpresaDAO.getInstancia.buscar(ItemContaCliente.Empresa);
            Result.Add(ItemContaCliente);
            FDQuery.Next;
            Application.processMessages;
          end;
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

function TItemContaClienteDAO.buscaTodosConferencia(ContaCliente: TContaCliente)
  : TObjectList<TItemContaCliente>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  Adicional: TItemContaCliente;
  TotalAdicional: Currency;
  PagamentoParcial: TPagamentoParcial;
begin
  Result := TObjectList<TItemContaCliente>.Create;
  try
    try

      FDQuery := FConnection.prepareStatement
        ('select * from SP_BUSCA_ITENS_CONTA_CLIENTE(:codigoconta)');

      FDQuery.ParamByName('codigoconta').AsInteger := ContaCliente.Codigo;
      FDQuery.Open;
      with FDQuery do
      begin
        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            ItemContaCliente := TItemContaCliente.Create;
            ItemContaCliente.Produto.Codigo := FieldByName('COD_PRO').AsInteger;
            ItemContaCliente.Produto.Nome := FieldByName('NOME_PRO').AsString;
            ItemContaCliente.Produto.DescricaoCupom :=
              FieldByName('DESC_CUPOM').AsString;
            ItemContaCliente.Ordem := FieldByName('ORDEM').AsInteger;
            ItemContaCliente.Garcom.Codigo := FieldByName('COD_VEND').AsInteger;
            ItemContaCliente.Valor := FieldByName('VALOR').AsCurrency;
            ItemContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM')
              .AsInteger;
            ItemContaCliente.Cancelado := FieldByName('CANCELADO').AsInteger;
            ItemContaCliente.Quantidade := FieldByName('QUANT').AsCurrency;
            ItemContaCliente.Total := FieldByName('TOTAL').AsCurrency;
            ItemContaCliente.Impresso := FieldByName('IMPRESSO').AsString;
            ItemContaCliente.Hora := FieldByName('HORA').AsDateTime;
            ItemContaCliente.Observacao := FieldByName('OBSERVACAO').AsString;

            ItemContaCliente.MotivoCancelamento :=
              FieldByName('MOTIVO_CANCELAMENTO').AsString;
            ItemContaCliente.DataHoraCancelamento :=
              FieldByName('DATA_HORA_CANCELAMENTO').AsDateTime;
            ItemContaCliente.OrdemItemPrincipal :=
              FieldByName('ORDEM_ITEM_PRINCIPAL').AsInteger;

            ItemContaCliente.ValorParcial := FieldByName('VALOR_PARCIAL')
              .AsCurrency;

            if DMConexao.Configuracao.DiscriminarValorPorAdicionalRestante then
              ItemContaCliente.TotalAdicional := TotalAdicional;

            TVendedorDAO.getInstancia.buscar(ItemContaCliente.Garcom);
            Result.Add(ItemContaCliente);
            FDQuery.Next;
            Application.processMessages;
          end;
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

constructor TItemContaClienteDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

procedure TItemContaClienteDAO.excluir(ItemContaCliente: TItemContaCliente);
var
  FDQuery: TFDQuery;
begin
  if Assigned(ItemContaCliente) then
  begin
    try
      try
        FDQuery := FConnection.prepareStatement
          (' delete from ITENS_CONTA_CLIENTE ICC where ICC.CODIGO = :CODIGO AND ICC.ORDEM = :ORDEM ');

        FDQuery.ParamByName('CODIGO').AsInteger := ItemContaCliente.Codigo;
        FDQuery.ParamByName('ORDEM').AsInteger := ItemContaCliente.Ordem;
        FDQuery.ExecSQL;

        if Assigned(FDQuery) then
          FConnection.closeConnection(FDQuery);

        FDQuery := FConnection.prepareStatement
          (' delete from ITENS_CONTA_CLIENTE ICC where ICC.ORDEM_ITEM_PRINCIPAL '
          + '= :ORDEM_ITEM_PRINCIPAl AND ICC.CODIGO = :CODIGO ');

        FDQuery.ParamByName('CODIGO').AsInteger := ItemContaCliente.Codigo;
        FDQuery.ParamByName('ORDEM_ITEM_PRINCIPAl').AsInteger :=
          ItemContaCliente.Ordem;
        FDQuery.ExecSQL;

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

class function TItemContaClienteDAO.getInstancia: TItemContaClienteDAO;
begin
  if FInstancia = nil then
    FInstancia := TItemContaClienteDAO.Create;

  Result := FInstancia;
end;

procedure TItemContaClienteDAO.inserir(ItemContaCliente: TItemContaCliente);
var
  FDQuery: TFDQuery;
  I: Integer;
begin
  if Assigned(ItemContaCliente) then
  begin
    try
      try
        FDQuery := FConnection.prepareStatement
          ('INSERT INTO ITENS_CONTA_CLIENTE (CODIGO, ORDEM, COD_PRO, COD_VEND, '
          + 'QUANT, VALOR, CONTA_ORIGEM, COD_EMP, CANCELADO, IMPRESSO, HORA, OBSERVACAO, ORDEM_ITEM_PRINCIPAL) '
          + 'VALUES(:CODIGO, :ORDEM, :COD_PRO, :COD_VEND, :QUANT, :VALOR, :CONTA_ORIGEM, :COD_EMP, '
          + '0, :IMPRESSO, :HORA, :OBSERVACAO, :ORDEM_ITEM_PRINCIPAl) ');
        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := ItemContaCliente.Codigo;
          ParamByName('ORDEM').AsInteger := ItemContaCliente.Ordem;
          ParamByName('COD_PRO').AsInteger := ItemContaCliente.Produto.Codigo;
          ParamByName('COD_EMP').AsInteger := ItemContaCliente.Empresa.Codigo;
          ParamByName('COD_VEND').AsInteger := ItemContaCliente.Garcom.Codigo;
          ParamByName('QUANT').AsCurrency := ItemContaCliente.Quantidade;
          ParamByName('VALOR').AsCurrency := ItemContaCliente.Valor;
          ParamByName('IMPRESSO').AsString := ItemContaCliente.Impresso;
          ParamByName('HORA').AsDateTime := ItemContaCliente.Hora;
          ParamByName('OBSERVACAO').AsString := ItemContaCliente.Observacao;

          if ItemContaCliente.ContaOrigem <= 0 then
            ParamByName('CONTA_ORIGEM').Value := null
          else
            ParamByName('CONTA_ORIGEM').AsInteger :=
              ItemContaCliente.ContaOrigem;

          if ItemContaCliente.OrdemItemPrincipal <= 0 then
            ParamByName('ORDEM_ITEM_PRINCIPAl').Value := null
          else
            ParamByName('ORDEM_ITEM_PRINCIPAl').AsInteger :=
              ItemContaCliente.OrdemItemPrincipal;

          ExecSQL;
        end;

        for I := 0 to ItemContaCliente.Adicionais.Count - 1 do
          if ItemContaCliente.Adicionais.Items[I].Cancelado = 0 then
            TItemContaClienteDAO.getInstancia.inserir
              (ItemContaCliente.Adicionais.Items[I]);

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

procedure TItemContaClienteDAO.selItens(ContaCliente: TContaCliente);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  Adicional: TItemContaCliente;
  TotalAdicional: Currency;
  PagamentoParcial: TPagamentoParcial;
begin
  try
    try

      FDQuery := FConnection.prepareStatement
        ('select * from SP_BUSCA_ITENS_CONTA_CLIENTE(:codigoconta)');

      FDQuery.ParamByName('codigoconta').AsInteger := ContaCliente.Codigo;
      FDQuery.Open;

      ContaCliente.ItensContaCliente := TObjectList<TItemContaCliente>.Create;

      with FDQuery do
      begin
        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            ItemContaCliente := TItemContaCliente.Create;
            ItemContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ItemContaCliente.Produto.Codigo := FieldByName('COD_PRO').AsInteger;
            ItemContaCliente.Produto.Nome := FieldByName('NOME_PRO').AsString;
            ItemContaCliente.Produto.DescricaoCupom :=
              FieldByName('DESC_CUPOM').AsString;
            ItemContaCliente.Ordem := FieldByName('ORDEM').AsInteger;
            ItemContaCliente.Garcom.Codigo := FieldByName('COD_VEND').AsInteger;
            ItemContaCliente.Valor := FieldByName('VALOR').AsCurrency;
            ItemContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM')
              .AsInteger;
            ItemContaCliente.Cancelado := FieldByName('CANCELADO').AsInteger;
            ItemContaCliente.Empresa.Codigo := FieldByName('COD_EMP').AsInteger;
            ItemContaCliente.Quantidade := FieldByName('QUANT').AsCurrency;
            ItemContaCliente.Total := FieldByName('TOTAL').AsCurrency;
            ItemContaCliente.Impresso := FieldByName('IMPRESSO').AsString;
            ItemContaCliente.Hora := FieldByName('HORA').AsDateTime;
            ItemContaCliente.Observacao := FieldByName('OBSERVACAO').AsString;
            ItemContaCliente.OrdemParPizza := FieldByName('ORDEM_PAR_PIZZA')
              .AsInteger;
            ItemContaCliente.Feito := FieldByName('FEITO').AsString;
            ItemContaCliente.Avisado := FieldByName('AVISADO').AsString;
            ItemContaCliente.MotivoCancelamento :=
              FieldByName('MOTIVO_CANCELAMENTO').AsString;
            ItemContaCliente.DataHoraCancelamento :=
              FieldByName('DATA_HORA_CANCELAMENTO').AsDateTime;
            ItemContaCliente.ObservacaoPizza :=
              FieldByName('OBS_PIZZA').AsString;
            ItemContaCliente.OrdemItemPrincipal :=
              FieldByName('ORDEM_ITEM_PRINCIPAL').AsInteger;

            ItemContaCliente.ValorParcial := FieldByName('VALOR_PARCIAL')
              .AsCurrency;
            ContaCliente.ItensContaCliente.Add(ItemContaCliente);

            FDQuery.Next;
            Application.processMessages;
          end;
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
