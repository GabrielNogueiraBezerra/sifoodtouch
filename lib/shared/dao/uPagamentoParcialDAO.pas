unit uPagamentoParcialDAO;

interface

uses
  uPagamentoParcial, System.Generics.Collections, uContaCliente,
  uItemContaCliente, uConexaoFiredac;

type
{$TYPEINFO ON}
  TPagamentoParcialDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TPagamentoParcialDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TPagamentoParcialDAO;
    procedure buscar(PagamentoParcial: TPagamentoParcial);
    procedure inserir(PagamentoParcial: TPagamentoParcial); overload;
    procedure inserir(ItemContaCliente: TItemContaCliente;
      PagamentoParcial: TPagamentoParcial); overload;
    procedure excluir(PagamentoParcial: TPagamentoParcial;
      ItemContaCliente: TItemContaCliente);
    function buscaTodos(ContaCliente: TContaCliente)
      : TObjectList<TPagamentoParcial>; overload;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils, uFormaPagamentoDAO;

{ TPagamentoParcialDAO }

procedure TPagamentoParcialDAO.buscar(PagamentoParcial: TPagamentoParcial);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select PFGCC.CODIGO, PFGCC.ORDEM, PFG.VALOR, PFG.COD_FORMA_PARC, PFG.DATA_HORA_PAG_PARC, '
        + 'PFG.HISTORICO, 0 as STATUS from PARCIAL_FORMAS_PAG PFG inner join PARCIAL_FORMAS_PAG_CC '
        + 'PFGCC on PFGCC.COD_PARC_FORMA_PAG = PFG.COD_PARC where PFGCC.CODIGO = :CODIGO and '
        + 'PFGCC.ORDEM = :ORDEM ');

      if Assigned(PagamentoParcial) then
      begin
        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := PagamentoParcial.Codigo;
          ParamByName('ORDEM').AsInteger := PagamentoParcial.Ordem;
          Open;

          if RecordCount > 0 then
          begin
            PagamentoParcial.Codigo := FieldByName('CODIGO').AsInteger;
            PagamentoParcial.Ordem := FieldByName('ORDEM').AsInteger;
            PagamentoParcial.Valor := FieldByName('VALOR').AsCurrency;
            PagamentoParcial.FormaPagamento.Codigo :=
              FieldByName('COD_FORMA_PARC').AsInteger;
            PagamentoParcial.DataHora := FieldByName('DATA_HORA_PAG_PARC')
              .AsDateTime;
            PagamentoParcial.Historico := FieldByName('HISTORICO').AsString;
            PagamentoParcial.Status := FieldByName('STATUS').AsInteger;

            TFormaPagamentoDAO.getInstancia.buscar
              (PagamentoParcial.FormaPagamento);
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

function TPagamentoParcialDAO.buscaTodos(ContaCliente: TContaCliente)
  : TObjectList<TPagamentoParcial>;
var
  Pagamentos: TObjectList<TPagamentoParcial>;
  Pagamento: TPagamentoParcial;
  FDQuery: TFDQuery;
begin

  Pagamentos := TObjectList<TPagamentoParcial>.Create;

  try
    try
      if Assigned(ContaCliente) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select PFGCC.CODIGO, PFGCC.ORDEM, PFG.VALOR, PFG.COD_FORMA_PARC, '
          + 'PFG.DATA_HORA_PAG_PARC, PFG.HISTORICO, 0 as STATUS from PARCIAL_FORMAS_PAG '
          + 'PFG inner join PARCIAL_FORMAS_PAG_CC PFGCC on PFGCC.COD_PARC_FORMA_PAG = PFG.COD_PARC '
          + 'where PFGCC.COD_CONTA_CLIENTE = :CODIGO  ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := ContaCliente.Codigo;
          Open;
          Last;
          First;

          if RecordCount > 0 then
          begin
            while not FDQuery.Eof do
            begin
              Pagamento := TPagamentoParcial.Create;
              Pagamento.Codigo := FDQuery.FieldByName('CODIGO').AsInteger;
              Pagamento.Ordem := FDQuery.FieldByName('ORDEM').AsInteger;
              Pagamento.Valor := FDQuery.FieldByName('VALOR').AsCurrency;
              Pagamento.FormaPagamento.Codigo :=
                FDQuery.FieldByName('COD_FORMA_PARC').AsInteger;
              Pagamento.DataHora := FDQuery.FieldByName('DATA_HORA_PAG_PARC')
                .AsDateTime;
              Pagamento.Historico := FDQuery.FieldByName('HISTORICO').AsString;
              Pagamento.Status := FDQuery.FieldByName('STATUS').AsInteger;

              FDQuery.Next;
            end;
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
    result := Pagamentos;
  end;

end;

constructor TPagamentoParcialDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

procedure TPagamentoParcialDAO.excluir(PagamentoParcial: TPagamentoParcial;
  ItemContaCliente: TItemContaCliente);
var
  FDQuery: TFDQuery;
begin
  try
    try

      if Assigned(ItemContaCliente) then
        FDQuery := FConnection.prepareStatement
          (' delete from PARCIAL_FORMAS_PAG PFG ' +
          'where PFG.COD_PARC = :CODIGO AND ORDEM_PAG_PARC = :ORDEM  ')
      else
        FDQuery := FConnection.prepareStatement
          (' delete from PARCIAL_FORMAS_PAG PFG ' +
          'where PFG.COD_PARC = (select PFGCC.COD_PARC_FORMA_PAG ' +
          'from PARCIAL_FORMAS_PAG_CC PFGCC ' +
          'where PFGCC.CODIGO = :CODIGO and ' + 'PFGCC.ORDEM = :ORDEM)      ');

      if Assigned(PagamentoParcial) then
      begin
        with FDQuery do
        begin

          ParamByName('CODIGO').AsInteger := PagamentoParcial.Codigo;
          ParamByName('ORDEM').AsInteger := PagamentoParcial.Ordem;
          ExecSQL;

          Close;
          SQL.Clear;
          if Assigned(ItemContaCliente) then
          begin
            SQL.Add(' delete from PARCIAL_FORMAS_PAG_ITEM_CC PFGICC ' +
              'where PFGICC.COD_CONTA_CLIENTE = :CODCONTA and PFGICC.ORDEM = :ORDEM and '
              + 'PFGICC.COD_PARC_FORMA_PAG = :COD_PARC_FORM_PAG    ');
            ParamByName('CODCONTA').AsInteger := ItemContaCliente.Codigo;
            ParamByName('ORDEM').AsInteger := ItemContaCliente.Ordem;
            ParamByName('COD_PARC_FORM_PAG').AsInteger :=
              PagamentoParcial.Codigo;
          end
          else
          begin
            SQL.Add(' delete from PARCIAL_FORMAS_PAG_CC PFGCC ' +
              'where PFGCC.CODIGO = :CODIGO and ' +
              'PFGCC.ORDEM = :ORDEM       ');
            ParamByName('CODIGO').AsInteger := PagamentoParcial.Codigo;
            ParamByName('ORDEM').AsInteger := PagamentoParcial.Ordem;
          end;
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

class function TPagamentoParcialDAO.getInstancia: TPagamentoParcialDAO;
begin
  if FInstancia = nil then
    FInstancia := TPagamentoParcialDAO.Create;

  result := FInstancia;
end;

procedure TPagamentoParcialDAO.inserir(ItemContaCliente: TItemContaCliente;
  PagamentoParcial: TPagamentoParcial);
var
  FDQuery: TFDQuery;
begin
  if (Assigned(ItemContaCliente) and (Assigned(PagamentoParcial))) then
  begin
    try
      try

        FDQuery := FConnection.prepareStatement
          (' execute procedure SP_INSERE_PARCIAL_ITEM_CC(:COD_FORMA_PAG, ' +
          ':VALOR, :COD_CAI, :COD_EMP, :COD_USU, :COD_CONTA_CLI, ' +
          ':ORDEM_CONTA_CLI) ');

        with FDQuery do
        begin

          ParamByName('COD_FORMA_PAG').AsInteger :=
            PagamentoParcial.FormaPagamento.Codigo;
          ParamByName('VALOR').AsCurrency := PagamentoParcial.Valor;
          ParamByName('COD_CAI').AsInteger :=
            DMConexao.Configuracao.Caixa.Codigo;
          ParamByName('COD_EMP').AsInteger :=
            DMConexao.Configuracao.Empresa.Codigo;
          ParamByName('COD_USU').AsInteger := DMConexao.Usuario.Codigo;
          ParamByName('COD_CONTA_CLI').AsInteger := ItemContaCliente.Codigo;
          ParamByName('ORDEM_CONTA_CLI').AsInteger := ItemContaCliente.Ordem;

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

procedure TPagamentoParcialDAO.inserir(PagamentoParcial: TPagamentoParcial);
var
  FDQuery: TFDQuery;
begin
  if Assigned(PagamentoParcial) then
  begin
    try
      try

        FDQuery := FConnection.prepareStatement
          (' select * from SP_INSERE_PARCIAL_CONTA_CLIENTE(:COD_FORMA_PAG, :VALOR, :COD_CAI, :COD_EMP '
          + ', :COD_USU, :COD_CONTA_CLI) ');

        with FDQuery do
        begin
          ParamByName('COD_FORMA_PAG').AsInteger :=
            PagamentoParcial.FormaPagamento.Codigo;
          ParamByName('VALOR').AsCurrency := PagamentoParcial.Valor;
          ParamByName('COD_CAI').AsInteger :=
            DMConexao.Configuracao.Caixa.Codigo;
          ParamByName('COD_EMP').AsInteger :=
            DMConexao.Configuracao.Empresa.Codigo;
          ParamByName('COD_USU').AsInteger := DMConexao.Usuario.Codigo;
          ParamByName('COD_CONTA_CLI').AsInteger :=
            PagamentoParcial.CodigoContaCliente;
          Open;

          if RecordCount > 0 then
          begin
            PagamentoParcial.Codigo := FieldByName('CODIGO_PARC').AsInteger;
            PagamentoParcial.Ordem := FieldByName('ORDEM_PARC').AsInteger;

            TPagamentoParcialDAO.getInstancia.buscar(PagamentoParcial);
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

end.
