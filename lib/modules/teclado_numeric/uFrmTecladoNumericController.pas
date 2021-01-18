unit uFrmTecladoNumericController;

interface

uses
  uFrmTecladoNumeric, uDmConexao;

type
  TFrmTecladoNumericController = class(TObject)
  private
    { private declarations }
    FView: TFrmTecladoNumeric;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(View: TFrmTecladoNumeric);
    destructor Destroy; override;

    procedure Clear;
    procedure evento(evento: String); overload;
    procedure evento(evento: String; Sender: TObject); overload;
  private
    { private declarations }
    procedure FormShow;
    procedure FormClose;
    procedure btnVirgulaClick;
    procedure btnApagarClick;
    procedure btnConfirmarClick;
    procedure verificaCampo;
    procedure btn1Click(Sender: TObject);

    class var FNumerosPosVirgula: Integer;
  end;

implementation

uses
  System.StrUtils, FMX.Edit, FMX.StdCtrls, System.SysUtils;

{ TFrmTecladoNumericController }

procedure TFrmTecladoNumericController.btn1Click(Sender: TObject);
var
  sNumero: String;
begin

  if FView.FEditor is TEdit then
  begin
    if Pos(',', TEdit(FView.FEditor).Text) <> 0 then
    begin
      if FNumerosPosVirgula < FView.FNumeroVirgula then
      begin
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text +
          TCornerButton(Sender).Text;
        inc(FNumerosPosVirgula);
      end;
    end
    else
    begin
      if TEdit(FView.FEditor).Text <> '' then
        TEdit(FView.FEditor).Text :=
          CurrToStr(StrToCurr(TEdit(FView.FEditor).Text));

      TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text +
        TCornerButton(Sender).Text;
    end;

    TEdit(FView.FEditor).SelStart := length(TEdit(FView.FEditor).Text);
  end
  else if FView.FEditor is TLabel then
  begin
    if Pos(',', TLabel(FView.FEditor).Text) <> 0 then
    begin
      if FNumerosPosVirgula < FView.FNumeroVirgula then
      begin
        TLabel(FView.FEditor).Text := TLabel(FView.FEditor).Text +
          TCornerButton(Sender).Text;
        inc(FNumerosPosVirgula);
      end;
    end
    else
    begin

      if TLabel(FView.FEditor).Text <> '' then
        TLabel(FView.FEditor).Text :=
          CurrToStr(StrToCurr(TLabel(FView.FEditor).Text));

      TLabel(FView.FEditor).Text := TLabel(FView.FEditor).Text +
        TCornerButton(Sender).Text;
    end;
  end;
end;

procedure TFrmTecladoNumericController.btnApagarClick;
begin
  if FView.FEditor is TEdit then
  begin
    TEdit(FView.FEditor).Text := copy(TEdit(FView.FEditor).Text, 1,
      TEdit(FView.FEditor).Text.length - 1);

    if Pos(',', TEdit(FView.FEditor).Text) <> 0 then
      FNumerosPosVirgula := FNumerosPosVirgula - 1;

    TEdit(FView.FEditor).SelStart := length(TEdit(FView.FEditor).Text);
  end
  else if FView.FEditor is TLabel then
  begin
    if Pos(',', TLabel(FView.FEditor).Text) <> 0 then
      FNumerosPosVirgula := FNumerosPosVirgula - 1;
    TLabel(FView.FEditor).Text := copy(TLabel(FView.FEditor).Text, 1,
      TLabel(FView.FEditor).Text.length - 1);
  end;
end;

procedure TFrmTecladoNumericController.btnConfirmarClick;
var
  I: Integer;
  zeros: String;
begin
  zeros := '';

  for I := 0 to FView.FNumeroVirgula - 1 do
    zeros := zeros + '0';

  if FView.FUsaVirgula then
  begin
    if FView.FEditor is TEdit then
      TEdit(FView.FEditor).Text := formatfloat('#,##0.' + zeros,
        StrToCurr(TEdit(FView.FEditor).Text))
    else if FView.FEditor is TLabel then
      TEdit(FView.FEditor).Text := formatfloat('#,##0.' + zeros,
        StrToCurr(TLabel(FView.FEditor).Text));
  end;

  FView.Close;
end;

procedure TFrmTecladoNumericController.btnVirgulaClick;
begin
  if FView.FUsaVirgula then
  begin
    if FView.FEditor is TEdit then
    begin
      if Pos(',', TEdit(FView.FEditor).Text) = 0 then
      begin
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + ',';

        TEdit(FView.FEditor).SelStart := length(TEdit(FView.FEditor).Text);
      end;
    end
    else if FView.FEditor is TLabel then
      if Pos(',', TLabel(FView.FEditor).Text) = 0 then
        TLabel(FView.FEditor).Text := TLabel(FView.FEditor).Text + ',';
  end;
end;

procedure TFrmTecladoNumericController.Clear;
begin

end;

constructor TFrmTecladoNumericController.Create(View: TFrmTecladoNumeric);
begin
  if Assigned(View) then
    FView := View;
end;

destructor TFrmTecladoNumericController.Destroy;
begin

  inherited;
end;

procedure TFrmTecladoNumericController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow', 'FormClose', 'btnVirgulaClick',
    'btnApagarClick', 'btnConfirmarClick']) of
    0:
      FormShow;
    1:
      FormClose;
    2:
      btnVirgulaClick;
    3:
      btnApagarClick;
    4:
      btnConfirmarClick;
  end;
end;

procedure TFrmTecladoNumericController.evento(evento: String; Sender: TObject);
begin
  case AnsiIndexStr(evento, ['btn1Click']) of
    0:
      btn1Click(Sender);
  end;
end;

procedure TFrmTecladoNumericController.FormClose;
begin
  FView.Close;
  DMConexao.TecladoNumeric := nil;
end;

procedure TFrmTecladoNumericController.FormShow;
begin

  FView.Left := 0;
  FView.Top := 0;

  if not FView.FUsaVirgula then
    FView.btnVirgula.Enabled := false;

  verificaCampo;
end;

procedure TFrmTecladoNumericController.verificaCampo;
var
  posVirgula: String;
begin

  if FView.FEditor is TEdit then
  begin
    posVirgula := copy(TEdit(FView.FEditor).Text,
      Pos(',', TEdit(FView.FEditor).Text) + 1, TEdit(FView.FEditor)
      .Text.length);
  end
  else if FView.FEditor is TLabel then
  begin
    posVirgula := copy(TLabel(FView.FEditor).Text,
      Pos(',', TLabel(FView.FEditor).Text) + 1, TLabel(FView.FEditor)
      .Text.length);
  end;

  FNumerosPosVirgula := posVirgula.length;

end;

end.
