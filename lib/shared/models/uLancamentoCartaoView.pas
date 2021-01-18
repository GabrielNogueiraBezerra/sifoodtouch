unit uLancamentoCartaoView;

interface

uses
  FMX.StdCtrls, FMX.Objects, uContaReceberCartao, uAdministradoraCartao,
  uContaReceber;

type
{$TYPEINFO ON}
  TLancamentoCartaoView = class(TObject)
  private
    FRetangulo: TRectangle;
    FValor: TLabel;
    FDescricaoLancamento: TLabel;
    FRetanguloValor: TRectangle;
    FContaReceberCartao: TContaReceberCartao;
    FAdministradoraCartao: TAdministradoraCartao;
    FContaReceber: TContaReceber;
    procedure SetContaReceberCartao(const Value: TContaReceberCartao);
    procedure SetDescricaoLancamento(const Value: TLabel);
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetRetanguloValor(const Value: TRectangle);
    procedure SetValor(const Value: TLabel);
    procedure CriaDescricaoLancamento;
    procedure CriaRetanguloValor;
    procedure CriaValor;
    procedure SetAdministradoraCartao(const Value: TAdministradoraCartao);
    procedure SetContaReceber(const Value: TContaReceber);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(ContaReceberCartao: TContaReceberCartao;
      Retangulo: TRectangle;
      AdministradoraCartao: TAdministradoraCartao); overload;
    constructor Create(ContaReceber: TContaReceber;
      Retangulo: TRectangle); overload;
    procedure FreeAndNil;
  published
    { published declarations }
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
    property DescricaoLancamento: TLabel read FDescricaoLancamento
      write SetDescricaoLancamento;
    property RetanguloValor: TRectangle read FRetanguloValor
      write SetRetanguloValor;
    property Valor: TLabel read FValor write SetValor;
    property ContaReceberCartao: TContaReceberCartao read FContaReceberCartao
      write SetContaReceberCartao;
    property AdministradoraCartao: TAdministradoraCartao
      read FAdministradoraCartao write SetAdministradoraCartao;
    property ContaReceber: TContaReceber read FContaReceber
      write SetContaReceber;

  end;

implementation

uses
  Vcl.Controls, FMX.Types, System.UITypes, System.SysUtils, Vcl.Graphics;

{ TLancamentoCartaoView }

constructor TLancamentoCartaoView.Create(ContaReceberCartao
  : TContaReceberCartao; Retangulo: TRectangle;
  AdministradoraCartao: TAdministradoraCartao);
begin
  if (Assigned(ContaReceberCartao)) and (Assigned(Retangulo)) and
    (Assigned(AdministradoraCartao)) then
  begin
    FContaReceberCartao := ContaReceberCartao;
    FRetangulo := Retangulo;
    FAdministradoraCartao := AdministradoraCartao;

    CriaRetanguloValor;
    CriaValor;
    CriaDescricaoLancamento;
  end;
end;

constructor TLancamentoCartaoView.Create(ContaReceber: TContaReceber;
  Retangulo: TRectangle);
begin
  if (Assigned(ContaReceber)) and (Assigned(Retangulo)) then
  begin
    FRetangulo := Retangulo;
    FContaReceber := ContaReceber;

    CriaRetanguloValor;
    CriaValor;
    CriaDescricaoLancamento;
  end;

end;

procedure TLancamentoCartaoView.CriaDescricaoLancamento;
begin
  FDescricaoLancamento := TLabel.Create(FRetangulo);
  FDescricaoLancamento.Parent := FRetangulo;
  FDescricaoLancamento.Align := TAlignLayout.Client;
  FDescricaoLancamento.StyledSettings := [];
  if FContaReceberCartao <> nil then
    FDescricaoLancamento.Text := AdministradoraCartao.Descricao + ' / ' +
      ContaReceberCartao.BandeiraCartao.Descricao
  else
    FDescricaoLancamento.Text := IntToStr(FContaReceber.Parcela);
  FDescricaoLancamento.TextSettings.HorzAlign := TTextAlign.Center;
  FDescricaoLancamento.TextSettings.WordWrap := True;
  FDescricaoLancamento.Tag := FRetangulo.Tag;
  FDescricaoLancamento.OnClick := FRetangulo.OnClick;
end;

procedure TLancamentoCartaoView.CriaRetanguloValor;
begin
  FRetanguloValor := TRectangle.Create(FRetangulo);
  FRetanguloValor.Parent := FRetangulo;
  FRetanguloValor.Align := TAlignLayout.Bottom;
  FRetanguloValor.Fill.Color := $FFE0E0E0;
  FRetanguloValor.Height := 24;
  FRetanguloValor.Tag := FRetangulo.Tag;
  FRetanguloValor.OnClick := FRetangulo.OnClick;
end;

procedure TLancamentoCartaoView.CriaValor;
begin
  FValor := TLabel.Create(FRetanguloValor);
  FValor.Parent := FRetanguloValor;
  FValor.Align := TAlignLayout.Client;
  FValor.StyledSettings := [];
  if FContaReceberCartao <> nil then
    FValor.Text := formatfloat('#,##0.00', ContaReceberCartao.Valor)
  else
    FValor.Text := formatfloat('#,##0.00', ContaReceber.Valor);
  FValor.Font.Style := [fsBold];
  FValor.TextSettings.HorzAlign := TTextAlign.Center;
  FValor.Tag := FRetangulo.Tag;
  FValor.OnClick := FRetangulo.OnClick;
end;

procedure TLancamentoCartaoView.FreeAndNil;
begin

end;

procedure TLancamentoCartaoView.SetAdministradoraCartao
  (const Value: TAdministradoraCartao);
begin
  FAdministradoraCartao := Value;
end;

procedure TLancamentoCartaoView.SetContaReceber(const Value: TContaReceber);
begin
  FContaReceber := Value;
end;

procedure TLancamentoCartaoView.SetContaReceberCartao
  (const Value: TContaReceberCartao);
begin
  FContaReceberCartao := Value;
end;

procedure TLancamentoCartaoView.SetDescricaoLancamento(const Value: TLabel);
begin
  FDescricaoLancamento := Value;
end;

procedure TLancamentoCartaoView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TLancamentoCartaoView.SetRetanguloValor(const Value: TRectangle);
begin
  FRetanguloValor := Value;
end;

procedure TLancamentoCartaoView.SetValor(const Value: TLabel);
begin
  FValor := Value;
end;

end.
