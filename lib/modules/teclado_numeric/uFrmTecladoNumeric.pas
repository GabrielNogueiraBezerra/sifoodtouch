unit uFrmTecladoNumeric;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmTecladoNumeric = class(TForm)
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    btn1: TCornerButton;
    btn2: TCornerButton;
    btn3: TCornerButton;
    btn9: TCornerButton;
    btn4: TCornerButton;
    btn5: TCornerButton;
    btn8: TCornerButton;
    btn6: TCornerButton;
    btn7: TCornerButton;
    btn0: TCornerButton;
    btnApagar: TCornerButton;
    btnVirgula: TCornerButton;
    btnConfirmar: TCornerButton;
    Rectangle2: TRectangle;
    procedure btn1Click(Sender: TObject);
    procedure btnVirgulaClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    FTela: TObject;
    FEditor: TObject;
    FNumeroVirgula: Integer;
    FUsaVirgula: Boolean;
  end;

var
  FrmTecladoNumeric: TFrmTecladoNumeric;

implementation

uses
  uFrmTecladoNumericController, Vcl.Forms;

{$R *.fmx}

procedure TFrmTecladoNumeric.btn1Click(Sender: TObject);
var
  controller: TFrmTecladoNumericController;
begin
  controller := TFrmTecladoNumericController.Create(Self);
  controller.evento('btn1Click', Sender);
end;

procedure TFrmTecladoNumeric.btnApagarClick(Sender: TObject);
var
  controller: TFrmTecladoNumericController;
begin
  controller := TFrmTecladoNumericController.Create(Self);
  controller.evento('btnApagarClick');
end;

procedure TFrmTecladoNumeric.btnConfirmarClick(Sender: TObject);
var
  controller: TFrmTecladoNumericController;
begin
  controller := TFrmTecladoNumericController.Create(Self);
  controller.evento('btnConfirmarClick');
end;

procedure TFrmTecladoNumeric.btnVirgulaClick(Sender: TObject);
var
  controller: TFrmTecladoNumericController;
begin
  controller := TFrmTecladoNumericController.Create(Self);
  controller.evento('btnVirgulaClick');
end;

procedure TFrmTecladoNumeric.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  controller: TFrmTecladoNumericController;
begin
  controller := TFrmTecladoNumericController.Create(Self);
  controller.evento('FormClose');

  Action := caFree;
end;

procedure TFrmTecladoNumeric.FormShow(Sender: TObject);
var
  controller: TFrmTecladoNumericController;
begin
  controller := TFrmTecladoNumericController.Create(Self);
  controller.evento('FormShow');
end;

end.
