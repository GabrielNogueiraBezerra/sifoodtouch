unit uFrmLiberaSenha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Edit;

type
  TFrmLiberaSenha = class(TForm)
    StyleBook1: TStyleBook;
    Rectangle4: TRectangle;
    retInformacao: TRectangle;
    lblTitulo: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    btnCancelar: TCornerButton;
    btnConfirmar: TCornerButton;
    Rectangle3: TRectangle;
    Label3: TLabel;
    EdtUsuario: TEdit;
    Label2: TLabel;
    EdtSenha: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure EdtUsuarioTap(Sender: TObject; const Point: TPointF);
    procedure EdtSenhaTap(Sender: TObject; const Point: TPointF);
    procedure EdtSenhaClick(Sender: TObject);
    procedure EdtUsuarioClick(Sender: TObject);
  public
    { Public declarations }
    class var FTitulo: String;
    procedure mostraMensagem(mensagem: String);
  end;

var
  FrmLiberaSenha: TFrmLiberaSenha;

implementation

uses
  uFrmLiberaSenhaController;

{$R *.fmx}

procedure TFrmLiberaSenha.btnCancelarClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(self);
  controller.evento('btnCancelarClick');
end;

procedure TFrmLiberaSenha.btnConfirmarClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(self);
  controller.evento('btnConfirmarClick');
end;

procedure TFrmLiberaSenha.EdtSenhaClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(self);
  controller.evento('EdtSenhaCanFocus');
end;

procedure TFrmLiberaSenha.EdtSenhaTap(Sender: TObject; const Point: TPointF);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(self);
  controller.evento('EdtSenhaCanFocus');
end;

procedure TFrmLiberaSenha.EdtUsuarioClick(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(self);
  controller.evento('EdtUsuarioCanFocus');
end;

procedure TFrmLiberaSenha.EdtUsuarioTap(Sender: TObject; const Point: TPointF);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(self);
  controller.evento('EdtUsuarioCanFocus');
end;

procedure TFrmLiberaSenha.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(self);
  if Key = VKRETURN then
    controller.evento('FormKeyDown');

  if Key = vkEscape then
    controller.evento('btnCancelarClick');
end;

procedure TFrmLiberaSenha.FormShow(Sender: TObject);
var
  controller: TFrmComandaController;
begin
  controller := TFrmComandaController.Create(self);
  controller.evento('FormShow');
end;

procedure TFrmLiberaSenha.mostraMensagem(mensagem: String);
begin
  ShowMessage(mensagem);
end;

end.
