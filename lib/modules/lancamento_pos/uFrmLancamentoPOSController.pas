unit uFrmLancamentoPOSController;

interface

uses
  uFrmLancamentoPOS, uVenda, uPOS, System.Generics.Collections,
  uPagamentoPOSView, uAdministradoraCartao, System.Classes, System.Threading;

type
  TFrmLancamentoPOSController = class(TObject)
  private
    { private declarations }
    FView: TFrmLancamentoPOS;
    procedure FormShow;
    procedure EdtValorFormaPagamentoClick;
    procedure btnConfirmarValorClick;
    procedure btnDesistirValorClick;
    procedure btnConfirmarClick;
    procedure btnSairClick;

    procedure limpaPagamentosPOS;
    procedure addPagamentosPOS;
    procedure OnClickPagamentoPOS(Sender: TObject);
    function existeRegistro(Lista: TStringList; Compara: String): Boolean;

    function totalPOS: Currency;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure Clear;
    constructor Create(view: TFrmLancamentoPOS); reintroduce;
    destructor Destroy; override;
    procedure evento(evento: String);

  class var
    FVenda: TVenda;
    FListaPagamentosPOS: TObjectList<TPagamentoPOSView>;
    FPagamentoPOSEscolhido: TPagamentoPOSView;
    FVerificaLista: ITask;
  end;

implementation

uses
  System.StrUtils, System.SysUtils, uPosDAO,
  FMX.Objects, uDMConexao, uFrmMensagem, FMX.Forms,
  uAdministradoraCartaoDAO;

{ TFrmLancamentoPOSController }

procedure TFrmLancamentoPOSController.addPagamentosPOS;
var
  I: Integer;
  ListaPos: TObjectList<TPos>;
  AdministradorasCartao: TObjectList<TAdministradoraCartao>;
  Retangulo: TRectangle;
  X, Y: Single;
  ListaPosAdministradoraCartao: TStringList;
  Z, M: Integer;
begin

  limpaPagamentosPOS;

  ListaPos := TPosDAO.getInstancia.buscarTodos;

  if FVenda.ContasReceberCartao.count > 0 then
  begin

    ListaPosAdministradoraCartao := TStringList.Create;
    AdministradorasCartao := TAdministradoraCartaoDAO.getInstancia.buscaTodos;

    for I := 0 to FVenda.ContasReceberCartao.count - 1 do
    begin
      for M := 0 to AdministradorasCartao.count - 1 do
      begin
        for Z := 0 to AdministradorasCartao.Items[M]
          .BandeirasCartao.count - 1 do
        begin
          if AdministradorasCartao.Items[M].BandeirasCartao.Items[Z]
            .Codigo = FVenda.ContasReceberCartao.Items[I].BandeiraCartao.Codigo
          then
          begin
            if not(existeRegistro(ListaPosAdministradoraCartao,
              IntToStr(AdministradorasCartao.Items[M].Codigo))) then
            begin
              ListaPosAdministradoraCartao.Add
                (IntToStr(AdministradorasCartao.Items[M].Codigo));
            end;
          end;
        end;
      end;
    end;
  end;

  X := 14;
  Y := 14;

  for I := 0 to ListaPos.count - 1 do
  begin
    if FVenda.ContasReceberCartao.count > 0 then
    begin
      if existeRegistro(ListaPosAdministradoraCartao,
        IntToStr(ListaPos.Items[I].AdministradoraCartao.Codigo)) then
      begin
        Retangulo := TRectangle.Create(FView.vRetPOS);
        Retangulo.Parent := FView.vRetPOS;
        Retangulo.Width := 100;
        Retangulo.Height := 100;
        Retangulo.OnClick := OnClickPagamentoPOS;
        Retangulo.Tag := I;

        Retangulo.Position.X := X;
        Retangulo.Position.Y := Y;

        if (X + 105) > (FView.vRetPOS.Width - 105) then
          X := 14
        else
          X := X + 105;

        if (X = 14) then
          Y := Y + 105;

        FListaPagamentosPOS.Add(TPagamentoPOSView.Create(Retangulo,
          ListaPos.Items[I]));
      end;
    end
    else
    begin
      Retangulo := TRectangle.Create(FView.vRetPOS);
      Retangulo.Parent := FView.vRetPOS;
      Retangulo.Width := 100;
      Retangulo.Height := 100;
      Retangulo.OnClick := OnClickPagamentoPOS;
      Retangulo.Tag := I;

      Retangulo.Position.X := X;
      Retangulo.Position.Y := Y;

      if (X + 105) > (FView.vRetPOS.Width - 105) then
        X := 14
      else
        X := X + 105;

      if (X = 14) then
        Y := Y + 105;

      FListaPagamentosPOS.Add(TPagamentoPOSView.Create(Retangulo,
        ListaPos.Items[I]));
    end;
  end;
end;

procedure TFrmLancamentoPOSController.btnConfirmarClick;
var
  I: Integer;
begin
  FView.btnConfirmar.Enabled := false;
  DMConexao.FPagamentosPOS := TObjectList<TPos>.Create;

  if Assigned(FListaPagamentosPOS) then
    for I := 0 to FListaPagamentosPOS.count - 1 do
      if FListaPagamentosPOS.Items[I].Selecionado then
        DMConexao.FPagamentosPOS.Add(FListaPagamentosPOS.Items[I].POS);

  FView.Close;

  FView.btnConfirmar.Enabled := true;
end;

procedure TFrmLancamentoPOSController.btnConfirmarValorClick;
begin

  FView.btnConfirmarValor.Enabled := false;

  if Assigned(FPagamentoPOSEscolhido) then
  begin
    if StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
      [rfReplaceAll, rfIgnoreCase])) >
      (FVenda.totalFormaPagamento('CA') - totalPOS) then
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
        ', O valor informado é maior que o total de cartão lançado nas formas de pagamento.';
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;
      FView.btnConfirmarValor.Enabled := true;
      exit;
    end;

    if StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
      [rfReplaceAll, rfIgnoreCase])) < 0 then
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
        ', O valor informado deve ser maior que 0.';
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;
      FView.btnConfirmarValor.Enabled := true;
      exit;
    end;

    FPagamentoPOSEscolhido.POS.Total :=
      StrToCurr(stringreplace(FView.EdtValorFormaPagamento.Text, '.', '',
      [rfReplaceAll, rfIgnoreCase]));

    if FPagamentoPOSEscolhido.POS.Total = 0 then
    begin
      FPagamentoPOSEscolhido.Selecao.Opacity := 0;
      FPagamentoPOSEscolhido.Selecao.Softness := 0;
      FPagamentoPOSEscolhido.Selecionado := false;
    end
    else
    begin
      FPagamentoPOSEscolhido.Selecao.Opacity := 0.6;
      FPagamentoPOSEscolhido.Selecao.Softness := 0.4;
      FPagamentoPOSEscolhido.Selecionado := true;
    end;

    FView.retLancamentoValor.Visible := false;
    FView.retShadow.Visible := false;
    FPagamentoPOSEscolhido := nil;

  end;

  FView.btnConfirmarValor.Enabled := true;
end;

procedure TFrmLancamentoPOSController.btnDesistirValorClick;
begin

  FView.btnDesistirValor.Enabled := false;

  FView.retLancamentoValor.Visible := false;
  FView.retShadow.Visible := false;

  if FPagamentoPOSEscolhido.Selecionado then
    if FPagamentoPOSEscolhido.POS.Total <= 0 then
    begin
      FPagamentoPOSEscolhido.Selecao.Opacity := 0;
      FPagamentoPOSEscolhido.Selecao.Softness := 0;
    end;

  FPagamentoPOSEscolhido := nil;

  FView.btnDesistirValor.Enabled := true;
end;

procedure TFrmLancamentoPOSController.btnSairClick;
begin
  FView.btnSair.Enabled := false;
  FView.Close;
  FView.btnSair.Enabled := true;
end;

procedure TFrmLancamentoPOSController.Clear;
begin

end;

constructor TFrmLancamentoPOSController.Create(view: TFrmLancamentoPOS);
begin
  if Assigned(view) then
    FView := view;
end;

destructor TFrmLancamentoPOSController.Destroy;
begin

  inherited;
end;

procedure TFrmLancamentoPOSController.EdtValorFormaPagamentoClick;
begin
  DMConexao.mostraTeclado(FView, FView.EdtValorFormaPagamento, true, 2);
end;

procedure TFrmLancamentoPOSController.evento(evento: String);
begin

  case AnsiIndexStr(evento, ['FormShow', 'EdtValorFormaPagamentoClick',
    'btnConfirmarValorClick', 'btnDesistirValorClick', 'btnConfirmarClick',
    'btnSairClick']) of
    0:
      FormShow;
    1:
      EdtValorFormaPagamentoClick;
    2:
      btnConfirmarValorClick;
    3:
      btnDesistirValorClick;
    4:
      btnConfirmarClick;
    5:
      btnSairClick;
  end;

  FView.lblTotalCartao.Text := 'R$: ' + formatfloat('#,##0.00',
    FVenda.totalFormaPagamento('CA') - totalPOS);
end;

function TFrmLancamentoPOSController.existeRegistro(Lista: TStringList;
  Compara: String): Boolean;
var
  I: Integer;
begin

  Result := false;

  for I := 0 to Lista.count - 1 do
  begin
    if Lista[I] = Compara then
    begin
      Result := true;
      break;
    end;
  end;

end;

procedure TFrmLancamentoPOSController.FormShow;
begin
  addPagamentosPOS;
  Application.processMessages;

  FVerificaLista := TTask.Create(
    procedure
    begin

      sleep(100);

      if FListaPagamentosPOS.count = 1 then
      begin
        FListaPagamentosPOS.Items[0].POS.Total :=
          FVenda.totalFormaPagamento('CA') - totalPOS;

        FListaPagamentosPOS.Items[0].Selecionado := true;

        Self.btnConfirmarClick;
      end;
    end);

  FVerificaLista.Start;
end;

procedure TFrmLancamentoPOSController.limpaPagamentosPOS;
var
  I: Integer;
begin
  if Assigned(FListaPagamentosPOS) then
    for I := 0 to FListaPagamentosPOS.count - 1 do
      FListaPagamentosPOS.Items[I].Retangulo.Free;

  FListaPagamentosPOS := TObjectList<TPagamentoPOSView>.Create;
end;

procedure TFrmLancamentoPOSController.OnClickPagamentoPOS(Sender: TObject);
begin
  if Assigned(FListaPagamentosPOS) then
    FPagamentoPOSEscolhido := FListaPagamentosPOS.Items[TRectangle(Sender).Tag];

  FView.retLancamentoValor.Position.X :=
    (FView.Width - FView.retLancamentoValor.Width) / 2;
  FView.retLancamentoValor.Position.Y :=
    (FView.Height - FView.retLancamentoValor.Height) / 2;

  FView.retShadow.Visible := true;
  FView.retLancamentoValor.Visible := true;

  if FPagamentoPOSEscolhido.Selecionado then
    FView.EdtValorFormaPagamento.Text := formatfloat('#,##0.00',
      FPagamentoPOSEscolhido.POS.Total)
  else
    FView.EdtValorFormaPagamento.Text := formatfloat('#,##0.00',
      FVenda.totalFormaPagamento('CA') - totalPOS);
end;

function TFrmLancamentoPOSController.totalPOS: Currency;
var
  I: Integer;
begin
  Result := 0;

  for I := 0 to FListaPagamentosPOS.count - 1 do
    if FListaPagamentosPOS.Items[I].Selecionado then
      Result := Result + FListaPagamentosPOS.Items[I].POS.Total;
end;

end.
