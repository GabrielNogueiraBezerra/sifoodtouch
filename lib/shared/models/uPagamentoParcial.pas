unit uPagamentoParcial;

interface

uses
  uFormaPagamento;

type
{$TYPEINFO ON}
  TPagamentoParcial = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FOrdem: Integer;
    FValor: Currency;
    FFormaPagamento: TFormaPagamento;
    FDataHora: TDateTime;
    FHistorico: String;
    FStatus: Integer;
    FCodigoContaCliente: Integer;
    procedure SetCodigo(const Value: Integer);
    procedure SetDataHora(const Value: TDateTime);
    procedure SetFormaPagamento(const Value: TFormaPagamento);
    procedure SetHistorico(const Value: String);
    procedure SetOrdem(const Value: Integer);
    procedure SetStatus(const Value: Integer);
    procedure SetValor(const Value: Currency);
    procedure SetCodigoContaCliente(const Value: Integer);
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
    property Ordem: Integer read FOrdem write SetOrdem;
    property Valor: Currency read FValor write SetValor;
    property FormaPagamento: TFormaPagamento read FFormaPagamento
      write SetFormaPagamento;
    property DataHora: TDateTime read FDataHora write SetDataHora;
    property Historico: String read FHistorico write SetHistorico;
    property Status: Integer read FStatus write SetStatus;
    property CodigoContaCliente: Integer read FCodigoContaCliente write SetCodigoContaCliente;
  end;

implementation

uses
  System.SysUtils;

{ TPagamentoParcial }

procedure TPagamentoParcial.Clear;
begin
  FCodigo := 0;
  FOrdem := 0;
  FValor := 0;
  FHistorico := '';
  FStatus := -1;
  FCodigoContaCliente := 0;
  FreeAndNil(FFormaPagamento);
end;

constructor TPagamentoParcial.Create;
begin
  self.Clear;
  FormaPagamento := TFormaPagamento.Create;
end;

destructor TPagamentoParcial.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TPagamentoParcial.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TPagamentoParcial.SetCodigoContaCliente(const Value: Integer);
begin
  FCodigoContaCliente := Value;
end;

procedure TPagamentoParcial.SetDataHora(const Value: TDateTime);
begin
  FDataHora := Value;
end;

procedure TPagamentoParcial.SetFormaPagamento(const Value: TFormaPagamento);
begin
  FFormaPagamento := Value;
end;

procedure TPagamentoParcial.SetHistorico(const Value: String);
begin
  FHistorico := Value;
end;

procedure TPagamentoParcial.SetOrdem(const Value: Integer);
begin
  FOrdem := Value;
end;

procedure TPagamentoParcial.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

procedure TPagamentoParcial.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
