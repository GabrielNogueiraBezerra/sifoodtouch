unit uFrmLiberaSenhaController;

interface

uses
  uFrmLiberaSenha;

type
  TFrmComandaController = class(TObject)
  private
    { private declarations }
    FView: TFrmLiberaSenha;
    procedure FormShow;
    procedure btnConfirmarClick;
    procedure btnCancelarClick;
    procedure FormKeyDown;
    procedure EdtUsuarioCanFocus;
    procedure EdtSenhaCanFocus;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure Clear;
    constructor Create(view: TFrmLiberaSenha); reintroduce;
    destructor Destroy; override;
    procedure evento(evento: String); overload;
    procedure evento(evento: String; Sender: TObject); overload;
  end;

implementation

uses
  System.SysUtils, System.StrUtils, uUsuario, uUsuarioDAO, uFrmMensagem,
  FMX.Forms, uDMConexao;

{ TFrmComandaController }

procedure TFrmComandaController.btnCancelarClick;
begin
  FView.close;
end;

procedure TFrmComandaController.btnConfirmarClick;
var
  Usuario: TUsuario;
begin
  FView.btnConfirmar.ModalResult := 11;
  Usuario := TUsuario.Create;
  Usuario.Nome := FView.EdtUsuario.Text.Trim;
  Usuario.Senha := FView.EdtSenha.Text.Trim;

  Usuario := TUsuarioDAO.getInstancia.buscar(Usuario);

  if Assigned(Usuario) then
  begin
    if Usuario.Gerente then
      exit;
  end;

  Application.CreateForm(TFrmMensagem, FrmMensagem);
  FrmMensagem.FTipo := 0;
  FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
    ', usuário não encontrado.';
  FrmMensagem.FTitulo := 'Atenção!';
  FrmMensagem.ShowModal;

  FView.btnConfirmar.ModalResult := 0;

end;

procedure TFrmComandaController.Clear;
begin
  FreeAndNil(FView);
end;

constructor TFrmComandaController.Create(view: TFrmLiberaSenha);
begin
  if FView = nil then
    FView := view;
end;

destructor TFrmComandaController.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TFrmComandaController.EdtSenhaCanFocus;
begin
  DMConexao.mostraTeclado(FView, FView.EdtSenha, FView.btnConfirmar);
end;

procedure TFrmComandaController.EdtUsuarioCanFocus;
begin
  DMConexao.mostraTeclado(FView, FView.EdtUsuario, FView.EdtSenha);
end;

procedure TFrmComandaController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow', 'btnConfirmarClick',
    'btnCancelarClick', 'FormKeyDown', 'EdtUsuarioCanFocus',
    'EdtSenhaCanFocus']) of
    0:
      FormShow;
    1:
      btnConfirmarClick;

    2:
      btnCancelarClick;
    3:
      FormKeyDown;
    4:
      EdtUsuarioCanFocus;
    5:
      EdtSenhaCanFocus;
  end;
end;

procedure TFrmComandaController.evento(evento: String; Sender: TObject);
begin

end;

procedure TFrmComandaController.FormKeyDown;
begin
  if FView.EdtUsuario.IsFocused then
    FView.EdtSenha.SetFocus;

  if FView.EdtSenha.IsFocused then
    FView.ActiveControl := FView.btnConfirmar;
end;

procedure TFrmComandaController.FormShow;
begin
  FView.lblTitulo.Text := FView.FTitulo;
  FView.EdtUsuario.SetFocus;
end;

end.
