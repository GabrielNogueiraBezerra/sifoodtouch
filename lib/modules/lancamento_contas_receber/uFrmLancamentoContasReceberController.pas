unit uFrmLancamentoContasReceberController;

interface

uses
  uDMConexao, StrUtils, uFrmLancamentoContasReceber, uVenda, uContaReceber,
  uLancamentoCartaoView, System.Generics.Collections;

type
  TFrmLancamentoContasReceberController = class(TObject)
  private
    { private declarations }
    FView: TFrmLancamentoContasReceber;
    procedure FormShow;
    procedure btnGravarParcelasClick;
    procedure btnSairClick;
    procedure btnAddParcelasClick;
    procedure btnRemoveParcelasClick;
    function totalContasReceber: Currency;
    procedure addContasReceber;
    procedure LimpaContasReceber;

  protected
    { protected declarations }
  public
    { public declarations }
    procedure Clear;
    constructor Create(view: TFrmLancamentoContasReceber); reintroduce;
    destructor Destroy; override;
    procedure evento(evento: String);

  class var
    FVenda: TVenda;
    FListaCOntasReceber: TObjectList<TLancamentoCartaoView>;
  end;

implementation

uses
  System.SysUtils, uFrmMensagem, Vcl.Forms, FMX.Objects;

{ TFrmLancamentoContasReceberController }

procedure TFrmLancamentoContasReceberController.addContasReceber;
var
  Retangulo: TRectangle;
  I: Integer;
  Y: Single;
begin

  LimpaContasReceber;

  Y := 8;
  if Assigned(DMConexao.FListaCOntasReceber) then
  begin
    for I := 0 to DMConexao.FListaCOntasReceber.Count - 1 do
    begin
      Retangulo := TRectangle.Create(FView.VertScrollBox1);
      Retangulo.Parent := FView.VertScrollBox1;
      Retangulo.Position.X := 8;
      Retangulo.Position.Y := Y;
      Retangulo.Width := 160;
      Retangulo.Height := 100;

      Y := Y + 105;

      FListaCOntasReceber.Add(TLancamentoCartaoView.Create
        (DMConexao.FListaCOntasReceber.Items[I], Retangulo));
    end;
  end;
end;

procedure TFrmLancamentoContasReceberController.btnAddParcelasClick;
begin
  FView.btnAddParcelas.Enabled := False;

  FView.EdtQuantidadeParcelas.Text :=
    CurrToStr((StrToCurr(FView.EdtQuantidadeParcelas.Text.Trim) + 1));

  FView.btnAddParcelas.Enabled := True;
end;

procedure TFrmLancamentoContasReceberController.btnGravarParcelasClick;
var
  I: Integer;
  ContaReceber: TContaReceber;
begin

  FView.btnGravarParcelas.Enabled := False;

  DMConexao.FListaCOntasReceber := TObjectList<TContaReceber>.Create;

  for I := 0 to StrToInt(stringreplace(FView.EdtQuantidadeParcelas.Text, '.',
    '', [rfReplaceAll, rfIgnoreCase])) - 1 do
  begin
    ContaReceber := TContaReceber.Create;
    ContaReceber.Sequencia := 1;
    ContaReceber.Empresa := DMConexao.Empresa;
    ContaReceber.CodigoCliente := FVenda.Cliente.codigo;
    ContaReceber.CodigoCobranca := DMConexao.Configuracao.CodigoCobranca;
    ContaReceber.CodigoClassificacao :=
      DMConexao.Configuracao.CodigoClassificacao;
    ContaReceber.Caixa := DMConexao.Configuracao.Caixa;
    ContaReceber.Parcela := I + 1;
    ContaReceber.Data := Date;

    if DMConexao.Configuracao.AdicionaMesCompletoGeracaoParcelas then
      ContaReceber.Vencimento := DMConexao.adicionaMes(Date, I + 1)
    else if I = 0 then
      ContaReceber.Vencimento := Date + FVenda.TipoVenda.DiasPrimeiraParcela
    else
      ContaReceber.Vencimento := (Date + FVenda.TipoVenda.DiasPrimeiraParcela) +
        (FVenda.TipoVenda.DiasEntreParcelas * (I));

    if (I = 0) and (FVenda.TipoVenda.PossuiEntrada) then
    begin
      ContaReceber.DataPagamento := Date;
      ContaReceber.ValorPagamento := ContaReceber.Valor;
      ContaReceber.CodigoVenda := FVenda.codigo;
    end;

    if FVenda.TipoVenda.PossuiEntrada then
      if I = 0 then
        ContaReceber.Valor :=
          (StrToCurr(stringreplace(FView.EdtValor.Text, '.', '',
          [rfReplaceAll, rfIgnoreCase])) *
          FVenda.TipoVenda.PercentualEntrada) / 100
      else
        ContaReceber.Valor :=
          (StrToCurr(stringreplace(FView.EdtValor.Text, '.', '',
          [rfReplaceAll, rfIgnoreCase])) - DMConexao.FListaCOntasReceber.Items
          [0].Valor) / StrToInt(stringreplace(FView.EdtQuantidadeParcelas.Text,
          '.', '', [rfReplaceAll, rfIgnoreCase]))
    else
      ContaReceber.Valor :=
        (StrToCurr(stringreplace(FView.EdtValor.Text, '.', '',
        [rfReplaceAll, rfIgnoreCase])) /
        StrToInt(stringreplace(FView.EdtQuantidadeParcelas.Text, '.', '',
        [rfReplaceAll, rfIgnoreCase])));

    ContaReceber.DataHoraLancamento := now;
    ContaReceber.UsuarioGerou := DMConexao.Usuario;

    DMConexao.FListaCOntasReceber.Add(ContaReceber);
  end;

  FView.EdtValor.Text := CurrToStr(FVenda.totalFormaPagamento('PR') -
    totalContasReceber);

  addContasReceber;

  if FVenda.totalFormaPagamento('PR') - totalContasReceber < 0 then
    FView.EdtValor.Text := '0,00';

  if round(totalContasReceber) <> FVenda.totalFormaPagamento('PR') then
    FView.btnGravarParcelas.Enabled := True;

end;

procedure TFrmLancamentoContasReceberController.btnRemoveParcelasClick;
begin
  FView.btnAddParcelas.Enabled := False;

  if StrToInt(FView.EdtQuantidadeParcelas.Text) > 1 then
  begin
    FView.EdtQuantidadeParcelas.Text :=
      CurrToStr((StrToCurr(FView.EdtQuantidadeParcelas.Text.Trim) - 1));
  end;

  FView.btnAddParcelas.Enabled := True;
end;

procedure TFrmLancamentoContasReceberController.btnSairClick;
begin

  FView.btnSair.Enabled := False;

  if StrToCurr(stringreplace(FView.EdtValor.Text, '.', '',
    [rfReplaceAll, rfIgnoreCase])) > (FVenda.totalFormaPagamento('PR') -
    totalContasReceber) then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.FTipo := 0;
    FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
      ', O valor informado é maior que o total de contas a receber lançadas nas formas de pagament.';
    FrmMensagem.FTitulo := 'Aviso!';
    FrmMensagem.ShowModal;
    FView.btnGravarParcelas.Enabled := True;
    exit;
  end;

  if (DMConexao.Configuracao.LiberarTotalContasReceber) then
  begin
    if DMConexao.FListaCOntasReceber.Count = 0 then
    begin
      Application.CreateForm(TFrmMensagem, FrmMensagem);
      FrmMensagem.FTipo := 0;
      FrmMensagem.FProcedimento := DMConexao.Usuario.Nome +
        ', ainda existe valores a serem lançados! Caso queira sair sem lançar, '
        + 'deve excluir a parcela lançada anteriormente!';
      FrmMensagem.FTitulo := 'Aviso!';
      FrmMensagem.ShowModal;
      FView.btnSair.Enabled := True;
      exit;
    end;
  end;

  FView.Close;

  FView.btnSair.Enabled := True;

end;

procedure TFrmLancamentoContasReceberController.Clear;
begin

end;

constructor TFrmLancamentoContasReceberController.Create
  (view: TFrmLancamentoContasReceber);
begin
  if Assigned(view) then
    FView := view;
end;

destructor TFrmLancamentoContasReceberController.Destroy;
begin

  inherited;
end;

procedure TFrmLancamentoContasReceberController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow', 'btnGravarParcelasClick',
    'btnSairClick', 'btnAddParcelasClick', 'btnRemoveParcelasClick']) of
    0:
      FormShow;
    1:
      btnGravarParcelasClick;
    2:
      btnSairClick;
    3:
      btnAddParcelasClick;
    4:
      btnRemoveParcelasClick;
  end;

end;

procedure TFrmLancamentoContasReceberController.FormShow;
begin
  if Assigned(FVenda) then
  begin
    FView.EdtValor.Text := formatfloat('#,##0.00',
      FVenda.totalFormaPagamento('PR'));

    FView.EdtCodigoCliente.Text := IntToStr(FVenda.Cliente.codigo);
    FView.EdtNomeCliente.Text := FVenda.Cliente.NomeCliente;
    FView.EdtQuantidadeParcelas.Text := '1';
  end;
end;

procedure TFrmLancamentoContasReceberController.LimpaContasReceber;
var
  I: Integer;
begin
  if Assigned(FListaCOntasReceber) then
    for I := 0 to FListaCOntasReceber.Count - 1 do
      FListaCOntasReceber.Items[I].Retangulo.Free;

  FListaCOntasReceber := TObjectList<TLancamentoCartaoView>.Create;
end;

function TFrmLancamentoContasReceberController.totalContasReceber: Currency;
var
  I: Integer;
begin

  Result := 0;

  if Assigned(DMConexao.FListaCOntasReceber) then
    for I := 0 to DMConexao.FListaCOntasReceber.Count - 1 do
      Result := Result + DMConexao.FListaCOntasReceber.Items[I].Valor;
end;

end.
