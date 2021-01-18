unit uFrmLoginController;

interface

uses
  uFrmLogin, uDMConexao, StrUtils, uController;

type
  TFrmLoginController = class(TController)
  private
    { private declarations }
    FView: TFrmLogin;
    procedure FormShow;
    procedure BtnCancelar;
    procedure Entrar;
    procedure FormKeyDown;
    procedure btnSelecionarEmpresaClick;
    procedure EdtUsuarioCanFocus;
    procedure EdtSenhaCanFocus;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure Clear;
    constructor Create(view: TFrmLogin); reintroduce;
    destructor Destroy; override;

    procedure evento(evento: String; Sender: TObject); override;
    procedure Update; override;
  end;

implementation

uses
  System.SysUtils, FMX.Dialogs, FMX.Forms,
  uFrmPrincipal;

{ TFrmLoginController }

procedure TFrmLoginController.BtnCancelar;
begin
  FView.close;
end;

procedure TFrmLoginController.btnSelecionarEmpresaClick;
begin
  DMConexao.selecionaEmpresa(FView.listEmpresas.ItemIndex);
  DMConexao.carregaParametros;
  FView.visible := false;

  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  FrmPrincipal.ShowModal;
end;

procedure TFrmLoginController.Clear;
begin
  FreeAndNil(FView);
end;

constructor TFrmLoginController.Create(view: TFrmLogin);
begin
  if Assigned(view) then
    FView := view;
end;

destructor TFrmLoginController.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TFrmLoginController.EdtSenhaCanFocus;
begin
  DMConexao.mostraTeclado(FView, FView.EdtSenha, FView.btnEntrar);
end;

procedure TFrmLoginController.EdtUsuarioCanFocus;
begin
  DMConexao.mostraTeclado(FView, FView.EdtUsuario, FView.EdtSenha);
end;

procedure TFrmLoginController.Entrar;
begin
  if FView.btnEntrar.Text = 'Entrar' then
  begin
    DMConexao.Entrar(FView.EdtUsuario.Text.Trim, FView.EdtSenha.Text.Trim);

    if Assigned(DMConexao.Usuario) then
    begin
      FView.retIniciaSessao.visible := false;

      if (DMConexao.Usuario.Empresas.Count = 1) then
      begin
        FView.retEmpresas.visible := false;
        DMConexao.selecionaEmpresa(0);
        DMConexao.carregaParametros;
        FView.visible := false;

        Application.CreateForm(TFrmPrincipal, FrmPrincipal);
        FrmPrincipal.ShowModal;
        exit;
      end
      else
        FView.retEmpresas.visible := true;

      FView.retLogin.Enabled := true;
      DMConexao.addListEmpresasUsuario(FView.listEmpresas);

    end;
  end
  else
  begin
    if FView.btnEntrar.Text = 'Deslogar' then
    begin
      DMConexao.Usuario := nil;
      FormShow;
    end;
  end;
end;

procedure TFrmLoginController.evento(evento: String; Sender: TObject);
begin

  case AnsiIndexStr(evento, ['FormShow', 'btnCancelarClick', 'btnEntrarClick',
    'FormKeyDown', 'btnSelecionarEmpresaClick', 'EdtUsuarioCanFocus',
    'EdtSenhaCanFocus']) of
    0:
      FormShow;
    1:
      BtnCancelar;
    2:
      Entrar;
    3:
      FormKeyDown;
    4:
      btnSelecionarEmpresaClick;
    5:
      EdtUsuarioCanFocus;
    6:
      EdtSenhaCanFocus;
  end;

end;

procedure TFrmLoginController.FormKeyDown;
begin
  if FView.EdtUsuario.IsFocused then
    FView.EdtSenha.SetFocus;

  if FView.EdtSenha.IsFocused then
    FView.ActiveControl := FView.btnEntrar;
end;

procedure TFrmLoginController.FormShow;
begin
  if Assigned(DMConexao.Usuario) then
  begin
    FView.EdtUsuario.Text := DMConexao.Usuario.Nome;
    FView.EdtUsuario.Enabled := false;
    FView.EdtSenha.Text := DMConexao.Usuario.Senha;
    FView.EdtSenha.Enabled := false;
    FView.btnEntrar.Text := 'Deslogar';
  end
  else
  begin
    FView.EdtUsuario.Enabled := true;
    FView.EdtSenha.Enabled := true;
    FView.EdtUsuario.Text := DMConexao.Configuracao.Usuario;
    FView.btnEntrar.Text := 'Entrar';
    FView.EdtSenha.SetFocus;
  end;
end;

procedure TFrmLoginController.Update;
begin

end;

end.
