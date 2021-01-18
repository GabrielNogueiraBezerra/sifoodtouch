unit uFrmMensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.ScrollBox, FMX.Memo;

type
  TFrmMensagem = class(TForm)
    StyleBook1: TStyleBook;
    retInformacao: TRectangle;
    lblTitulo: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    vRetInformacao: TVertScrollBox;
    btnOk: TCornerButton;
    btnNao: TCornerButton;
    btnSim: TCornerButton;
    Rectangle4: TRectangle;
    lblInformacao: TMemo;
    procedure FormShow(Sender: TObject);
  public
    { Public declarations }
    class var FTipo: Integer;
    class var FProcedimento: String;
    class var FTitulo: String;
  end;

var
  FrmMensagem: TFrmMensagem;

implementation

uses
  uFrmMensagemController;

{$R *.fmx}
{ TFrmMensagem }

procedure TFrmMensagem.FormShow(Sender: TObject);
var
  controller: TFrmMensagemController;
begin
  controller := TFrmMensagemController.Create(self);
  controller.evento('FormShow');
end;

end.
