unit uFrmAlterarDadosVendaController;

interface

uses
  uFrmAlterarDadosvenda, uVenda, uTipoVenda, System.Generics.Collections,
  uCliente;

type
  TFrmAlterarDadosVendaController = class(TObject)
  private
    { private declarations }
    FView: TFrmAlterarDadosVenda;
    procedure FormShow;
    procedure btnSairClick;
    procedure btnAlterarDadosClick;
    procedure FormClose;
    procedure btnConsultarClienteClick;
    function buscaTipoVenda: TTipoVenda;
    function buscaCliente: TCliente;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure Clear;
    constructor Create(view: TFrmAlterarDadosVenda); reintroduce;
    destructor Destroy; override;
    procedure evento(evento: String);

  class var
    FVenda: TVenda;
    TiposVenda: TObjectList<TTipoVenda>;
  end;

implementation

uses
  System.StrUtils, System.SysUtils, uTipoVendaDAO, uClienteDAO,
  FMX.Forms, uFrmConsultaCliente, uDMConexao;

{ TFrmAlterarDadosVendaController }

procedure TFrmAlterarDadosVendaController.btnAlterarDadosClick;
begin
  FView.btnAlterarDados.Enabled := False;

  FVenda.TipoVenda := buscaTipoVenda;
  FVenda.Cliente := buscaCliente;

  FView.Close;

  FView.btnAlterarDados.Enabled := True;
end;

procedure TFrmAlterarDadosVendaController.btnConsultarClienteClick;
begin
  FView.btnConsultarCliente.Enabled := False;

  Application.CreateForm(TFrmConsultaCliente, FrmConsultaCliente);
  FrmConsultaCliente.ShowModal;

  if Assigned(Dmconexao.FCliente) then
  begin
    FView.EdtCodigoCliente.Text := IntToStr(Dmconexao.FCliente.Codigo);
    FView.EdtNomeCliente.Text := Dmconexao.FCliente.NomeCliente;

    Dmconexao.FCliente := nil;
  end;

  FView.btnConsultarCliente.Enabled := True;
end;

procedure TFrmAlterarDadosVendaController.btnSairClick;
begin
  FView.btnSair.Enabled := False;
  FView.Close;
  FView.btnSair.Enabled := True;
end;

function TFrmAlterarDadosVendaController.buscaCliente: TCliente;
var
  Cliente: TCliente;
begin

  Cliente := TCliente.Create;
  Cliente.Codigo := StrToInt(FView.EdtCodigoCliente.Text.Trim);
  TClienteDAO.getInstancia.buscar(Cliente);
  Result := Cliente;

end;

function TFrmAlterarDadosVendaController.buscaTipoVenda: TTipoVenda;
var
  Codigo: Integer;
  I: Integer;
begin

  Result := nil;

  Codigo := StrToInt
    (copy(FView.cbTiposVenda.Items[FView.cbTiposVenda.ItemIndex], 1,
    pos(' ', FView.cbTiposVenda.Items[FView.cbTiposVenda.ItemIndex]) - 1));

  if Assigned(TiposVenda) then
  begin
    if TiposVenda.Count = 0 then
      TiposVenda := TTipoVendaDAO.getInstancia.buscarTodos
  end
  else
    TiposVenda := TTipoVendaDAO.getInstancia.buscarTodos;

  for I := 0 to TiposVenda.Count - 1 do
  begin
    if TiposVenda.Items[I].Codigo = Codigo then
    begin
      Result := TiposVenda.Items[I];
      break;
    end;
  end;

end;

procedure TFrmAlterarDadosVendaController.Clear;
begin

end;

constructor TFrmAlterarDadosVendaController.Create(view: TFrmAlterarDadosVenda);
begin

  if view <> nil then
    FView := view;

end;

destructor TFrmAlterarDadosVendaController.Destroy;
begin

  inherited;
end;

procedure TFrmAlterarDadosVendaController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow', 'btnSairClick', 'btnAlterarDadosClick',
    'FormClose', 'btnConsultarClienteClick']) of
    0:
      FormShow;
    1:
      btnSairClick;
    2:
      btnAlterarDadosClick;
    3:
      FormClose;
    4:
      btnConsultarClienteClick;
  end;
end;

procedure TFrmAlterarDadosVendaController.FormClose;
begin
  FVenda := nil;
  TiposVenda := nil;
  FView.Close;
end;

procedure TFrmAlterarDadosVendaController.FormShow;
var
  I: Integer;
begin
  if Assigned(FVenda) then
  begin
    FView.EdtCodigoCliente.Text := IntToStr(FVenda.Cliente.Codigo);
    FView.EdtNomeCliente.Text := FVenda.Cliente.NomeCliente;

    TiposVenda := TTipoVendaDAO.getInstancia.buscarTodos;

    for I := 0 to TiposVenda.Count - 1 do
    begin
      FView.cbTiposVenda.Items.Add(IntToStr(TiposVenda.Items[I].Codigo) + ' - '
        + TiposVenda.Items[I].Nome);
      if FVenda.TipoVenda.Codigo = TiposVenda.Items[I].Codigo then
        FView.cbTiposVenda.ItemIndex := I;
    end;
  end;
end;

end.
