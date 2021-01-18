unit uFrmLancamentoPOS;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Edit;

type
  TFrmLancamentoPOS = class(TForm)
    StyleBook1: TStyleBook;
    ToolbarHolder: TLayout;
    ToolbarPopup: TPopup;
    ToolbarPopupAnimation: TFloatAnimation;
    ToolBar1: TToolBar;
    ToolbarApplyButton: TButton;
    ToolbarCloseButton: TButton;
    ToolbarAddButton: TButton;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    vRetPOS: TVertScrollBox;
    Rectangle6: TRectangle;
    btnConfirmar: TCornerButton;
    btnSair: TCornerButton;
    Rectangle51: TRectangle;
    Label49: TLabel;
    Label1: TLabel;
    lblTotalCartao: TLabel;
    retShadow: TRectangle;
    retLancamentoValor: TRectangle;
    Rectangle60: TRectangle;
    btnConfirmarValor: TCornerButton;
    btnDesistirValor: TCornerButton;
    Rectangle61: TRectangle;
    Label62: TLabel;
    Rectangle62: TRectangle;
    EdtValorFormaPagamento: TEdit;
    procedure EdtValorFormaPagamentoClick(Sender: TObject);
    procedure btnConfirmarValorClick(Sender: TObject);
    procedure btnDesistirValorClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLancamentoPOS: TFrmLancamentoPOS;

implementation

uses
  uFrmLancamentoPOSController, Vcl.Forms;

{$R *.fmx}

procedure TFrmLancamentoPOS.btnConfirmarClick(Sender: TObject);
var
  controller: TFrmLancamentoPOSController;
begin
  controller := TFrmLancamentoPOSController.Create(Self);
  controller.evento('btnConfirmarClick');
end;

procedure TFrmLancamentoPOS.btnConfirmarValorClick(Sender: TObject);
var
  controller: TFrmLancamentoPOSController;
begin
  controller := TFrmLancamentoPOSController.Create(Self);
  controller.evento('btnConfirmarValorClick');
end;

procedure TFrmLancamentoPOS.btnDesistirValorClick(Sender: TObject);
var
  controller: TFrmLancamentoPOSController;
begin
  controller := TFrmLancamentoPOSController.Create(Self);
  controller.evento('btnDesistirValorClick');
end;

procedure TFrmLancamentoPOS.btnSairClick(Sender: TObject);
var
  controller: TFrmLancamentoPOSController;
begin
  controller := TFrmLancamentoPOSController.Create(Self);
  controller.evento('btnSairClick');
end;

procedure TFrmLancamentoPOS.EdtValorFormaPagamentoClick(Sender: TObject);
var
  controller: TFrmLancamentoPOSController;
begin
  controller := TFrmLancamentoPOSController.Create(Self);
  controller.evento('EdtValorFormaPagamentoClick');
end;

procedure TFrmLancamentoPOS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmLancamentoPOS.FormShow(Sender: TObject);
var
  controller: TFrmLancamentoPOSController;
begin
  controller := TFrmLancamentoPOSController.Create(Self);
  controller.evento('FormShow');
end;

end.
