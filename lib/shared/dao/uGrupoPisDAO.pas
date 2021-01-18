unit uGrupoPisDAO;

interface

uses
  uGrupoPis, uConexaoFiredac;

type
{$TYPEINFO ON}
  TGrupoPisDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TGrupoPisDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TGrupoPisDAO;
    procedure buscar(GrupoPis: TGrupoPis);
  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils, FireDAC.Comp.Client;

{ TGrupoPisDAO }

procedure TGrupoPisDAO.buscar(GrupoPis: TGrupoPis);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(GrupoPis) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select GP.COD_GRUPO_PIS, GP.NOME_GRUPO, COALESCE(GP.ALIQUOTA,0) as ALIQUOTA '
          + ', GP.CST from GRUPO_PIS GP  where GP.COD_GRUPO_PIS = :CODIGO ');

        FDQuery.ParamByName('CODIGO').AsInteger := GrupoPis.CODIGO;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            GrupoPis.CODIGO := FieldByName('COD_GRUPO_PIS').AsInteger;
            GrupoPis.Descricao := FieldByName('NOME_GRUPO').AsString;
            GrupoPis.Aliquota := FieldByName('ALIQUOTA').AsCurrency;
            GrupoPis.CST := FieldByName('CST').AsString;
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

constructor TGrupoPisDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TGrupoPisDAO.getInstancia: TGrupoPisDAO;
begin
  if FInstancia = nil then
    FInstancia := TGrupoPisDAO.Create;

  Result := FInstancia;
end;

end.
