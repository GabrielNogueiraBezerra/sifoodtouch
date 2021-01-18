unit uUsuario;

interface

uses
  uGrupoUsuario, System.Generics.Collections, uEmpresa;

type
{$TYPEINFO ON}
  TUsuario = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FNome: String;
    FSenha: String;
    FGrupoUsuario: TGrupoUsuario;
    FGerente: Boolean;
    FDesconto: Currency;
    FAtivo: Boolean;
    FEmpresas: TObjectList<TEmpresa>;
    procedure SetAtivo(const Value: Boolean);
    procedure SetCodigo(const Value: Integer);
    procedure SetDesconto(const Value: Currency);
    procedure SetGerente(const Value: Boolean);
    procedure SetGrupoUsuario(const Value: TGrupoUsuario);
    procedure SetNome(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetEmpresas(const Value: TObjectList<TEmpresa>);
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
    property Nome: String read FNome write SetNome;
    property Senha: String read FSenha write SetSenha;
    property GrupoUsuario: TGrupoUsuario read FGrupoUsuario
      write SetGrupoUsuario;
    property Gerente: Boolean read FGerente write SetGerente;
    property Desconto: Currency read FDesconto write SetDesconto;
    property Ativo: Boolean read FAtivo write SetAtivo;
    property Empresas: TObjectList<TEmpresa> read FEmpresas write SetEmpresas;
  end;

implementation

uses
  System.SysUtils;

{ TUsuario }

function TUsuario.buscaAcesso(Funcao: String): Boolean;
begin
  Result := false;
  Result := FGrupoUsuario.buscaAcesso(Funcao);
end;

procedure TUsuario.Clear;
begin
  FCodigo := 0;
  FNome := '';
  FSenha := '';
  FreeAndNil(FGrupoUsuario);
  FreeAndNil(FEmpresas);
  FGerente := false;
  FDesconto := 0.0;
  FAtivo := false;
end;

constructor TUsuario.Create;
begin
  Self.Clear;
  FGrupoUsuario := TGrupoUsuario.Create;
  FEmpresas := TObjectList<TEmpresa>.Create;
end;

destructor TUsuario.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TUsuario.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TUsuario.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TUsuario.SetDesconto(const Value: Currency);
begin
  FDesconto := Value;
end;

procedure TUsuario.SetEmpresas(const Value: TObjectList<TEmpresa>);
begin
  FEmpresas := Value;
end;

procedure TUsuario.SetGerente(const Value: Boolean);
begin
  FGerente := Value;
end;

procedure TUsuario.SetGrupoUsuario(const Value: TGrupoUsuario);
begin
  FGrupoUsuario := Value;
end;

procedure TUsuario.SetNome(const Value: String);
begin
  if Value = EmptyStr then
    raise Exception.Create('Informe o Nome do Usuário.');

  if Value.Length > 10 then
    raise Exception.Create('Nome do Usuário deve conter até 10 caracteres.');

  FNome := Value;
end;

procedure TUsuario.SetSenha(const Value: String);
begin
  if Value = EmptyStr then
    raise Exception.Create('Informe a Senha do Usuário.');

  if Value.Length > 12 then
    raise Exception.Create('A senha deve conter no máximo 12 caracteres.');

  FSenha := Value;
end;

end.
