unit uConexaoFiredac;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, FireDAC.Comp.Client, Data.DB,
  FireDAC.Stan.StorageJSON, FireDAC.Phys.SQLite,
  FireDAC.Comp.DataSet;

type
{$TYPEINFO ON}
  TConexaoFiredac = class(TObject)
  private
    { private declarations }
    FConnection: TFDConnection;
    FConexao: TFDConnection;
    FDriver: String;
    FDatabase: String;
    FOpenMode: String;
    FUsername: String;
    FPassword: String;
    FPorta: Integer;
    FHostBanco: String;

    constructor Create;
    function getConnection: TFDConnection;

    class var FInstancia: TConexaoFiredac;
  protected
    { protected declarations }
  public
    { public declarations }
    function prepareStatement(const Value: String): TFDQuery;
    procedure closeConnection(Query: TFDQuery);
    procedure functionGetConfiguration(Driver, OpenMode, Host, Caminho,
      Username, Password: String; Porta: Integer);
    class function getInstancia: TConexaoFiredac;
  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils;

{ TConexaoFiredac }

procedure TConexaoFiredac.closeConnection(Query: TFDQuery);
begin
  try
    if Assigned(Query) then
    begin
      Query.Close;

      FreeAndNil(Query);
    end;
  except
    raise Exception.Create('Não foi possível encerra a conexão');
  end;
end;

constructor TConexaoFiredac.Create;
begin
end;

procedure TConexaoFiredac.functionGetConfiguration(Driver, OpenMode, Host,
  Caminho, Username, Password: String; Porta: Integer);
begin
  FDriver := Driver;
  FDatabase := Caminho;
  FOpenMode := OpenMode;
  FHostBanco := Host;
  FUsername := Username;
  FPassword := Password;
  FPorta := Porta;
end;

function TConexaoFiredac.getConnection: TFDConnection;
begin
  try

    Result := TFDConnection.Create(nil);
    with Result.Params do
    begin
      Clear;
      Values['DriverID'] := FDriver;
      Values['Server'] := FHostBanco;
      Values['Database'] := FDatabase;
      Values['User_name'] := FUsername;
      Values['Password'] := FPassword;
      Values['Port'] := IntToStr(FPorta);
    end;
    Result.Params.Add('StringFormat=Unicode');
    Result.FetchOptions.AssignedValues := [evCursorKind];
    Result.FetchOptions.AutoClose := True;
    Result.FetchOptions.CursorKind := ckDefault;
    Result.UpdateOptions.AssignedValues :=
      [uvCountUpdatedRecords, uvAutoCommitUpdates];
    Result.UpdateOptions.AutoCommitUpdates := True;
    Result.UpdateOptions.CountUpdatedRecords := false;
    Result.LoginPrompt := false;
    Result.Connected := True;

  except
    raise Exception.Create('Não foi possível criar a conexão com ' +
      'o banco de dados.');
  end;
end;

class function TConexaoFiredac.getInstancia: TConexaoFiredac;
begin
  if FInstancia = Nil then
    FInstancia := TConexaoFiredac.Create;

  Result := FInstancia;
end;

function TConexaoFiredac.prepareStatement(const Value: String): TFDQuery;
var
  Query: TFDQuery;
begin

  if FConnection = nil then
    FConnection := getConnection;

  Result := TFDQuery.Create(nil);

  Result.Connection := FConnection;
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Text := Value;
end;

end.
