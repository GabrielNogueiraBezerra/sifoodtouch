unit uEmpresaDAO;

interface

uses
  uEmpresa, uClass, uConexaoFiredac;

type
{$TYPEINFO ON}
  TEmpresaDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TEmpresaDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TEmpresaDAO;
    procedure buscar(Empresa: TEmpresa);
    function versaoSistema: String;
  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils, FireDAC.Comp.Client;

{ TEmpresaDAO }

procedure TEmpresaDAO.buscar(Empresa: TEmpresa);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(Empresa) then
      begin
        FDQuery := FConnection.prepareStatement
          ('select E.FJ_EMP, E.FANTASIA_EMP, E.RAZAO_EMP, E.END_EMP, E.NUMERO_EMP, E.BAI_EMP, '
          + 'E.CID_EMP, cast(E.CODIGO_MUNICIPIO as integer) as CODIGO_MUNICIPIO, '
          + 'E.EST_EMP, E.CEP_EMP, ' + quotedstr('') +
          ' as REFERENCIA, E.TEL_EMP, E.FAX_EMP, E.EMAIL, E.CNPJ_EMP, E.INSC_EMP, '
          + 'E.INSCRICAO_MUNICIPAL, E.TIPO_EMP, E.REG_TRIB_ISSQN, E.CHAVE_ACESSO_VFPE, '
          + 'E.SEGUIMENTO_EMP from EMPRESA E where E.COD_EMP = :CODEMP ');
        FDQuery.ParamByName('CODEMP').AsInteger := Empresa.Codigo;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin

            if trim(fieldbyname('est_emp').AsString) = 'RO' then
              Empresa.UFContMfe := '11'
            else if trim(fieldbyname('est_emp').AsString) = 'AC' then
              Empresa.UFContMfe := '12'
            else if trim(fieldbyname('est_emp').AsString) = 'AM' then
              Empresa.UFContMfe := '13'
            else if trim(fieldbyname('est_emp').AsString) = 'RR' then
              Empresa.UFContMfe := '14'
            else if trim(fieldbyname('est_emp').AsString) = 'PA' then
              Empresa.UFContMfe := '15'
            else if trim(fieldbyname('est_emp').AsString) = 'AP' then
              Empresa.UFContMfe := '16'
            else if trim(fieldbyname('est_emp').AsString) = 'TO' then
              Empresa.UFContMfe := '17'
            else if trim(fieldbyname('est_emp').AsString) = 'MA' then
              Empresa.UFContMfe := '21'
            else if trim(fieldbyname('est_emp').AsString) = 'PI' then
              Empresa.UFContMfe := '22'
            else if trim(fieldbyname('est_emp').AsString) = 'CE' then
              Empresa.UFContMfe := '23'
            else if trim(fieldbyname('est_emp').AsString) = 'RN' then
              Empresa.UFContMfe := '24'
            else if trim(fieldbyname('est_emp').AsString) = 'PB' then
              Empresa.UFContMfe := '25'
            else if trim(fieldbyname('est_emp').AsString) = 'PE' then
              Empresa.UFContMfe := '26'
            else if trim(fieldbyname('est_emp').AsString) = 'AL' then
              Empresa.UFContMfe := '27'
            else if trim(fieldbyname('est_emp').AsString) = 'SE' then
              Empresa.UFContMfe := '28'
            else if trim(fieldbyname('est_emp').AsString) = 'BA' then
              Empresa.UFContMfe := '29'
            else if trim(fieldbyname('est_emp').AsString) = 'MG' then
              Empresa.UFContMfe := '31'
            else if trim(fieldbyname('est_emp').AsString) = 'ES' then
              Empresa.UFContMfe := '32'
            else if trim(fieldbyname('est_emp').AsString) = 'RJ' then
              Empresa.UFContMfe := '33'
            else if trim(fieldbyname('est_emp').AsString) = 'SP' then
              Empresa.UFContMfe := '35'
            else if trim(fieldbyname('est_emp').AsString) = 'PR' then
              Empresa.UFContMfe := '41'
            else if trim(fieldbyname('est_emp').AsString) = 'SC' then
              Empresa.UFContMfe := '42'
            else if trim(fieldbyname('est_emp').AsString) = 'RS' then
              Empresa.UFContMfe := '43'
            else if trim(fieldbyname('est_emp').AsString) = 'MS' then
              Empresa.UFContMfe := '50'
            else if trim(fieldbyname('est_emp').AsString) = 'MT' then
              Empresa.UFContMfe := '51'
            else if trim(fieldbyname('est_emp').AsString) = 'GO' then
              Empresa.UFContMfe := '52'
            else if trim(fieldbyname('est_emp').AsString) = 'DF' then
              Empresa.UFContMfe := '53';

            Empresa.Tipo := fieldbyname('FJ_EMP').AsString;
            Empresa.Fantasia := fieldbyname('FANTASIA_EMP').AsString;
            Empresa.Razao := fieldbyname('RAZAO_EMP').AsString;
            Empresa.Endereco.Endereco := fieldbyname('END_EMP').AsString;
            Empresa.Endereco.Numero := fieldbyname('NUMERO_EMP').AsString;
            Empresa.Endereco.Bairro := fieldbyname('BAI_EMP').AsString;
            Empresa.Endereco.Cidade.Codigo := fieldbyname('CODIGO_MUNICIPIO')
              .AsInteger;
            Empresa.Endereco.Cidade.Descricao := fieldbyname('CID_EMP')
              .AsString;
            Empresa.Endereco.Cidade.UF := fieldbyname('EST_EMP').AsString;
            Empresa.Endereco.Cep := fieldbyname('CEP_EMP').AsString;
            Empresa.Endereco.PontoReferencia :=
              fieldbyname('REFERENCIA').AsString;
            Empresa.Contato.Telefone := fieldbyname('TEL_EMP').AsString;
            Empresa.Contato.Fax := fieldbyname('FAX_EMP').AsString;
            Empresa.Contato.Email := fieldbyname('EMAIL').AsString;
            Empresa.Cnpj := fieldbyname('CNPJ_EMP').AsString;
            Empresa.InscricaoEstadual := fieldbyname('INSC_EMP').AsString;
            Empresa.InscricaoMunicipal :=
              fieldbyname('INSCRICAO_MUNICIPAL').AsString;

            case fieldbyname('TIPO_EMP').AsInteger of
              0:
                Empresa.TipoEmpresa := opSimplesNacional;
              1:
                Empresa.TipoEmpresa := opLucroReal;
              2:
                Empresa.TipoEmpresa := opSimplesNacionalEx;
              3:
                Empresa.TipoEmpresa := opLucroPresumido;
            end;
            Empresa.RegimeTributadoISSQN := fieldbyname('REG_TRIB_ISSQN')
              .AsInteger;
            Empresa.ChaveAcessoVFPE := fieldbyname('CHAVE_ACESSO_VFPE')
              .AsString;
            Empresa.Segmento := fieldbyname('SEGUIMENTO_EMP').AsInteger;
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

constructor TEmpresaDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TEmpresaDAO.getInstancia: TEmpresaDAO;
begin
  if FInstancia = nil then
    FInstancia := TEmpresaDAO.Create;

  result := FInstancia;
end;

function TEmpresaDAO.versaoSistema: String;
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select RDB$DESCRIPTION AS VERSAO from RDB$DATABASE ');

      FDQuery.Open;
      result := FDQuery.fieldbyname('VERSAO').AsString;

    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
  end;
end;

end.
