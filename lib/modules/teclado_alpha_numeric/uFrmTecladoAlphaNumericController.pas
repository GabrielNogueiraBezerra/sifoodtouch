unit uFrmTecladoAlphaNumericController;

interface

uses
  uFrmTecladoAlphaNumeric, System.Threading, uDMConexao;

type
  TFrmTecladoAlphaNumericController = class(TObject)
  private
    { private declarations }
    FView: TFrmTecladoAlphaNumeric;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(View: TFrmTecladoAlphaNumeric);
    destructor Destroy; override;

    procedure Clear;
    procedure evento(evento: String); overload;
    procedure evento(evento: String; Sender: TObject); overload;
  private
    { private declarations }
    procedure FormShow;
    procedure FormClose;
    procedure btnDeleteMouseUp;
    procedure btnDeleteMouseDown(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure mudaTeclado;
    procedure shift(Sender: TObject);
    procedure capslock(Sender: TObject);
    procedure addTio(Sender: TObject);
    procedure addACrase(Sender: TObject);

  class var
    FShift: Boolean;
    FApagarPress: Boolean;
    Trabalho: ITask;
    FCapsLock: Boolean;
    FTio: Boolean;
    FATio: String;
    FACrase: Boolean;
    FAACrase: String;
  end;

const
  Character = ['a' .. 'z', 'A' .. 'Z'];

implementation

uses
  System.StrUtils, FMX.Edit, FMX.StdCtrls, System.SysUtils, FMX.Forms,
  FMX.Memo, FMX.Objects, Vcl.Forms, System.Classes;

{ TFrmTecladoAlphaNumericController }

procedure TFrmTecladoAlphaNumericController.addACrase(Sender: TObject);
begin
  if FACrase then
  begin
    if FView.FEditor is TEdit then
    begin

      if ((TCornerButton(Sender).Text = '`') or
        ((TCornerButton(Sender).Text = '´'))) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + FAACrase +
          TCornerButton(Sender).Text.Chars[0]
      else if ((TCornerButton(Sender).Text = 'e') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'é'
      else if ((TCornerButton(Sender).Text = 'y') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ý'
      else if ((TCornerButton(Sender).Text = 'u') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ú'
      else if ((TCornerButton(Sender).Text = 'i') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'í'
      else if ((TCornerButton(Sender).Text = 'o') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ó'
      else if ((TCornerButton(Sender).Text = 'a') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'á'
      else if ((TCornerButton(Sender).Text = 'E') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'É'
      else if ((TCornerButton(Sender).Text = 'Y') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ý'
      else if ((TCornerButton(Sender).Text = 'U') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ú'
      else if ((TCornerButton(Sender).Text = 'I') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Í'
      else if ((TCornerButton(Sender).Text = 'O') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ó'
      else if ((TCornerButton(Sender).Text = 'A') and (FAACrase = '´')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Á'
      else if ((TCornerButton(Sender).Text = 'e') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'è'
      else if ((TCornerButton(Sender).Text = 'u') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ù'
      else if ((TCornerButton(Sender).Text = 'i') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ì'
      else if ((TCornerButton(Sender).Text = 'o') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ò'
      else if ((TCornerButton(Sender).Text = 'a') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'à'
      else if ((TCornerButton(Sender).Text = 'E') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'È'
      else if ((TCornerButton(Sender).Text = 'U') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ù'
      else if ((TCornerButton(Sender).Text = 'I') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ì'
      else if ((TCornerButton(Sender).Text = 'O') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ò'
      else if ((TCornerButton(Sender).Text = 'A') and (FAACrase = '`')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'À'
      else
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + FAACrase +
          TCornerButton(Sender).Text.Chars[0];
    end
    else if FView.FEditor is TMemo then
    begin
      if ((TCornerButton(Sender).Text = '`') or
        ((TCornerButton(Sender).Text = '´'))) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + FAACrase +
          TCornerButton(Sender).Text.Chars[0]
      else if ((TCornerButton(Sender).Text = 'e') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'é'
      else if ((TCornerButton(Sender).Text = 'y') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ý'
      else if ((TCornerButton(Sender).Text = 'u') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ú'
      else if ((TCornerButton(Sender).Text = 'i') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'í'
      else if ((TCornerButton(Sender).Text = 'o') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ó'
      else if ((TCornerButton(Sender).Text = 'a') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'á'
      else if ((TCornerButton(Sender).Text = 'E') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'É'
      else if ((TCornerButton(Sender).Text = 'Y') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ý'
      else if ((TCornerButton(Sender).Text = 'U') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ú'
      else if ((TCornerButton(Sender).Text = 'I') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Í'
      else if ((TCornerButton(Sender).Text = 'O') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ó'
      else if ((TCornerButton(Sender).Text = 'A') and (FAACrase = '´')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Á'
      else if ((TCornerButton(Sender).Text = 'e') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'è'
      else if ((TCornerButton(Sender).Text = 'u') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ù'
      else if ((TCornerButton(Sender).Text = 'i') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ì'
      else if ((TCornerButton(Sender).Text = 'o') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ò'
      else if ((TCornerButton(Sender).Text = 'a') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'à'
      else if ((TCornerButton(Sender).Text = 'E') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'È'
      else if ((TCornerButton(Sender).Text = 'U') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ù'
      else if ((TCornerButton(Sender).Text = 'I') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ì'
      else if ((TCornerButton(Sender).Text = 'O') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ò'
      else if ((TCornerButton(Sender).Text = 'A') and (FAACrase = '`')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'À'
      else
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + FAACrase +
          TCornerButton(Sender).Text.Chars[0];
    end;

    FACrase := False;
  end
  else
  begin
    FACrase := true;
    FAACrase := TCornerButton(Sender).Text.Chars[0];
  end;
end;

procedure TFrmTecladoAlphaNumericController.addTio(Sender: TObject);
begin
  if FTio then
  begin
    if FView.FEditor is TEdit then
    begin
      if ((TCornerButton(Sender).Text = '~') or
        ((TCornerButton(Sender).Text = '^'))) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + FATio +
          TCornerButton(Sender).Text.Chars[0]
      else if ((TCornerButton(Sender).Text = 'a') and (FATio = '~')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ã'
      else if ((TCornerButton(Sender).Text = 'o') and (FATio = '~')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'õ'
      else if ((TCornerButton(Sender).Text = 'a') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'â'
      else if ((TCornerButton(Sender).Text = 'e') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ê'
      else if ((TCornerButton(Sender).Text = 'i') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'î'
      else if ((TCornerButton(Sender).Text = 'o') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'ô'
      else if ((TCornerButton(Sender).Text = 'u') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'û'
      else if ((TCornerButton(Sender).Text = 'A') and (FATio = '~')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ã'
      else if ((TCornerButton(Sender).Text = 'O') and (FATio = '~')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Õ'
      else if ((TCornerButton(Sender).Text = 'A') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Â'
      else if ((TCornerButton(Sender).Text = 'E') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ê'
      else if ((TCornerButton(Sender).Text = 'I') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Î'
      else if ((TCornerButton(Sender).Text = 'O') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Ô'
      else if ((TCornerButton(Sender).Text = 'U') and (FATio = '^')) then
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + 'Û'
      else
        TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + FATio +
          TCornerButton(Sender).Text.Chars[0];
    end
    else if FView.FEditor is TMemo then
    begin
      if ((TCornerButton(Sender).Text = '~') or
        ((TCornerButton(Sender).Text = '^'))) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + FATio +
          TCornerButton(Sender).Text.Chars[0]
      else if ((TCornerButton(Sender).Text = 'a') and (FATio = '~')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ã'
      else if ((TCornerButton(Sender).Text = 'o') and (FATio = '~')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'õ'
      else if ((TCornerButton(Sender).Text = 'a') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'â'
      else if ((TCornerButton(Sender).Text = 'e') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ê'
      else if ((TCornerButton(Sender).Text = 'i') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'î'
      else if ((TCornerButton(Sender).Text = 'o') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'ô'
      else if ((TCornerButton(Sender).Text = 'u') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'û'
      else if ((TCornerButton(Sender).Text = 'A') and (FATio = '~')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ã'
      else if ((TCornerButton(Sender).Text = 'O') and (FATio = '~')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Õ'
      else if ((TCornerButton(Sender).Text = 'A') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Â'
      else if ((TCornerButton(Sender).Text = 'E') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ê'
      else if ((TCornerButton(Sender).Text = 'I') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Î'
      else if ((TCornerButton(Sender).Text = 'O') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Ô'
      else if ((TCornerButton(Sender).Text = 'U') and (FATio = '^')) then
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + 'Û'
      else
        TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + FATio +
          TCornerButton(Sender).Text.Chars[0];
    end;

    FTio := False;
  end
  else
  begin
    FTio := true;
    FATio := TCornerButton(Sender).Text.Chars[0];
  end;
end;

procedure TFrmTecladoAlphaNumericController.btn0Click(Sender: TObject);
begin
  if FView.FEditor is TEdit then
  begin
    if TCornerButton(Sender).Text = 'ESPAÇO' then
      TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text + ' '
    else if TCornerButton(Sender).Text = 'TAB' then
    else if TCornerButton(Sender).Text = 'ENTER' then
      FView.Close
    else if TCornerButton(Sender).Text = 'CAPS LOCK' then
      capslock(Sender)
    else if TCornerButton(Sender).Text = 'SHIFT' then
      shift(Sender)
    else if ((TCornerButton(Sender) = FView.btnTio) or (FTio)) then
      addTio(Sender)
    else if ((TCornerButton(Sender) = FView.btnACrase) or (FACrase)) then
      addACrase(Sender)
    else
      TEdit(FView.FEditor).Text := TEdit(FView.FEditor).Text +
        TCornerButton(Sender).Text.Chars[0];

    TEdit(FView.FEditor).SelStart := length(TEdit(FView.FEditor).Text);
  end
  else if FView.FEditor is TMemo then
  begin
    if TCornerButton(Sender).Text = 'ESPAÇO' then
      TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text + ' '
    else if TCornerButton(Sender).Text = 'TAB' then
    else if TCornerButton(Sender).Text = 'ENTER' then
      FView.Close
    else if TCornerButton(Sender).Text = 'CAPS LOCK' then
      capslock(Sender)
    else if TCornerButton(Sender).Text = 'SHIFT' then
      shift(Sender)
    else if ((TCornerButton(Sender) = FView.btnTio) or (FTio)) then
      addTio(Sender)
    else if ((TCornerButton(Sender) = FView.btnACrase) or (FACrase)) then
      addACrase(Sender)
    else
      TMemo(FView.FEditor).Text := TMemo(FView.FEditor).Text +
        TCornerButton(Sender).Text.Chars[0];

    TMemo(FView.FEditor).SelStart := length(TMemo(FView.FEditor).Text);
  end;
end;

procedure TFrmTecladoAlphaNumericController.btnDeleteMouseDown(Sender: TObject);
begin
  if FView.FEditor is TEdit then
  begin
    if TCornerButton(Sender).Text = 'APAGAR' then
      FApagarPress := true;
    if FApagarPress then
    begin
      Trabalho := TTask.Create(
        procedure
        begin
          try
            while FApagarPress do
            begin
              TEdit(FView.FEditor).Text := copy(TEdit(FView.FEditor).Text, 1,
                (length(TEdit(FView.FEditor).Text) - 1));
              sleep(150);
            end;
          except
          end;
        end);

      Trabalho.Start;
    end;
  end
  else if FView.FEditor is TMemo then
  begin
    if TCornerButton(Sender).Text = 'APAGAR' then
      FApagarPress := true;
    if FApagarPress then
    begin
      Trabalho := TTask.Create(
        procedure
        begin
          try
            while FApagarPress do
            begin
              TMemo(FView.FEditor).Text := copy(TMemo(FView.FEditor).Text, 1,
                (length(TMemo(FView.FEditor).Text) - 1));
              sleep(150);
            end;
          except
          end;
        end);

      Trabalho.Start;
    end;
  end;
end;

procedure TFrmTecladoAlphaNumericController.btnDeleteMouseUp;
begin
  try
    FApagarPress := False;
    Trabalho := nil;
  except
  end;
end;

procedure TFrmTecladoAlphaNumericController.capslock(Sender: TObject);
var
  I: Integer;
begin

  FCapsLock := not FCapsLock;

  for I := 0 to FView.ComponentCount - 1 do
  begin
    if FView.Components[I] is TCornerButton then
    begin
      if length((TCornerButton(FView.Components[I]).Text)) = 1 then
      begin
        if (TCornerButton(FView.Components[I]).Text.ToCharArray[0]) in Character
        then
        begin
          if not FCapsLock then
            TCornerButton(FView.Components[I]).Text :=
              LowerCase(TButton(FView.Components[I]).Text)
          else
            TCornerButton(FView.Components[I]).Text :=
              UpperCase(TButton(FView.Components[I]).Text);
        end;
      end;
    end;
  end;
end;

procedure TFrmTecladoAlphaNumericController.Clear;
begin

end;

constructor TFrmTecladoAlphaNumericController.Create
  (View: TFrmTecladoAlphaNumeric);
begin
  if (Assigned(View)) then
    FView := View;

  FApagarPress := False;
end;

destructor TFrmTecladoAlphaNumericController.Destroy;
begin

  inherited;
end;

procedure TFrmTecladoAlphaNumericController.evento(evento: String;
Sender: TObject);
begin
  case AnsiIndexStr(evento, ['btn0Click', 'btnDeleteMouseDown']) of
    0:
      btn0Click(Sender);
    1:
      btnDeleteMouseDown(Sender);
  end;
end;

procedure TFrmTecladoAlphaNumericController.evento(evento: String);
begin
  case AnsiIndexStr(evento, ['FormShow', 'FormClose', 'btnDeleteMouseUp']) of
    0:
      FormShow;
    1:
      FormClose;
    2:
      btnDeleteMouseUp;
  end;
end;

procedure TFrmTecladoAlphaNumericController.FormClose;
begin
  TEdit(FView.FEditorProximo).SetFocus;
  DMConexao.TecladoAlphaNumeric := nil;
end;

procedure TFrmTecladoAlphaNumericController.FormShow;
begin

  FView.Left := 0;
  FView.Top := 0;
  if FView.FTela is TForm then
  begin
    if FView.FEditor is TEdit then
    begin
      FView.Left := ((TForm(FView.FTela).Left div 2) +
        round(TEdit(FView.FEditor).Position.X));

      FView.Top := TForm(FView.FTela).Top +
        round(TEdit(FView.FEditor).Position.y + (TEdit(FView.FEditor).Height
        * 2)) + 5;
    end;

    if FView.FEditor is TMemo then
    begin
      FView.Left := ((TForm(FView.FTela).Left div 2) +
        round(TMemo(FView.FEditor).Position.X));

      FView.Top := TForm(FView.FTela).Top +
        round(TMemo(FView.FEditor).Position.y + (TMemo(FView.FEditor).Height
        * 2)) + 5;
    end;

  end
  else if FView.FTela is TFrame then
  begin
    if FView.FEditor is TEdit then
    begin
      FView.Left := ((TForm(TFrame(FView.FTela).Parent).Left div 2) +
        round(TEdit(FView.FEditor).Position.X));

      FView.Top := TForm(TFrame(FView.FTela).Parent).Top +
        round(TEdit(FView.FEditor).Position.y + (TEdit(FView.FEditor).Height
        * 2)) + 5;
    end;

    if FView.FEditor is TMemo then
    begin
      FView.Left := round(TRectangle(TMemo(FView.FEditor).Parent)
        .Position.X) div 2;
      FView.Top := round(TRectangle(TMemo(FView.FEditor).Parent).Position.y) +
        round(TMemo(FView.FEditor).Height);
    end;

  end;
end;

procedure TFrmTecladoAlphaNumericController.mudaTeclado;
var
  I: Integer;
begin
  for I := 0 to FView.ComponentCount - 1 do
  begin
    if FView.Components[I] is TCornerButton then
    begin
      if length((TCornerButton(FView.Components[I]).Text)) = 1 then
      begin
        if (TCornerButton(FView.Components[I]).Text.ToCharArray[0]) in Character
        then
        begin
          if not FShift then
            TCornerButton(FView.Components[I]).Text :=
              LowerCase(TButton(FView.Components[I]).Text)
          else
            TCornerButton(FView.Components[I]).Text :=
              UpperCase(TButton(FView.Components[I]).Text);
        end
        else
        begin
          if not FShift then
          begin
            if TCornerButton(FView.Components[I]) = FView.btnAspa then
              TCornerButton(FView.Components[I]).Text := Chr(39);

            if TCornerButton(FView.Components[I]) = FView.btnACrase then
              TCornerButton(FView.Components[I]).Text := '`';

            if TCornerButton(FView.Components[I]) = FView.btnAbreConchete then
              TCornerButton(FView.Components[I]).Text := '[';

            if TCornerButton(FView.Components[I]) = FView.btnFechaConchete then
              TCornerButton(FView.Components[I]).Text := ']';

            if TCornerButton(FView.Components[I]) = FView.btnTio then
              TCornerButton(FView.Components[I]).Text := '~';

            if TCornerButton(FView.Components[I]) = FView.btnPonto then
              TCornerButton(FView.Components[I]).Text := '.';

            if TCornerButton(FView.Components[I]) = FView.btnVirgula then
              TCornerButton(FView.Components[I]).Text := ',';

            if TCornerButton(FView.Components[I]) = FView.btnPontoVirgula then
              TCornerButton(FView.Components[I]).Text := ';';

            if TCornerButton(FView.Components[I]) = FView.btnBarra then
              TCornerButton(FView.Components[I]).Text := '/';

            if TCornerButton(FView.Components[I]) = FView.btnBarraInvertida then
              TCornerButton(FView.Components[I]).Text := '\';

            if TCornerButton(FView.Components[I]) = FView.btn1 then
              TCornerButton(FView.Components[I]).Text := '1';

            if TCornerButton(FView.Components[I]) = FView.btn2 then
              TCornerButton(FView.Components[I]).Text := '2';

            if TCornerButton(FView.Components[I]) = FView.btn3 then
              TCornerButton(FView.Components[I]).Text := '3';

            if TCornerButton(FView.Components[I]) = FView.btn4 then
              TCornerButton(FView.Components[I]).Text := '4';

            if TCornerButton(FView.Components[I]) = FView.btn5 then
              TCornerButton(FView.Components[I]).Text := '5';

            if TCornerButton(FView.Components[I]) = FView.btn6 then
              TCornerButton(FView.Components[I]).Text := '6';

            if TCornerButton(FView.Components[I]) = FView.btn7 then
              TCornerButton(FView.Components[I]).Text := '7';

            if TCornerButton(FView.Components[I]) = FView.btn8 then
              TCornerButton(FView.Components[I]).Text := '8';

            if TCornerButton(FView.Components[I]) = FView.btn9 then
              TCornerButton(FView.Components[I]).Text := '9';

            if TCornerButton(FView.Components[I]) = FView.btn0 then
              TCornerButton(FView.Components[I]).Text := '0';

            if TCornerButton(FView.Components[I]) = FView.btnMenos then
              TCornerButton(FView.Components[I]).Text := '-';

            if TCornerButton(FView.Components[I]) = FView.btnIgual then
              TCornerButton(FView.Components[I]).Text := '=';
          end
          else
          begin
            if TCornerButton(FView.Components[I]) = FView.btnAspa then
              TCornerButton(FView.Components[I]).Text := '"';

            if TCornerButton(FView.Components[I]) = FView.btnACrase then
              TCornerButton(FView.Components[I]).Text := '´';

            if TCornerButton(FView.Components[I]) = FView.btnAbreConchete then
              TCornerButton(FView.Components[I]).Text := '{';

            if TCornerButton(FView.Components[I]) = FView.btnFechaConchete then
              TCornerButton(FView.Components[I]).Text := '}';

            if TCornerButton(FView.Components[I]) = FView.btnTio then
              TCornerButton(FView.Components[I]).Text := '^';

            if TCornerButton(FView.Components[I]) = FView.btnPonto then
              TCornerButton(FView.Components[I]).Text := '>';

            if TCornerButton(FView.Components[I]) = FView.btnVirgula then
              TCornerButton(FView.Components[I]).Text := '<';

            if TCornerButton(FView.Components[I]) = FView.btnPontoVirgula then
              TCornerButton(FView.Components[I]).Text := ':';

            if TCornerButton(FView.Components[I]) = FView.btnBarra then
              TCornerButton(FView.Components[I]).Text := '?';

            if TCornerButton(FView.Components[I]) = FView.btnBarraInvertida then
              TCornerButton(FView.Components[I]).Text := '|';

            if TCornerButton(FView.Components[I]) = FView.btn1 then
              TCornerButton(FView.Components[I]).Text := '!';

            if TCornerButton(FView.Components[I]) = FView.btn2 then
              TCornerButton(FView.Components[I]).Text := '@';

            if TCornerButton(FView.Components[I]) = FView.btn3 then
              TCornerButton(FView.Components[I]).Text := '#';

            if TCornerButton(FView.Components[I]) = FView.btn4 then
              TCornerButton(FView.Components[I]).Text := '$';

            if TCornerButton(FView.Components[I]) = FView.btn5 then
              TCornerButton(FView.Components[I]).Text := '%';

            if TCornerButton(FView.Components[I]) = FView.btn6 then
              TCornerButton(FView.Components[I]).Text := '¨';

            if TCornerButton(FView.Components[I]) = FView.btn7 then
              TCornerButton(FView.Components[I]).Text := '&&';

            if TCornerButton(FView.Components[I]) = FView.btn8 then
              TCornerButton(FView.Components[I]).Text := '*';

            if TCornerButton(FView.Components[I]) = FView.btn9 then
              TCornerButton(FView.Components[I]).Text := '(';

            if TCornerButton(FView.Components[I]) = FView.btn0 then
              TCornerButton(FView.Components[I]).Text := ')';

            if TCornerButton(FView.Components[I]) = FView.btnMenos then
              TCornerButton(FView.Components[I]).Text := '_';

            if TCornerButton(FView.Components[I]) = FView.btnIgual then
              TCornerButton(FView.Components[I]).Text := '+';

          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmTecladoAlphaNumericController.shift(Sender: TObject);
begin
  TCornerButton(Sender).StaysPressed := true;
  FShift := not FShift;
  mudaTeclado;
end;

end.
