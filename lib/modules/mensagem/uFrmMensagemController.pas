unit uFrmMensagemController;

interface

uses
  uFrmMensagem, StrUtils;

type
  TFrmMensagemController = class(TObject)
  private
    { private declarations }
    FView: TFrmMensagem;
    procedure FormShow;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure Clear;
    constructor Create(view: TFrmMensagem); reintroduce;
    destructor Destroy; override;
    procedure evento(evento: String);
  end;

implementation

uses
  System.SysUtils, FMX.Dialogs, FMX.Forms;

{ TFrmMensagemController }

procedure TFrmMensagemController.Clear;
begin
  FreeAndNil(FView);
end;

constructor TFrmMensagemController.Create(view: TFrmMensagem);
begin
  if not Assigned(FView) then
    FView := view;
end;

destructor TFrmMensagemController.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TFrmMensagemController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow']) of
    0:
      FormShow;
  end;
end;

procedure TFrmMensagemController.FormShow;
begin
  FView.lblTitulo.Text := FView.FTitulo;
  FView.lblInformacao.Text := FView.FProcedimento;
  case FView.FTipo of
    0:
      begin
        FView.btnSim.Visible := false;
        FView.btnNao.Visible := false;
      end;
    1:
      begin
        FView.btnOK.Visible := false;
      end;
  end;
end;

end.
