unit uSecaoDAO;

interface

uses
  uSecao, System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TSecaoDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TSecaoDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TSecaoDAO;
    procedure buscar(Secao: TSecao);
    function buscarTodosComProduto(): TObjectList<TSecao>; overload;
    function buscarTodosComProduto(nome: String): TObjectList<TSecao>; overload;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils, FMX.Forms;

{ TSecaoDAO }

procedure TSecaoDAO.buscar(Secao: TSecao);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(Secao) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select S.COD_SEC, S.NOME_SEC, S.ADICIONAL_PIZZA from SECAO S ' +
          'where S.COD_SEC = :CODIGO    ');

        FDQuery.ParamByName('CODIGO').AsInteger := Secao.Codigo;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            Secao.Codigo := FieldByName('COD_SEC').AsInteger;
            Secao.Descricao := FieldByName('NOME_SEC').AsString;
            Secao.Adicional := DMConexao.Configuracao.StrToBool
              (FieldByName('ADICIONAL_PIZZA').AsString, 'S');
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

function TSecaoDAO.buscarTodosComProduto: TObjectList<TSecao>;
var
  FDQuery: TFDQuery;
  Secao: TSecao;
  Secoes: TObjectList<TSecao>;
begin
  Secoes := TObjectList<TSecao>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select * from SP_BUSCA_SECAO_COM_PRODUTO  ');
      FDQuery.Open;
      with FDQuery do
      begin

        if RecordCount > 0 then
        begin
          while not FDQuery.EOF do
          begin
            Secao := TSecao.Create;
            Secao.Codigo := FieldByName('COD_SEC').AsInteger;
            Secao.Descricao := FieldByName('NOME_SEC').AsString;
            Secao.Adicional := DMConexao.Configuracao.StrToBool
              (FieldByName('ADICIONAL_PIZZA').AsString, 'S');
            Secoes.Add(Secao);
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
    result := Secoes;
  end;
end;

function TSecaoDAO.buscarTodosComProduto(nome: String): TObjectList<TSecao>;
var
  FDQuery: TFDQuery;
  Secao: TSecao;
  Secoes: TObjectList<TSecao>;
begin
  Secoes := TObjectList<TSecao>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        ('select S.COD_SEC, S.NOME_SEC, S.ADICIONAL_PIZZA from SECAO S where S.COD_SEC in (select P.COD_SEC '
        + 'from PRODUTO P where P.ATIVO_PRO = ' + quotedstr('S') +
        ' and (P.CODIGO_TIPO = 6 or P.CODIGO_TIPO = 1) and S.USA_RESTAURANTE = '
        + quotedstr('S') + ' and P.NOME_SEC LIKE ' + quotedstr(nome) +
        ' group by P.COD_SEC)');
      FDQuery.Open;
      with FDQuery do
      begin
        if RecordCount > 0 then
        begin
          while not FDQuery.EOF do
          begin
            Secao := TSecao.Create;
            Secao.Codigo := FieldByName('COD_SEC').AsInteger;
            Secao.Descricao := FieldByName('NOME_SEC').AsString;
            Secao.Adicional := DMConexao.Configuracao.StrToBool
              (FieldByName('ADICIONAL_PIZZA').AsString, 'S');
            Secoes.Add(Secao);
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
    result := Secoes;
  end;
end;

constructor TSecaoDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TSecaoDAO.getInstancia: TSecaoDAO;
begin
  if FInstancia = nil then
    FInstancia := TSecaoDAO.Create;

  result := FInstancia;
end;

end.
