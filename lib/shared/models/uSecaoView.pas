unit uSecaoView;

interface

uses
  FMX.Objects, uSecao, FMX.StdCtrls, FMX.Effects;

type
{$TYPEINFO ON}
  TSecaoView = class(TObject)
  private
    { private declarations }
    FRetangulo: TRectangle;
    FLinha: TLine;
    FSecao: TSecao;
    FNome: TLabel;
    FLinhaDir: TLine;
    FEffect: TInnerGlowEffect;
    procedure SetLinha(const Value: TLine);
    procedure SetRetangulo(const Value: TRectangle);
    procedure SetSecao(const Value: TSecao);
    procedure SetNome(const Value: TLabel);
    procedure criaLinha;
    procedure criaNome;
    procedure criaLinhaDir;
    procedure criaEffect;
    procedure SetLinhaDir(const Value: TLine);
    procedure SetEffect(const Value: TInnerGlowEffect);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce; overload;
    constructor Create(Retangulo: TRectangle; Secao: TSecao);
      reintroduce; overload;

    procedure seleciona(Value: Boolean);
  published
    { published declarations }
    property Retangulo: TRectangle read FRetangulo write SetRetangulo;
    property Linha: TLine read FLinha write SetLinha;
    property Secao: TSecao read FSecao write SetSecao;
    property Nome: TLabel read FNome write SetNome;
    property LinhaDir: TLine read FLinhaDir write SetLinhaDir;
    property Effect: TInnerGlowEffect read FEffect write SetEffect;
  end;

implementation

uses
  FMX.Types, Vcl.Controls, System.UITypes;

{ TSecaoView }

constructor TSecaoView.Create(Retangulo: TRectangle; Secao: TSecao);
begin
  if Assigned(Retangulo) and Assigned(Secao) then
  begin
    FRetangulo := Retangulo;
    FSecao := Secao;
    criaNome;
    criaLinha;
    criaLinhaDir;
    criaEffect;
  end;
end;

constructor TSecaoView.Create;
begin

end;

procedure TSecaoView.criaEffect;
begin
  FEffect := TInnerGlowEffect.Create(FRetangulo);
  FEffect.Parent := FRetangulo;
  FEffect.GlowColor := TAlphaColors.Black;
  FEffect.Opacity := 0;
  FEffect.Softness := 0;
end;

procedure TSecaoView.criaLinha;
begin
  FLinha := TLine.Create(FRetangulo);
  FLinha.Align := TAlignLayout.Bottom;
  FLinha.Parent := FRetangulo;
  FLinha.Size.Height := 1;
  FLinha.Stroke.Color := TAlphaColors.Lightgray;
end;

procedure TSecaoView.criaLinhaDir;
begin
  FLinhaDir := TLine.Create(FRetangulo);
  FLinhaDir.Align := TAlignLayout.Right;
  FLinhaDir.Parent := FRetangulo;
  FLinhaDir.Size.Width := 1;
  FLinhaDir.Stroke.Color := TAlphaColors.Lightgray;
end;

procedure TSecaoView.criaNome;
begin
  FNome := TLabel.Create(FRetangulo);
  FNome.Parent := FRetangulo;
  FNome.Align := TAlignLayout.Client;
  FNome.StyledSettings := [];
  FNome.WordWrap := true;
  FNome.Text := Secao.Descricao;
  FNome.TextSettings.HorzAlign := TTextAlign.Center;
  FNome.Cursor := crHandPoint;
  FNome.TextSettings.FontColor := TAlphaColors.Black;
  FNome.Tag := Secao.Codigo;
  FNome.OnClick := FRetangulo.OnClick;
end;

procedure TSecaoView.seleciona(Value: Boolean);
begin
  if FEffect <> nil then
  begin
    if Value then
    begin
      FEffect.Opacity := 1;
      FEffect.Softness := 0.5;
      FLinha.Stroke.Color := TAlphaColors.White;
      FLinhaDir.Stroke.Color := TAlphaColors.White;
    end
    else
    begin
      FEffect.Opacity := 0;
      FEffect.Softness := 0;
      FLinha.Stroke.Color := TAlphaColors.Lightgray;
      FLinhaDir.Stroke.Color := TAlphaColors.Lightgray;
    end;
  end;
end;

procedure TSecaoView.SetEffect(const Value: TInnerGlowEffect);
begin
  FEffect := Value;
end;

procedure TSecaoView.SetLinha(const Value: TLine);
begin
  FLinha := Value;
end;

procedure TSecaoView.SetLinhaDir(const Value: TLine);
begin
  FLinhaDir := Value;
end;

procedure TSecaoView.SetNome(const Value: TLabel);
begin
  FNome := Value;
end;

procedure TSecaoView.SetRetangulo(const Value: TRectangle);
begin
  FRetangulo := Value;
end;

procedure TSecaoView.SetSecao(const Value: TSecao);
begin
  FSecao := Value;
end;

end.
