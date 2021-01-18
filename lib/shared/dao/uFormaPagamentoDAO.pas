unit uFormaPagamentoDAO;

interface

uses
  uFormaPagamento, System.Generics.Collections, uClass,
  uConexaoFiredac;

type
{$TYPEINFO ON}
  TFormaPagamentoDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TFormaPagamentoDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure buscar(FormaPagamento: TFormaPagamento);
    function buscaTodos: TObjectList<TFormaPagamento>;
    function buscaTroco: TFormaPagamento;
    class function getInstancia: TFormaPagamentoDAO;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, FMX.Forms;

{ TFormaPagamentoDAO }

procedure TFormaPagamentoDAO.buscar(FormaPagamento: TFormaPagamento);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        ('select FP.CODIGO, FP.DESCRICAO, FP.TIPO, FP.TIPO_CARTAO from FORMAS_PAGAMENTO FP where FP.CODIGO = :CODIGO');

      FDQuery.ParamByName('CODIGO').AsInteger := FormaPagamento.Codigo;
      FDQuery.Open;

      if Assigned(FormaPagamento) then
      begin
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            FormaPagamento.Descricao := FieldByName('DESCRICAO').AsString;
            FormaPagamento.Tipo := FieldByName('TIPO').AsString;
            if FieldByName('TIPO_CARTAO').AsString = 'C' then
              FormaPagamento.TipoCartao := opCredito
            else
              FormaPagamento.TipoCartao := opDebito;
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

function TFormaPagamentoDAO.buscaTodos: TObjectList<TFormaPagamento>;
var
  FDQuery: TFDQuery;
  FormaPagamento: TFormaPagamento;
  FormasPagamento: TObjectList<TFormaPagamento>;
begin
  FormasPagamento := TObjectList<TFormaPagamento>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        ('select FP.CODIGO, FP.DESCRICAO, FP.TIPO from ' +
        'FORMAS_PAGAMENTO FP WHERE FP.TIPO <> ' + QuoTedStr('TR') +
        'AND FP.USAR_VENDAS_RETAGUARDA = ' + QuoTedStr('S') +
        ' ORDER BY FP.CODIGO ');

      FDQuery.Open;
      with FDQuery do
      begin
        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            FormaPagamento := TFormaPagamento.Create;
            FormaPagamento.Codigo := FieldByName('CODIGO').AsInteger;
            FormaPagamento.Descricao := FieldByName('DESCRICAO').AsString;
            FormaPagamento.Tipo := FieldByName('TIPO').AsString;

            FormasPagamento.Add(FormaPagamento);
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
    result := FormasPagamento;
  end;
end;

function TFormaPagamentoDAO.buscaTroco: TFormaPagamento;
var
  FDQuery: TFDQuery;
  FormaPagamento: TFormaPagamento;
begin

  FormaPagamento := TFormaPagamento.Create;

  try
    try
      FDQuery := FConnection.prepareStatement
        (' select first 1 FP.CODIGO, FP.DESCRICAO, FP.TIPO ' +
        'from FORMAS_PAGAMENTO FP where FP.TIPO = ' + QuoTedStr('TR'));
      FDQuery.Open;
      with FDQuery do
      begin
        if RecordCount > 0 then
        begin
          FormaPagamento.Codigo := FieldByName('CODIGO').AsInteger;
          FormaPagamento.Descricao := FieldByName('DESCRICAO').AsString;
          FormaPagamento.Tipo := FieldByName('TIPO').AsString;
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
    result := FormaPagamento;
  end;
end;

constructor TFormaPagamentoDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TFormaPagamentoDAO.getInstancia: TFormaPagamentoDAO;
begin
  if FInstancia = nil then
    FInstancia := TFormaPagamentoDAO.Create;

  result := FInstancia;
end;

end.
