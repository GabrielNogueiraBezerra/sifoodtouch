unit uFrmMesas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Controls.Presentation, FMX.Layouts,
  FMX.DateTimeCtrls, Vcl.Controls, uFrmComanda, FMX.Edit;

type
  TFrmMesas = class(TFrame)
    retMesas: TRectangle;
    retOpcoes: TRectangle;
    ShadowEffect1: TShadowEffect;
    ccLivre: TCircle;
    lblLivre: TLabel;
    retStatus: TRectangle;
    lbCancelado: TLabel;
    ccCancelado: TCircle;
    Line1: TLine;
    vMesas: TVertScrollBox;
    EdtDateIni: TDateEdit;
    EdtDateFin: TDateEdit;
    ccFechado: TCircle;
    lbFechado: TLabel;
    retDatas: TRectangle;
    Label2: TLabel;
    retSelected: TRectangle;
    retFiltros: TRectangle;
    Line2: TLine;
    Line3: TLine;
    Label1: TLabel;
    retAberto: TRectangle;
    retSelectedAberto: TRectangle;
    Label3: TLabel;
    Label4: TLabel;
    retCancelado: TRectangle;
    retSelectedCancelado: TRectangle;
    Label5: TLabel;
    retFechado: TRectangle;
    retSelectedFechado: TRectangle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    btnAplicar: TCornerButton;
    retPanel: TRectangle;
    Circle1: TCircle;
    Label6: TLabel;
    retNovaMesa: TRectangle;
    Rectangle4: TRectangle;
    Image1: TImage;
    Line4: TLine;
    Line5: TLine;
    Line6: TLine;
    retSelPanel: TRectangle;
    retAddNovaMesa: TRectangle;
    edtNovaComanda: TEdit;
    btnAddMesa: TCornerButton;
    btnCancelarAddMesa: TCornerButton;
    Rectangle5: TRectangle;
    Label7: TLabel;
    Rectangle6: TRectangle;
    retSelAgruparMesas: TRectangle;
    bottom: TRectangle;
    imgFundo: TImage;
    retDadosVenda: TRectangle;
    btnReenviar: TCornerButton;
    btnCancelar: TCornerButton;
    btnReimprimir: TCornerButton;
    Label8: TLabel;
    retStatusEnvioFiscal: TRectangle;
    lblStatusEnvioFiscal: TLabel;
    Image2: TImage;
    btnSairDadosCupom: TCornerButton;
    FrmComanda: TFrmComanda;
    procedure Label2Click(Sender: TObject);
    procedure retDatasClick(Sender: TObject);
    procedure chAbertoClick(Sender: TObject);
    procedure retAbertoClick(Sender: TObject);
    procedure retCanceladoClick(Sender: TObject);
    procedure retFechadoClick(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
    procedure retNovaMesaClick(Sender: TObject);
    procedure btnAddMesaClick(Sender: TObject);
    procedure btnCancelarAddMesaClick(Sender: TObject);
    procedure edtNovaComandaEnter(Sender: TObject);
    procedure retSelAgruparMesasClick(Sender: TObject);
    procedure Rectangle5Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure edtNovaComandaClick(Sender: TObject);
    procedure btnReenviarClick(Sender: TObject);
    procedure btnSairDadosCupomClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnReimprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FormShow;
    procedure FormClose;
  end;

implementation

uses
  uFrmMesasController;

{$R *.fmx}
{ TFrmMesas }

procedure TFrmMesas.chAbertoClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('btnAplicarClick');
end;

procedure TFrmMesas.edtNovaComandaClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('edtNovaComandaClick');
end;

procedure TFrmMesas.edtNovaComandaEnter(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('edtNovaComandaEnter');
end;

procedure TFrmMesas.btnAddMesaClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('btnAddMesaClick');
end;

procedure TFrmMesas.btnAplicarClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('btnAplicarClick');
end;

procedure TFrmMesas.btnCancelarAddMesaClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('btnCancelarAddMesaClick');
end;

procedure TFrmMesas.btnCancelarClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('btnCancelarClick');
end;

procedure TFrmMesas.btnReenviarClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('btnReenviarClick');
end;

procedure TFrmMesas.btnReimprimirClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('btnReimprimirClick');
end;

procedure TFrmMesas.btnSairDadosCupomClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('btnSairDadosCupomClick');
end;

procedure TFrmMesas.FormClose;
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('FormClose');
end;

procedure TFrmMesas.FormShow;
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('FormShow');
end;

procedure TFrmMesas.Label2Click(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('Label2Click');
end;

procedure TFrmMesas.Label7Click(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('retSelAgruparMesas');
end;

procedure TFrmMesas.Rectangle5Click(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('retSelAgruparMesas');
end;

procedure TFrmMesas.retAbertoClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('retAbertoClick');
end;

procedure TFrmMesas.retCanceladoClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('retCanceladoClick');
end;

procedure TFrmMesas.retDatasClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('Label2Click');
end;

procedure TFrmMesas.retFechadoClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('retFechadoClick');
end;

procedure TFrmMesas.retNovaMesaClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('retNovaMesaClick');
end;

procedure TFrmMesas.retSelAgruparMesasClick(Sender: TObject);
var
  controller: TFrmMesasController;
begin
  controller := TFrmMesasController.Create(self);
  controller.evento('retSelAgruparMesasClick');
end;

end.
