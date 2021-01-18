unit uUnidadeMedidaDAO;

interface

uses
  uUnidadeMedida, uConexaoFiredac;

type
{$TYPEINFO ON}
  TUnidadeMedidaDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TUnidadeMedidaDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TUnidadeMedidaDAO;
    procedure buscar(UnidadeMedida: TUnidadeMedida);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils;

{ TUnidadeMedidaDAO }

procedure TUnidadeMedidaDAO.buscar(UnidadeMedida: TUnidadeMedida);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(UnidadeMedida) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select UM.CODIGO, UM.DESCRICAO from UNIDADE_MEDIDA UM where UM.CODIGO = :CODIGO ');

        FDQuery.ParamByName('CODIGO').AsInteger := UnidadeMedida.Codigo;
        FDQuery.Open;

        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            UnidadeMedida.Codigo := FieldByName('CODIGO').AsInteger;
            UnidadeMedida.Descricao := FieldByName('DESCRICAO').AsString;
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

constructor TUnidadeMedidaDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TUnidadeMedidaDAO.getInstancia: TUnidadeMedidaDAO;
begin
  if FInstancia = nil then
    FInstancia := TUnidadeMedidaDAO.Create;

  Result := FInstancia;
end;

end.
