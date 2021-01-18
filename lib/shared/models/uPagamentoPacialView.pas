unit uPagamentoPacialView;

interface

uses
  uPagamentoParcial, FMX.Objects, FMX.StdCtrls;

type
{$TYPEINFO ON}
  TPagamentoParcialView = class(TObject)
  private
    FRetangulo: TRectangle;
    FPagamentoParcial: TPagamentoParcial;
    FNomeFormaPagamento: TLabel;
    FObservacao: TLabel;
    FDataHora: TLabel;
    FValor: TLabel;
    FLocalValor: TRectangle;
    procedure SetPagamentoParcial(const Value: TPagamentoParcial);
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetDataHora(const Value: TLabel);
    procedure SetLocalValor(const Value: TRectangle);
    procedure SetNomeFormaPagamento(const Value: TLabel);
    procedure SetObservacao(const Value: TLabel);
    procedure SetValor(const Value: TLabel);
    procedure criaNomeFormaPagamento;
    procedure criaObservacao;
    procedure criaDataHora;
    procedure criaLocalValor;
    procedure criaValor;
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(PagamentoParcial: TPagamentoParcial;
      Retangulo: TRectangle); reintroduce; overload;
    procedure FreeAndNil;
  published
    { published declarations }
    property PagamentoParcial: TPagamentoParcial read FPagamentoParcial
      write SetPagamentoParcial;
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
    property Observacao: TLabel read FObservacao write SetObservacao;
    property DataHora: TLabel read FDataHora write SetDataHora;
    property NomeFormaPagamento: TLabel read FNomeFormaPagamento
      write SetNomeFormaPagamento;
    property LocalValor: TRectangle read FLocalValor write SetLocalValor;
    property Valor: TLabel read FValor write SetValor;
  end;

implementation

uses
  FMX.Types, System.UITypes, System.SysUtils;

{ TPagamentoParcialView }

constructor TPagamentoParcialView.Create(PagamentoParcial: TPagamentoParcial;
  Retangulo: TRectangle);
begin
  if (Assigned(PagamentoParcial) and Assigned(Retangulo)) then
  begin
    FRetangulo := Retangulo;
    FPagamentoParcial := PagamentoParcial;

    criaLocalValor;
    criaValor;
    if PagamentoParcial.Historico <> '' then
      criaObservacao;

    criaDataHora;
    criaNomeFormaPagamento;
  end;
end;

procedure TPagamentoParcialView.criaDataHora;
begin
  FDataHora := TLabel.Create(FRetangulo);
  FDataHora.Parent := FRetangulo;
  FDataHora.Position.Y := 100;
  FDataHora.Align := TAlignLayout.Top;
  FDataHora.Text := 'DATA/HORA: ' + DateTimeToStr(PagamentoParcial.DataHora);
  FDataHora.TextSettings.VertAlign := TTextAlign.Leading;
  FDataHora.StyledSettings := [];
  FDataHora.TextSettings.WordWrap := True;
  FDataHora.Height := 45;
  FDataHora.TextSettings.Font.Size := 12;
  FDataHora.Margins.Left := 3;
  FDataHora.Margins.Right := 3;
  FDataHora.Tag := FRetangulo.Tag;
  FDataHora.OnClick := FRetangulo.OnClick;
end;

procedure TPagamentoParcialView.criaLocalValor;
begin
  FLocalValor := TRectangle.Create(FRetangulo);
  FLocalValor.Parent := FRetangulo;
  FLocalValor.Align := TAlignLayout.Bottom;
  FLocalValor.Height := 28;
  FLocalValor.Fill.Color := TAlphaColors.Gray;
  FLocalValor.Tag := FRetangulo.Tag;
  FLocalValor.OnClick := FRetangulo.OnClick;
end;

procedure TPagamentoParcialView.criaNomeFormaPagamento;
begin
  FNomeFormaPagamento := TLabel.Create(FRetangulo);
  FNomeFormaPagamento.Parent := FRetangulo;
  FNomeFormaPagamento.Position.Y := 100;
  FNomeFormaPagamento.Align := TAlignLayout.Client;
  FNomeFormaPagamento.TextSettings.HorzAlign := TTextAlign.Center;
  FNomeFormaPagamento.Text := PagamentoParcial.FormaPagamento.Descricao;
  FNomeFormaPagamento.TextSettings.VertAlign := TTextAlign.Leading;
  FNomeFormaPagamento.TextSettings.Font.Size := 12;
  FNomeFormaPagamento.StyledSettings := [];
  FNomeFormaPagamento.Tag := FRetangulo.Tag;
  FNomeFormaPagamento.Margins.Left := 3;
  FNomeFormaPagamento.Margins.Right := 3;
  FNomeFormaPagamento.OnClick := FRetangulo.OnClick;
end;

procedure TPagamentoParcialView.criaObservacao;
begin
  FObservacao := TLabel.Create(FRetangulo);
  FObservacao.Parent := FRetangulo;
  FObservacao.Position.Y := 100;
  FObservacao.Align := TAlignLayout.Top;
  FObservacao.Text := PagamentoParcial.Historico;
  FObservacao.TextSettings.VertAlign := TTextAlign.Leading;
  FObservacao.StyledSettings := [];
  FObservacao.Margins.Left := 3;
  FObservacao.Margins.Right := 3;
  FObservacao.TextSettings.Font.Size := 12;
  FObservacao.Tag := FRetangulo.Tag;
  FObservacao.OnClick := FRetangulo.OnClick;
end;

procedure TPagamentoParcialView.criaValor;
begin
  FValor := TLabel.Create(FLocalValor);
  FValor.Parent := FLocalValor;
  FValor.Align := TAlignLayout.Client;
  FValor.Text := formatfloat('#,##0.00', FPagamentoParcial.Valor);
  FValor.TextSettings.HorzAlign := TTextAlign.Center;
  FValor.StyledSettings := [];
  FValor.Tag := FRetangulo.Tag;
  FValor.TextSettings.FontColor := TAlphaColors.White;
  FValor.OnClick := FRetangulo.OnClick;
end;

procedure TPagamentoParcialView.FreeAndNil;
begin

end;

procedure TPagamentoParcialView.SetDataHora(const Value: TLabel);
begin
  FDataHora := Value;
end;

procedure TPagamentoParcialView.SetLocalValor(const Value: TRectangle);
begin
  FLocalValor := Value;
end;

procedure TPagamentoParcialView.SetNomeFormaPagamento(const Value: TLabel);
begin
  FNomeFormaPagamento := Value;
end;

procedure TPagamentoParcialView.SetObservacao(const Value: TLabel);
begin
  FObservacao := Value;
end;

procedure TPagamentoParcialView.SetPagamentoParcial
  (const Value: TPagamentoParcial);
begin
  FPagamentoParcial := Value;
end;

procedure TPagamentoParcialView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TPagamentoParcialView.SetValor(const Value: TLabel);
begin
  FValor := Value;
end;

end.
