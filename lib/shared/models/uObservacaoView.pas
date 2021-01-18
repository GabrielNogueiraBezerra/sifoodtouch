unit uObservacaoView;

interface

uses
  FMX.Objects, uObservacao, FMX.StdCtrls, FMX.Effects;

type
{$TYPEINFO ON}
  TObservacaoView = class(TObject)
  private
    { private declarations }
    FLocal: TRectangle;
    FNome: TLabel;
    FObservacao: TObservacao;
    FSelecionado: Boolean;
    FSelected: TShadowEffect;
    procedure SetLocal(const Value: TRectangle);
    procedure SetNome(const Value: TLabel);
    procedure setObservacao(const Value: TObservacao);
    procedure SetSelecionado(const Value: Boolean);
    procedure SetSelected(const Value: TShadowEffect);
    procedure criaNome;
    procedure criaSelected;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce; overload;
    constructor Create(Retangulo: TRectangle; Observacao: TObservacao);
      reintroduce; overload;
    procedure seleciona;
    procedure removeSelecao;
  published
    { published declarations }
    property Local: TRectangle read FLocal write SetLocal;
    property Nome: TLabel read FNome write SetNome;
    property Observacao: TObservacao read FObservacao write setObservacao;
    property Selecionado: Boolean read FSelecionado write SetSelecionado;
    property Selected: TShadowEffect read FSelected write SetSelected;
  end;

implementation

uses
  FMX.Types, System.UITypes;

{ TObservacaoView }

constructor TObservacaoView.Create(Retangulo: TRectangle;
  Observacao: TObservacao);
begin
  if (Assigned(Retangulo) and Assigned(Observacao)) then
  begin
    FLocal := Retangulo;
    FObservacao := Observacao;
    FSelecionado := false;
    criaNome;
    criaSelected;
    removeSelecao;
  end;
end;

procedure TObservacaoView.criaNome;
begin
  FNome := TLabel.Create(FLocal);
  FNome.StyledSettings := [];
  FNome.Align := TAlignLayout.Client;
  FNome.TextSettings.HorzAlign := TTextAlign.Center;
  FNome.Text := FObservacao.Descricao;
  FNome.Parent := FLocal;
  FNome.WordWrap := True;
  FNome.Cursor := crHandPoint;
  FNome.Tag := FLocal.Tag;
  FNome.OnDblClick := FLocal.OnDblClick;
end;

procedure TObservacaoView.criaSelected;
begin
  FSelected := TShadowEffect.Create(FLocal);
  FSelected.Opacity := 0.6;
  FSelected.Softness := 0.3;
  FSelected.ShadowColor := TAlphaColors.black;
  FSelected.Tag := FLocal.Tag;
  FSelected.Parent := FLocal;
  FSelected.ShadowColor := $FF00754D;
end;

procedure TObservacaoView.removeSelecao;
begin
  if Assigned(FSelected) then
  begin
    FSelected.Opacity := 0.0;
    FSelected.Softness := 0.0;
    FSelecionado := false;
  end;
end;

procedure TObservacaoView.seleciona;
begin
  if Assigned(FSelected) then
  begin
    FSelected.Opacity := 0.6;
    FSelected.Softness := 0.3;
    FSelecionado := True;
  end;
end;

procedure TObservacaoView.SetLocal(const Value: TRectangle);
begin
  FLocal := Value;
end;

procedure TObservacaoView.SetNome(const Value: TLabel);
begin
  FNome := Value;
end;

procedure TObservacaoView.setObservacao(const Value: TObservacao);
begin
  FObservacao := Value;
end;

procedure TObservacaoView.SetSelecionado(const Value: Boolean);
begin
  FSelecionado := Value;
end;

procedure TObservacaoView.SetSelected(const Value: TShadowEffect);
begin
  FSelected := Value;
end;

constructor TObservacaoView.Create;
begin

end;

end.
