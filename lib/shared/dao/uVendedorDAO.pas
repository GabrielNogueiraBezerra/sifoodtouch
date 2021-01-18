unit uVendedorDAO;

interface

uses
  uVendedor, System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TVendedorDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TVendedorDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TVendedorDAO;
    procedure buscar(Vendedor: TVendedor);
    function buscarTodos: TObjectList<TVendedor>;
  published
    { published declarations }
  end;

implementation

uses
  uDMConexao, System.SysUtils, uEmpresaDAO, FireDAC.Comp.Client, FMX.Forms;

{ TVendedorDAO }

procedure TVendedorDAO.buscar(Vendedor: TVendedor);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(Vendedor) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select V.COD_VEND, V.NOME_VEND, V.ATIVO_VEND, V.COD_EMP ' +
          'from VENDEDOR V where V.COD_VEND = :CODVEND   ');
        FDQuery.ParamByName('CODVEND').AsInteger := Vendedor.Codigo;
        FDQuery.Open;

        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            Vendedor.Nome := FieldByName('NOME_VEND').AsString;
            Vendedor.Ativo := DMConexao.Configuracao.StrToBool
              (FieldByName('ATIVO_VEND').AsString, 'S');
            Vendedor.Empresa.Codigo := FieldByName('COD_EMP').AsInteger;
            TEmpresaDAO.getInstancia.buscar(Vendedor.Empresa);
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

function TVendedorDAO.buscarTodos: TObjectList<TVendedor>;
var
  FDQuery: TFDQuery;
  Garcom: TVendedor;
  Garcons: TObjectList<TVendedor>;
begin
  Garcons := TObjectList<TVendedor>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        ('select V.COD_VEND, V.NOME_VEND from VENDEDOR V where ' +
        'V.COD_EMP = :CODEMP and V.ATIVO_VEND = :S ');
      FDQuery.ParamByName('CODEMP').AsInteger := DMConexao.Empresa.Codigo;
      FDQuery.ParamByName('S').AsString := 'S';
      FDQuery.Open;
      with FDQuery do
      begin
        if FDQuery.RecordCount > 0 then
        begin
          while not FDQuery.EOF do
          begin
            Garcom := TVendedor.Create;
            Garcom.Codigo := FieldByName('COD_VEND').AsInteger;
            Garcom.Nome := FieldByName('NOME_VEND').AsString;
            Garcom.Ativo := True;
            Garcom.Empresa := DMConexao.Empresa;
            Garcons.Add(Garcom);
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
    result := Garcons;
  end;
end;

constructor TVendedorDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TVendedorDAO.getInstancia: TVendedorDAO;
begin
  if FInstancia = nil then
    FInstancia := TVendedorDAO.Create;

  result := FInstancia;
end;

end.
