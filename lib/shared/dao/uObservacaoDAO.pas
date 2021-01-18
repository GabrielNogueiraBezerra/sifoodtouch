unit uObservacaoDAO;

interface

uses
  uObservacao, System.Contnrs, System.Generics.Collections, uSecaoDAO, uSecao,
  uConexaoFiredac;

type
{$TYPEINFO ON}
  TObservacaoDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TObservacaoDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TObservacaoDAO;
    procedure buscar(Observacao: TObservacao);
    function buscarTodos: TObjectList<TObservacao>; overload;
    function buscarTodos(Secao: TSecao): TObjectList<TObservacao>; overload;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils, FMX.Forms;

{ TObservacaoDAO }

procedure TObservacaoDAO.buscar(Observacao: TObservacao);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select OPR.COD_OBS, OPR.DESCRICAO_OBS, OPR.ATIVO, ' +
        'OPR.COD_SEC from OBSERVACAO_PADRAO_RECEITA OPR ' +
        'where OPR.COD_OBS = :CODIGO    ');

      if Assigned(Observacao) then
      begin
        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := Observacao.Codigo;
          Open;

          if RecordCount > 0 then
          begin
            Observacao.Codigo := FieldByName('COD_OBS').AsInteger;
            Observacao.Descricao := FieldByName('COD_OBS').AsString;
            Observacao.Ativo := DMConexao.Configuracao.StrToBool
              (FieldByName('ATIVO').AsString, 'S');
            Observacao.Secao.Codigo := FieldByName('COD_SEC').AsInteger;

            TSecaoDAO.getInstancia.buscar(Observacao.Secao);
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

function TObservacaoDAO.buscarTodos: TObjectList<TObservacao>;
var
  FDQuery: TFDQuery;
  Observacao: TObservacao;
  Observacoes: TObjectList<TObservacao>;
begin
  Observacoes := TObjectList<TObservacao>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select OPR.COD_OBS, OPR.DESCRICAO_OBS, OPR.ATIVO, ' +
        'OPR.COD_SEC from OBSERVACAO_PADRAO_RECEITA OPR where OPR.ATIVO = :S  ');

      with FDQuery do
      begin
        ParamByName('S').AsString := 'S';
        Open;

        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            Observacao := TObservacao.Create;
            Observacao.Codigo := FieldByName('COD_OBS').AsInteger;
            Observacao.Descricao := FieldByName('DESCRICAO_OBS').AsString;
            Observacao.Ativo := True;
            Observacao.Secao.Codigo := FieldByName('COD_SEC').AsInteger;

            TSecaoDAO.getInstancia.buscar(Observacao.Secao);
            Observacoes.Add(Observacao);
            Next;
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
    result := Observacoes;
  end;
end;

function TObservacaoDAO.buscarTodos(Secao: TSecao): TObjectList<TObservacao>;
var
  FDQuery: TFDQuery;
  Observacao: TObservacao;
  Observacoes: TObjectList<TObservacao>;
begin
  Observacoes := TObjectList<TObservacao>.Create;
  try
    try
      if Assigned(Secao) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select OPR.COD_OBS, OPR.DESCRICAO_OBS, OPR.ATIVO, ' +
          'OPR.COD_SEC from OBSERVACAO_PADRAO_RECEITA OPR ' +
          'where OPR.ATIVO = :S and OPR.COD_SEC = :CODSEC  ');

        with FDQuery do
        begin
          ParamByName('S').AsString := 'S';
          ParamByName('CODSEC').AsInteger := Secao.Codigo;
          Open;
          First;
          if RecordCount > 0 then
          begin
            while not FDQuery.Eof do
            begin
              Observacao := TObservacao.Create;
              Observacao.Codigo := FieldByName('COD_OBS').AsInteger;
              Observacao.Descricao := FieldByName('DESCRICAO_OBS').AsString;
              Observacao.Ativo := True;
              Observacao.Secao := Secao;

              Observacoes.Add(Observacao);
              Next;
              Application.ProcessMessages;
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
    result := Observacoes;
  end;
end;

constructor TObservacaoDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TObservacaoDAO.getInstancia: TObservacaoDAO;
begin
  if FInstancia = nil then
    FInstancia := TObservacaoDAO.Create;

  result := FInstancia;
end;

end.
