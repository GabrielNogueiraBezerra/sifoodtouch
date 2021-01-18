unit uGrupoUsuario;

interface

uses
  System.Generics.Collections, uFuncoes;

type
{$TYPEINFO ON}
  TGrupoUsuario = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FDescricao: String;
    FSuperGrupo: Boolean;
    FFuncoes: TObjectList<TFuncoes>;
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetSuperGrupo(const Value: Boolean);
    procedure SetFuncoes(const Value: TObjectList<TFuncoes>);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;

    function buscaAcesso(Funcao: String): Boolean;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property Descricao: String read FDescricao write SetDescricao;
    property SuperGrupo: Boolean read FSuperGrupo write SetSuperGrupo;
    property Funcoes: TObjectList<TFuncoes> read FFuncoes write SetFuncoes;
  end;

implementation

uses
  System.SysUtils;

{ TGrupoUsuario }

function TGrupoUsuario.buscaAcesso(Funcao: String): Boolean;
var
  I: Integer;

begin
  result := False;

  if FSuperGrupo then
  begin
    result := True;
    exit;
  end;

  for I := 0 to FFuncoes.Count - 1 do
  begin
    with FFuncoes.Items[I] do
    begin
      if Funcao = ItemMenu then
      begin
        result := True;
        break;
      end;
    end;
  end;
end;

procedure TGrupoUsuario.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FSuperGrupo := False;
  FreeAndNil(FFuncoes);
end;

constructor TGrupoUsuario.Create;
begin
  self.Clear;
  FFuncoes := TObjectList<TFuncoes>.Create;
end;

destructor TGrupoUsuario.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TGrupoUsuario.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TGrupoUsuario.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TGrupoUsuario.SetFuncoes(const Value: TObjectList<TFuncoes>);
begin
  FFuncoes := Value;
end;

procedure TGrupoUsuario.SetSuperGrupo(const Value: Boolean);
begin
  FSuperGrupo := Value;
end;

end.
