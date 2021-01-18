unit uFrmConsultaCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Layouts,
  FMX.Gestures, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView, FMX.Edit, FMX.ListView.Adapters.Base;

type
  TFrmConsultaCliente = class(TForm)
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    listaClientes: TListView;
    btnSelecionar: TCornerButton;
    btnSair: TCornerButton;
    Rectangle4: TRectangle;
    EdtConsulta: TEdit;
    btnBuscarCliente: TCornerButton;
    Label3: TLabel;
    retProduto: TRectangle;
    lblNomeProduto: TLabel;
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure listaClientesDblClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure EdtConsultaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsultaCliente: TFrmConsultaCliente;

implementation

uses
  uFrmConsultaClienteController;

{$R *.fmx}

procedure TFrmConsultaCliente.btnBuscarClienteClick(Sender: TObject);
var
  controller: TFrmConsultaClienteController;
begin
  controller := TFrmConsultaClienteController.Create(Self);
  controller.evento('btnBuscarClienteClick');
end;

procedure TFrmConsultaCliente.btnSairClick(Sender: TObject);
var
  controller: TFrmConsultaClienteController;
begin
  controller := TFrmConsultaClienteController.Create(Self);
  controller.evento('btnSairClick');
end;

procedure TFrmConsultaCliente.btnSelecionarClick(Sender: TObject);
var
  controller: TFrmConsultaClienteController;
begin
  controller := TFrmConsultaClienteController.Create(Self);
  controller.evento('btnSelecionarClick');
end;

procedure TFrmConsultaCliente.EdtConsultaClick(Sender: TObject);
var
  controller: TFrmConsultaClienteController;
begin
  controller := TFrmConsultaClienteController.Create(Self);
  controller.evento('EdtConsultaClick');
end;

procedure TFrmConsultaCliente.listaClientesDblClick(Sender: TObject);
var
  controller: TFrmConsultaClienteController;
begin
  controller := TFrmConsultaClienteController.Create(Self);
  controller.evento('listaClientesDblClick');
end;

end.
