unit uGrupoIcmsDAO;

interface

uses
  uGrupoIcms, uEmpresa, uClass, uConexaoFiredac;

type
{$TYPEINFO ON}
  TGrupoIcmsDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TGrupoIcmsDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TGrupoIcmsDAO;
    procedure buscar(GrupoIcms: TGrupoIcms);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils, System.StrUtils;

{ TGrupoIcmsDAO }

procedure TGrupoIcmsDAO.buscar(GrupoIcms: TGrupoIcms);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(GrupoIcms) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select GI.COD_GRP, GI.ICMS_SERVICO_GRP, GI.ORIGEM, GI.CSOSN, GI.CST, '
          + 'GI.NOME_GRP, COALESCE(GI.ALIQUOTA_GRP,0) as ALIQUOTA_GRP from GRUPO_ICMS GI '
          + 'where GI.COD_GRP = :CODIGO   ');

        FDQuery.ParamByName('CODIGO').AsInteger := GrupoIcms.Codigo;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            GrupoIcms.Codigo := FieldByName('COD_GRP').AsInteger;
            GrupoIcms.Descricao := FieldByName('NOME_GRP').AsString;
            GrupoIcms.Aliquota := FieldByName('ALIQUOTA_GRP').AsCurrency;

            if (DMConexao.Empresa.TipoEmpresa = opSimplesNacional) or
              (DMConexao.Empresa.TipoEmpresa = opSimplesNacionalEx) then
              GrupoIcms.Origem :=
                StrToInt(copy(FieldByName('CSOSN').AsString, 1, 1))
            else
              GrupoIcms.Origem :=
                StrToInt(copy(FieldByName('CST').AsString, 1, 1));

            if (DMConexao.Empresa.TipoEmpresa = opSimplesNacional) or
              (DMConexao.Empresa.TipoEmpresa = opSimplesNacionalEx) then
              GrupoIcms.CSTCSOSN := copy(FieldByName('CSOSN').AsString, 2, 3)
            else
              GrupoIcms.CSTCSOSN := copy(FieldByName('CST').AsString, 2, 2);

            case AnsiIndexStr(FieldByName('ICMS_SERVICO_GRP').AsString,
              ['I', 'S', 'N']) of
              0:
                GrupoIcms.TipoIcmsServico := opIcms;
              1:
                GrupoIcms.TipoIcmsServico := opServico;
              2:
                GrupoIcms.TipoIcmsServico := opNaoFiscalIcms;
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
  end;
end;

constructor TGrupoIcmsDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TGrupoIcmsDAO.getInstancia: TGrupoIcmsDAO;
begin
  if FInstancia = nil then
    FInstancia := TGrupoIcmsDAO.Create;

  Result := FInstancia;
end;

end.
