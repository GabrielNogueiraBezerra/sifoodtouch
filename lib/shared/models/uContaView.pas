unit uContaView;

interface

uses
  FMX.Objects, FMX.StdCtrls, uContaCliente;

type
{$TYPEINFO ON}
  TContaView = class(TObject)
  private
    { private declarations }
    FRetangulo: TRectangle;
    FLineRight: TLine;
    FLineBottom: TLine;
    FLineTop: TLine;
    FRetanguloComandaStatus: TRectangle;
    FRetanguloConteudo: TRectangle;
    FNomeComanda: TLabel;
    FTempo: TLabel;
    FModo: TRectangle;
    FModoTexto: TLabel;
    FRetanguloValor: TRectangle;
    FValor: TLabel;
    FContaCliente: TContaCliente;
    FParcial: TLabel;
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetContaCliente(const Value: TContaCliente);
    procedure SetLineBottom(const Value: TLine);
    procedure SetLineRight(const Value: TLine);
    procedure SetLineTop(const Value: TLine);
    procedure SetModo(const Value: TRectangle);
    procedure SetModoTexto(const Value: TLabel);
    procedure SetNomeComanda(const Value: TLabel);
    procedure SetRetanguloConteudo(const Value: TRectangle);
    procedure SetRetanguloValor(const Value: TRectangle);
    procedure SetTempo(const Value: TLabel);
    procedure SetValor(const Value: TLabel);
    constructor Create; overload;
    procedure SetRetanguloComandaStatus(const Value: TRectangle);
    procedure SetParcial(const Value: TLabel);
    procedure criaLinhaBottom;
    procedure criaLinhaRight;
    procedure criaLinhaTop;
    procedure criaRetanguloComandaStatus;
    procedure criaRetanguloConteudo;
    procedure criaModo;
    procedure criaModoTexto;
    procedure criaNomeComanda;
    procedure criaTempo;
    procedure criaRetanguloValor;
    procedure criaValor;
    procedure criaParcial;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(ContaCliente: TContaCliente; Retangulo: TRectangle);
      reintroduce; overload;
    procedure FreeAndNil;
  published
    { published declarations }
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
    property LineRight: TLine read FLineRight write SetLineRight;
    property LineBottom: TLine read FLineBottom write SetLineBottom;
    property LineTop: TLine read FLineTop write SetLineTop;
    property RetanguloComandaStatus: TRectangle read FRetanguloComandaStatus
      write SetRetanguloComandaStatus;
    property RetanguloConteudo: TRectangle read FRetanguloConteudo
      write SetRetanguloConteudo;
    property NomeComanda: TLabel read FNomeComanda write SetNomeComanda;
    property Tempo: TLabel read FTempo write SetTempo;
    property Modo: TRectangle read FModo write SetModo;
    property ModoTexto: TLabel read FModoTexto write SetModoTexto;
    property RetanguloValor: TRectangle read FRetanguloValor
      write SetRetanguloValor;
    property Valor: TLabel read FValor write SetValor;
    property ContaCliente: TContaCliente read FContaCliente
      write SetContaCliente;
    property Parcial: TLabel read FParcial write SetParcial;
  end;

implementation

uses
  FMX.Types, System.UITypes, System.SysUtils, FMX.Graphics, uDMConexao,
  uComprovante;

{ TContaView }

constructor TContaView.Create(ContaCliente: TContaCliente;
  Retangulo: TRectangle);
begin
  if (Assigned(ContaCliente) and (Assigned(Retangulo))) then
  begin
    FRetangulo := Retangulo;
    FContaCliente := ContaCliente;

    criaLinhaBottom;
    criaLinhaRight;
    criaLinhaTop;
    criaRetanguloComandaStatus;
    criaRetanguloConteudo;
    criaModo;
    criaModoTexto;
    criaNomeComanda;
    criaTempo;
    criaRetanguloValor;
    criaValor;
    criaParcial;
  end;
end;

procedure TContaView.criaLinhaBottom;
begin
  FLineBottom := TLine.Create(Retangulo);
  FLineBottom.Align := TAlignLayout.Bottom;
  FLineBottom.Parent := Retangulo;
  FLineBottom.LineType := TLineType.Diagonal;
  FLineBottom.Stroke.Color := TAlphaColors.Gray;
  FLineBottom.Height := 1;
  FLineBottom.Cursor := crHandPoint;
  FLineBottom.onClick := Retangulo.onClick;
  FLineBottom.Tag := Retangulo.Tag;
end;

procedure TContaView.criaLinhaRight;
begin
  FLineRight := TLine.Create(Retangulo);
  FLineRight.Align := TAlignLayout.Right;
  FLineRight.Parent := Retangulo;
  FLineRight.LineType := TLineType.Diagonal;
  FLineRight.Stroke.Color := TAlphaColors.Gray;
  FLineRight.Width := 1;
  FLineRight.Cursor := crHandPoint;
  FLineRight.onClick := Retangulo.onClick;
  FLineRight.Tag := Retangulo.Tag;
end;

procedure TContaView.criaLinhaTop;
begin
  FLineTop := TLine.Create(Retangulo);
  FLineTop.Align := TAlignLayout.Top;
  FLineTop.Parent := Retangulo;
  FLineTop.LineType := TLineType.Diagonal;
  FLineTop.Stroke.Color := TAlphaColors.Gray;
  FLineTop.Height := 1;
  FLineTop.Cursor := crHandPoint;
  FLineTop.onClick := Retangulo.onClick;
  FLineTop.Tag := Retangulo.Tag;
end;

procedure TContaView.criaModo;
begin
  FModo := TRectangle.Create(FRetanguloConteudo);
  FModo.Position.X := 7;
  FModo.Position.Y := 7;
  FModo.Stroke.Color := TAlphaColors.White;
  case ContaCliente.Status of
    0:
      begin
        if ContaCliente.ConferenciaEmitida = 'S' then
          FModo.Fill.Color := TAlphaColors.Gold
        else
          FModo.Fill.Color := TAlphaColors.Green
      end;
    1:
      FModo.Fill.Color := TAlphaColors.Black;
    2:
      FModo.Fill.Color := TAlphaColors.Red;
  end;
  FModo.Stroke.Color := TAlphaColors.White;
  FModo.Width := 147;
  FModo.Height := 20;
  FModo.Parent := FRetanguloConteudo;
  FModo.Cursor := crHandPoint;
  FModo.onClick := Retangulo.onClick;
  FModo.Tag := Retangulo.Tag;
end;

procedure TContaView.criaModoTexto;
begin
  FModoTexto := TLabel.Create(FModo);
  FModoTexto.Align := TAlignLayout.Client;
  FModoTexto.StyledSettings := [];

  if FContaCliente.Status <> 1 then
    FModoTexto.Text := 'COMANDA: ' + TComprovante.FormataStringD
      (IntToStr(FContaCliente.Conta), '3', '0')
  else
    FModoTexto.Text := 'VENDA: ' + TComprovante.FormataStringD
      (IntToStr(FContaCliente.Venda.Codigo), '3', '0');

  FModoTexto.TextSettings.Font.Size := 12;

  if ((FContaCliente.ConferenciaEmitida = 'S') and (FContaCliente.Status = 0))
  then
  begin
    FModoTexto.TextSettings.FontColor := TAlphaColors.Black;
  end
  else
    FModoTexto.TextSettings.FontColor := TAlphaColors.White;
  FModoTexto.TextSettings.HorzAlign := TTextAlign.Center;
  FModoTexto.Parent := FModo;
  FModoTexto.Cursor := crHandPoint;
  FModoTexto.onClick := Retangulo.onClick;
  FModoTexto.WordWrap := true;
  FModoTexto.Tag := Retangulo.Tag;
end;

procedure TContaView.criaNomeComanda;
begin
  if FContaCliente.Status <> 1 then
  begin
    if ContaCliente.DescricaoMesa <> '' then
    begin
      FNomeComanda := TLabel.Create(FRetanguloConteudo);
      FNomeComanda.Position.X := 9;
      FNomeComanda.Position.Y := 42;
      FNomeComanda.StyledSettings := [];
      FNomeComanda.Text := 'Descrição: ' + ContaCliente.DescricaoMesa;
      FNomeComanda.TextSettings.Font.Family := 'Tahoma';
      FNomeComanda.Parent := FRetanguloConteudo;
      FNomeComanda.Width := 130;
      FNomeComanda.Height := 30;
      FNomeComanda.Cursor := crHandPoint;
      FNomeComanda.onClick := Retangulo.onClick;
      FNomeComanda.Tag := Retangulo.Tag;
    end;
  end
  else
  begin
    FNomeComanda := TLabel.Create(FRetanguloConteudo);
    FNomeComanda.Position.X := 9;
    FNomeComanda.Position.Y := 42;
    FNomeComanda.StyledSettings := [];
    FNomeComanda.Text := 'Cliente: ' + ContaCliente.Venda.Cliente.NomeCliente;
    FNomeComanda.TextSettings.Font.Family := 'Tahoma';
    FNomeComanda.Parent := FRetanguloConteudo;
    FNomeComanda.Width := 130;
    FNomeComanda.Height := 30;
    FNomeComanda.Cursor := crHandPoint;
    FNomeComanda.onClick := Retangulo.onClick;
    FNomeComanda.Tag := Retangulo.Tag;
  end;
end;

procedure TContaView.criaParcial;
begin

  FParcial := TLabel.Create(FRetanguloConteudo);

  if FNomeComanda = nil then
  begin
    FParcial.Position.X := 9;
    FParcial.Position.Y := 50;
  end
  else
  begin
    FParcial.Position.X := 9;
    FParcial.Position.Y := 68;
  end;

  if FContaCliente.Status <> 1 then
  begin
    if ContaCliente.ValorPacial > 0 then
    begin
      FParcial.StyledSettings := [];
      FParcial.Text := 'Parcial: R$ ' + formatfloat('#,##0.00',
        ContaCliente.ValorPacial);
      FParcial.FontColor := TAlphaColors.Blue;
      FParcial.TextSettings.Font.Family := 'Tahoma';
      FParcial.Parent := FRetanguloConteudo;
      FParcial.Cursor := crHandPoint;
      FParcial.onClick := Retangulo.onClick;
      FParcial.Tag := Retangulo.Tag;
    end;
  end
  else
  begin
    FParcial.StyledSettings := [];
    FParcial.Text := 'Número: ' + IntToStr(ContaCliente.Venda.CupomFiscal);
    FParcial.FontColor := TAlphaColors.Black;
    FParcial.TextSettings.Font.Family := 'Tahoma';
    FParcial.Parent := FRetanguloConteudo;
    FParcial.Cursor := crHandPoint;
    FParcial.onClick := Retangulo.onClick;
    FParcial.Tag := Retangulo.Tag;
  end;
end;

procedure TContaView.criaRetanguloComandaStatus;
begin
  FRetanguloComandaStatus := TRectangle.Create(Retangulo);
  FRetanguloComandaStatus.Align := TAlignLayout.Left;
  case ContaCliente.Status of
    0:
      begin
        if ContaCliente.ConferenciaEmitida = 'S' then
        begin
          FRetanguloComandaStatus.Stroke.Color := TAlphaColors.Gold;
          FRetanguloComandaStatus.Fill.Color := TAlphaColors.Gold;
        end
        else
        begin
          FRetanguloComandaStatus.Stroke.Color := TAlphaColors.Green;
          FRetanguloComandaStatus.Fill.Color := TAlphaColors.Green;
        end;
      end;
    1:
      begin
        FRetanguloComandaStatus.Stroke.Color := TAlphaColors.Black;
        FRetanguloComandaStatus.Fill.Color := TAlphaColors.Black;
      end;
    2:
      begin
        FRetanguloComandaStatus.Stroke.Color := TAlphaColors.Red;
        FRetanguloComandaStatus.Fill.Color := TAlphaColors.Red;
      end;
  end;

  FRetanguloComandaStatus.Width := 6;
  FRetanguloComandaStatus.Parent := Retangulo;

  FRetanguloComandaStatus.Cursor := crHandPoint;
  FRetanguloComandaStatus.onClick := Retangulo.onClick;

  FRetanguloComandaStatus.Tag := Retangulo.Tag;
end;

procedure TContaView.criaRetanguloConteudo;
begin
  FRetanguloConteudo := TRectangle.Create(Retangulo);
  FRetanguloConteudo.Align := TAlignLayout.Client;
  FRetanguloConteudo.Stroke.Color := TAlphaColors.White;
  FRetanguloConteudo.Fill.Color := TAlphaColors.White;
  FRetanguloConteudo.Parent := Retangulo;

  FRetanguloConteudo.Cursor := crHandPoint;
  FRetanguloConteudo.onClick := Retangulo.onClick;
  FRetanguloConteudo.Tag := Retangulo.Tag;
end;

procedure TContaView.criaRetanguloValor;
begin
  FRetanguloValor := TRectangle.Create(FRetanguloConteudo);
  FRetanguloValor.Height := 30;
  FRetanguloValor.Align := TAlignLayout.Bottom;
  FRetanguloValor.Fill.Color := TAlphaColors.Whitesmoke;
  FRetanguloValor.Stroke.Color := TAlphaColors.Whitesmoke;
  FRetanguloValor.Parent := FRetanguloConteudo;

  FRetanguloValor.Cursor := crHandPoint;
  FRetanguloValor.onClick := Retangulo.onClick;
  FRetanguloValor.Tag := Retangulo.Tag;
end;

procedure TContaView.criaTempo;
begin
  FTempo := TLabel.Create(FRetanguloConteudo);
  FTempo.Position.X := 9;
  FTempo.Position.Y := 30;
  FTempo.StyledSettings := [];

  if ContaCliente.Status <> 1 then
    FTempo.Text := 'Tempo: ' + DMConexao.calculatempo
      (StrToDateTime(DateToStr(ContaCliente.DataAbertura) + ' ' +
      TimeToStr(ContaCliente.HoraAbertura)), now)
  else
    FTempo.Text := 'Tempo: ' + DMConexao.calculatempo
      (StrToDateTime(DateToStr(ContaCliente.DataAbertura) + ' ' +
      TimeToStr(ContaCliente.Venda.DataHora)), now);

  FTempo.TextSettings.Font.Family := 'Tahoma';
  FTempo.Parent := FRetanguloConteudo;
  if FContaCliente.Status <> 1 then
  begin
    FTempo.Cursor := crHandPoint;
    FTempo.onClick := Retangulo.onClick;
  end;
  FTempo.Tag := Retangulo.Tag;
end;

procedure TContaView.criaValor;
begin
  FValor := TLabel.Create(FRetanguloValor);
  FValor.Align := TAlignLayout.Client;
  FValor.StyledSettings := [];
  case ContaCliente.Status of
    0:
      begin
        if ContaCliente.ConferenciaEmitida = 'S' then
          FValor.TextSettings.FontColor := TAlphaColors.Gold
        else
          FValor.TextSettings.FontColor := TAlphaColors.Green;
      end;
    1:
      FValor.TextSettings.FontColor := TAlphaColors.Black;
    2:
      FValor.TextSettings.FontColor := TAlphaColors.Red;
  end;

  if ContaCliente.Status <> 1 then
  begin
    if ContaCliente.DispensarTaxaServico = 'N' then
    begin
      FValor.Text := 'R$: ' + formatfloat('#,##0.00',
        (ContaCliente.Total - ContaCliente.ValorPacial +
        DMConexao.CalcularTaxaServico(ContaCliente.Total -
        ContaCliente.ValorPacial, ContaCliente)));
    end
    else
    begin
      FValor.Text := 'R$: ' + formatfloat('#,##0.00',
        (ContaCliente.Total - ContaCliente.ValorPacial));
    end;
  end
  else
  begin

    if ContaCliente.Venda.ChaveAcessoCancelCfeNfce <> '' then
    begin
      FValor.Text := 'CANCELADA';
      FValor.TextSettings.FontColor := TAlphaColors.Red;
    end;

    if (ContaCliente.Venda.ChaveAcessoCancelCfeNfce = '') and
      (ContaCliente.Venda.ChaveAcessoCfeNfce <> '') and
      (ContaCliente.Venda.CupomFiscal > 0) then
    begin
      FValor.Text := 'TRANSMITIDO';
      FValor.TextSettings.FontColor := TAlphaColors.Green;
    end;

    if (ContaCliente.Venda.ChaveAcessoCancelCfeNfce = '') and
      (ContaCliente.Venda.ChaveAcessoCfeNfce = '') and
      (ContaCliente.Venda.CupomFiscal <= 0) then
    begin
      FValor.Text := 'NÃO TRANSMITIDO';
      FValor.TextSettings.FontColor := TAlphaColors.Gray;
    end;

  end;

  FValor.TextSettings.Font.Family := 'Tahoma';
  FValor.TextSettings.Font.Size := 16;
  FValor.TextSettings.HorzAlign := TTextAlign.Center;
  FValor.Parent := FRetanguloValor;

  FValor.Cursor := crHandPoint;
  FValor.onClick := Retangulo.onClick;
  FValor.Tag := Retangulo.Tag;
end;

procedure TContaView.FreeAndNil;
begin
  if Assigned(FLineRight) then
    FLineRight.Free;

  if Assigned(FLineBottom) then
    FLineBottom.Free;

  if Assigned(FLineTop) then
    FLineTop.Free;

  if Assigned(FValor) then
    FValor.Free;

  if Assigned(FParcial) then
    FParcial.Free;

  if Assigned(FRetanguloValor) then
    FRetanguloValor.Free;

  if Assigned(FModoTexto) then
    FModoTexto.Free;

  if Assigned(FModo) then
    FModo.Free;

  if Assigned(FTempo) then
    FTempo.Free;

  if Assigned(FNomeComanda) then
    FNomeComanda.Free;

  if Assigned(FRetanguloConteudo) then
    FRetanguloConteudo.Free;

  if Assigned(FRetanguloComandaStatus) then
    FRetanguloComandaStatus.Free;

  if Assigned(FRetangulo) then
    FRetangulo.Free;

end;

constructor TContaView.Create;
begin
end;

procedure TContaView.SetContaCliente(const Value: TContaCliente);
begin
  FContaCliente := Value;
end;

procedure TContaView.SetLineBottom(const Value: TLine);
begin
  FLineBottom := Value;
end;

procedure TContaView.SetLineRight(const Value: TLine);
begin
  FLineRight := Value;
end;

procedure TContaView.SetLineTop(const Value: TLine);
begin
  FLineTop := Value;
end;

procedure TContaView.SetModo(const Value: TRectangle);
begin
  FModo := Value;
end;

procedure TContaView.SetModoTexto(const Value: TLabel);
begin
  FModoTexto := Value;
end;

procedure TContaView.SetNomeComanda(const Value: TLabel);
begin
  FNomeComanda := Value;
end;

procedure TContaView.SetParcial(const Value: TLabel);
begin
  FParcial := Value;
end;

procedure TContaView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TContaView.SetRetanguloComandaStatus(const Value: TRectangle);
begin
  FRetanguloComandaStatus := Value;
end;

procedure TContaView.SetRetanguloConteudo(const Value: TRectangle);
begin
  FRetanguloConteudo := Value;
end;

procedure TContaView.SetRetanguloValor(const Value: TRectangle);
begin
  FRetanguloValor := Value;
end;

procedure TContaView.SetTempo(const Value: TLabel);
begin
  FTempo := Value;
end;

procedure TContaView.SetValor(const Value: TLabel);
begin
  FValor := Value;
end;

end.
