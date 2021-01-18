unit uCliente;

interface

uses
  System.Generics.Collections, uContaReceber;

type
{$TYPEINFO ON}
  TCliente = class(TObject)
  private
    FCnpj: String;
    FNomeCliente: String;
    FAtivo: Boolean;
    FCodigo: Integer;
    FCep: String;
    FSexo: String;
    FCidade: String;
    FTipo: String;
    FEndereco: String;
    FTelefone: String;
    FNomeFantasia: String;
    FBloqueado: Boolean;
    FBairro: String;
    FNumero: String;
    FUF: String;
    FControlaLimite: Boolean;
    FContasReceber: TObjectList<TContaReceber>;
    FLimiteCliente: Currency;
    procedure SetAtivo(const Value: Boolean);
    procedure SetCep(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetCnpj(const Value: String);
    procedure SetCodigo(const Value: Integer);
    procedure SetEndereco(const Value: String);
    procedure SetNomeCliente(const Value: String);
    procedure SetNomeFantasia(const Value: String);
    procedure SetSexo(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetTipo(const Value: String);
    procedure SetBloqueado(const Value: Boolean);
    procedure SetBairro(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetUF(const Value: String);
    procedure SetControlaLimite(const Value: Boolean);
    procedure SetContasReceber(const Value: TObjectList<TContaReceber>);
    procedure SetLimiteCliente(const Value: Currency);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;

    function saldoDevedor: Currency;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property Tipo: String read FTipo write SetTipo;
    property NomeCliente: String read FNomeCliente write SetNomeCliente;
    property NomeFantasia: String read FNomeFantasia write SetNomeFantasia;
    property Ativo: Boolean read FAtivo write SetAtivo;
    property Endereco: String read FEndereco write SetEndereco;
    property Cidade: String read FCidade write SetCidade;
    property Cep: String read FCep write SetCep;
    property Bairro: String read FBairro write SetBairro;
    property Telefone: String read FTelefone write SetTelefone;
    property Cnpj: String read FCnpj write SetCnpj;
    property Sexo: String read FSexo write SetSexo;
    property Bloqueado: Boolean read FBloqueado write SetBloqueado;
    property Numero: String read FNumero write SetNumero;
    property UF: String read FUF write SetUF;
    property ControlaLimite: Boolean read FControlaLimite
      write SetControlaLimite;
    property ContasReceber: TObjectList<TContaReceber> read FContasReceber
      write SetContasReceber;
    property LimiteCliente: Currency read FLimiteCliente write SetLimiteCliente;
  end;

implementation

uses
  System.SysUtils, uDMConexao;

{ TCliente }

procedure TCliente.Clear;
begin
  FCnpj := '';
  FNomeCliente := '';
  FAtivo := False;
  FCodigo := 0;
  FCep := '';
  FSexo := '';
  FCidade := '';
  FTipo := '';
  FEndereco := '';
  FTelefone := '';
  FNomeFantasia := '';
  FBloqueado := False;
  FNumero := '';
  FUF := '';
  FControlaLimite := False;
  FreeAndNil(FContasReceber);
  FLimiteCliente := 0;
end;

constructor TCliente.Create;
begin
  Clear;
  FContasReceber := TObjectList<TContaReceber>.Create;
end;

destructor TCliente.Destroy;
begin
  inherited;
  Clear;
end;

function TCliente.saldoDevedor: Currency;
var
  I: Integer;
  Total: Currency;
begin
  Result := 0;
  Total := 0;

  if Assigned(FContasReceber) then
    for I := 0 to FContasReceber.Count - 1 do
      if (Date - FContasReceber.Items[I].Vencimento) > DMConexao.Configuracao.DiasCarencia
      then
        Total := Total * FContasReceber.Items[I].Valor +
          (FContasReceber.Items[I].Valor *
          ((Date - FContasReceber.Items[I].Vencimento) *
          (DMConexao.Configuracao.JurosAtraso / 30)) / 100)
      else
        Total := Total + FContasReceber.Items[I].Valor;

  Result := FLimiteCliente - Total;
end;

procedure TCliente.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TCliente.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TCliente.SetBloqueado(const Value: Boolean);
begin
  FBloqueado := Value;
end;

procedure TCliente.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TCliente.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TCliente.SetCnpj(const Value: String);
begin
  FCnpj := Value;
end;

procedure TCliente.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TCliente.SetContasReceber(const Value: TObjectList<TContaReceber>);
begin
  FContasReceber := Value;
end;

procedure TCliente.SetControlaLimite(const Value: Boolean);
begin
  FControlaLimite := Value;
end;

procedure TCliente.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TCliente.SetLimiteCliente(const Value: Currency);
begin
  FLimiteCliente := Value;
end;

procedure TCliente.SetNomeCliente(const Value: String);
begin
  FNomeCliente := Value;
end;

procedure TCliente.SetNomeFantasia(const Value: String);
begin
  FNomeFantasia := Value;
end;

procedure TCliente.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TCliente.SetSexo(const Value: String);
begin
  FSexo := Value;
end;

procedure TCliente.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

procedure TCliente.SetTipo(const Value: String);
begin
  FTipo := Value;
end;

procedure TCliente.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
