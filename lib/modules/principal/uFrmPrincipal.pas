unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox, System.ImageList,
  FMX.ImgList, FMX.Effects, FMX.Objects, FMX.Printer, FMX.ExtCtrls,
  FMX.Filter.Effects, FMX.Edit, uFrmMesas, System.UITypes;

type
  TFrmPrincipal = class(TForm)
    StyleBook1: TStyleBook;
    ImageList1: TImageList;
    retDesktop: TRectangle;
    retLogin: TRectangle;
    retFechar: TRectangle;
    imgFechar: TImage;
    Line1: TLine;
    retUsuario: TRectangle;
    Rectangle1: TRectangle;
    Line3: TLine;
    lblUsuario: TLabel;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Line2: TLine;
    lblNomeComanda: TLabel;
    FrmMesas: TFrmMesas;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgFecharClick(Sender: TObject);
    procedure retUsuarioClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uFrmPrincipalController;

{$R *.fmx}

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
var
  controller: TFrmPrincipalController;
begin
  controller := TFrmPrincipalController.Create(self);
  controller.evento('FormClose');
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  controller: TFrmPrincipalController;
begin
  controller := TFrmPrincipalController.Create(self);
  controller.evento('FormShow');
end;

procedure TFrmPrincipal.imgFecharClick(Sender: TObject);
var
  controller: TFrmPrincipalController;
begin
  controller := TFrmPrincipalController.Create(self);
  controller.evento('imgFecharClick');
end;

procedure TFrmPrincipal.retUsuarioClick(Sender: TObject);
var
  controller: TFrmPrincipalController;
begin
  controller := TFrmPrincipalController.Create(self);
  controller.evento('retUsuarioClick');
end;

end.
