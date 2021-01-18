unit uFrmMesasController;

interface

uses
  uFrmMesas, uContaView, System.Generics.Collections, System.Threading,
  uContaClienteDAO, uSat;

type
  TFrmMesasController = class(TObject)
  private
    { private declarations }
    btnAplicarExecutable: Boolean;
    procedure FormShow;
    procedure FormClose;
    procedure btnAplicarClick;
    procedure retAbertoClick;
    procedure retCanceladoClick;
    procedure retFechadoClick;
    procedure retNovaMesaClick;
    procedure btnAddMesaClick;
    procedure btnCancelarAddMesaClick;
    procedure edtNovaComandaEnter;
    procedure Label2Click;
    procedure retSelAgruparMesasClick;
    procedure edtNovaComandaClick;
    procedure btnReenviarClick;
    procedure btnSairDadosCupomClick;
    procedure btnCancelarClick;
    procedure btnReimprimirClick;
    procedure CarregaMesas;
    procedure limpaMesas;
    procedure onClick(Sender: TObject);
    procedure clickMesaCancelada(mesa: TContaView);
    procedure clickMesaAberta(mesa: TContaView);
    procedure clickMesaFechada(mesa: TContaView);
    function buscaRetMesa(Codigo: Integer): TContaView;

    procedure abreTelaStatusEnviaFiscal(Value: Boolean);

  class var
    FListaComandas: TObjectList<TContaView>;
    FchAberto: Boolean;
    FchFechado: Boolean;
    FchCancelado: Boolean;
    FchAgruparMesas: Boolean;
    FAtualizaMesas: ITask;
    FAtualizaTempoMesas: ITask;
    FSat: TSat;
    FMesaSelecionada: TContaView;
    FView: TFrmMesas;

  protected
    { protected declarations }
  public
    { public declarations }
    procedure Clear;
    constructor Create(view: TFrmMesas); reintroduce;
    destructor Destroy; override;
    procedure evento(evento: String); overload;
    procedure evento(evento: String; Sender: TObject); overload;
  end;

implementation

uses
  System.SysUtils, System.StrUtils, FMX.Objects,
  uContaCliente, System.UITypes, FMX.Forms, System.Classes,
  uDMConexao, FMX.Layouts, FMX.Types, uFrmMensagem,
  uClass, UVendaDAO, FMX.Dialogs;

{ TFrmMesasController }

procedure TFrmMesasController.abreTelaStatusEnviaFiscal(Value: Boolean);
begin
  FView.retStatusEnvioFiscal.Position.X :=
    (FView.Width - FView.retStatusEnvioFiscal.Width) / 2;
  FView.retStatusEnvioFiscal.Position.Y :=
    (FView.Height - FView.retStatusEnvioFiscal.Height) / 2;

  FView.retDadosVenda.Enabled := not Value;
  FView.retStatusEnvioFiscal.Visible := Value;

  Application.ProcessMessages;
end;

procedure TFrmMesasController.btnAddMesaClick;
var
  Value: Integer;
  ContaCliente: TContaCliente;
begin

  if FView.edtNovaComanda.Text.Trim.Length > 9 then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
      ', Informe um número válido.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.edtNovaComanda.Text := '';
    FView.edtNovaComanda.SetFocus;
    exit;
  end;

  if (FView.edtNovaComanda.Text.Trim <> '') and
    (StrToInt(FView.edtNovaComanda.Text.Trim) > 0) then
  begin

    if not TContaClienteDAO.getInstancia.existeMesaAberta
      (StrToInt(FView.edtNovaComanda.Text.Trim), DMConexao.Empresa.Codigo) then
    begin

      Value := DMConexao.mensagem(DMConexao.Usuario.Nome +
        ', deseja iniciar o atendimento da comanda?', 1);

      if Value = 6 then
      begin
        ContaCliente := TContaCliente.Create;
        ContaCliente.Conta := StrToInt(FView.edtNovaComanda.Text.Trim);
        ContaCliente.Empresa := DMConexao.Empresa;
        ContaCliente.Caixa := DMConexao.Configuracao.Caixa;
        TContaClienteDAO.getInstancia.inserir(ContaCliente);

        if FView.retSelected.Visible then
          FView.retSelected.Visible := not FView.retSelected.Visible;

        if FView.retFiltros.Visible then
          FView.retFiltros.Visible := not FView.retFiltros.Visible;

        limpaMesas;
        sleep(1000);
        CarregaMesas;
      end;

      if FView.retSelPanel.Visible then
      begin
        FView.retSelPanel.Visible := False;
        if FView.retAddNovaMesa.Visible then
          FView.retAddNovaMesa.Visible := False;
      end;
    end
    else
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
        ', essa comanda já encontra-se aberta.';
      FrmMensagem.FTitulo := 'Atenção!';
      FrmMensagem.ShowModal;

      FView.edtNovaComanda.SetFocus;
    end;
  end
  else
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
      ', informe o número da comanda.';
    FrmMensagem.FTitulo := 'Atenção!';
    FrmMensagem.ShowModal;
    FView.edtNovaComanda.SetFocus;
  end;

end;

procedure TFrmMesasController.btnAplicarClick;
begin
  FView.btnAplicar.Enabled := False;

  if FView.retSelected.Visible then
    FView.retSelected.Visible := not FView.retSelected.Visible;

  if FView.retFiltros.Visible then
    FView.retFiltros.Visible := not FView.retFiltros.Visible;

  limpaMesas;
  Application.ProcessMessages;
  CarregaMesas;
  Application.ProcessMessages;
  FView.btnAplicar.Enabled := True;
end;

procedure TFrmMesasController.btnCancelarAddMesaClick;
begin
  if FView.retSelPanel.Visible then
  begin
    FView.retSelPanel.Visible := False;
    if FView.retAddNovaMesa.Visible then
      FView.retAddNovaMesa.Visible := False;
  end;
end;

procedure TFrmMesasController.btnCancelarClick;
begin
  FView.btnCancelar.Enabled := False;

  TContaClienteDAO.getInstancia.buscar(FMesaSelecionada.ContaCliente);

  DMConexao.FLabelStatusEnvioFiscal := FView.lblStatusEnvioFiscal;

  DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
    ', VALIDANDO INFORMAÇÕES DA VENDA, AGUARDE...';

  abreTelaStatusEnviaFiscal(True);

  if (FMesaSelecionada.ContaCliente.Venda.Cancelada = 1) or
    (FMesaSelecionada.ContaCliente.Venda.CanceladaRetaguarda = 1) then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
      ', essa venda já encontra-se cancelada!';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    FView.btnCancelar.Enabled := True;

    exit;
  end;

  case DMConexao.Configuracao.Caixa.TipoCaixa of
    opSAT, opMFE:
      begin
        try
          FSat.CancelaCupomFiscal(FMesaSelecionada.ContaCliente.Venda);
          FMesaSelecionada.ContaCliente.Venda.Cancelada := 1;
        except
          on E: Exception do
          begin
            Application.CreateForm(TFrmMensagem, FrmMensagem);
            FrmMensagem.FTipo := 0;
            FrmMensagem.FProcedimento := E.Message;
            FrmMensagem.FTitulo := 'Aviso!';
            FrmMensagem.ShowModal;
            abreTelaStatusEnviaFiscal(False);
            FView.btnCancelar.Enabled := True;
            exit;
          end;
        end;
      end;
  end;

  TVendaDAO.getInstancia.alterar(FMesaSelecionada.ContaCliente.Venda);

  sleep(500);

  abreTelaStatusEnviaFiscal(False);

  btnSairDadosCupomClick;
  btnAplicarClick;

  FView.btnCancelar.Enabled := True;
end;

procedure TFrmMesasController.btnReenviarClick;
var
  Confirmacao, Enviou: Boolean;
  Iteracao, Value: Integer;
begin
  FView.btnReenviar.Enabled := False;

  DMConexao.FLabelStatusEnvioFiscal := FView.lblStatusEnvioFiscal;

  DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
    ', VALIDANDO INFORMAÇÕES DA VENDA, AGUARDE...';

  abreTelaStatusEnviaFiscal(True);

  try
    if DMConexao.Configuracao.Caixa.TipoCaixa = opMFE then
      if not FSat.IntegradorAtivo then
      begin
        FView.btnReenviar.Enabled := True;

        abreTelaStatusEnviaFiscal(False);
        exit;
      end;
  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := E.Message;
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;
      abreTelaStatusEnviaFiscal(False);
      FView.btnReenviar.Enabled := True;
    end;
  end;

  TContaClienteDAO.getInstancia.buscar(FMesaSelecionada.ContaCliente);

  Confirmacao := False;
  Iteracao := 3;
  Enviou := False;

  while not Confirmacao do
  begin
    try
      try
        FSat.FechaCupomFiscal(FMesaSelecionada.ContaCliente.Venda);
        Confirmacao := True;
        Enviou := True;
        Continue;
      except
        on E: Exception do
        begin
          if Iteracao = 0 then
          begin
            Application.CreateForm(TFrmMensagem, FrmMensagem);
            FrmMensagem.FTipo := 0;
            FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
              ', Não Foi Possível Enviar o documento fiscal. ' +
              'Abaixo está a lista do(s) erro(s) acontecido(s): ' + sLineBreak +
              sLineBreak + E.Message + sLineBreak + sLineBreak +
              'Para completar seu envio, verifique o(s) Erro(s) ' +
              'Acontecido(s).';
            FrmMensagem.FTitulo := 'Atenção!';
            FrmMensagem.ShowModal;

            Confirmacao := True;
            Continue;
          end
          else
          begin
            Application.CreateForm(TFrmMensagem, FrmMensagem);
            FrmMensagem.FTipo := 1;
            FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
              ', Não Foi Possível Enviar o documento fiscal. ' +
              'Abaixo está a lista do(s) erro(s) acontecido(s): ' + sLineBreak +
              sLineBreak + E.Message + sLineBreak + sLineBreak +
              'Deseja Enviar Novamente? (' + IntToStr(Iteracao) +
              ' Tentativa(s) Restante(s))';
            FrmMensagem.FTitulo := 'Atenção!';
            Value := FrmMensagem.ShowModal;

            if Value <> 6 then
              Confirmacao := True;
          end;
        end;
      end;
    finally
      Iteracao := Iteracao - 1;
    end;
  end;

  if Enviou then
    TVendaDAO.getInstancia.alterar(FMesaSelecionada.ContaCliente.Venda);

  sleep(500);

  abreTelaStatusEnviaFiscal(False);

  btnSairDadosCupomClick;
  btnAplicarClick;

  FView.btnReenviar.Enabled := True;
end;

procedure TFrmMesasController.btnReimprimirClick;
begin
  FView.btnReimprimir.Enabled := False;

  DMConexao.FLabelStatusEnvioFiscal := FView.lblStatusEnvioFiscal;

  DMConexao.FLabelStatusEnvioFiscal.Text := DMConexao.Usuario.Nome +
    ', VALIDANDO INFORMAÇÕES DA VENDA, AGUARDE...';

  abreTelaStatusEnviaFiscal(True);
  TContaClienteDAO.getInstancia.buscar(FMesaSelecionada.ContaCliente);

  try
    FSat.FechaCupomFiscalImprimirCupomFiscal
      (FMesaSelecionada.ContaCliente.Venda, True);
  except
    on E: Exception do
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := E.Message;
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;

      abreTelaStatusEnviaFiscal(False);

      FView.btnReimprimir.Enabled := True;

      exit;
    end;
  end;

  sleep(500);

  abreTelaStatusEnviaFiscal(False);

  btnSairDadosCupomClick;
  btnAplicarClick;

  FView.btnReimprimir.Enabled := True;
end;

procedure TFrmMesasController.btnSairDadosCupomClick;
begin
  if FView.retSelPanel.Visible then
  begin

    FMesaSelecionada := nil;

    FView.retSelPanel.Visible := False;
    if FView.retDadosVenda.Visible then
      FView.retDadosVenda.Visible := False;

  end;
end;

function TFrmMesasController.buscaRetMesa(Codigo: Integer): TContaView;
var
  I: Integer;
begin
  result := nil;
  for I := 0 to FListaComandas.Count - 1 do
  begin
    if FListaComandas.Items[I].ContaCliente.Codigo = Codigo then
    begin
      result := FListaComandas.Items[I];
      break;
    end;
  end;
end;

procedure TFrmMesasController.CarregaMesas;
var
  Contas: TObjectList<TContaCliente>;
  Retangulo: TRectangle;
  I: Integer;
  X, Y: Single;
begin
  try
    FView.vMesas.Visible := False;
    limpaMesas;

    Contas := TContaClienteDAO.getInstancia.buscaTodos
      (StrToDateTime(DateToStr(FView.EdtDateIni.Date) + ' 00:00:01'),
      StrToDateTime(DateToStr(FView.EdtDateFin.Date) + ' ' + TimeToStr(Time)),
      FchAberto, FchCancelado, FchFechado, FchAgruparMesas);

    { local de inicio do primeiro retangulo }
    X := 200;
    Y := 20;

    for I := 0 to Contas.Count - 1 do
    begin
      if Assigned(Contas.Items[I]) then
      begin
        Retangulo := TRectangle.Create(FView);
        Retangulo.Fill.Color := TAlphaColors.White;
        Retangulo.Stroke.Color := TAlphaColors.White;
        Retangulo.parent := FView.vMesas;
        Retangulo.Width := 170;
        Retangulo.Height := 120;
        Retangulo.Cursor := crHandPoint;
        Retangulo.onClick := onClick;

        Retangulo.Tag := Contas.Items[I].Codigo;

        if I <> 0 then
        begin
          if (X + 180) > (FView.vMesas.Width - 180) then
            X := 20
          else
            X := X + 180;

          if (X = 20) then
            Y := Y + 130;
        end;

        Retangulo.Position.X := X;
        Retangulo.Position.Y := Y;
        FListaComandas.Add(TContaView.Create(Contas.Items[I], Retangulo));
        Application.ProcessMessages;
      end;
    end;

    FView.bottom.Height := 20;
    FView.bottom.Position.X := 0;
    FView.bottom.Position.Y := Y + 130;
    FView.bottom.Width := FView.vMesas.Width;
  finally
    FView.vMesas.Visible := True;
  end;
end;

procedure TFrmMesasController.Clear;
begin
  FreeAndNil(FView);
end;

procedure TFrmMesasController.clickMesaAberta(mesa: TContaView);
begin
  FView.retPanel.Visible := False;
  FView.FrmComanda.FormShow(mesa);
end;

procedure TFrmMesasController.clickMesaCancelada(mesa: TContaView);
var
  Value: Integer;
  I: Integer;
begin

  if not DMConexao.Usuario.buscaAcesso('A076') then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
      ', Você não tem permissão para efetuar esta operação.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    exit;
  end;

  Value := DMConexao.mensagem(DMConexao.Usuario.Nome +
    ', deseja reabrir esta comanda?', 1);

  if Value = 6 then
  begin

    Value := DMConexao.senha('liberar a reabertura de comanda.');

    if Value = 11 then
    begin

      for I := 0 to FListaComandas.Count - 1 do
      begin
        if ((FListaComandas.Items[I].ContaCliente.Conta = mesa.ContaCliente.
          Conta) and (FListaComandas.Items[I].ContaCliente.Status = 0)) then
        begin
          Application.CreateForm(TFrmMensagem, FrmMensagem);
          FrmMensagem.FTipo := 0;
          FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
            ', existe uma comanda com essa mesma conta em aberto.';
          FrmMensagem.FTitulo := 'Atenção!';
          FrmMensagem.ShowModal;
          exit;
        end;
      end;
      TContaClienteDAO.getInstancia.buscar(mesa.ContaCliente);
      mesa.ContaCliente.DataFechamento := 0;
      mesa.ContaCliente.HoraFechamento := 0;
      mesa.ContaCliente.Status := 0;

      TContaClienteDAO.getInstancia.alterar(mesa.ContaCliente);

      limpaMesas;

      CarregaMesas;
    end;

  end;
end;

procedure TFrmMesasController.clickMesaFechada(mesa: TContaView);
begin
  if Assigned(mesa) then
  begin
    if not FView.retSelPanel.Visible then
    begin

      FView.btnReenviar.Visible := False;
      FView.btnReimprimir.Visible := False;
      FView.btnCancelar.Visible := False;

      FView.btnReimprimir.Position.X := 8;
      FView.btnReimprimir.Position.Y := 55;

      FView.btnCancelar.Position.X := 8;
      FView.btnCancelar.Position.Y := 105;

      FView.btnReenviar.Position.X := 8;
      FView.btnReenviar.Position.Y := 156;

      FView.btnSairDadosCupom.Position.X := 8;
      FView.btnSairDadosCupom.Position.Y := 207;

      FMesaSelecionada := mesa;

      TContaClienteDAO.getInstancia.buscar(FMesaSelecionada.ContaCliente);

      if (FMesaSelecionada.ContaCliente.Venda.ChaveAcessoCfeNfce <> '') and
        (FMesaSelecionada.ContaCliente.Venda.CupomFiscal > 0) then
      begin
        FView.btnReimprimir.Visible := True;
        FView.btnCancelar.Visible := True;
        FView.retDadosVenda.Height := 220;

        FView.btnReimprimir.Position.X := 8;
        FView.btnReimprimir.Position.Y := 55;

        FView.btnCancelar.Position.X := 8;
        FView.btnCancelar.Position.Y := 105;

        FView.btnSairDadosCupom.Position.X := 8;
        FView.btnSairDadosCupom.Position.Y := 156;
      end
      else
      begin
        FView.btnReenviar.Visible := True;
        FView.retDadosVenda.Height := 158;

        FView.btnReenviar.Position.X := 8;
        FView.btnReenviar.Position.Y := 55;

        FView.btnSairDadosCupom.Position.X := 8;
        FView.btnSairDadosCupom.Position.Y := 105;
      end;

      FView.retSelPanel.Visible := True;
      if not FView.retDadosVenda.Visible then
        FView.retDadosVenda.Visible := True;

    end;
  end;
end;

constructor TFrmMesasController.Create(view: TFrmMesas);
begin
  if Assigned(view) then
    FView := view;

  if not Assigned(FSat) then
    FSat := TSat.Create;

  if not Assigned(FListaComandas) then
    FListaComandas := TObjectList<TContaView>.Create;

end;

destructor TFrmMesasController.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TFrmMesasController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow', 'Label2Click', 'FormClose',
    'btnAplicarClick', 'retAbertoClick', 'retCanceladoClick', 'retFechadoClick',
    'retNovaMesaClick', 'btnAddMesaClick', 'btnCancelarAddMesaClick',
    'edtNovaComandaEnter', 'retSelAgruparMesasClick', 'edtNovaComandaClick',
    'btnReenviarClick', 'btnSairDadosCupomClick', 'btnCancelarClick',
    'btnReimprimirClick']) of
    0:
      FormShow;
    1:
      Label2Click;
    2:
      FormClose;
    3:
      btnAplicarClick;
    4:
      retAbertoClick;
    5:
      retCanceladoClick;
    6:
      retFechadoClick;
    7:
      retNovaMesaClick;
    8:
      btnAddMesaClick;
    9:
      btnCancelarAddMesaClick;
    10:
      edtNovaComandaEnter;
    11:
      retSelAgruparMesasClick;
    12:
      edtNovaComandaClick;
    13:
      btnReenviarClick;
    14:
      btnSairDadosCupomClick;
    15:
      btnCancelarClick;
    16:
      btnReimprimirClick;
  end;
end;

procedure TFrmMesasController.edtNovaComandaClick;
begin
  DMConexao.mostraTeclado(FView, FView.edtNovaComanda, False, 0);
end;

procedure TFrmMesasController.edtNovaComandaEnter;
begin
  FView.edtNovaComanda.SelectAll;
end;

procedure TFrmMesasController.evento(evento: String; Sender: TObject);
begin

end;

procedure TFrmMesasController.FormClose;
begin

  DMConexao.FSistemaAberto := False;

  if FchAberto then
    DMConexao.Configuracao.GravaIni('CHECKBOX', 'FrmMesas.checkAberto', '1')
  else
    DMConexao.Configuracao.GravaIni('CHECKBOX', 'FrmMesas.checkAberto', '0');

  if FchCancelado then
    DMConexao.Configuracao.GravaIni('CHECKBOX', 'FrmMesas.checkCancelado', '1')
  else
    DMConexao.Configuracao.GravaIni('CHECKBOX', 'FrmMesas.checkCancelado', '0');

  if FchFechado then
    DMConexao.Configuracao.GravaIni('CHECKBOX', 'FrmMesas.checkFechado', '1')
  else
    DMConexao.Configuracao.GravaIni('CHECKBOX', 'FrmMesas.checkFechado', '0');

  if FchAgruparMesas then
    DMConexao.Configuracao.GravaIni('CHECKBOX',
      'FrmMesas.checkAgruparMesas', '1')
  else
    DMConexao.Configuracao.GravaIni('CHECKBOX',
      'FrmMesas.checkAgruparMesas', '0');
end;

procedure TFrmMesasController.FormShow;
var
  iTempo: Integer;
begin
  try

    DMConexao.FTempoAtualizaMesas := True;
    if DMConexao.Configuracao.LeIni('CHECKBOX', 'FrmMesas.checkAberto') = '1'
    then
    begin
      FView.retSelectedAberto.Fill.Color := TAlphaColors.Green;
      FchAberto := True;
    end;

    if DMConexao.Configuracao.LeIni('CHECKBOX', 'FrmMesas.checkCancelado') = '1'
    then
    begin
      FView.retSelectedCancelado.Fill.Color := TAlphaColors.Red;
      FchCancelado := True;
    end;

    if DMConexao.Configuracao.LeIni('CHECKBOX', 'FrmMesas.checkFechado') = '1'
    then
    begin
      FView.retSelectedFechado.Fill.Color := TAlphaColors.Black;
      FchFechado := True;
    end;

    if DMConexao.Configuracao.LeIni('CHECKBOX', 'FrmMesas.checkAgruparMesas') = '1'
    then
    begin
      FView.retSelAgruparMesas.Fill.Color := TAlphaColors.Black;
      FchAgruparMesas := True;
    end;
  except
    on E: Exception do
    begin
      FView.retSelectedAberto.Fill.Color := TAlphaColors.White;
      FchAberto := False;

      FView.retSelectedCancelado.Fill.Color := TAlphaColors.White;
      FchCancelado := False;

      FView.retSelectedFechado.Fill.Color := TAlphaColors.White;
      FchFechado := False;

      FView.retSelAgruparMesas.Fill.Color := TAlphaColors.White;
      FchAgruparMesas := False;
    end;
  end;

  FView.FrmComanda.Visible := False;
  FView.EdtDateIni.Date := Date;
  FView.EdtDateFin.Date := Date;
  FView.EdtDateIni.Enabled := True;
  FView.EdtDateFin.Enabled := True;
  FView.EdtDateIni.ReadOnly := False;
  FView.EdtDateFin.ReadOnly := False;
  FView.Visible := True;

  CarregaMesas;
  Application.ProcessMessages;

  FAtualizaMesas := TTask.Create(
    procedure()
    begin
      while DMConexao.FSistemaAberto do
      begin

        iTempo := 0;

        while (DMConexao.FSistemaAberto) and
          (iTempo <> DMConexao.Configuracao.TempoAtualizarMesas * 1000) do
        begin
          iTempo := iTempo + 200;
          sleep(200);
        end;

        if DMConexao.FSistemaAberto then
        begin
          TThread.Queue(nil,
            procedure
            begin
              if DMConexao.FTempoAtualizaMesas then
              begin
                if (FView.btnAplicar.Enabled) and (not btnAplicarExecutable) and
                  (DMConexao.FSistemaAberto) then
                begin
                  btnAplicarExecutable := True;
                  btnAplicarClick;
                  Application.ProcessMessages;
                  btnAplicarExecutable := False;
                end;
              end;
            end);
        end;
        Application.ProcessMessages;
      end;
    end);

  FAtualizaMesas.Start;

end;

procedure TFrmMesasController.Label2Click;
begin
  FView.retSelected.Visible := not FView.retSelected.Visible;
  FView.retFiltros.Visible := not FView.retFiltros.Visible;
end;

procedure TFrmMesasController.limpaMesas;
var
  I: Integer;
begin
  if Assigned(FListaComandas) then
    for I := 0 to FListaComandas.Count - 1 do
      FListaComandas.Items[I].Retangulo.Free;

  FListaComandas := TObjectList<TContaView>.Create;
end;

procedure TFrmMesasController.onClick(Sender: TObject);
var
  mesa: TContaView;
begin
  if Sender is TRectangle then
  begin
    mesa := buscaRetMesa(TRectangle(Sender).Tag);

    if Assigned(mesa) then
    begin
      case mesa.ContaCliente.Status of
        0:
          clickMesaAberta(mesa);
        1:
          clickMesaFechada(mesa);
        2:
          clickMesaCancelada(mesa);
      end;
    end;
  end;
end;

procedure TFrmMesasController.retAbertoClick;
begin
  if FView.retSelectedAberto.Fill.Color = TAlphaColors.Green then
  begin
    FView.retSelectedAberto.Fill.Color := TAlphaColors.White;
    FchAberto := False;
  end
  else
  begin
    FView.retSelectedAberto.Fill.Color := TAlphaColors.Green;
    FchAberto := True;
  end;
end;

procedure TFrmMesasController.retCanceladoClick;
begin
  if FView.retSelectedCancelado.Fill.Color = TAlphaColors.Red then
  begin
    FView.retSelectedCancelado.Fill.Color := TAlphaColors.White;
    FchCancelado := False;
  end
  else
  begin
    FView.retSelectedCancelado.Fill.Color := TAlphaColors.Red;
    FchCancelado := True;
  end;
end;

procedure TFrmMesasController.retFechadoClick;
begin
  if FView.retSelectedFechado.Fill.Color = TAlphaColors.Black then
  begin
    FView.retSelectedFechado.Fill.Color := TAlphaColors.White;
    FchFechado := False;
  end
  else
  begin
    FView.retSelectedFechado.Fill.Color := TAlphaColors.Black;
    FchFechado := True;
  end;
end;

procedure TFrmMesasController.retNovaMesaClick;
begin

  { if not TCaixaDAO.getInstancia.verificaCaixaAberto(DMConexao.Configuracao.Caixa)
    then
    begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
    ', o caixa não está aberto! Abra-o antes de iniciar a movimentação.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    exit;
    end; }

  if not FView.retSelPanel.Visible then
  begin
    FView.retSelPanel.Visible := True;
    if not FView.retAddNovaMesa.Visible then
      FView.retAddNovaMesa.Visible := True;

    FView.edtNovaComanda.Text := '0';
    FView.edtNovaComanda.SetFocus;
  end;
end;

procedure TFrmMesasController.retSelAgruparMesasClick;
begin
  if FView.retSelAgruparMesas.Fill.Color = TAlphaColors.Black then
  begin
    FView.retSelAgruparMesas.Fill.Color := TAlphaColors.White;
    FchAgruparMesas := False;
  end
  else
  begin
    FView.retSelAgruparMesas.Fill.Color := TAlphaColors.Black;
    FchAgruparMesas := True;
  end;
end;

end.
