unit uSetorDAO;

interface

uses
  uSetor, uConexaoFiredac;

type
{$TYPEINFO ON}
  TSetorDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TSetorDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TSetorDAO;
    procedure buscar(Setor: TSetor);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils;

{ TSetorDAO }

procedure TSetorDAO.buscar(Setor: TSetor);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select S.COD_SETOR, S.DESCRICAO from SETOR S where S.COD_SETOR = :CODSETOR ');

      FDQuery.ParamByName('CODSETOR').AsInteger := Setor.Codigo;
      FDQuery.Open;

      if Assigned(Setor) then
      begin
        with FDQuery do
        begin

          if RecordCount > 0 then
          begin
            Setor.Descricao := FieldByName('DESCRICAO').AsString;
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

constructor TSetorDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TSetorDAO.getInstancia: TSetorDAO;
begin
  if FInstancia = nil then
    FInstancia := TSetorDAO.Create;

  result := FInstancia;
end;

end.
