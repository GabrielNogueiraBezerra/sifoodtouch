unit uEndereco;

interface

uses
  uCidade, System.SysUtils;

type
{$TYPEINFO ON}
  TEndereco = class(TObject)
  private
    { private declarations }
    FEndereco: String;
    FNumero: String;
    FBairro: String;
    FCidade: TCidade;
    FCep: String;
    FPontoReferencia: String;

    procedure SetBairro(const Value: String);
    procedure SetCidade(const Value: TCidade);
    procedure SetEndereco(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetPontoReferencia(const Value: String);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;
  published
    { published declarations }
    property Endereco: String read FEndereco write SetEndereco;
    property Numero: String read FNumero write SetNumero;
    property Bairro: String read FBairro write SetBairro;
    property Cidade: TCidade read FCidade write SetCidade;
    property Cep: String read FCep write SetCep;
    property PontoReferencia: String read FPontoReferencia
      write SetPontoReferencia;
  end;

implementation

{ TEndereco }
procedure TEndereco.Clear;
begin
  FEndereco := '';
  FNumero := '';
  FBairro := '';
  FCep := '';
  FreeAndNil(FCidade);
  FPontoReferencia := '';
end;

constructor TEndereco.Create;
begin
  FCidade := TCidade.Create;
end;

destructor TEndereco.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TEndereco.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TEndereco.SetCidade(const Value: TCidade);
begin
  FCidade := Value;
end;

procedure TEndereco.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TEndereco.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TEndereco.SetPontoReferencia(const Value: String);
begin
  FPontoReferencia := Value;
end;

end.

