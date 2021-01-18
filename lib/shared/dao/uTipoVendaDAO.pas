unit uTipoVendaDAO;

interface

uses
  uTipoVenda, System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TTipoVendaDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TTipoVendaDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TTipoVendaDAO;
    procedure buscar(TipoVenda: TTipoVenda);
    function buscarTodos: TObjectList<TTipoVenda>;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils, Vcl.Forms;

{ TTipoVendaDAO }

procedure TTipoVendaDAO.buscar(TipoVenda: TTipoVenda);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(TipoVenda) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select TV.COD_TPV, TV.NOME_TPV, TV.QTDPARCELAS_TPV, TV.DIASPRIPARC_TPV, '
          + 'TV.DIASENTREPARC_TPV, TV.POSSUI_ENTRADA, TV.AVISTA, TV.GERA_CARNE, TV.PERC_ENTRADA, TV.CODIGO_CLASSIFICACAO from '
          + 'TIPO_VENDA TV where TV.COD_TPV = :CODIGO  ');

        FDQuery.ParamByName('CODIGO').AsInteger := TipoVenda.Codigo;
        FDQuery.Open;
        with FDQuery do
        begin

          if RecordCount > 0 then
          begin
            TipoVenda.Codigo := FieldByName('COD_TPV').AsInteger;
            TipoVenda.Nome := FieldByName('NOME_TPV').AsString;
            TipoVenda.Parcelas := FieldByName('QTDPARCELAS_TPV').AsInteger;
            TipoVenda.DiasPrimeiraParcela := FieldByName('DIASPRIPARC_TPV')
              .AsInteger;
            TipoVenda.DiasEntreParcelas := FieldByName('DIASENTREPARC_TPV')
              .AsInteger;
            TipoVenda.PossuiEntrada := DMConexao.Configuracao.StrToBool
              (FieldByName('POSSUI_ENTRADA').AsString, 'S');
            TipoVenda.GeraCarne := DMConexao.Configuracao.StrToBool
              (FieldByName('GERA_CARNE').AsString, 'S');
            TipoVenda.AVista := DMConexao.Configuracao.StrToBool
              (FieldByName('AVISTA').AsString, 'S');
            TipoVenda.PercentualEntrada := FieldByName('PERC_ENTRADA')
              .AsCurrency;
            TipoVenda.CodigoClassificacao := FieldByName('CODIGO_CLASSIFICACAO')
              .AsInteger;
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

function TTipoVendaDAO.buscarTodos: TObjectList<TTipoVenda>;
var
  FDQuery: TFDQuery;
  TipoVenda: TTipoVenda;
begin
  Result := TObjectList<TTipoVenda>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select TV.COD_TPV, TV.NOME_TPV, TV.QTDPARCELAS_TPV, TV.DIASPRIPARC_TPV, '
        + 'TV.DIASENTREPARC_TPV, TV.POSSUI_ENTRADA, TV.AVISTA, TV.GERA_CARNE, TV.PERC_ENTRADA, TV.CODIGO_CLASSIFICACAO from '
        + 'TIPO_VENDA TV order by TV.COD_TPV ');

      FDQuery.Open;
      with FDQuery do
      begin

        if FDQuery.RecordCount > 0 then
        begin
          while not FDQuery.EOF do
          begin
            TipoVenda := TTipoVenda.Create;
            TipoVenda.Codigo := FieldByName('COD_TPV').AsInteger;
            TipoVenda.Nome := FieldByName('NOME_TPV').AsString;
            TipoVenda.Parcelas := FieldByName('QTDPARCELAS_TPV').AsInteger;
            TipoVenda.DiasPrimeiraParcela := FieldByName('DIASPRIPARC_TPV')
              .AsInteger;
            TipoVenda.DiasEntreParcelas := FieldByName('DIASENTREPARC_TPV')
              .AsInteger;
            TipoVenda.PossuiEntrada := DMConexao.Configuracao.StrToBool
              (FieldByName('POSSUI_ENTRADA').AsString, 'S');
            TipoVenda.GeraCarne := DMConexao.Configuracao.StrToBool
              (FieldByName('GERA_CARNE').AsString, 'S');
            TipoVenda.PercentualEntrada := FieldByName('PERC_ENTRADA')
              .AsCurrency;
            TipoVenda.CodigoClassificacao := FieldByName('CODIGO_CLASSIFICACAO')
              .AsInteger;

            TipoVenda.AVista := DMConexao.Configuracao.StrToBool
              (FieldByName('AVISTA').AsString, 'S');

            Result.Add(TipoVenda);

            FDQuery.Next;
            Application.ProcessMessages;
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

constructor TTipoVendaDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TTipoVendaDAO.getInstancia: TTipoVendaDAO;
begin
  if FInstancia = nil then
    FInstancia := TTipoVendaDAO.Create;

  Result := FInstancia;
end;

end.
