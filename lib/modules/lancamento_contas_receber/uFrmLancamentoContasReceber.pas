unit uFrmLancamentoContasReceber;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Edit;

type
  TFrmLancamentoContasReceber = class(TForm)
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    retContasReceber: TRectangle;
    Line1: TLine;
    VertScrollBox1: TVertScrollBox;
    Label1: TLabel;
    Label3: TLabel;
    Rectangle24: TRectangle;
    EdtCodigoCliente: TEdit;
    Rectangle3: TRectangle;
    EdtNomeCliente: TEdit;
    Rectangle4: TRectangle;
    EdtQuantidadeParcelas: TEdit;
    btnAddParcelas: TCornerButton;
    btnRemoveParcelas: TCornerButton;
    Label2: TLabel;
    Rectangle5: TRectangle;
    EdtValor: TEdit;
    Label4: TLabel;
    btnSair: TCornerButton;
    btnGravarParcelas: TCornerButton;
    retProduto: TRectangle;
    lblNomeProduto: TLabel;
    procedure btnGravarParcelasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnAddParcelasClick(Sender: TObject);
    procedure btnRemoveParcelasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLancamentoContasReceber: TFrmLancamentoContasReceber;

implementation

uses
  uFrmLancamentoContasReceberController;

{$R *.fmx}

procedure TFrmLancamentoContasReceber.btnAddParcelasClick(Sender: TObject);
var
  controller: TFrmLancamentoContasReceberController;
begin
  controller := TFrmLancamentoContasReceberController.Create(Self);
  controller.evento('btnAddParcelasClick');
end;

procedure TFrmLancamentoContasReceber.btnGravarParcelasClick(Sender: TObject);
var
  controller: TFrmLancamentoContasReceberController;
begin
  controller := TFrmLancamentoContasReceberController.Create(Self);
  controller.evento('btnGravarParcelasClick');
end;

procedure TFrmLancamentoContasReceber.btnRemoveParcelasClick(Sender: TObject);
var
  controller: TFrmLancamentoContasReceberController;
begin
  controller := TFrmLancamentoContasReceberController.Create(Self);
  controller.evento('btnRemoveParcelasClick');
end;

procedure TFrmLancamentoContasReceber.btnSairClick(Sender: TObject);
var
  controller: TFrmLancamentoContasReceberController;
begin
  controller := TFrmLancamentoContasReceberController.Create(Self);
  controller.evento('btnSairClick');
end;

procedure TFrmLancamentoContasReceber.FormShow(Sender: TObject);
var
  controller: TFrmLancamentoContasReceberController;
begin
  controller := TFrmLancamentoContasReceberController.Create(Self);
  controller.evento('FormShow');
end;

end.
