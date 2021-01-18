unit uUsuarioDAO;

interface

uses
  uUsuario, uConexaoFiredac;

type
{$TYPEINFO ON}
  TUsuarioDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TUsuarioDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TUsuarioDAO;
    function buscar(Usuario: TUsuario): TUsuario;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils, uGrupoUsuarioDAO, uEmpresa,
  uEmpresaDAO, FMX.Forms;

{ TUsuarioDAO }

function TUsuarioDAO.buscar(Usuario: TUsuario): TUsuario;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  Empresa: TEmpresa;
begin
  result := nil;

  if Assigned(Usuario) then
  begin
    try
      try

        if Usuario.Codigo > 0 then
        begin
          FDQuery := FConnection.prepareStatement
            ('select U.COD_USU, U.NOME_USU, U.SENHA_USU, U.COD_GRUPO, U.GERENTE_CAIXA, '
            + 'U.DESC_MAX, U.ATIVO from USUARIO U where U.COD_USU = :CODIGO');
          FDQuery.ParamByName('CODIGO').AsInteger := Usuario.Codigo;
        end
        else
        begin
          if (not(Usuario.Nome = EmptyStr) and (not(Usuario.Senha = EmptyStr)))
          then
          begin
            FDQuery := FConnection.prepareStatement
              ('select U.COD_USU, U.NOME_USU, U.SENHA_USU, U.COD_GRUPO, U.GERENTE_CAIXA, '
              + 'U.DESC_MAX, U.ATIVO from USUARIO U where U.NOME_USU = :NOMEUSU and U.SENHA_USU = :SENHAUSU');
            FDQuery.ParamByName('NOMEUSU').AsString := Usuario.Nome;
            FDQuery.ParamByName('SENHAUSU').AsString :=
              DMConexao.Criptografa(Usuario.Senha);
          end;
        end;

        FDQuery.Open;

        if FDQuery.RecordCount > 0 then
        begin
          Usuario.Codigo := FDQuery.FieldByName('COD_USU').AsInteger;
          Usuario.Nome := FDQuery.FieldByName('NOME_USU').AsString;
          Usuario.Senha := DMConexao.DesCriptografa
            (FDQuery.FieldByName('SENHA_USU').AsString);
          Usuario.GrupoUsuario.Codigo := FDQuery.FieldByName('COD_GRUPO')
            .AsInteger;
          Usuario.Gerente := DMConexao.Configuracao.StrToBool
            (FDQuery.FieldByName('GERENTE_CAIXA').AsString, 'S');
          Usuario.Desconto := FDQuery.FieldByName('DESC_MAX').AsCurrency;
          Usuario.Ativo := DMConexao.Configuracao.StrToBool
            (FDQuery.FieldByName('ATIVO').AsString, 'S');

          FDAux := FConnection.prepareStatement
            (' select EU.COD_USU, EU.COD_EMP from EMPRESA_USUARIO EU ' +
            'where EU.COD_USU = :CODIGO ');

          FDAux.ParamByName('CODIGO').AsInteger := Usuario.Codigo;
          FDAux.Open;

          with FDAux do
          begin
            while not FDAux.Eof do
            begin
              Empresa := TEmpresa.Create;
              Empresa.Codigo := FDAux.FieldByName('COD_EMP').AsInteger;
              TEmpresaDAO.getInstancia.buscar(Empresa);
              Usuario.Empresas.Add(Empresa);
              FDAux.Next;
              Application.processMessages;
            end;
          end;

          TGrupoUsuarioDAO.getInstancia.buscar(Usuario.GrupoUsuario);
        end
        else
          Usuario := nil;

      except
        on E: Exception do
          raise Exception.Create(E.Message);
      end;
    finally
      if Assigned(FDQuery) then
        FConnection.closeConnection(FDQuery);
      if Assigned(FDAux) then
        FConnection.closeConnection(FDAux);
      result := Usuario;
    end;
  end;
end;

constructor TUsuarioDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TUsuarioDAO.getInstancia: TUsuarioDAO;
begin
  if FInstancia = nil then
    FInstancia := TUsuarioDAO.Create;

  result := FInstancia;
end;

end.
