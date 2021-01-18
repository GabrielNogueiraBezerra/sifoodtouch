unit uFrmAlterarDadosvenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Edit, FMX.ExtCtrls,
  FMX.ListBox;

type
  TFrmAlterarDadosVenda = class(TForm)
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    btnAlterarDados: TCornerButton;
    btnSair: TCornerButton;
    Label1: TLabel;
    Label3: TLabel;
    Rectangle24: TRectangle;
    EdtCodigoCliente: TEdit;
    Rectangle3: TRectangle;
    EdtNomeCliente: TEdit;
    Label2: TLabel;
    Rectangle26: TRectangle;
    cbTiposVenda: TComboBox;
    btnConsultarCliente: TCornerButton;
    retProduto: TRectangle;
    lblNomeProduto: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnAlterarDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConsultarClienteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlterarDadosVenda: TFrmAlterarDadosVenda;

implementation

uses
  uFrmAlterarDadosVendaController, Vcl.Forms;

{$R *.fmx}

procedure TFrmAlterarDadosVenda.btnAlterarDadosClick(Sender: TObject);
var
  controller: TFrmAlterarDadosVendaController;
begin
  controller := TFrmAlterarDadosVendaController.Create(Self);
  controller.evento('btnAlterarDadosClick');
end;

procedure TFrmAlterarDadosVenda.btnConsultarClienteClick(Sender: TObject);
var
  controller: TFrmAlterarDadosVendaController;
begin
  controller := TFrmAlterarDadosVendaController.Create(Self);
  controller.evento('btnConsultarClienteClick');
end;

procedure TFrmAlterarDadosVenda.btnSairClick(Sender: TObject);
var
  controller: TFrmAlterarDadosVendaController;
begin
  controller := TFrmAlterarDadosVendaController.Create(Self);
  controller.evento('btnSairClick');
end;

procedure TFrmAlterarDadosVenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  controller: TFrmAlterarDadosVendaController;
begin
  controller := TFrmAlterarDadosVendaController.Create(Self);
  controller.evento('FormClose');

  Action := caFree;
end;

procedure TFrmAlterarDadosVenda.FormShow(Sender: TObject);
var
  controller: TFrmAlterarDadosVendaController;
begin
  controller := TFrmAlterarDadosVendaController.Create(Self);
  controller.evento('FormShow');
end;

end.
