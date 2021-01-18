unit uGrupoUsuarioDAO;

interface

uses
  uGrupoUsuario, uConexaoFiredac;

type
{$TYPEINFO ON}
  TGrupoUsuarioDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TGrupoUsuarioDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TGrupoUsuarioDAO;
    procedure buscar(GrupoUsuario: TGrupoUsuario);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uFuncoes, FMX.Forms, System.SysUtils, uDmConexao;

{ TGrupoUsuarioDAO }

procedure TGrupoUsuarioDAO.buscar(GrupoUsuario: TGrupoUsuario);
var
  FDQuery, FDAux: TFDQuery;
  Funcao: TFuncoes;
begin
  if Assigned(GrupoUsuario) then
  begin
    try
      try
        FDQuery := FConnection.prepareStatement
          (' select GU.COD_GRUPO, GU.NOME_GRUPO, GU.SUPER_GRUPO ' +
          'from GRUPO_USUARIO GU where GU.COD_GRUPO = :CODIGO  ');
        FDQuery.ParamByName('CODIGO').AsInteger := GrupoUsuario.Codigo;

        FDQuery.open;

        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            GrupoUsuario.Descricao := FieldByName('NOME_GRUPO').AsString;
            GrupoUsuario.SuperGrupo := DMConexao.Configuracao.StrToBool
              (FieldByName('SUPER_GRUPO').AsString, 'S');

            FDAux := FConnection.prepareStatement
              (' select F.COD_FUNCAO, F.NOME_FUNCAO, F.ITEM_MENU from FUNCOES F inner join FUNCOES_GRUPO_USUARIO FGU '
              + 'on FGU.COD_FUNCAO = F.COD_FUNCAO where F.TIPO_EXIBICAO = 1 and '
              + '(F.RESTAURANTE = :S or F.HOTEL_RESTAURANTE = :S) and F.COMERCIO = :N and '
              + 'F.HOTEL = :N and FGU.COD_GRUPO = :CODIGO   ');
            FDAux.ParamByName('CODIGO').AsInteger := GrupoUsuario.Codigo;
            FDAux.ParamByName('S').AsString := 'S';
            FDAux.ParamByName('N').AsString := 'N';
            FDAux.open;

            with FDAux do
            begin

              while not FDAux.Eof do
              begin
                Funcao := TFuncoes.Create;
                Funcao.Codigo := FDAux.FieldByName('COD_FUNCAO').AsInteger;
                Funcao.Nome := FDAux.FieldByName('NOME_FUNCAO').AsString;
                Funcao.ItemMenu := FDAux.FieldByName('ITEM_MENU').AsString;

                GrupoUsuario.Funcoes.Add(Funcao);
                FDAux.Next;
                Application.processMessages;
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

      if Assigned(FDAux) then
        FConnection.closeConnection(FDAux);
    end;
  end;
end;

constructor TGrupoUsuarioDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TGrupoUsuarioDAO.getInstancia: TGrupoUsuarioDAO;
begin
  if FInstancia = nil then
    FInstancia := TGrupoUsuarioDAO.Create;

  result := FInstancia;
end;

end.
