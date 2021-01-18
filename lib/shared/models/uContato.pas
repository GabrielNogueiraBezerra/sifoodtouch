unit uContato;

interface

type
{$TYPEINFO ON}
  TContato = class(TObject)
  private
    { private declarations }
    FTelefone: String;
    FFax: String;
    FEmail: String;
    procedure SetEmail(const Value: String);
    procedure SetFax(const Value: String);
    procedure SetTelefone(const Value: String);

  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;
  published
    { published declarations }
    property Telefone: String read FTelefone write SetTelefone;
    property Fax: String read FFax write SetFax;
    property Email: String read FEmail write SetEmail;

  end;

implementation

{ TContato }

procedure TContato.Clear;
begin
  FTelefone := '';
  FFax := '';
  FEmail := '';
end;

constructor TContato.Create;
begin
end;

destructor TContato.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TContato.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TContato.SetFax(const Value: String);
begin
  FFax := Value;
end;

procedure TContato.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

end.
