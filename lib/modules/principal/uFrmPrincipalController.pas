unit uFrmPrincipalController;

interface

uses
  uFrmPrincipal, uDMConexao, FMX.Objects;

type
  TFrmPrincipalController = class(TObject)
  private
    { private declarations }
    FView: TFrmPrincipal;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(View: TFrmPrincipal);
    destructor Destroy; override;

    procedure Clear;
    procedure evento(evento: String);
  private
    { private declarations }
    procedure FormShow;
    procedure FormClose;
    procedure imgFecharClick;
    procedure retUsuarioClick;
    procedure modificaTelaPrincipal;
  end;

implementation

uses
  System.SysUtils, uFrmLogin, FMX.Forms, System.StrUtils, System.UITypes,
  uFrmComanda, FMX.Types,
  Winapi.Windows, uFrmMensagem;

{ TFrmPrincipalController }

procedure TFrmPrincipalController.Clear;
begin
  FreeAndNil(FView);
end;

constructor TFrmPrincipalController.Create(View: TFrmPrincipal);
begin
  if Assigned(View) then
    FView := View;
end;

destructor TFrmPrincipalController.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TFrmPrincipalController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow', 'FormClose', 'imgFecharClick',
    'retUsuarioClick']) of
    0:
      FormShow;
    1:
      FormClose;
    2:
      imgFecharClick;
    3:
      retUsuarioClick;
  end;
end;

procedure TFrmPrincipalController.FormClose;
begin
  FView.Close;
  if FrmLogin <> nil then
    FrmLogin.Close;
end;

procedure TFrmPrincipalController.FormShow;
begin

  modificaTelaPrincipal;

  if Assigned(DMConexao.Usuario) then
  begin
    FView.FrmMesas.FormShow;
    FView.lblUsuario.Text := 'OPERADOR: ' + DMConexao.Usuario.Nome;
  end;
end;

procedure TFrmPrincipalController.imgFecharClick;
var
  Value: Integer;
begin
  try
    if FView.FrmMesas.FrmComanda.Visible then
    begin
      FView.FrmMesas.FrmComanda.FormClose;
      FView.FrmMesas.Visible := true;
    end
    else
    begin

      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 1;

      if Assigned(DMConexao.Usuario) then
        FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
          ', Deseja fechar o sistema?'
      else
        FrmMensagem.FProcedimento := 'Deseja fechar o sistema?';

      FrmMensagem.FTitulo := 'Atenção!';
      Value := FrmMensagem.ShowModal;

      if Value = 6 then
      begin
        FView.FrmMesas.FormClose;
        FView.Close;
      end;
    end;
  except
    Application.Terminate;
  end;

end;

procedure TFrmPrincipalController.modificaTelaPrincipal;
var
  TaskBarH: THandle;
  TaskBarR: TRect;
begin

  TaskBarH := FindWindow('Shell_TrayWnd', nil);
  GetWindowRect(TaskBarH, TaskBarR);
  FView.Left := 0;
  FView.Top := 0;

  FView.Height := Screen.Height - (TaskBarR.Bottom - TaskBarR.Top);
  FView.Width := Screen.Width;

end;

procedure TFrmPrincipalController.retUsuarioClick;
begin
  if not Assigned(DMConexao.Usuario) then
  begin
    Application.CreateForm(TFrmLogin, FrmLogin);
    FrmLogin.ShowModal;

    if Assigned(DMConexao.Usuario) then
    begin
      FView.FrmMesas.FormShow;
      FView.lblUsuario.Text := 'OPERADOR: ' + DMConexao.Usuario.Nome;
    end;
  end;
end;

end.
