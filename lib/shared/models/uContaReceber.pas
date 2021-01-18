unit uContaReceber;

interface

uses
  uUsuario, uCaixa, uEmpresa;

type
{$TYPEINFO ON}
  TContaReceber = class(TObject)
  private
    FDataHoraLancamento: TDateTime;
    FAcrescimo: Currency;
    FDesconto: Currency;
    FSequencia: Integer;
    FValor: Currency;
    FCodigoClassificacao: Integer;
    FCodigo: Integer;
    FUsuarioGerou: TUsuario;
    FVencimento: TDate;
    FCaixa: TCaixa;
    FCodigoCobranca: Integer;
    FEmpresa: TEmpresa;
    FData: TDate;
    FNumeroDocumento: String;
    FParcela: Integer;
    FObservacao: String;
    FDataPagamento: TDate;
    FValorPagamento: Currency;
    FCodigoCliente: Integer;
    FCodigoVenda: Integer;
    procedure SetAcrescimo(const Value: Currency);
    procedure SetCaixa(const Value: TCaixa);
    procedure SetCodigo(const Value: Integer);
    procedure SetCodigoClassificacao(const Value: Integer);
    procedure SetCodigoCobranca(const Value: Integer);
    procedure SetData(const Value: TDate);
    procedure SetDataHoraLancamento(const Value: TDateTime);
    procedure SetDesconto(const Value: Currency);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetNumeroDocumento(const Value: String);
    procedure SetParcela(const Value: Integer);
    procedure SetSequencia(const Value: Integer);
    procedure SetUsuarioGerou(const Value: TUsuario);
    procedure SetValor(const Value: Currency);
    procedure SetVeencimento(const Value: TDate);
    procedure SetObservacao(const Value: String);
    procedure SetDataPagamento(const Value: TDate);
    procedure SetValorPagamento(const Value: Currency);
    procedure SetCodigoCliente(const Value: Integer);
    procedure SetCodigoVenda(const Value: Integer);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property Sequencia: Integer read FSequencia write SetSequencia;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property CodigoCliente: Integer read FCodigoCliente write SetCodigoCliente;
    property CodigoCobranca: Integer read FCodigoCobranca
      write SetCodigoCobranca;
    property CodigoClassificacao: Integer read FCodigoClassificacao
      write SetCodigoClassificacao;
    property Caixa: TCaixa read FCaixa write SetCaixa;
    property Parcela: Integer read FParcela write SetParcela;
    property NumeroDocumento: String read FNumeroDocumento
      write SetNumeroDocumento;
    property Data: TDate read FData write SetData;
    property Vencimento: TDate read FVencimento write SetVeencimento;
    property Valor: Currency read FValor write SetValor;
    property Desconto: Currency read FDesconto write SetDesconto;
    property Acrescimo: Currency read FAcrescimo write SetAcrescimo;
    property DataHoraLancamento: TDateTime read FDataHoraLancamento
      write SetDataHoraLancamento;
    property UsuarioGerou: TUsuario read FUsuarioGerou write SetUsuarioGerou;
    property Observacao: String read FObservacao write SetObservacao;
    property DataPagamento: TDate read FDataPagamento write SetDataPagamento;
    property ValorPagamento: Currency read FValorPagamento
      write SetValorPagamento;
    property CodigoVenda: Integer read FCodigoVenda write SetCodigoVenda;
  end;

implementation

uses
  System.SysUtils;

{ TContaReceber }

procedure TContaReceber.Clear;
begin
  FAcrescimo := 0;
  FDesconto := 0;
  FSequencia := 0;
  FValor := 0;
  FCodigoClassificacao := 0;
  FCodigoCliente := 0;
  FCodigo := 0;
  FreeAndNil(FUsuarioGerou);
  FreeAndNil(FCaixa);
  FCodigoCobranca := 0;
  FreeAndNil(FEmpresa);
  FNumeroDocumento := '';
  FParcela := 0;
  FObservacao := '';
  FValorPagamento := 0;
  FCodigoVenda := 0;
end;

constructor TContaReceber.Create;
begin
  Clear;
  FEmpresa := TEmpresa.Create;
  FCaixa := TCaixa.Create;
  FUsuarioGerou := TUsuario.Create;
end;

destructor TContaReceber.Destroy;
begin
  Clear;
  inherited;
end;

procedure TContaReceber.SetAcrescimo(const Value: Currency);
begin
  FAcrescimo := Value;
end;

procedure TContaReceber.SetCaixa(const Value: TCaixa);
begin
  FCaixa := Value;
end;

procedure TContaReceber.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TContaReceber.SetCodigoClassificacao(const Value: Integer);
begin
  FCodigoClassificacao := Value;
end;

procedure TContaReceber.SetCodigoCliente(const Value: Integer);
begin
  FCodigoCliente := Value;
end;

procedure TContaReceber.SetCodigoCobranca(const Value: Integer);
begin
  FCodigoCobranca := Value;
end;

procedure TContaReceber.SetCodigoVenda(const Value: Integer);
begin
  FCodigoVenda := Value;
end;

procedure TContaReceber.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TContaReceber.SetDataHoraLancamento(const Value: TDateTime);
begin
  FDataHoraLancamento := Value;
end;

procedure TContaReceber.SetDataPagamento(const Value: TDate);
begin
  FDataPagamento := Value;
end;

procedure TContaReceber.SetDesconto(const Value: Currency);
begin
  FDesconto := Value;
end;

procedure TContaReceber.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TContaReceber.SetNumeroDocumento(const Value: String);
begin
  FNumeroDocumento := Value;
end;

procedure TContaReceber.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TContaReceber.SetParcela(const Value: Integer);
begin
  FParcela := Value;
end;

procedure TContaReceber.SetSequencia(const Value: Integer);
begin
  FSequencia := Value;
end;

procedure TContaReceber.SetUsuarioGerou(const Value: TUsuario);
begin
  FUsuarioGerou := Value;
end;

procedure TContaReceber.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TContaReceber.SetValorPagamento(const Value: Currency);
begin
  FValorPagamento := Value;
end;

procedure TContaReceber.SetVeencimento(const Value: TDate);
begin
  FVencimento := Value;
end;

end.
