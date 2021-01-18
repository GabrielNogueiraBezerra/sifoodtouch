unit uCaixaDAO;

interface

uses
  uCaixa, uClass, uConexaoFiredac;

type
{$TYPEINFO ON}
  TCaixaDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TCaixaDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure buscar(Caixa: TCaixa);
    procedure buscarCaixaCadastrado(Caixa: TCaixa);
    class function getInstancia: TCaixaDAO;
    class function verificaCaixaAberto(Caixa: TCaixa): Boolean;
  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils, uDMConexao, FireDAC.Comp.Client;

{ TCaixaDAO }

procedure TCaixaDAO.buscar(Caixa: TCaixa);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        ('select C.TIPO_CAI, C.NUM_CAI, C.AMBIENTE_SAT, C.COD_ATIV_SAT, ' +
        'C.NUM_CAIXA_SAT, C.VERSAO_SAT, C.ASS_SWHOUSE_SAT, C.INDICE_GAVETA, ' +
        'C.TEF_CAI, C.IP_SERVIDOR_TEF, C.VELOCIDADE, C.GP, C.INDICE_CNF_CELULAR, '
        + 'C.SINAL_INVERTIDO_GAVETA, C.INDICE_BALANCA, C.PORTA_BALANCA, C.BAUD_BALANCA, '
        + 'C.CAMINHO_INPUT_MFE, C.CAMINHO_OUTPUT_MFE, C.COMUNIC_INTEG_CAI, ' +
        'C.USA_INTEGRADOR_NFCE, C.R01_CNPJ_USUARIO, C.R01_IE_USUARIO, C.DESC_CAI, '
        + 'C.LINHA1, C.LINHA2, C.LINHA3, C.CAMINHO_INPUT_MFE, C.CAMINHO_OUTPUT_MFE from CAIXA '
        + 'C where C.COD_CAI = :CODCAI and C.COD_EMP = :CODEMP');
      FDQuery.ParamByName('CODCAI').AsInteger := Caixa.Codigo;
      FDQuery.ParamByName('CODEMP').AsInteger := Caixa.Empresa.Codigo;
      FDQuery.Open;

      if Assigned(Caixa) then
      begin
        with FDQuery do
        begin

          if RecordCount > 0 then
          begin

            Caixa.CaminhoInputMfe := FieldByname('CAMINHO_INPUT_MFE').AsString;
            Caixa.CaminhoOutputMfe := FieldByname('CAMINHO_OUTPUT_MFE')
              .AsString;

            case FieldByname('TIPO_CAI').AsInteger of
              0:
                Caixa.TipoCaixa := opNaoFiscal;
              1:
                Caixa.TipoCaixa := opECF;
              2:
                Caixa.TipoCaixa := opSAT;
              3:
                Caixa.TipoCaixa := opNFCe;
              4:
                Caixa.TipoCaixa := opMFE;
            end;

            Caixa.Linha1 := FieldByname('LINHA1').AsString;
            Caixa.Linha2 := FieldByname('LINHA2').AsString;
            Caixa.Linha3 := FieldByname('LINHA3').AsString;
            Caixa.NumeroCaixa := FieldByname('NUM_CAI').AsInteger;

            if FieldByname('AMBIENTE_SAT').AsString = 'P' then
              Caixa.AmbienteSat := opProducao
            else
              Caixa.AmbienteSat := opHomologacao;

            Caixa.CodigoAtivacaoSat := FieldByname('COD_ATIV_SAT').AsString;
            Caixa.NumeroCaixaSat := FieldByname('NUM_CAIXA_SAT').AsInteger;
            Caixa.VersaoSat := FieldByname('VERSAO_SAT').AsString;

            if DMConexao.Configuracao.HomologacaoSI then
              Caixa.AssinaturaSWHouseSat := 'CODIGO DE VINCULACAO AC DO MFE-CFE'
            else
              Caixa.AssinaturaSWHouseSat :=
                FieldByname('ASS_SWHOUSE_SAT').AsString;

            Caixa.IndiceGaveta := FieldByname('INDICE_GAVETA').AsInteger;
            Caixa.TefCaixa := FieldByname('TEF_CAI').AsString;
            Caixa.IpServidorTef := FieldByname('IP_SERVIDOR_TEF').AsString;
            Caixa.Velocidade := FieldByname('VELOCIDADE').AsInteger;
            Caixa.Gp := FieldByname('GP').AsInteger;
            Caixa.IndiceCnfCelular := FieldByname('INDICE_CNF_CELULAR')
              .AsString;
            Caixa.SinalInvertidoGaveta :=
              FieldByname('SINAL_INVERTIDO_GAVETA').AsString;
            Caixa.IndiceBalanca := FieldByname('INDICE_BALANCA').AsInteger;
            Caixa.PortaBalanca := FieldByname('PORTA_BALANCA').AsInteger;
            Caixa.BaudBalanca := FieldByname('BAUD_BALANCA').AsInteger;
            Caixa.CaminhoInputMfe := FieldByname('CAMINHO_INPUT_MFE').AsString;
            Caixa.CaminhoOutputMfe := FieldByname('CAMINHO_OUTPUT_MFE')
              .AsString;
            Caixa.ComunicaIntegracaoCaixa := DMConexao.Configuracao.StrToBool
              (FieldByname('COMUNIC_INTEG_CAI').AsString, '1');
            Caixa.UsaIntegradorNfce :=
              FieldByname('USA_INTEGRADOR_NFCE').AsString;
            Caixa.R01CnpjUsuario := FieldByname('R01_CNPJ_USUARIO').AsString;
            Caixa.R01IeUsuario := FieldByname('R01_IE_USUARIO').AsString;
            Caixa.DescricaoCaixa := FieldByname('DESC_CAI').AsString;
          end
          else
            raise Exception.Create('Caixa não encontrado.');

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

procedure TCaixaDAO.buscarCaixaCadastrado(Caixa: TCaixa);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(Caixa) then
      begin
        FDQuery := FConnection.prepareStatement
          ('select C.TIPO_CAI, C.NUM_CAI, C.AMBIENTE_SAT, C.COD_ATIV_SAT, ' +
          'C.NUM_CAIXA_SAT, C.VERSAO_SAT, C.ASS_SWHOUSE_SAT, C.INDICE_GAVETA, '
          + 'C.TEF_CAI, C.IP_SERVIDOR_TEF, C.VELOCIDADE, C.GP, C.INDICE_CNF_CELULAR, '
          + 'C.SINAL_INVERTIDO_GAVETA, C.INDICE_BALANCA, C.PORTA_BALANCA, C.BAUD_BALANCA, '
          + 'C.CAMINHO_INPUT_MFE, C.CAMINHO_OUTPUT_MFE, C.COMUNIC_INTEG_CAI, ' +
          'C.USA_INTEGRADOR_NFCE, C.R01_CNPJ_USUARIO, C.R01_IE_USUARIO, C.DESC_CAI from CAIXA '
          + 'C where C.COD_CAI = :CODCAI');
        FDQuery.ParamByName('CODCAI').AsInteger := Caixa.Codigo;
        FDQuery.Open;
        if FDQuery.RecordCount <= 0 then
          raise Exception.Create('Caixa não encontrado.');
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

constructor TCaixaDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TCaixaDAO.getInstancia: TCaixaDAO;
begin
  if FInstancia = nil then
    FInstancia := TCaixaDAO.Create;

  Result := FInstancia;
end;

class function TCaixaDAO.verificaCaixaAberto(Caixa: TCaixa): Boolean;
var
  FDQuery: TFDQuery;
begin

  Result := False;

  if DMConexao.Configuracao.LiberarMovimentacaoAposAbertura then
    Result := True;

  if not Result then
  begin
    FDQuery := TConexaoFiredac.getInstancia.prepareStatement
      ('select * from ABRE_FECHA_CAIXA AFC where AFC.COD_EMP = :CODEMP and ' +
      'AFC.COD_CAI = :CODCAI and  AFC.DATA_FECHA is null  ');
    FDQuery.ParamByName('CODEMP').AsInteger := Caixa.Empresa.Codigo;
    FDQuery.ParamByName('CODCAI').AsInteger := Caixa.Codigo;
    FDQuery.Open;

    if FDQuery.RecordCount <= 0 then
      Result := False
    else
      Result := True;

    if Assigned(FDQuery) then
      TConexaoFiredac.getInstancia.closeConnection(FDQuery);
  end;
end;

end.
