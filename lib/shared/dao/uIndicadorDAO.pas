unit uIndicadorDAO;

interface

uses
  uIndicador, System.Contnrs, System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TIndicadorDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TIndicadorDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TIndicadorDAO;
    procedure buscar(Indicador: TIndicador);
    function buscarTodos: TObjectList<TIndicador>;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils;

{ TIndicadorDAO }

procedure TIndicadorDAO.buscar(Indicador: TIndicador);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(Indicador) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select I.COD_IND, I.NOME_IND from INDICADOR I where I.COD_IND = :CODIND ');

        FDQuery.ParamByName('CODIND').AsInteger := Indicador.Codigo;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            Indicador.Nome := FieldByName('NOME_IND').AsString;
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

function TIndicadorDAO.buscarTodos: TObjectList<TIndicador>;
var
  FDQuery: TFDQuery;
  Indicador: TIndicador;
  Indicadores: TObjectList<TIndicador>;
begin
  Indicadores := TObjectList<TIndicador>.Create;
  try
    try

      FDQuery := FConnection.prepareStatement
        (' select I.COD_IND, I.NOME_IND from INDICADOR I  ');

      with FDQuery do
      begin
        Open;

        if RecordCount > 0 then
        begin
          Indicador := TIndicador.Create;
          Indicador.Codigo := FieldByName('COD_IND').AsInteger;
          Indicador.Nome := FieldByName('NOME_IND').AsString;

          Indicadores.Add(Indicador);
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
    result := Indicadores;
  end;
end;

constructor TIndicadorDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TIndicadorDAO.getInstancia: TIndicadorDAO;
begin
  if FInstancia = nil then
    FInstancia := TIndicadorDAO.Create;

  result := FInstancia;
end;

end.
