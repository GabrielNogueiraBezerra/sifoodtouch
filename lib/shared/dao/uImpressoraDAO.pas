unit uImpressoraDAO;

interface

uses
  uImpressora, uDMConexao, uCaminhoImpressora, System.Contnrs,
  System.Generics.Collections, uSetor, uConexaoFiredac;

type
{$TYPEINFO ON}
  TImpressoraDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TImpressoraDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure buscar(Impressora: TImpressora);
    function buscarTodos: TObjectList<TImpressora>; overload;
    function buscarTodos(Setor: TSetor): TObjectList<TImpressora>; overload;
    class function getInstancia: TImpressoraDAO;
  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils, FMX.Forms, FireDAC.Comp.Client;

{ TImpressoraDAO }

procedure TImpressoraDAO.buscar(Impressora: TImpressora);
var
  caminhoImpressora: TCaminhoImpressora;
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
begin
  try
    try

      if Assigned(Impressora) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select I.COD_IMP, I.NOME_IMP from IMPRESSORAS I ' +
          'where I.COD_IMP = :CODIMP  ');
        FDQuery.ParamByName('CODIMP').AsInteger := Impressora.Codigo;
        FDQuery.Open;

        with FDQuery do
        begin

          if RecordCount > 0 then
          begin
            Impressora.Descricao := FieldByName('NOME_IMP').AsString;

            FDAux := FConnection.prepareStatement
              ('select IC.CODIGO, IC.PORTA, IC.MODELO, IC.COLUNAS ' +
              'from IMPRESSORAS_CAMINHO IC where IC.COD_IMP = :CODIMP');
            FDAux.ParamByName('CODIMP').AsInteger := Impressora.Codigo;
            FDAux.Open;
            with FDAux do
            begin
              Close;
              SQL.Clear;

              while not FDAux.Eof do
              begin
                caminhoImpressora := TCaminhoImpressora.Create;
                caminhoImpressora.Porta := FDAux.FieldByName('PORTA').AsString;
                caminhoImpressora.Modelo := FDAux.FieldByName('MODELO')
                  .AsInteger;
                caminhoImpressora.Colunas := FDAux.FieldByName('COLUNAS')
                  .AsInteger;
                Impressora.CaminhosImpressora.Add(caminhoImpressora);
                FDAux.Next;
                Application.processMessages;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);
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

function TImpressoraDAO.buscarTodos: TObjectList<TImpressora>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  Impressora: TImpressora;
  Impressoras: TObjectList<TImpressora>;
  caminhoImpressora: TCaminhoImpressora;
begin
  Impressoras := TObjectList<TImpressora>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        ('select I.COD_IMP, I.NOME_IMP from IMPRESSORAS I');
      FDQuery.Open;
      with FDQuery do
      begin
        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            Impressora := TImpressora.Create;
            Impressora.Codigo := FieldByName('COD_IMP').AsInteger;
            Impressora.Descricao := FieldByName('NOME_IMP').AsString;

            FDAux := FConnection.prepareStatement
              ('select IC.CODIGO, IC.PORTA, IC.MODELO, IC.COLUNAS, IC.PAGINADECODIGO, '
              + 'IC.PARAMSSTRING, IC.ESPACO_ENTRE_LINHAS, IC.CONTROLE_PORTA, IC.CORTARPAPEL '
              + 'from IMPRESSORAS_CAMINHO IC where IC.COD_IMP = :CODIMP');

            FDAux.ParamByName('CODIMP').AsInteger := Impressora.Codigo;
            FDAux.Open;
            with FDAux do
            begin
              First;

              while not FDAux.Eof do
              begin
                caminhoImpressora := TCaminhoImpressora.Create;
                caminhoImpressora.Codigo := FDAux.FieldByName('CODIGO')
                  .AsInteger;
                caminhoImpressora.Porta := FDAux.FieldByName('PORTA').AsString;
                caminhoImpressora.Modelo := FDAux.FieldByName('MODELO')
                  .AsInteger;
                caminhoImpressora.Colunas := FDAux.FieldByName('COLUNAS')
                  .AsInteger;
                caminhoImpressora.PaginaCodigo :=
                  FDAux.FieldByName('PAGINADECODIGO').AsInteger;
                caminhoImpressora.ParametroString :=
                  FDAux.FieldByName('PARAMSSTRING').AsString;
                caminhoImpressora.EspacoEntreLinhas :=
                  FDAux.FieldByName('ESPACO_ENTRE_LINHAS').AsInteger;
                caminhoImpressora.ControlaPorta :=
                  DMConexao.Configuracao.StrToBool
                  (FDAux.FieldByName('CONTROLE_PORTA').AsString, '1');
                caminhoImpressora.CortaPapel := DMConexao.Configuracao.StrToBool
                  (FDAux.FieldByName('CORTARPAPEL').AsString, '1');

                Impressora.CaminhosImpressora.Add(caminhoImpressora);
                FDAux.Next;
                Application.processMessages;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            Impressoras.Add(Impressora);
            FDQuery.Next;
            Application.processMessages;
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
    result := Impressoras;
  end;
end;

function TImpressoraDAO.buscarTodos(Setor: TSetor): TObjectList<TImpressora>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  Impressora: TImpressora;
  Impressoras: TObjectList<TImpressora>;
  caminhoImpressora: TCaminhoImpressora;
begin
  Impressoras := TObjectList<TImpressora>.Create;
  try
    try
      if Assigned(Setor) then
      begin
        FDQuery := FConnection.prepareStatement
          ('select I.COD_IMP, I.NOME_IMP from IMPRESSORAS I');
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            while not FDQuery.Eof do
            begin
              Impressora := TImpressora.Create;
              Impressora.Codigo := FieldByName('COD_IMP').AsInteger;
              Impressora.Descricao := FieldByName('NOME_IMP').AsString;

              FDAux := FConnection.prepareStatement
                ('select IC.CODIGO, IC.PORTA, IC.MODELO, IC.COLUNAS, IC.PAGINADECODIGO, '
                + 'IC.PARAMSSTRING, IC.ESPACO_ENTRE_LINHAS, IC.CONTROLE_PORTA, IC.CORTARPAPEL '
                + 'from IMPRESSORAS_CAMINHO IC where IC.COD_IMP = :CODIMP AND I.COD_SETOR = :CODSETOR');
              FDAux.Open;
              with FDAux do
              begin
                First;

                while not FDAux.Eof do
                begin
                  caminhoImpressora := TCaminhoImpressora.Create;
                  caminhoImpressora.Codigo := FDAux.FieldByName('CODIGO')
                    .AsInteger;
                  caminhoImpressora.Porta := FDAux.FieldByName('PORTA')
                    .AsString;
                  caminhoImpressora.Modelo := FDAux.FieldByName('MODELO')
                    .AsInteger;
                  caminhoImpressora.Colunas := FDAux.FieldByName('COLUNAS')
                    .AsInteger;
                  caminhoImpressora.PaginaCodigo :=
                    FDAux.FieldByName('PAGINADECODIGO').AsInteger;
                  caminhoImpressora.ParametroString :=
                    FDAux.FieldByName('PARAMSSTRING').AsString;
                  caminhoImpressora.EspacoEntreLinhas :=
                    FDAux.FieldByName('ESPACO_ENTRE_LINHAS').AsInteger;
                  caminhoImpressora.ControlaPorta :=
                    DMConexao.Configuracao.StrToBool
                    (FDAux.FieldByName('CONTROLE_PORTA').AsString, '1');
                  caminhoImpressora.CortaPapel :=
                    DMConexao.Configuracao.StrToBool
                    (FDAux.FieldByName('CORTARPAPEL').AsString, '1');

                  Impressora.CaminhosImpressora.Add(caminhoImpressora);
                  FDAux.Next;
                  Application.processMessages;
                end;
              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);

              Impressoras.Add(Impressora);
              FDQuery.Next;
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
    result := Impressoras;
  end;
end;

constructor TImpressoraDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TImpressoraDAO.getInstancia: TImpressoraDAO;
begin
  if FInstancia = nil then
    FInstancia := TImpressoraDAO.Create;

  result := FInstancia;
end;

end.
