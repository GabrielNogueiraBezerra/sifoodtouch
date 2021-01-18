unit uLocalEstoqueDAO;

interface

uses
  uLocalEstoque, System.Contnrs, System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TLocalEstoqueDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TLocalEstoqueDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TLocalEstoqueDAO;
    procedure buscar(LocalEstoque: TLocalEstoque);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils;

{ TLocalEstoqueDAO }

procedure TLocalEstoqueDAO.buscar(LocalEstoque: TLocalEstoque);

var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(LocalEstoque) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select * from LOCAIS_ESTOQUE LE where LE.CODIGO = :CODIGO ');

        FDQuery.ParamByName('CODIGO').AsInteger := LocalEstoque.Codigo;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            LocalEstoque.Codigo := FieldByName('CODIGO').AsInteger;
            LocalEstoque.Descricao := FieldByName('DESCRICAO').AsString;
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

constructor TLocalEstoqueDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TLocalEstoqueDAO.getInstancia: TLocalEstoqueDAO;
begin
  if FInstancia = nil then
    FInstancia := TLocalEstoqueDAO.Create;

  result := FInstancia;
end;

end.
