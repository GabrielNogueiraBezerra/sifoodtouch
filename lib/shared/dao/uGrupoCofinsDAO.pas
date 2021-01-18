unit uGrupoCofinsDAO;

interface

uses
  uGrupoCofins, uConexaoFiredac;

type
{$TYPEINFO ON}
  TGrupoCofinsDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TGrupoCofinsDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TGrupoCofinsDAO;
    procedure buscar(GrupoCofins: TGrupoCofins);
  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils, FireDAC.Comp.Client;

{ TGrupoCofinsDAO }

procedure TGrupoCofinsDAO.buscar(GrupoCofins: TGrupoCofins);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(GrupoCofins) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select GC.COD_GRUPO_COFINS, GC.CST, GC.NOME_GRUPO, coalesce(GC.ALIQUOTA, 0) as ALIQUOTA '
          + 'from GRUPO_COFINS GC where GC.COD_GRUPO_COFINS = :CODIGO    ');

        FDQuery.ParamByName('CODIGO').AsInteger := GrupoCofins.CODIGO;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            GrupoCofins.CODIGO := FieldByName('COD_GRUPO_COFINS').AsInteger;
            GrupoCofins.Descricao := FieldByName('NOME_GRUPO').AsString;
            GrupoCofins.Aliquota := FieldByName('ALIQUOTA').AsCurrency;
            GrupoCofins.CST := FieldByName('CST').AsString;
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

constructor TGrupoCofinsDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TGrupoCofinsDAO.getInstancia: TGrupoCofinsDAO;
begin
  if FInstancia = nil then
    FInstancia := TGrupoCofinsDAO.Create;

  Result := FInstancia;
end;

end.
