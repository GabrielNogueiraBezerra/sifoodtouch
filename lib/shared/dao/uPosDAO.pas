unit uPosDAO;

interface

uses
  uPos, System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TPosDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TPosDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TPosDAO;
    procedure buscar(Pos: TPos);
    function buscarTodos: TObjectList<TPos>;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, uAdministradoraCartaoDAO, System.SysUtils;

{ TPosDAO }

procedure TPosDAO.buscar(Pos: TPos);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select P.COD_POS, P.NOME_POS, P.SERIAL_POS, P.CODIGO_ADMINISTRADORA '
        + 'from POS P where P.COD_POS = :CODIGO    ');

      if Assigned(Pos) then
      begin
        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := Pos.Codigo;
          Open;

          if RecordCount > 0 then
          begin
            Pos.Codigo := FieldByName('COD_POS').AsInteger;
            Pos.Nome := FieldByName('NOME_POS').AsString;
            Pos.Serial := FieldByName('SERIAL_POS').AsString;
            Pos.AdministradoraCartao.Codigo :=
              FieldByName('CODIGO_ADMINISTRADORA').AsInteger;

            TAdministradoraCartaoDAO.getInstancia.buscar
              (Pos.AdministradoraCartao);
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

function TPosDAO.buscarTodos: TObjectList<TPos>;
var
  FDQuery: TFDQuery;
  Pos: TPos;
  ListaPos: TObjectList<TPos>;
begin
  ListaPos := TObjectList<TPos>.Create;

  try
    try

      FDQuery := FConnection.prepareStatement
        (' select P.COD_POS, P.NOME_POS, P.SERIAL_POS, ' +
        'P.CODIGO_ADMINISTRADORA from POS P ');

      with FDQuery do
      begin
        Open;

        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            Pos := TPos.Create;
            Pos.Codigo := FieldByName('COD_POS').AsInteger;
            Pos.Nome := FieldByName('NOME_POS').AsString;
            Pos.Serial := FieldByName('SERIAL_POS').AsString;
            Pos.AdministradoraCartao.Codigo :=
              FieldByName('CODIGO_ADMINISTRADORA').AsInteger;

            TAdministradoraCartaoDAO.getInstancia.buscar
              (Pos.AdministradoraCartao);

            ListaPos.Add(Pos);

            FDQuery.Next;
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
    result := ListaPos;
  end;
end;

constructor TPosDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TPosDAO.getInstancia: TPosDAO;
begin
  if FInstancia = nil then
    FInstancia := TPosDAO.Create;

  result := FInstancia;
end;

end.
