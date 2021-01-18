unit uFrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Effects, FMX.Objects,
  FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView, FMX.ListBox;

type
  TFrmLogin = class(TForm)
    StyleBook1: TStyleBook;
    ToolbarHolder: TLayout;
    ToolbarPopup: TPopup;
    ToolbarPopupAnimation: TFloatAnimation;
    ToolBar1: TToolBar;
    ToolbarApplyButton: TButton;
    ToolbarCloseButton: TButton;
    ToolbarAddButton: TButton;
    retLogin: TRectangle;
    ShadowEffect1: TShadowEffect;
    retIniciaSessao: TRectangle;
    Label3: TLabel;
    EdtUsuario: TEdit;
    Label2: TLabel;
    EdtSenha: TEdit;
    btnCancelar: TSpeedButton;
    btnEntrar: TButton;
    retEmpresas: TRectangle;
    ShadowEffect3: TShadowEffect;
    listEmpresas: TListBox;
    btnSelecionarEmpresa: TButton;
    ShadowEffect4: TShadowEffect;
    Label1: TLabel;
    Image1: TImage;
    Rectangle1: TRectangle;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Rectangle2: TRectangle;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnEntrarClick(Sender: TObject);
    procedure btnSelecionarEmpresaClick(Sender: TObject);
    procedure EdtUsuarioTap(Sender: TObject; const Point: TPointF);
    procedure EdtSenhaTap(Sender: TObject; const Point: TPointF);
    procedure EdtUsuarioClick(Sender: TObject);
    procedure EdtSenhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses
  uFrmLoginController, Winapi.Windows, Winapi.Messages;

{$R *.fmx}

procedure TFrmLogin.btnCancelarClick(Sender: TObject);
var
  controller: TFrmLoginController;
begin
  controller := TFrmLoginController.Create(Self);
  controller.evento('btnCancelarClick', Sender);
end;

procedure TFrmLogin.btnEntrarClick(Sender: TObject);
var
  controller: TFrmLoginController;
begin
  controller := TFrmLoginController.Create(Self);
  controller.evento('btnEntrarClick', Sender);
end;

procedure TFrmLogin.btnSelecionarEmpresaClick(Sender: TObject);
var
  controller: TFrmLoginController;
begin
  controller := TFrmLoginController.Create(Self);
  controller.evento('btnSelecionarEmpresaClick', Sender);
end;

procedure TFrmLogin.EdtSenhaClick(Sender: TObject);
var
  controller: TFrmLoginController;
begin
  controller := TFrmLoginController.Create(Self);
  controller.evento('EdtSenhaCanFocus', Sender);
end;

procedure TFrmLogin.EdtSenhaTap(Sender: TObject; const Point: TPointF);
var
  controller: TFrmLoginController;
begin
  controller := TFrmLoginController.Create(Self);
  controller.evento('EdtSenhaCanFocus', Sender);
end;

procedure TFrmLogin.EdtUsuarioClick(Sender: TObject);
var
  controller: TFrmLoginController;
begin
  controller := TFrmLoginController.Create(Self);
  controller.evento('EdtUsuarioCanFocus', Sender);
end;

procedure TFrmLogin.EdtUsuarioTap(Sender: TObject; const Point: TPointF);
var
  controller: TFrmLoginController;
begin
  controller := TFrmLoginController.Create(Self);
  controller.evento('EdtUsuarioCanFocus', Sender);
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  controller: TFrmLoginController;
begin
  controller := TFrmLoginController.Create(Self);
  if Key = VKRETURN then
    controller.evento('FormKeyDown', Sender);

  if Key = vkEscape then
    controller.evento('btnCancelarClick', Sender);
end;

procedure TFrmLogin.FormShow(Sender: TObject);
var
  controller: TFrmLoginController;
begin
  try
    controller := TFrmLoginController.Create(Self);
    controller.evento('FormShow', Sender);
  finally
    controller._Release;
  end;

end;

end.
