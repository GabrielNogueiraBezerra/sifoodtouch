unit uItemContaCliente;

interface

uses
  System.SysUtils, uEmpresa, uVendedor, uProduto, System.Generics.Collections,
  uPagamentoParcial;

type
{$TYPEINFO ON}
  TItemContaCliente = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FOrdem: Integer;
    FProduto: TProduto;
    FGarcom: TVendedor;
    FValor: Currency;
    FContaOrigem: Integer;
    FCancelado: Integer;
    FEmpresa: TEmpresa;
    FQuantidade: Currency;
    FTotal: Currency;
    FImpresso: String;
    FHora: TTime;
    FObservacao: String;
    FOrdemParPizza: Integer;
    FFeito: String;
    FAvisado: String;
    FMotivoCancelamento: String;
    FDataHoraCancelamento: TDateTime;
    FObservacaoPizza: String;
    FOrdemItemPrincipal: Integer;
    FAdicionais: TObjectList<TItemContaCliente>;
    FTotalAdicional: Currency;
    FValorParcial: Currency;
    FPagamentosParciais: TObjectList<TPagamentoParcial>;
    FQuantidadeTransferencia: Currency;
    procedure SetAvisado(const Value: String);
    procedure SetCancelado(const Value: Integer);
    procedure SetCodigo(const Value: Integer);
    procedure SetContaOrigem(const Value: Integer);
    procedure SetDataHoraCancelamento(const Value: TDateTime);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetFeito(const Value: String);
    procedure SetGarcom(const Value: TVendedor);
    procedure SetHora(const Value: TTime);
    procedure SetImpresso(const Value: String);
    procedure SetMotivoCancelamento(const Value: String);
    procedure SetObservacao(const Value: String);
    procedure SetObservacaoPizza(const Value: String);
    procedure SetOrdem(const Value: Integer);
    procedure SetORdemItemPrincipal(const Value: Integer);
    procedure SetOrdemParPizza(const Value: Integer);
    procedure SetProduto(const Value: TProduto);
    procedure SetQuantidade(const Value: Currency);
    procedure SetTotal(const Value: Currency);
    procedure SetValor(const Value: Currency);
    procedure SetAdicionais(const Value: TObjectList<TItemContaCliente>);
    procedure SetTotalAdicional(const Value: Currency);
    procedure SetValorParcial(const Value: Currency);
    procedure SetPagamentosParciais(const Value
      : TObjectList<TPagamentoParcial>);
    procedure SetQuantidadeTransferencia(const Value: Currency);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;

    function TotalItem: Currency;
    function TotalAdicionais: Currency;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property Ordem: Integer read FOrdem write SetOrdem;
    property Produto: TProduto read FProduto write SetProduto;
    property Garcom: TVendedor read FGarcom write SetGarcom;
    property Valor: Currency read FValor write SetValor;
    property ContaOrigem: Integer read FContaOrigem write SetContaOrigem;
    property Cancelado: Integer read FCancelado write SetCancelado;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property Quantidade: Currency read FQuantidade write SetQuantidade;
    property Total: Currency read FTotal write SetTotal;
    property Impresso: String read FImpresso write SetImpresso;
    property Hora: TTime read FHora write SetHora;
    property Observacao: String read FObservacao write SetObservacao;
    property OrdemParPizza: Integer read FOrdemParPizza write SetOrdemParPizza;
    property Feito: String read FFeito write SetFeito;
    property Avisado: String read FAvisado write SetAvisado;
    property MotivoCancelamento: String read FMotivoCancelamento
      write SetMotivoCancelamento;
    property DataHoraCancelamento: TDateTime read FDataHoraCancelamento
      write SetDataHoraCancelamento;
    property ObservacaoPizza: String read FObservacaoPizza
      write SetObservacaoPizza;
    property OrdemItemPrincipal: Integer read FOrdemItemPrincipal
      write SetORdemItemPrincipal;
    property Adicionais: TObjectList<TItemContaCliente> read FAdicionais
      write SetAdicionais;
    property TotalAdicional: Currency read FTotalAdicional
      write SetTotalAdicional;
    property ValorParcial: Currency read FValorParcial write SetValorParcial;
    property PagamentosParciais: TObjectList<TPagamentoParcial>
      read FPagamentosParciais write SetPagamentosParciais;
    property QuantidadeTransferencia: Currency read FQuantidadeTransferencia
      write SetQuantidadeTransferencia;
  end;

implementation

{ TItemContaCliente }

procedure TItemContaCliente.Clear;
begin
  FCodigo := 0;
  FOrdem := 0;
  FValor := 0.0;
  FContaOrigem := 0;
  FCancelado := 0;
  FreeAndNil(FEmpresa);
  FQuantidade := 0.0;
  FTotal := 0.0;
  FreeAndNil(FProduto);
  FreeAndNil(FGarcom);
  FImpresso := '';
  FObservacao := '';
  FOrdemParPizza := 0;
  FFeito := '';
  FAvisado := '';
  FMotivoCancelamento := '';
  FObservacaoPizza := '';
  FOrdemItemPrincipal := 0;
end;

constructor TItemContaCliente.Create;
begin
  FEmpresa := TEmpresa.Create;
  FProduto := TProduto.Create;
  FGarcom := TVendedor.Create;
  FAdicionais := TObjectList<TItemContaCliente>.Create;
  FPagamentosParciais := TObjectList<TPagamentoParcial>.Create;
end;

destructor TItemContaCliente.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TItemContaCliente.SetAdicionais(const Value
  : TObjectList<TItemContaCliente>);
begin
  FAdicionais := Value;
end;

procedure TItemContaCliente.SetAvisado(const Value: String);
begin
  FAvisado := Value;
end;

procedure TItemContaCliente.SetCancelado(const Value: Integer);
begin
  FCancelado := Value;
end;

procedure TItemContaCliente.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TItemContaCliente.SetContaOrigem(const Value: Integer);
begin
  FContaOrigem := Value;
end;

procedure TItemContaCliente.SetDataHoraCancelamento(const Value: TDateTime);
begin
  FDataHoraCancelamento := Value;
end;

procedure TItemContaCliente.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TItemContaCliente.SetFeito(const Value: String);
begin
  FFeito := Value;
end;

procedure TItemContaCliente.SetGarcom(const Value: TVendedor);
begin
  FGarcom := Value;
end;

procedure TItemContaCliente.SetHora(const Value: TTime);
begin
  FHora := Value;
end;

procedure TItemContaCliente.SetImpresso(const Value: String);
begin
  FImpresso := Value;
end;

procedure TItemContaCliente.SetMotivoCancelamento(const Value: String);
begin
  FMotivoCancelamento := Value;
end;

procedure TItemContaCliente.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TItemContaCliente.SetObservacaoPizza(const Value: String);
begin
  FObservacaoPizza := Value;
end;

procedure TItemContaCliente.SetOrdem(const Value: Integer);
begin
  FOrdem := Value;
end;

procedure TItemContaCliente.SetORdemItemPrincipal(const Value: Integer);
begin
  FOrdemItemPrincipal := Value;
end;

procedure TItemContaCliente.SetOrdemParPizza(const Value: Integer);
begin
  FOrdemParPizza := Value;
end;

procedure TItemContaCliente.SetPagamentosParciais
  (const Value: TObjectList<TPagamentoParcial>);
begin
  FPagamentosParciais := Value;
end;

procedure TItemContaCliente.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TItemContaCliente.SetQuantidade(const Value: Currency);
begin
  FQuantidade := Value;
end;

procedure TItemContaCliente.SetQuantidadeTransferencia(const Value: Currency);
begin
  FQuantidadeTransferencia := Value;
end;

procedure TItemContaCliente.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

procedure TItemContaCliente.SetTotalAdicional(const Value: Currency);
begin
  FTotalAdicional := Value;
end;

procedure TItemContaCliente.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TItemContaCliente.SetValorParcial(const Value: Currency);
begin
  FValorParcial := Value;
end;

function TItemContaCliente.TotalAdicionais: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FAdicionais.Count - 1 do
    with FAdicionais.Items[I] do
      Result := Result + FTotal;
end;

function TItemContaCliente.TotalItem: Currency;
begin
  Result := ((FTotal + TotalAdicionais) - FValorParcial);
end;

end.
