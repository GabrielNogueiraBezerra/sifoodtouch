unit uContaReceberCartaoDAO;

interface

uses
  uContaReceberCartao, uVenda, uConexaoFiredac;

type
{$TYPEINFO ON}
  TContaReceberCartaoDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TContaReceberCartaoDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TContaReceberCartaoDAO;
    procedure buscar(ContaReceberCartao: TContaReceberCartao);
    procedure inserir(ContaReceberCartao: TContaReceberCartao; Venda: TVenda);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, System.Variants;

{ TContaReceberCartaoDAO }

procedure TContaReceberCartaoDAO.buscar(ContaReceberCartao
  : TContaReceberCartao);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(ContaReceberCartao) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select CRAC.CODIGO_BANDEIRA, CRAC.OBS, CRAC.CODIGO, CRAC.NUMERO_AUTORIZACAO, CRAC.TAXA, '
          + 'CRAC.VALOR, CRAC.COD_CLI, CRAC.VENCIMENTO, CRAC.COD_CAI, CRAC.COD_EMP, '
          + 'CRAC.EMISSAO, CRAC.PARCELA from CONTAS_RECEBER_ADM_CARTAO CRAC where CRAC.CODIGO = :CODIGO   ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := ContaReceberCartao.Codigo;
          Open;

          if RecordCount > 0 then
          begin
            ContaReceberCartao.Codigo := FieldByName('CODIGO').AsInteger;
            ContaReceberCartao.BandeiraCartao.Codigo :=
              FieldByName('CODIGO_BANDEIRA').AsInteger;
            ContaReceberCartao.Emissao := FieldByName('EMISSAO').AsDateTime;
            ContaReceberCartao.Vencimento := FieldByName('VENCIMENTO')
              .AsDateTime;
            ContaReceberCartao.Caixa.Codigo := FieldByName('COD_CAI').AsInteger;
            ContaReceberCartao.Empresa.Codigo := FieldByName('COD_EMP')
              .AsInteger;
            ContaReceberCartao.Valor := FieldByName('VALOR').AsCurrency;
            ContaReceberCartao.Cliente.Codigo := FieldByName('COD_CLI')
              .AsInteger;
            ContaReceberCartao.Parcela := FieldByName('PARCELA').AsInteger;
            ContaReceberCartao.NumeroAutorizacao :=
              FieldByName('NUMERO_AUTORIZACAO').AsString;
            ContaReceberCartao.Observacao := FieldByName('OBS').AsString;
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

constructor TContaReceberCartaoDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TContaReceberCartaoDAO.getInstancia: TContaReceberCartaoDAO;
begin
  if FInstancia = nil then
    FInstancia := TContaReceberCartaoDAO.Create;

  result := FInstancia;
end;

procedure TContaReceberCartaoDAO.inserir(ContaReceberCartao
  : TContaReceberCartao; Venda: TVenda);
var
  FDQuery: TFDQuery;
  I: Integer;
begin
  try
    try
      if Assigned(ContaReceberCartao) and Assigned(Venda) then
      begin
        FDQuery := FConnection.prepareStatement
          (' insert into CONTAS_RECEBER_ADM_CARTAO (CODIGO, CODIGO_BANDEIRA, EMISSAO, VENCIMENTO, '
          + 'COD_CAI, COD_EMP, COD_VEN, VALOR, VALOR_PAGO, ACRESCIMO, DESCONTO, TAXA, COD_CLI, DOCUMENTO, '
          + 'PARCELA, OBS, COD_ENT_HOSP, COD_ALUGUEL, COD_OS, NUMERO_AUTORIZACAO, COD_RESERVA, COD_NF) '
          + 'values (gen_id(GNT_COD_CTR_ADM, 1), :BAND, :EMISSAO, :VENCTO, :CAI, :EMP, '
          + ':VEN, :VALOR, 0, 0, 0, :TAXA, :CODCLI, :DOCUMENTO, :PARCELA, :OBS, '
          + ':CODENTHOSP, :CODALUGUEL, :CODOS, :NUMERO_AUTORIZACAO, :CODRESERVA, :CODNF)     ');

        with FDQuery do
        begin
          ParamByName('band').AsInteger :=
            ContaReceberCartao.BandeiraCartao.Codigo;
          ParamByName('emissao').AsDate := ContaReceberCartao.Emissao;
          ParamByName('vencto').AsDate := ContaReceberCartao.Vencimento;
          ParamByName('cai').AsInteger := ContaReceberCartao.Caixa.Codigo;
          ParamByName('emp').AsInteger := ContaReceberCartao.Empresa.Codigo;
          ParamByName('ven').AsInteger := Venda.Codigo;
          ParamByName('valor').AsCurrency := ContaReceberCartao.Valor;
          ParamByName('taxa').AsCurrency := ContaReceberCartao.Taxa;
          ParamByName('codcli').AsInteger := ContaReceberCartao.Cliente.Codigo;
          ParamByName('documento').Value := null;
          ParamByName('parcela').AsInteger := ContaReceberCartao.Parcela;
          ParamByName('obs').AsString := ContaReceberCartao.Observacao;
          ParamByName('numero_autorizacao').AsString :=
            ContaReceberCartao.NumeroAutorizacao;
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
