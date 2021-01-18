unit uFrmTecladoAlphaNumeric;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects;

type
  TFrmTecladoAlphaNumeric = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    btnQ: TCornerButton;
    btnW: TCornerButton;
    btnR: TCornerButton;
    btnE: TCornerButton;
    btnACrase: TCornerButton;
    btnP: TCornerButton;
    btnT: TCornerButton;
    btnY: TCornerButton;
    btnU: TCornerButton;
    btnI: TCornerButton;
    btnO: TCornerButton;
    btn1: TCornerButton;
    btn0: TCornerButton;
    btn9: TCornerButton;
    btn8: TCornerButton;
    btnDelete: TCornerButton;
    btnEnter: TCornerButton;
    btn3: TCornerButton;
    btn5: TCornerButton;
    btn6: TCornerButton;
    btn4: TCornerButton;
    btn2: TCornerButton;
    btn7: TCornerButton;
    btnZ: TCornerButton;
    btnX: TCornerButton;
    btnEspaco: TCornerButton;
    btnV: TCornerButton;
    btnPontoVirgula: TCornerButton;
    btnPonto: TCornerButton;
    btnVirgula: TCornerButton;
    btnM: TCornerButton;
    btnN: TCornerButton;
    btnC: TCornerButton;
    btnB: TCornerButton;
    btnCCedilha: TCornerButton;
    btnL: TCornerButton;
    btnK: TCornerButton;
    btnJ: TCornerButton;
    btnH: TCornerButton;
    btnG: TCornerButton;
    btnF: TCornerButton;
    btnD: TCornerButton;
    btnS: TCornerButton;
    btnA: TCornerButton;
    btnTio: TCornerButton;
    btnShift1: TCornerButton;
    btnMenos: TCornerButton;
    btnIgual: TCornerButton;
    btnAspa: TCornerButton;
    btnTab: TCornerButton;
    btnCapsLock: TCornerButton;
    btnAbreConchete: TCornerButton;
    btnFechaConchete: TCornerButton;
    btnBarra: TCornerButton;
    btnShift2: TCornerButton;
    btnBarraInvertida: TCornerButton;
    procedure btn0Click(Sender: TObject);
    procedure btnDeleteMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnDeleteMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    FGestureOrigin: TPointF;
    FGestureInProgress: Boolean;
    StyleBook1: TStyleBook;

  public
    { Public declarations }
  class var
    FEditor: TObject;
    FEditorProximo: TObject;
    FTela: TObject;

  published
    { published declarations }
  end;

var
  FrmTecladoAlphaNumeric: TFrmTecladoAlphaNumeric;

implementation

uses
  uFrmTecladoAlphaNumericController, Vcl.Forms;

{$R *.fmx}
{ TFrmTecladoAlphaNumeric }

procedure TFrmTecladoAlphaNumeric.btn0Click(Sender: TObject);
var
  controller: TFrmTecladoAlphaNumericController;
begin
  controller := TFrmTecladoAlphaNumericController.Create(Self);
  controller.evento('btn0Click', Sender);
end;

procedure TFrmTecladoAlphaNumeric.btnDeleteMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  controller: TFrmTecladoAlphaNumericController;
begin
  controller := TFrmTecladoAlphaNumericController.Create(Self);
  controller.evento('btnDeleteMouseDown', Sender);
end;

procedure TFrmTecladoAlphaNumeric.btnDeleteMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  controller: TFrmTecladoAlphaNumericController;
begin
  controller := TFrmTecladoAlphaNumericController.Create(Self);
  controller.evento('btnDeleteMouseUp');
end;

procedure TFrmTecladoAlphaNumeric.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  controller: TFrmTecladoAlphaNumericController;
begin
  controller := TFrmTecladoAlphaNumericController.Create(Self);
  controller.evento('FormClose');

  Action := CaFree;
end;

procedure TFrmTecladoAlphaNumeric.FormShow(Sender: TObject);
var
  controller: TFrmTecladoAlphaNumericController;
begin
  controller := TFrmTecladoAlphaNumericController.Create(Self);
  controller.evento('FormShow');
end;

end.
