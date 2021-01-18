unit uEstoqueDAO;

interface

uses
  uEstoque, uProduto, uConexaoFiredac;

type
{$TYPEINFO ON}
  TEstoqueDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TEstoqueDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TEstoqueDAO;
    procedure buscar(Estoque: TEstoque; Produto: TProduto);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils;

{ TEstoqueDAO }

procedure TEstoqueDAO.buscar(Estoque: TEstoque; Produto: TProduto);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(Estoque) and Assigned(Produto) then
      begin
        FDQuery := FConnection.prepareStatement
          (' SELECT E.COD_EMP, E.COD_PRO, E.ESTOQUE, E.CODIGO_LOCAL_ESTOQUE FROM ESTOQUE '
          + 'E WHERE E.COD_EMP = :COD_EMP AND E.COD_PRO = :COD_PRO AND E.CODIGO_LOCAL_ESTOQUE '
          + '= :CODIGO_LOCAL_ESTOQUE ');

        with FDQuery do
        begin
          ParamByName('COD_EMP').AsInteger := Estoque.Empresa.Codigo;
          ParamByName('COD_PRO').AsInteger := Produto.Codigo;
          ParamByName('CODIGO_LOCAL_ESTOQUE').AsInteger :=
            Estoque.LocalEstoque.Codigo;
          Open;

          if RecordCount > 0 then
            Estoque.Estoque := FieldByName('ESTOQUE').AsCurrency;
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

constructor TEstoqueDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TEstoqueDAO.getInstancia: TEstoqueDAO;
begin
  if FInstancia = nil then
    FInstancia := TEstoqueDAO.Create;

  result := FInstancia;
end;

end.
