unit uContaReceberDAO;

interface

uses
  uContaReceber, uConexaoFiredac;

type
{$TYPEINFO ON}
  TContaReceberDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TContaReceberDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TContaReceberDAO;
    procedure buscar(ContaReceber: TContaReceber);
    procedure inserir(ContaReceber: TContaReceber);
  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils, FireDAC.Comp.Client;

{ TContaReceberDAO }

procedure TContaReceberDAO.buscar(ContaReceber: TContaReceber);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(ContaReceber) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select COD_CTR, SEQUENCIA_CTR, COD_EMP, DATA_CTR, COD_VENDA, COD_CLI, '
          + 'VENCTO_CTR, VALOR_CTR, CAIXA_EMISSAO_CTR, PARCELA_CTR, DTPAGTO_CTR, VLRPAGO_CTR, '
          + 'COD_COB, NUMDOCUMENTO_CTR, CODIGO_CLASSIFICACAO, OBS_CTR from CONTAS_RECEBER '
          + 'where COD_CTR = :CODIGO and SEQUENCIA_CTR = :SEQUENCIA     ');
        FDQuery.ParamByName('CODIGO').AsInteger := ContaReceber.Codigo;
        FDQuery.ParamByName('SEQUENCIA').AsInteger := ContaReceber.Sequencia;

        FDQuery.Open;
        with FDQuery do
        begin

          if RecordCount > 0 then
          begin
            ContaReceber.Codigo := FieldBYName('COD_CTR').AsInteger;
            ContaReceber.Sequencia := FieldBYName('SEQUENCIA_CTR').AsInteger;
            ContaReceber.Empresa.Codigo := FieldBYName('COD_EMP').AsInteger;
            ContaReceber.Data := FieldBYName('DATA_CTR').ASDateTime;
            ContaReceber.CodigoVenda := FieldBYName('COD_VENDA').AsInteger;
            ContaReceber.CodigoCliente := FieldBYName('COD_CLI').AsInteger;
            ContaReceber.Vencimento := FieldBYName('VENCTO_CTR').ASDateTime;
            ContaReceber.Valor := FieldBYName('VALOR_CTR').AsCurrency;
            ContaReceber.Caixa.Codigo := FieldBYName('CAIXA_EMISSAO_CTR')
              .AsInteger;
            ContaReceber.Parcela := FieldBYName('PARCELA_CTR').AsInteger;
            ContaReceber.DataPagamento := FieldBYName('DTPAGTO_CTR').ASDateTime;
            ContaReceber.ValorPagamento := FieldBYName('VLRPAGO_CTR')
              .AsCurrency;
            ContaReceber.CodigoCobranca := FieldBYName('COD_COB').AsInteger;
            ContaReceber.NumeroDocumento :=
              FieldBYName('NUMDOCUMENTO_CTR').AsString;
            ContaReceber.CodigoClassificacao :=
              FieldBYName('CODIGO_CLASSIFICACAO').AsInteger;
            ContaReceber.Observacao := FieldBYName('OBS_CTR').AsString;
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

constructor TContaReceberDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TContaReceberDAO.getInstancia: TContaReceberDAO;
begin
  if FInstancia = nil then
    FInstancia := TContaReceberDAO.Create;

  Result := FInstancia;
end;

procedure TContaReceberDAO.inserir(ContaReceber: TContaReceber);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(ContaReceber) then
      begin
        if ContaReceber.ValorPagamento > 0 then
        begin
          FDQuery := FConnection.prepareStatement
            (' insert into CONTAS_RECEBER (COD_CTR, SEQUENCIA_CTR, COD_EMP, DATA_CTR, COD_VENDA, '
            + 'COD_CLI, VENCTO_CTR, VALOR_CTR, CAIXA_EMISSAO_CTR, PARCELA_CTR, DTPAGTO_CTR, '
            + 'VLRPAGO_CTR, COD_COB, NUMDOCUMENTO_CTR, CODIGO_CLASSIFICACAO, OBS_CTR) '
            + 'values (gen_id(GNT_COD_CONTAS_RECEBER, 1), :SEQ, :CODEMP, :DATACTR, :CODVENDA, '
            + ':CODCLI, :VENCTOCTR, :VALORCTR, :CODCAI, :PARC, :DTPAGTOCTR, :VLRPAGOCTR, '
            + ':CODCOB, :DOCUMENTO, :CODCLA, :OBS_CTR)   ');
          FDQuery.ParamByName('DTPAGTOCTR').ASDateTime :=
            ContaReceber.DataPagamento;
          FDQuery.ParamByName('VLRPAGOCTR').AsCurrency :=
            ContaReceber.ValorPagamento;
        end
        else
        begin
          FDQuery := FConnection.prepareStatement
            (' insert into CONTAS_RECEBER (COD_CTR, SEQUENCIA_CTR, COD_EMP, DATA_CTR, COD_VENDA, '
            + 'COD_CLI, VENCTO_CTR, VALOR_CTR, CAIXA_EMISSAO_CTR, PARCELA_CTR, '
            + 'COD_COB, NUMDOCUMENTO_CTR, CODIGO_CLASSIFICACAO, OBS_CTR) ' +
            'values (gen_id(GNT_COD_CONTAS_RECEBER, 1), :SEQ, :CODEMP, :DATACTR, :CODVENDA, '
            + ':CODCLI, :VENCTOCTR, :VALORCTR, :CODCAI, :PARC, ' +
            ':CODCOB, :DOCUMENTO, :CODCLA, :OBS_CTR)   ');
        end;

        FDQuery.ParamByName('SEQ').AsInteger := ContaReceber.Sequencia;
        FDQuery.ParamByName('CODEMP').AsInteger := ContaReceber.Empresa.Codigo;
        FDQuery.ParamByName('DATACTR').ASDateTime := ContaReceber.Data;
        FDQuery.ParamByName('CODVENDA').AsInteger := ContaReceber.CodigoVenda;
        FDQuery.ParamByName('CODCLI').AsInteger := ContaReceber.CodigoCliente;
        FDQuery.ParamByName('VENCTOCTR').ASDateTime := ContaReceber.Vencimento;
        FDQuery.ParamByName('VALORCTR').AsCurrency := ContaReceber.Valor;
        FDQuery.ParamByName('CODCAI').AsInteger := ContaReceber.Caixa.Codigo;
        FDQuery.ParamByName('PARC').AsInteger := ContaReceber.Parcela;
        FDQuery.ParamByName('CODCOB').AsInteger := ContaReceber.CodigoCobranca;
        FDQuery.ParamByName('DOCUMENTO').AsString :=
          ContaReceber.NumeroDocumento;
        FDQuery.ParamByName('CODCLA').AsInteger :=
          ContaReceber.CodigoClassificacao;
        FDQuery.ParamByName('OBS_CTR').AsString := ContaReceber.Observacao;

        FDQuery.ExecSQL;
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
