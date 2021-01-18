unit uContaClienteDAO;

interface

uses
  uContaCliente, uDMConexao, uItemContaCliente, FireDAC.Comp.Client,
  System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TContaClienteDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TContaClienteDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TContaClienteDAO;
    procedure atualizaProdutosImpressos(Codigo: Integer);
    function existeMesaAberta(Conta: Integer; Empresa: Integer): Boolean;
    procedure buscar(ContaCliente: TContaCliente);
    procedure buscarConferencia(ContaCliente: TContaCliente);
    procedure buscarComanda(ContaCliente: TContaCliente);
    procedure buscarParciais(ContaCliente: TContaCliente);
    procedure selMesa(ContaCliente: TContaCliente; EstadoItens: Boolean);
    procedure buscarAtualizacao(ContaCliente: TContaCliente);
    procedure inserir(ContaCliente: TContaCliente);
    procedure alterar(ContaCliente: TContaCliente);
    procedure excluir(ContaCliente: TContaCliente);
    procedure transferirItens(ContaOrigem, ContaDestino: TContaCliente;
      ItensTransferencia: TObjectList<TItemContaCliente>);
    function buscaTodos: TObjectList<TContaCliente>; overload;
    function buscaTodos(EdtDataIni, EdtDataFin: TDateTime)
      : TObjectList<TContaCliente>; overload;
    function buscaTodos(EdtDataIni, EdtDataFin: TDateTime;
      aberto, cancelado, fechado: Boolean; agrupar: Boolean)
      : TObjectList<TContaCliente>; overload;
  published
    { published declarations }
  end;

implementation

uses
  Fmx.Forms, System.SysUtils, uCaixaDAO, uEmpresaDAO,
  System.Variants, uItemContaClienteDAO, uSetorDAO,
  uIndicadorDAO, uPagamentoParcial, uPagamentoParcialDAO, UVendaDAO, uVenda,
  uCaixa, uIndicador;

{ TContaClienteDAO }

procedure TContaClienteDAO.alterar(ContaCliente: TContaCliente);
var
  FDQuery: TFDQuery;
begin
  if Assigned(ContaCliente) then
  begin
    try
      try
        FDQuery := FConnection.prepareStatement
          ('update CONTA_CLIENTE set TOTAL = :TOTAL, ' +
          'DISPENSAR_TAXA_SERVICO = :DISPTAXA, NUM_PESSOAS = :NUM, ' +
          'DESC_MESA = :desc, COD_SETOR = :CODSETOR, ' +
          'COD_IND = :CODIND, COD_CAI = :CODCAI, ' +
          'CONFERENCIA_EMITIDA = :CONFERENCIAEMITIDA, ' +
          'DATA_FECHAMENTO = :DATAFECHAMENTO, ' +
          'HORA_FECHAMENTO = :HORAFECHAMENTO, STATUS = :STATUS, ' +
          'COD_VENDA = :CODVENDA, ' +
          'MOTIVO_CANCELAMENTO = :MOTIVOCANCELAMENTO, ' +
          'DATA_HORA_CANCELAMENTO = :DATAHORACANCELAMENTO ' +
          'where CODIGO = :CODIGO   ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
          ParamByName('TOTAL').AsCurrency := ContaCliente.Total;
          ParamByName('DISPTAXA').AsString := ContaCliente.DispensarTaxaServico;
          ParamByName('NUM').AsInteger := ContaCliente.NumeroPessoas;
          ParamByName('desc').AsString := ContaCliente.DescricaoMesa;

          if ContaCliente.Setor.Codigo > 0 then
            ParamByName('CODSETOR').AsInteger := ContaCliente.Setor.Codigo
          else
            ParamByName('CODSETOR').Value := null;

          if Assigned(ContaCliente.Indicador) then
          begin
            if ContaCliente.Indicador.Codigo > 0 then
              ParamByName('CODIND').AsInteger := ContaCliente.Indicador.Codigo
            else
              ParamByName('CODIND').Value := null
          end
          else
            ParamByName('CODIND').Value := null;

          ParamByName('CODCAI').AsInteger := ContaCliente.Caixa.Codigo;
          ParamByName('CONFERENCIAEMITIDA').AsString :=
            ContaCliente.ConferenciaEmitida;

          if ContaCliente.DataFechamento <= 0 then
            ParamByName('DATAFECHAMENTO').Value := null
          else
            ParamByName('DATAFECHAMENTO').ASDateTime :=
              ContaCliente.DataFechamento;

          if ContaCliente.HoraFechamento <= 0 then
            ParamByName('HORAFECHAMENTO').Value := null
          else
            ParamByName('HORAFECHAMENTO').ASDateTime :=
              ContaCliente.HoraFechamento;

          ParamByName('STATUS').AsInteger := ContaCliente.Status;

          if Assigned(ContaCliente.Venda) then
            ParamByName('CODVENDA').AsInteger := ContaCliente.Venda.Codigo
          else
            ParamByName('CODVENDA').Value := null;

          ParamByName('MOTIVOCANCELAMENTO').AsString :=
            ContaCliente.MotivoCancelamento;

          if ContaCliente.DataHoraCancelamento <= 0 then
            ParamByName('DATAHORACANCELAMENTO').Value := null
          else
            ParamByName('DATAHORACANCELAMENTO').ASDateTime :=
              ContaCliente.DataHoraCancelamento;

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

procedure TContaClienteDAO.atualizaProdutosImpressos(Codigo: Integer);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        ('update ITENS_CONTA_CLIENTE ICC set ICC.IMPRESSO = ' + quotedstr('S') +
        'where ICC.CODIGO = :CODIGO and  ICC.CANCELADO = 0');
      FDQuery.ParamByName('CODIGO').AsInteger := Codigo;

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

procedure TContaClienteDAO.buscar(ContaCliente: TContaCliente);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  Parcial: TPagamentoParcial;
  sSQL: String;
begin
  if Assigned(ContaCliente) then
  begin
    try
      try
        if ContaCliente.Codigo > 0 then
        begin

          sSQL := ' select * from SP_BUSCA_CONTA_CLIENTE_CODIGO(:CODIGO) ';

          FDQuery := FConnection.prepareStatement(sSQL);
          FDQuery.ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
        end
        else
        begin
          if ((ContaCliente.Conta > 0) and (ContaCliente.Status = 0) and
            (ContaCliente.Empresa.Razao <> '')) then
          begin
            sSQL := ' select * from SP_BUSCA_CONTA_CLIENTE_CONTA(:CONTA, :CODEMP)  ';
            FDQuery := FConnection.prepareStatement(sSQL);
            FDQuery.ParamByName('CONTA').AsInteger := ContaCliente.Conta;
            FDQuery.ParamByName('CODEMP').AsInteger :=
              ContaCliente.Empresa.Codigo;
          end;
        end;

        with FDQuery do
        begin

          Open;

          if RecordCount > 0 then
          begin
            ContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ContaCliente.ContadorConta := FieldByName('CONTADOR_CONTA')
              .AsInteger;
            ContaCliente.DataAbertura := FieldByName('DATA_ABERTURA')
              .ASDateTime;
            ContaCliente.HoraAbertura := FieldByName('HORA_ABERTURA')
              .ASDateTime;

            if FieldByName('DATA_FECHAMENTO').IsNull then
              ContaCliente.DataFechamento := 0
            else
              ContaCliente.DataFechamento := FieldByName('DATA_FECHAMENTO')
                .ASDateTime;

            if FieldByName('HORA_FECHAMENTO').IsNull then
              ContaCliente.HoraFechamento := 0
            else
              ContaCliente.HoraFechamento := FieldByName('HORA_FECHAMENTO')
                .ASDateTime;

            ContaCliente.Caixa.Codigo := FieldByName('COD_CAI').AsInteger;

            if not FieldByName('COD_VENDA').IsNull then
            begin
              ContaCliente.Venda := TVenda.Create;
              ContaCliente.Venda.Codigo := FieldByName('COD_VENDA').AsInteger;
              TVendaDAO.getInstancia.buscar(ContaCliente.Venda);
            end
            else
              ContaCliente.Venda := nil;

            ContaCliente.Conta := FieldByName('CONTA').AsInteger;
            ContaCliente.Caixa.Codigo := FieldByName('COD_CAI').AsInteger;
            ContaCliente.Empresa.Codigo := FieldByName('COD_EMP').AsInteger;
            ContaCliente.Caixa.Empresa := ContaCliente.Empresa;
            ContaCliente.Status := FieldByName('STATUS').AsInteger;
            ContaCliente.DispensarTaxaServico :=
              FieldByName('DISPENSAR_TAXA_SERVICO').AsString;
            ContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM').AsInteger;
            ContaCliente.ConferenciaEmitida :=
              FieldByName('CONFERENCIA_EMITIDA').AsString;
            ContaCliente.Coo := FieldByName('COO').AsInteger;
            ContaCliente.MotivoCancelamento :=
              FieldByName('MOTIVO_CANCELAMENTO').AsString;

            if FieldByName('DATA_HORA_CANCELAMENTO').IsNull then
              ContaCliente.DataHoraCancelamento := 0
            else
              ContaCliente.DataHoraCancelamento :=
                FieldByName('DATA_HORA_CANCELAMENTO').ASDateTime;

            ContaCliente.VendaDelivery := FieldByName('VENDA_DELIVERY')
              .AsString;

            if FieldByName('COD_IND').IsNull then
              ContaCliente.Indicador := nil
            else
              ContaCliente.Indicador.Codigo := FieldByName('COD_IND').AsInteger;

            ContaCliente.TaxaServicoCobrada :=
              FieldByName('TAXA_SERVICO_COBRADA').AsCurrency;
            ContaCliente.NumeroPessoas := FieldByName('NUM_PESSOAS').AsInteger;
            ContaCliente.VendaBalcao := FieldByName('VENDA_BALCAO').AsString;
            ContaCliente.DescricaoMesa := FieldByName('DESC_MESA').AsString;
            ContaCliente.Setor.Codigo := FieldByName('COD_SETOR').AsInteger;
            ContaCliente.ItensContaCliente :=
              TItemContaClienteDAO.getInstancia.buscaTodos(ContaCliente);

            ContaCliente.Total := FieldByName('TOTAL').AsCurrency;

            ContaCliente.ValorPacial := 0;

            ContaCliente.PagamentosParciais :=
              TObjectList<TPagamentoParcial>.Create;

            FDAux := FConnection.prepareStatement
              (' select PFPCC.CODIGO, PFPCC.ORDEM from PARCIAL_FORMAS_PAG PFG '
              + 'inner join PARCIAL_FORMAS_PAG_CC PFPCC on PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
              + 'where PFPCC.COD_CONTA_CLIENTE = :CODIGO  ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
              Open;
              First;

              while not FDAux.Eof do
              begin
                Parcial := TPagamentoParcial.Create;
                Parcial.Codigo := FieldByName('CODIGO').AsInteger;
                Parcial.Ordem := FieldByName('ORDEM').AsInteger;
                TPagamentoParcialDAO.getInstancia.buscar(Parcial);
                ContaCliente.ValorPacial := ContaCliente.ValorPacial +
                  Parcial.Valor;

                ContaCliente.PagamentosParciais.Add(Parcial);
                FDAux.Next;
                Application.processMessages;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            ContaCliente.ValorPacial := ContaCliente.ValorPacial +
              FieldByName('TOTAL_PARCIAL_FORMAS').AsCurrency;

            ContaCliente.OrdemFinal := FieldByName('ULTIMA_ORDEM_ITENS')
              .AsInteger;

            TEmpresaDAO.getInstancia.buscar(ContaCliente.Empresa);
            TCaixaDAO.getInstancia.buscar(ContaCliente.Caixa);
            TSetorDAO.getInstancia.buscar(ContaCliente.Setor);
            if Assigned(ContaCliente.Indicador) then
              TIndicadorDAO.getInstancia.buscar(ContaCliente.Indicador);
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

procedure TContaClienteDAO.buscarAtualizacao(ContaCliente: TContaCliente);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  Parcial: TPagamentoParcial;
begin
  if Assigned(ContaCliente) then
  begin
    try
      try
        if ContaCliente.Codigo > 0 then
        begin

          FDQuery := FConnection.prepareStatement
            (' select CC.CODIGO, (select coalesce((sum(coalesce(ICC.QUANT, 0) * '
            + 'coalesce(ICC.VALOR, 0))), 0) as TOTAL from ITENS_CONTA_CLIENTE ICC '
            + 'where ICC.CODIGO = :CODIGO and ' +
            'ICC.CANCELADO = 0) as TOTAL, CC.CONTADOR_CONTA, CC.DATA_ABERTURA, CC.HORA_ABERTURA, '
            + 'CC.CONTA, CC.DATA_FECHAMENTO, CC.HORA_FECHAMENTO, CC.COD_CAI, CC.COD_EMP, '
            + 'CC.STATUS, CC.COD_VENDA, CC.TOTAL, CC.DISPENSAR_TAXA_SERVICO, CC.CONTA_ORIGEM, '
            + 'CC.CONFERENCIA_EMITIDA, CC.COO, CC.MOTIVO_CANCELAMENTO, ' +
            'CC.DATA_HORA_CANCELAMENTO, CC.VENDA_DELIVERY, CC.COD_IND, ' +
            'CC.TAXA_SERVICO_COBRADA, CC.NUM_PESSOAS, CC.VENDA_BALCAO, CC.DESC_MESA, '
            + 'CC.COD_SETOR from CONTA_CLIENTE CC where CC.CODIGO = :CODIGO   ');
          FDQuery.ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
        end
        else
        begin
          if ((ContaCliente.Conta > 0) and (ContaCliente.Status = 0) and
            (ContaCliente.Empresa.Razao <> '')) then
          begin

            FDQuery := FConnection.prepareStatement
              (' select CC.CODIGO, (select coalesce((sum(coalesce(ICC.QUANT, 0) '
              + '* coalesce(ICC.VALOR, 0))), 0) as TOTAL from ITENS_CONTA_CLIENTE ICC '
              + 'where ICC.CODIGO = :CODIGO and ICC.CANCELADO = 0  ) as TOTAL, CC.CONTADOR_CONTA, CC.DATA_ABERTURA, CC.HORA_ABERTURA, '
              + 'CC.CONTA, CC.COD_VENDA, CC.DATA_FECHAMENTO, CC.HORA_FECHAMENTO, CC.COD_CAI, CC.COD_EMP, '
              + 'CC.STATUS, CC.TOTAL, CC.DISPENSAR_TAXA_SERVICO, CC.CONTA_ORIGEM, '
              + 'CC.CONFERENCIA_EMITIDA, CC.COO, CC.MOTIVO_CANCELAMENTO, ' +
              'CC.DATA_HORA_CANCELAMENTO, CC.VENDA_DELIVERY, CC.COD_IND, ' +
              'CC.TAXA_SERVICO_COBRADA, CC.NUM_PESSOAS, CC.VENDA_BALCAO, CC.DESC_MESA, '
              + 'CC.COD_SETOR from CONTA_CLIENTE CC where CC.CONTA = :CONTA and '
              + 'CC.STATUS = 0 and CC.COD_EMP = :CODEMP ');
            FDQuery.ParamByName('CONTA').AsInteger := ContaCliente.Conta;
            FDQuery.ParamByName('CODEMP').AsInteger :=
              ContaCliente.Empresa.Codigo;
          end;
        end;

        with FDQuery do
        begin
          Open;

          if RecordCount > 0 then
          begin
            ContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ContaCliente.ContadorConta := FieldByName('CONTADOR_CONTA')
              .AsInteger;
            ContaCliente.DataAbertura := FieldByName('DATA_ABERTURA')
              .ASDateTime;
            ContaCliente.HoraAbertura := FieldByName('HORA_ABERTURA')
              .ASDateTime;

            ContaCliente.Conta := FieldByName('CONTA').AsInteger;

            if FieldByName('COD_IND').IsNull then
              ContaCliente.Indicador := nil
            else
              ContaCliente.Indicador.Codigo := FieldByName('COD_IND').AsInteger;

            ContaCliente.NumeroPessoas := FieldByName('NUM_PESSOAS').AsInteger;
            ContaCliente.DescricaoMesa := FieldByName('DESC_MESA').AsString;

            ContaCliente.Total := FieldByName('TOTAL').AsCurrency;

            ContaCliente.ValorPacial := 0;

            ContaCliente.PagamentosParciais :=
              TObjectList<TPagamentoParcial>.Create;

            FDAux := FConnection.prepareStatement
              (' select PFPCC.CODIGO, PFPCC.ORDEM from PARCIAL_FORMAS_PAG PFG '
              + 'inner join PARCIAL_FORMAS_PAG_CC PFPCC on PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
              + 'where PFPCC.COD_CONTA_CLIENTE = :CODIGO  ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
              Open;
              First;

              while not FDAux.Eof do
              begin
                Parcial := TPagamentoParcial.Create;
                Parcial.Codigo := FieldByName('CODIGO').AsInteger;
                Parcial.Ordem := FieldByName('ORDEM').AsInteger;
                TPagamentoParcialDAO.getInstancia.buscar(Parcial);
                ContaCliente.ValorPacial := ContaCliente.ValorPacial +
                  Parcial.Valor;

                ContaCliente.PagamentosParciais.Add(Parcial);
                FDAux.Next;
                Application.processMessages;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' select coalesce(sum(PFG.VALOR), 0) as TOTAL_VALOR_PARC_ITENS '
              + 'from PARCIAL_FORMAS_PAG PFG inner join PARCIAL_FORMAS_PAG_ITEM_CC PFPCC on '
              + 'PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC where PFPCC.COD_CONTA_CLIENTE = :CODIGO    ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
              Open;
              First;

              ContaCliente.ValorPacial := ContaCliente.ValorPacial +
                FieldByName('TOTAL_VALOR_PARC_ITENS').AsCurrency;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            if Assigned(ContaCliente.Indicador) then
              TIndicadorDAO.getInstancia.buscar(ContaCliente.Indicador);
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

procedure TContaClienteDAO.buscarComanda(ContaCliente: TContaCliente);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  Parcial: TPagamentoParcial;
  sSQL: String;
begin
  if Assigned(ContaCliente) then
  begin
    try
      try
        sSQL := ' select CC.CODIGO, (select coalesce((sum(coalesce(ICC.QUANT, '
          + '0) * coalesce(ICC.VALOR, 0))), 0) as TOTAL ' +
          '    from ITENS_CONTA_CLIENTE ICC ' +
          '   where ICC.CODIGO = CC.CODIGO and ' +
          '        ICC.CANCELADO = 0) as TOTAL, CC.CONTADOR_CONTA, CC.DATA_ABERTURA, CC.HORA_ABERTURA, CC.CONTA, '
          + '       CC.DATA_FECHAMENTO, CC.HORA_FECHAMENTO, CC.COD_CAI, CC.COD_EMP, CC.STATUS, CC.COD_VENDA, CC.TOTAL, '
          + '       CC.DISPENSAR_TAXA_SERVICO, CC.CONTA_ORIGEM, CC.CONFERENCIA_EMITIDA, CC.COO, CC.MOTIVO_CANCELAMENTO, '
          + '      CC.DATA_HORA_CANCELAMENTO, CC.VENDA_DELIVERY, CC.COD_IND, CC.TAXA_SERVICO_COBRADA, CC.NUM_PESSOAS, '
          + '     CC.VENDA_BALCAO, CC.DESC_MESA, CC.COD_SETOR, ' +
          '    (select coalesce(sum(PFG.VALOR), 0) as TOTAL_VALOR_PARC_ITENS ' +
          '    from PARCIAL_FORMAS_PAG PFG ' +
          '   inner join PARCIAL_FORMAS_PAG_ITEM_CC PFPCC on PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
          + '  where PFPCC.COD_CONTA_CLIENTE = CC.CODIGO) as TOTAL_PARCIAL_FORMAS, '
          + '(select first 1 ICC.ORDEM as TOTAL ' +
          '        from ITENS_CONTA_CLIENTE ICC ' +
          '       where ICC.CODIGO = CC.CODIGO ' +
          '      order by ICC.ORDEM desc) as ULTIMA_ORDEM_ITENS ' +
          'from CONTA_CLIENTE CC ' + 'where CC.CODIGO = :CODIGO      ';

        FDQuery := FConnection.prepareStatement(sSQL);
        FDQuery.ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;

        with FDQuery do
        begin

          Open;

          if RecordCount > 0 then
          begin
            ContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ContaCliente.ContadorConta := FieldByName('CONTADOR_CONTA')
              .AsInteger;
            ContaCliente.DataAbertura := FieldByName('DATA_ABERTURA')
              .ASDateTime;
            ContaCliente.HoraAbertura := FieldByName('HORA_ABERTURA')
              .ASDateTime;

            ContaCliente.Conta := FieldByName('CONTA').AsInteger;

            ContaCliente.DispensarTaxaServico :=
              FieldByName('DISPENSAR_TAXA_SERVICO').AsString;
            ContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM').AsInteger;
            ContaCliente.ConferenciaEmitida :=
              FieldByName('CONFERENCIA_EMITIDA').AsString;

            if FieldByName('COD_IND').IsNull then
              ContaCliente.Indicador := nil
            else
              ContaCliente.Indicador.Codigo := FieldByName('COD_IND').AsInteger;

            ContaCliente.TaxaServicoCobrada :=
              FieldByName('TAXA_SERVICO_COBRADA').AsCurrency;
            ContaCliente.NumeroPessoas := FieldByName('NUM_PESSOAS').AsInteger;

            ContaCliente.DescricaoMesa := FieldByName('DESC_MESA').AsString;
            ContaCliente.Setor.Codigo := FieldByName('COD_SETOR').AsInteger;

            ContaCliente.ItensContaCliente :=
              TItemContaClienteDAO.getInstancia.buscaTodosConferencia
              (ContaCliente);

            ContaCliente.Total := FieldByName('TOTAL').AsCurrency;

            ContaCliente.ValorPacial := 0;

            ContaCliente.ValorPacial := ContaCliente.ValorPacial +
              FieldByName('TOTAL_PARCIAL_FORMAS').AsCurrency;

            ContaCliente.OrdemFinal := FieldByName('ULTIMA_ORDEM_ITENS')
              .AsInteger;

            TSetorDAO.getInstancia.buscar(ContaCliente.Setor);

            if Assigned(ContaCliente.Indicador) then
              TIndicadorDAO.getInstancia.buscar(ContaCliente.Indicador);
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

procedure TContaClienteDAO.buscarConferencia(ContaCliente: TContaCliente);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  Parcial: TPagamentoParcial;
  sSQL: String;
begin
  if Assigned(ContaCliente) then
  begin
    try
      try
        sSQL := ' select CC.CODIGO, (select coalesce((sum(coalesce(ICC.QUANT, '
          + '0) * coalesce(ICC.VALOR, 0))), 0) as TOTAL ' +
          '    from ITENS_CONTA_CLIENTE ICC ' +
          '   where ICC.CODIGO = CC.CODIGO and ' +
          '        ICC.CANCELADO = 0) as TOTAL, CC.CONTADOR_CONTA, CC.DATA_ABERTURA, CC.HORA_ABERTURA, CC.CONTA, '
          + '       CC.DATA_FECHAMENTO, CC.HORA_FECHAMENTO, CC.COD_CAI, CC.COD_EMP, CC.STATUS, CC.COD_VENDA, CC.TOTAL, '
          + '       CC.DISPENSAR_TAXA_SERVICO, CC.CONTA_ORIGEM, CC.CONFERENCIA_EMITIDA, CC.COO, CC.MOTIVO_CANCELAMENTO, '
          + '      CC.DATA_HORA_CANCELAMENTO, CC.VENDA_DELIVERY, CC.COD_IND, CC.TAXA_SERVICO_COBRADA, CC.NUM_PESSOAS, '
          + '     CC.VENDA_BALCAO, CC.DESC_MESA, CC.COD_SETOR, ' +
          '    (select coalesce(sum(PFG.VALOR), 0) as TOTAL_VALOR_PARC_ITENS ' +
          '    from PARCIAL_FORMAS_PAG PFG ' +
          '   inner join PARCIAL_FORMAS_PAG_ITEM_CC PFPCC on PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
          + '  where PFPCC.COD_CONTA_CLIENTE = CC.CODIGO) as TOTAL_PARCIAL_FORMAS, '
          + '(select first 1 ICC.ORDEM as TOTAL ' +
          '        from ITENS_CONTA_CLIENTE ICC ' +
          '       where ICC.CODIGO = CC.CODIGO ' +
          '      order by ICC.ORDEM desc) as ULTIMA_ORDEM_ITENS ' +
          'from CONTA_CLIENTE CC ' + 'where CC.CODIGO = :CODIGO      ';

        FDQuery := FConnection.prepareStatement(sSQL);
        FDQuery.ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;

        with FDQuery do
        begin

          Open;

          if RecordCount > 0 then
          begin
            ContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ContaCliente.ContadorConta := FieldByName('CONTADOR_CONTA')
              .AsInteger;
            ContaCliente.DataAbertura := FieldByName('DATA_ABERTURA')
              .ASDateTime;
            ContaCliente.HoraAbertura := FieldByName('HORA_ABERTURA')
              .ASDateTime;

            ContaCliente.Conta := FieldByName('CONTA').AsInteger;

            ContaCliente.DispensarTaxaServico :=
              FieldByName('DISPENSAR_TAXA_SERVICO').AsString;
            ContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM').AsInteger;
            ContaCliente.ConferenciaEmitida :=
              FieldByName('CONFERENCIA_EMITIDA').AsString;

            if FieldByName('COD_IND').IsNull then
              ContaCliente.Indicador := nil
            else
              ContaCliente.Indicador.Codigo := FieldByName('COD_IND').AsInteger;

            ContaCliente.TaxaServicoCobrada :=
              FieldByName('TAXA_SERVICO_COBRADA').AsCurrency;
            ContaCliente.NumeroPessoas := FieldByName('NUM_PESSOAS').AsInteger;

            ContaCliente.DescricaoMesa := FieldByName('DESC_MESA').AsString;
            ContaCliente.Setor.Codigo := FieldByName('COD_SETOR').AsInteger;

            ContaCliente.ItensContaCliente :=
              TItemContaClienteDAO.getInstancia.buscaTodosConferencia
              (ContaCliente);

            ContaCliente.Total := FieldByName('TOTAL').AsCurrency;

            ContaCliente.ValorPacial := 0;

            ContaCliente.ValorPacial := ContaCliente.ValorPacial +
              FieldByName('TOTAL_PARCIAL_FORMAS').AsCurrency;

            ContaCliente.OrdemFinal := FieldByName('ULTIMA_ORDEM_ITENS')
              .AsInteger;

            TSetorDAO.getInstancia.buscar(ContaCliente.Setor);

            if Assigned(ContaCliente.Indicador) then
              TIndicadorDAO.getInstancia.buscar(ContaCliente.Indicador);
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

procedure TContaClienteDAO.buscarParciais(ContaCliente: TContaCliente);
var
  FDAux: TFDQuery;
  Parcial: TPagamentoParcial;
begin
  ContaCliente.ValorPacial := 0;

  ContaCliente.PagamentosParciais := TObjectList<TPagamentoParcial>.Create;

  FDAux := FConnection.prepareStatement
    (' select PFPCC.CODIGO, PFPCC.ORDEM from PARCIAL_FORMAS_PAG PFG ' +
    'inner join PARCIAL_FORMAS_PAG_CC PFPCC on PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
    + 'where PFPCC.COD_CONTA_CLIENTE = :CODIGO  ');

  with FDAux do
  begin
    ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
    Open;
    First;

    while not FDAux.Eof do
    begin
      Parcial := TPagamentoParcial.Create;
      Parcial.Codigo := FieldByName('CODIGO').AsInteger;
      Parcial.Ordem := FieldByName('ORDEM').AsInteger;
      TPagamentoParcialDAO.getInstancia.buscar(Parcial);
      ContaCliente.ValorPacial := ContaCliente.ValorPacial + Parcial.Valor;

      ContaCliente.PagamentosParciais.Add(Parcial);
      FDAux.Next;
      Application.processMessages;
    end;
  end;

  if Assigned(FDAux) then
    FConnection.closeConnection(FDAux);
end;

function TContaClienteDAO.buscaTodos(EdtDataIni, EdtDataFin: TDateTime)
  : TObjectList<TContaCliente>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  ContaCliente: TContaCliente;
  Contas: TObjectList<TContaCliente>;
begin
  Contas := TObjectList<TContaCliente>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        ('SELECT * FROM CONTA_CLIENTE C WHERE C.COD_EMP ' +
        ' = :CODEMP and (C.STATUS = 0 or C.STATUS = 1 or C.STATUS = 2) and (cast(DATA_ABERTURA + HORA_ABERTURA '
        + ' as timestamp) BETWEEN :DATAINI AND :DATAFIN) and coalesce(C.VENDA_DELIVERY, :N) = :N ORDER BY C.CONTA');

      with FDQuery do
      begin
        ParamByName('CODEMP').AsInteger := DMConexao.Empresa.Codigo;
        ParamByName('DATAINI').ASDateTime := EdtDataIni;
        ParamByName('DATAFIN').ASDateTime := EdtDataFin;
        ParamByName('N').AsString := 'N';
        Open;
        Last;
        First;

        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            ContaCliente := TContaCliente.Create;
            ContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ContaCliente.ContadorConta := FieldByName('CONTADOR_CONTA')
              .AsInteger;
            ContaCliente.DataAbertura := FieldByName('DATA_ABERTURA')
              .ASDateTime;
            ContaCliente.HoraAbertura := FieldByName('HORA_ABERTURA')
              .ASDateTime;

            ContaCliente.Conta := FieldByName('CONTA').AsInteger;
            ContaCliente.Status := FieldByName('STATUS').AsInteger;
            ContaCliente.Total := FieldByName('TOTAL').AsCurrency;
            ContaCliente.DispensarTaxaServico :=
              FieldByName('DISPENSAR_TAXA_SERVICO').AsString;
            ContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM').AsInteger;
            ContaCliente.NumeroPessoas := FieldByName('NUM_PESSOAS').AsInteger;
            ContaCliente.DescricaoMesa := FieldByName('DESC_MESA').AsString;

            FDAux := FConnection.prepareStatement
              (' select sum(PFG.VALOR) as TOTAL_PARCIAL from PARCIAL_FORMAS_PAG PFG '
              + 'inner join PARCIAL_FORMAS_PAG_CC PFPCC on PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
              + 'where PFPCC.COD_CONTA_CLIENTE = :CODIGO    ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
              Open;

              ContaCliente.ValorPacial := FieldByName('TOTAL_PARCIAL')
                .AsCurrency;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' select coalesce(sum(PFG.VALOR), 0) as TOTAL_VALOR_PARC_ITENS '
              + 'from PARCIAL_FORMAS_PAG PFG inner join PARCIAL_FORMAS_PAG_ITEM_CC PFPCC on '
              + 'PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC where PFPCC.COD_CONTA_CLIENTE = :CODIGO    ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
              Open;
              First;

              ContaCliente.ValorPacial := ContaCliente.ValorPacial +
                FieldByName('TOTAL_VALOR_PARC_ITENS').AsCurrency;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            Contas.Add(ContaCliente);
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
    result := Contas;
  end;
end;

function TContaClienteDAO.buscaTodos: TObjectList<TContaCliente>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  ContaCliente: TContaCliente;
  Contas: TObjectList<TContaCliente>;
  I: Integer;
begin
  Contas := TObjectList<TContaCliente>.Create;
  try
    try

      FDQuery := FConnection.prepareStatement
        ('SELECT * FROM CONTA_CLIENTE C WHERE C.COD_EMP = :CODEMP ' +
        'and coalesce(C.VENDA_DELIVERY, :N) = :NORDER BY C.CONTA DESC');

      with FDQuery do
      begin
        ParamByName('CODEMP').AsInteger := DMConexao.Empresa.Codigo;
        ParamByName('N').AsString := 'N';
        Open;

        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            ContaCliente := TContaCliente.Create;
            ContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ContaCliente.ContadorConta := FieldByName('CONTADOR_CONTA')
              .AsInteger;

            ContaCliente.Conta := FieldByName('CONTA').AsInteger;
            ContaCliente.Status := FieldByName('STATUS').AsInteger;
            ContaCliente.Total := FieldByName('TOTAL').AsCurrency;
            ContaCliente.DispensarTaxaServico :=
              FieldByName('DISPENSAR_TAXA_SERVICO').AsString;
            ContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM').AsInteger;
            ContaCliente.NumeroPessoas := FieldByName('NUM_PESSOAS').AsInteger;
            ContaCliente.DescricaoMesa := FieldByName('DESC_MESA').AsString;

            FDAux := FConnection.prepareStatement
              (' select sum(PFG.VALOR) as TOTAL_PARCIAL from PARCIAL_FORMAS_PAG PFG '
              + 'inner join PARCIAL_FORMAS_PAG_CC PFPCC on PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
              + 'where PFPCC.COD_CONTA_CLIENTE = :CODIGO    ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
              Open;

              ContaCliente.ValorPacial := FieldByName('TOTAL_PARCIAL')
                .AsCurrency;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' select coalesce(sum(PFG.VALOR), 0) as TOTAL_VALOR_PARC_ITENS '
              + 'from PARCIAL_FORMAS_PAG PFG inner join PARCIAL_FORMAS_PAG_ITEM_CC PFPCC on '
              + 'PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC where PFPCC.COD_CONTA_CLIENTE = :CODIGO    ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
              Open;
              First;

              ContaCliente.ValorPacial := ContaCliente.ValorPacial +
                FieldByName('TOTAL_VALOR_PARC_ITENS').AsCurrency;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            Contas.Add(ContaCliente);
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
    result := Contas;
  end;
end;

constructor TContaClienteDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

procedure TContaClienteDAO.excluir(ContaCliente: TContaCliente);
var
  FDQuery: TFDQuery;
begin
  if Assigned(ContaCliente) then
  begin
    try
      try

        FDQuery := FConnection.prepareStatement
          (' delete from CONTA_CLIENTE CC where CC.CODIGO = :CODIGO ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
          ExecSQL;
        end;

      except
        on E: Exception do
          raise Exception.Create(E.Message);
      end;
    finally
      if Assigned(FDQuery) then
        FConnection.closeConnection(FDQuery);
      FreeAndNil(ContaCliente);
    end;
  end;
end;

function TContaClienteDAO.existeMesaAberta(Conta, Empresa: Integer): Boolean;
var
  FDQuery: TFDQuery;
begin
  result := false;
  try
    try

      FDQuery := FConnection.prepareStatement
        (' select cc.codigo from conta_cliente cc ' +
        'where cc.conta = :conta and cc.status = 0 and cc.cod_emp = :codemp ');

      with FDQuery do
      begin
        ParamByName('conta').AsInteger := Conta;
        ParamByName('codemp').AsInteger := Empresa;
        Open;
      end;

      if FDQuery.RecordCount <= 0 then
        result := false
      else
        result := true;

    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
  end;
end;

class function TContaClienteDAO.getInstancia: TContaClienteDAO;
begin
  if FInstancia = nil then
    FInstancia := TContaClienteDAO.Create;

  result := FInstancia;
end;

procedure TContaClienteDAO.inserir(ContaCliente: TContaCliente);
var
  FDQuery: TFDQuery;
begin
  if Assigned(ContaCliente) then
  begin
    try
      try

        FDQuery := FConnection.prepareStatement
          ('SELECT * FROM SP_INSERT_CONTA_CLIENTE(:DATA, :HORA, :CONTA, ' +
          ':CODCAI, :CODEMP)');

        with FDQuery do
        begin
          ParamByName('DATA').AsDate := Date;
          ParamByName('HORA').ASDateTime := now;
          ParamByName('CONTA').AsInteger := ContaCliente.Conta;
          ParamByName('CODCAI').AsInteger := ContaCliente.Caixa.Codigo;
          ParamByName('CODEMP').AsInteger := ContaCliente.Empresa.Codigo;
          Open;

          if RecordCount > 0 then
          begin
            ContaCliente.Codigo := FDQuery.FieldByName('CODIGO').AsInteger;
            buscar(ContaCliente);

            ContaCliente.DispensarTaxaServico := 'N';
            alterar(ContaCliente);
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

procedure TContaClienteDAO.selMesa(ContaCliente: TContaCliente;
  EstadoItens: Boolean);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  Parcial: TPagamentoParcial;
  sSQL: String;
begin
  if Assigned(ContaCliente) then
  begin
    try
      try
        if ((ContaCliente.Conta > 0) and (ContaCliente.Status = 0) and
          (ContaCliente.Empresa.Razao <> '')) then
        begin
          sSQL := 'select CC.CODIGO, CC.CONTA, CC.STATUS, ' +
            'CC.CONFERENCIA_EMITIDA from CONTA_CLIENTE CC ' +
            'where CC.CONTA = :CONTA and  CC.STATUS = 0 and  CC.COD_EMP = :CODEMP   ';
          FDQuery := FConnection.prepareStatement(sSQL);
          FDQuery.ParamByName('CONTA').AsInteger := ContaCliente.Conta;
          FDQuery.ParamByName('CODEMP').AsInteger :=
            ContaCliente.Empresa.Codigo;
        end;

        with FDQuery do
        begin

          Open;

          if RecordCount > 0 then
          begin
            ContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ContaCliente.Conta := FieldByName('CONTA').AsInteger;
            ContaCliente.Caixa.Codigo := FieldByName('COD_CAI').AsInteger;
            ContaCliente.Empresa.Codigo := FieldByName('COD_EMP').AsInteger;
            ContaCliente.Caixa.Empresa := ContaCliente.Empresa;
            ContaCliente.Status := FieldByName('STATUS').AsInteger;
            ContaCliente.DispensarTaxaServico :=
              FieldByName('DISPENSAR_TAXA_SERVICO').AsString;
            ContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM').AsInteger;
            ContaCliente.ConferenciaEmitida :=
              FieldByName('CONFERENCIA_EMITIDA').AsString;
            ContaCliente.Coo := FieldByName('COO').AsInteger;
            ContaCliente.MotivoCancelamento :=
              FieldByName('MOTIVO_CANCELAMENTO').AsString;

            if FieldByName('DATA_HORA_CANCELAMENTO').IsNull then
              ContaCliente.DataHoraCancelamento := 0
            else
              ContaCliente.DataHoraCancelamento :=
                FieldByName('DATA_HORA_CANCELAMENTO').ASDateTime;

            ContaCliente.VendaDelivery := FieldByName('VENDA_DELIVERY')
              .AsString;

            if FieldByName('COD_IND').IsNull then
              ContaCliente.Indicador := nil
            else
              ContaCliente.Indicador.Codigo := FieldByName('COD_IND').AsInteger;

            ContaCliente.TaxaServicoCobrada :=
              FieldByName('TAXA_SERVICO_COBRADA').AsCurrency;
            ContaCliente.NumeroPessoas := FieldByName('NUM_PESSOAS').AsInteger;
            ContaCliente.VendaBalcao := FieldByName('VENDA_BALCAO').AsString;
            ContaCliente.DescricaoMesa := FieldByName('DESC_MESA').AsString;
            ContaCliente.Setor.Codigo := FieldByName('COD_SETOR').AsInteger;
            ContaCliente.ItensContaCliente :=
              TItemContaClienteDAO.getInstancia.buscaTodos(ContaCliente);

            ContaCliente.Total := FieldByName('TOTAL').AsCurrency;

            ContaCliente.ValorPacial := 0;

            ContaCliente.PagamentosParciais :=
              TObjectList<TPagamentoParcial>.Create;

            FDAux := FConnection.prepareStatement
              (' select PFPCC.CODIGO, PFPCC.ORDEM from PARCIAL_FORMAS_PAG PFG '
              + 'inner join PARCIAL_FORMAS_PAG_CC PFPCC on PFPCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
              + 'where PFPCC.COD_CONTA_CLIENTE = :CODIGO  ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
              Open;
              First;

              while not FDAux.Eof do
              begin
                Parcial := TPagamentoParcial.Create;
                Parcial.Codigo := FieldByName('CODIGO').AsInteger;
                Parcial.Ordem := FieldByName('ORDEM').AsInteger;
                TPagamentoParcialDAO.getInstancia.buscar(Parcial);
                ContaCliente.ValorPacial := ContaCliente.ValorPacial +
                  Parcial.Valor;

                ContaCliente.PagamentosParciais.Add(Parcial);
                FDAux.Next;
                Application.processMessages;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            ContaCliente.ValorPacial := ContaCliente.ValorPacial +
              FieldByName('TOTAL_PARCIAL_FORMAS').AsCurrency;

            ContaCliente.OrdemFinal := FieldByName('ULTIMA_ORDEM_ITENS')
              .AsInteger;

            TEmpresaDAO.getInstancia.buscar(ContaCliente.Empresa);
            TCaixaDAO.getInstancia.buscar(ContaCliente.Caixa);
            TSetorDAO.getInstancia.buscar(ContaCliente.Setor);
            if Assigned(ContaCliente.Indicador) then
              TIndicadorDAO.getInstancia.buscar(ContaCliente.Indicador);
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

procedure TContaClienteDAO.transferirItens(ContaOrigem,
  ContaDestino: TContaCliente;
  ItensTransferencia: TObjectList<TItemContaCliente>);
var
  I: Integer;
  ItemTransferencia, Adicional: TItemContaCliente;
  Y: Integer;
begin
  try
    try

      { EXCLUINDO ITENS DA TRANSFERENCIA ANTIGA }
      for I := 0 to ItensTransferencia.Count - 1 do
      begin
        ItensTransferencia.Items[I].Codigo := ContaOrigem.Codigo;
        if ItensTransferencia.Items[I].Quantidade = ItensTransferencia.Items[I].QuantidadeTransferencia
        then
        begin
          TItemContaClienteDAO.getInstancia.excluir
            (ItensTransferencia.Items[I]);
        end
        else
        begin
          ItensTransferencia.Items[I].Quantidade := ItensTransferencia.Items[I]
            .Quantidade - ItensTransferencia.Items[I].QuantidadeTransferencia;
          TItemContaClienteDAO.getInstancia.alterar
            (ItensTransferencia.Items[I]);
        end;
      end;

      { INSERIR OS ITENS NO DESTINO }
      for I := 0 to ItensTransferencia.Count - 1 do
      begin
        ItemTransferencia := ItensTransferencia.Items[I];
        ItemTransferencia.Codigo := ContaDestino.Codigo;
        ItemTransferencia.ContaOrigem := ContaOrigem.Conta;
        ContaDestino.OrdemFinal := ContaDestino.OrdemFinal + 1;
        ItemTransferencia.Ordem := ContaDestino.OrdemFinal;
        ItemTransferencia.Quantidade :=
          ItemTransferencia.QuantidadeTransferencia;

        for Y := 0 to ItemTransferencia.Adicionais.Count - 1 do
        begin
          ItemTransferencia.Adicionais.Items[Y].Codigo := ContaDestino.Codigo;
          ItemTransferencia.Adicionais.Items[Y].ContaOrigem :=
            ContaOrigem.Conta;
          ContaDestino.OrdemFinal := ContaDestino.OrdemFinal + 1;
          ItemTransferencia.Adicionais.Items[Y].Ordem :=
            ContaDestino.OrdemFinal;
          ItemTransferencia.Adicionais.Items[Y].OrdemItemPrincipal :=
            ItemTransferencia.Ordem;
        end;

        TItemContaClienteDAO.getInstancia.inserir(ItemTransferencia);
        ContaDestino.ItensContaCliente.Add(ItemTransferencia);
      end;

    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally

  end;
end;

function TContaClienteDAO.buscaTodos(EdtDataIni, EdtDataFin: TDateTime;
  aberto, cancelado, fechado: Boolean; agrupar: Boolean)
  : TObjectList<TContaCliente>;
var
  FDQuery: TFDQuery;
  ItemContaCliente: TItemContaCliente;
  ContaCliente: TContaCliente;
  Contas: TObjectList<TContaCliente>;
  sSQL: String;
begin
  Contas := TObjectList<TContaCliente>.Create;
  result := Contas;

  if not aberto then
    if not cancelado then
      if not fechado then
        exit;

  try
    try
      sSQL := '';
      sSQL := sSQL + inttostr(DMConexao.Empresa.Codigo) + ', ' +
        quotedstr(formatdatetime('yyyy-mm-dd', EdtDataIni)) + ', ' +
        quotedstr(formatdatetime('yyyy-mm-dd', EdtDataFin)) + ', ';
      if aberto then
        sSQL := sSQL + '1, '
      else
        sSQL := sSQL + '0, ';

      if cancelado then
        sSQL := sSQL + '1, '
      else
        sSQL := sSQL + '0, ';

      if fechado then
        sSQL := sSQL + '1, '
      else
        sSQL := sSQL + '0, ';

      if agrupar then
        sSQL := sSQL + '1'
      else
        sSQL := sSQL + '0';

      FDQuery := FConnection.prepareStatement
        ('select * from SP_BUSCA_CONTAS_CLIENTE(' + sSQL + ')');

      FDQuery.Open;
      with FDQuery do
      begin
        Last;
        First;

        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            ContaCliente := TContaCliente.Create;
            ContaCliente.Codigo := FieldByName('CODIGO').AsInteger;
            ContaCliente.ContadorConta := FieldByName('CONTADOR_CONTA')
              .AsInteger;
            ContaCliente.DataAbertura := FieldByName('DATA_ABERTURA')
              .ASDateTime;
            ContaCliente.HoraAbertura := FieldByName('HORA_ABERTURA')
              .ASDateTime;

            ContaCliente.Conta := FieldByName('CONTA').AsInteger;
            ContaCliente.Status := FieldByName('STATUS').AsInteger;
            ContaCliente.DispensarTaxaServico :=
              FieldByName('DISPENSAR_TAXA_SERVICO').AsString;
            ContaCliente.ContaOrigem := FieldByName('CONTA_ORIGEM').AsInteger;
            ContaCliente.NumeroPessoas := FieldByName('NUM_PESSOAS').AsInteger;
            ContaCliente.DescricaoMesa := FieldByName('DESC_MESA').AsString;
            ContaCliente.ConferenciaEmitida :=
              FieldByName('CONFERENCIA_EMITIDA').AsString;

            if ContaCliente.Caixa = nil then
              ContaCliente.Caixa := TCaixa.Create;

            ContaCliente.Caixa.Codigo := FieldByName('COD_CAI').AsInteger;

            if ContaCliente.Indicador = nil then
              ContaCliente.Indicador := TIndicador.Create;

            ContaCliente.Indicador.Codigo := FieldByName('COD_IND').AsInteger;

            if not FieldByName('COD_VENDA').IsNull then
            begin
              ContaCliente.Venda := TVenda.Create;
              ContaCliente.Venda.Codigo := FieldByName('COD_VENDA').AsInteger;

              TVendaDAO.getInstancia.buscarInf(ContaCliente.Venda);
            end;

            ContaCliente.Total := FieldByName('TOTAL').AsCurrency;

            ContaCliente.ValorPacial := FieldByName('VALOR_PARCIAL').AsCurrency;

            ContaCliente.OrdemFinal := FieldByName('ULTIMA_ORDEM_ITENS')
              .AsInteger;

            Contas.Add(ContaCliente);
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
    result := Contas;
  end;
end;

end.
