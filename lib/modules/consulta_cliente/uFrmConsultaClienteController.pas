unit uFrmConsultaClienteController;

interface

uses
  uFrmConsultaCliente, System.Generics.Collections, uCliente;

type
  TFrmConsultaClienteController = class(TObject)
  private
    { private declarations }
    FView: TFrmConsultaCliente;
    procedure FormShow;
    procedure btnBuscarClienteClick;
    procedure btnSelecionarClick;
    procedure listaClientesDblClick;
    procedure btnSairClick;
    procedure EdtConsultaClick;
    procedure addClientes;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure Clear;
    constructor Create(view: TFrmConsultaCliente); reintroduce;
    destructor Destroy; override;
    procedure evento(evento: String);

    class var FListaClientes: TObjectList<TCliente>;
  end;

implementation

uses
  System.StrUtils, uClienteDAO, Vcl.ComCtrls, FMX.ListView.Appearances,
  FMX.ListView.Types, System.SysUtils, uDMConexao;

{ TFrmConsultaClienteController }

procedure TFrmConsultaClienteController.addClientes;
var
  I: Integer;
  Lista: TlistView;
  LItem: TListViewItem;
begin
  FView.listaClientes.BeginUpdate;

  FView.listaClientes.Items.Clear;

  for I := 0 to FListaClientes.Count - 1 do
  begin

    LItem := FView.listaClientes.Items.Add;

    LItem.Tag := I;
    LItem.Objects.FindObjectT<TListItemText>('Codigo').Text :=
      IntToStr(FListaClientes.Items[I].Codigo);
    LItem.Objects.FindObjectT<TListItemText>('Nome').Text :=
      FListaClientes.Items[I].NomeCliente;
    LItem.Objects.FindObjectT<TListItemText>('CPF').Text :=
      FListaClientes.Items[I].Cnpj;
  end;

  FView.listaClientes.EndUpdate;

end;

procedure TFrmConsultaClienteController.btnBuscarClienteClick;
begin
  FListaClientes := TClienteDAO.getInstancia.buscarTodos
    (FView.EdtConsulta.Text);

  addClientes;

  FView.listaClientes.Selected := FView.listaClientes.Items[0];
end;

procedure TFrmConsultaClienteController.btnSairClick;
begin
  Dmconexao.FCliente := nil;
  FView.Close;
end;

procedure TFrmConsultaClienteController.btnSelecionarClick;
var
  I: Integer;
begin
  TDmconexao.FCliente := FListaClientes.Items[FView.listaClientes.Selected.Tag];
  FView.Close;
end;

procedure TFrmConsultaClienteController.Clear;
begin

end;

constructor TFrmConsultaClienteController.Create(view: TFrmConsultaCliente);
begin
  if view <> nil then
    FView := view;
end;

destructor TFrmConsultaClienteController.Destroy;
begin

  inherited;
end;

procedure TFrmConsultaClienteController.EdtConsultaClick;
begin
  Dmconexao.mostraTeclado(FView, FView.EdtConsulta, FView.btnBuscarCliente);
end;

procedure TFrmConsultaClienteController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow', 'btnBuscarClienteClick',
    'btnSelecionarClick', 'listaClientesDblClick', 'btnSairClick',
    'EdtConsultaClick']) of
    0:
      FormShow;
    1:
      btnBuscarClienteClick;
    2:
      btnSelecionarClick;
    3:
      listaClientesDblClick;
    4:
      btnSairClick;
    5:
      EdtConsultaClick;
  end;
end;

procedure TFrmConsultaClienteController.FormShow;
begin
  FView.EdtConsulta.Text := '';
  FView.EdtConsulta.SetFocus;
end;

procedure TFrmConsultaClienteController.listaClientesDblClick;
begin
  btnSelecionarClick;
end;

end.
