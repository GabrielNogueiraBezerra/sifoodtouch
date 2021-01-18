unit uContaCliente;

interface

uses
  SysUtils, uEmpresa, uCaixa, uIndicador, uSetor, uItemContaCliente,
  System.Generics.Collections, uPagamentoParcial, uVenda;

type
{$TYPEINFO ON}
  TContaCliente = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FContadorConta: Integer;
    FDataAbertura: TDate;
    FHoraAbertura: TTime;
    FDataFechamento: TDate;
    FHoraFechamento: TTime;
    FConta: Integer;
    FCaixa: TCaixa;
    FEmpresa: TEmpresa;
    FStatus: Integer;
    FTotal: Currency;
    FDispensarTaxaServico: String;
    FContaOrigem: Integer;
    FConferenciaEmitida: String;
    FCoo: Integer;
    FMotivoCancelamento: String;
    FDataHoraCancelamento: TDateTime;
    FVendaDelivery: String;
    FIndicador: TIndicador;
    FTaxaServicoCobrada: Currency;
    FNumeroPessoas: Integer;
    FVendaBalcao: String;
    FDescricaoMesa: String;
    FSetor: TSetor;
    FItensContaCliente: TObjectList<TItemContaCliente>;
    FValorPacial: Currency;
    FPagamentosParciais: TObjectList<TPagamentoParcial>;
    FOrdemFinal: Integer;
    FVenda: TVenda;
    procedure SetCodigo(const Value: Integer);
    procedure SetContadorConta(const Value: Integer);
    procedure SetDataAbertura(const Value: TDate);
    procedure SetHoraAbertura(const Value: TTime);
    procedure SetCaixa(const Value: TCaixa);
    procedure SetConferenciaEmitida(const Value: String);
    procedure SetConta(const Value: Integer);
    procedure SetContaOrigem(const Value: Integer);
    procedure SetCoo(const Value: Integer);
    procedure SetDataFechamento(const Value: TDate);
    procedure SetDataHoraCancelamento(const Value: TDateTime);
    procedure SetDescricaoMesa(const Value: String);
    procedure SetDispensarTaxaServico(const Value: String);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetIndicador(const Value: TIndicador);
    procedure SetMotivoCancelamento(const Value: String);
    procedure SetNumeroPessoas(const Value: Integer);
    procedure SetSetor(const Value: TSetor);
    procedure SetStatus(const Value: Integer);
    procedure SetTaxaServicoCobrada(const Value: Currency);
    procedure SetTotal(const Value: Currency);
    procedure SetVendaBalcao(const Value: String);
    procedure SetVendaDelivery(const Value: String);
    procedure SetHoraFechamento(const Value: TTime);
    procedure SetItensContaCliente(const Value: TObjectList<TItemContaCliente>);
    procedure SetValorParcial(const Value: Currency);
    procedure SetPagamentosParciais(const Value
      : TObjectList<TPagamentoParcial>);
    procedure SetOrdemFinal(const Value: Integer);
    procedure SetVenda(const Value: TVenda);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;

    function TotalMesa: Currency;
    function TotalAdicionais: Currency;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property ContadorConta: Integer read FContadorConta write SetContadorConta;
    property DataAbertura: TDate read FDataAbertura write SetDataAbertura;
    property HoraAbertura: TTime read FHoraAbertura write SetHoraAbertura;
    property DataFechamento: TDate read FDataFechamento write SetDataFechamento;
    property HoraFechamento: TTime read FHoraFechamento write SetHoraFechamento;
    property Conta: Integer read FConta write SetConta;
    property Caixa: TCaixa read FCaixa write SetCaixa;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property Status: Integer read FStatus write SetStatus;
    property Total: Currency read FTotal write SetTotal;
    property DispensarTaxaServico: String read FDispensarTaxaServico
      write SetDispensarTaxaServico;
    property ContaOrigem: Integer read FContaOrigem write SetContaOrigem;
    property ConferenciaEmitida: String read FConferenciaEmitida
      write SetConferenciaEmitida;
    property Coo: Integer read FCoo write SetCoo;
    property MotivoCancelamento: String read FMotivoCancelamento
      write SetMotivoCancelamento;
    property DataHoraCancelamento: TDateTime read FDataHoraCancelamento
      write SetDataHoraCancelamento;
    property VendaDelivery: String read FVendaDelivery write SetVendaDelivery;
    property Indicador: TIndicador read FIndicador write SetIndicador;
    property TaxaServicoCobrada: Currency read FTaxaServicoCobrada
      write SetTaxaServicoCobrada;
    property NumeroPessoas: Integer read FNumeroPessoas write SetNumeroPessoas;
    property VendaBalcao: String read FVendaBalcao write SetVendaBalcao;
    property DescricaoMesa: String read FDescricaoMesa write SetDescricaoMesa;
    property Setor: TSetor read FSetor write SetSetor;
    property ItensContaCliente: TObjectList<TItemContaCliente>
      read FItensContaCliente write SetItensContaCliente;
    property ValorPacial: Currency read FValorPacial write SetValorParcial;
    property PagamentosParciais: TObjectList<TPagamentoParcial>
      read FPagamentosParciais write SetPagamentosParciais;
    property OrdemFinal: Integer read FOrdemFinal write SetOrdemFinal;
    property Venda: TVenda read FVenda write SetVenda;
  end;

implementation

{ TContaCliente }

procedure TContaCliente.Clear;
begin
  FCodigo := 0;
  FContadorConta := 0;
  FConta := 0;
  FreeAndNil(FCaixa);
  FreeAndNil(FEmpresa);
  FStatus := -1;
  FTotal := 0.0;
  FDispensarTaxaServico := '';
  FContaOrigem := 0;
  FConferenciaEmitida := '';
  FCoo := 0;
  FMotivoCancelamento := '';
  FVendaDelivery := '';
  FreeAndNil(FIndicador);
  FTaxaServicoCobrada := 0.0;
  FNumeroPessoas := 0;
  FVendaBalcao := '';
  FDescricaoMesa := '';
  FreeAndNil(FSetor);
  FreeAndNil(FItensContaCliente);
  FreeAndNil(FPagamentosParciais);
  FreeAndNil(FVenda);
end;

constructor TContaCliente.Create;
begin
  Clear;
  FEmpresa := TEmpresa.Create;
  FCaixa := TCaixa.Create;
  FIndicador := TIndicador.Create;
  FSetor := TSetor.Create;
  FItensContaCliente := TObjectList<TItemContaCliente>.Create;
  FPagamentosParciais := TObjectList<TPagamentoParcial>.Create;
end;

destructor TContaCliente.Destroy;
begin
  inherited;
  Self.Clear;
end;

procedure TContaCliente.SetCaixa(const Value: TCaixa);
begin
  FCaixa := Value;
end;

procedure TContaCliente.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TContaCliente.SetConferenciaEmitida(const Value: String);
begin
  FConferenciaEmitida := Value;
end;

procedure TContaCliente.SetConta(const Value: Integer);
begin
  FConta := Value;
end;

procedure TContaCliente.SetContadorConta(const Value: Integer);
begin
  FContadorConta := Value;
end;

procedure TContaCliente.SetContaOrigem(const Value: Integer);
begin
  FContaOrigem := Value;
end;

procedure TContaCliente.SetCoo(const Value: Integer);
begin
  FCoo := Value;
end;

procedure TContaCliente.SetDataAbertura(const Value: TDate);
begin
  FDataAbertura := Value;
end;

procedure TContaCliente.SetDataFechamento(const Value: TDate);
begin
  FDataFechamento := Value;
end;

procedure TContaCliente.SetDataHoraCancelamento(const Value: TDateTime);
begin
  FDataHoraCancelamento := Value;
end;

procedure TContaCliente.SetDescricaoMesa(const Value: String);
begin
  FDescricaoMesa := Value;
end;

procedure TContaCliente.SetDispensarTaxaServico(const Value: String);
begin
  FDispensarTaxaServico := Value;
end;

procedure TContaCliente.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TContaCliente.SetHoraAbertura(const Value: TTime);
begin
  FHoraAbertura := Value;
end;

procedure TContaCliente.SetHoraFechamento(const Value: TTime);
begin
  FHoraFechamento := Value;
end;

procedure TContaCliente.SetIndicador(const Value: TIndicador);
begin
  FIndicador := Value;
end;

procedure TContaCliente.SetItensContaCliente(const Value
  : TObjectList<TItemContaCliente>);
begin
  FItensContaCliente := Value;
end;

procedure TContaCliente.SetMotivoCancelamento(const Value: String);
begin
  FMotivoCancelamento := Value;
end;

procedure TContaCliente.SetNumeroPessoas(const Value: Integer);
begin
  FNumeroPessoas := Value;
end;

procedure TContaCliente.SetOrdemFinal(const Value: Integer);
begin
  FOrdemFinal := Value;
end;

procedure TContaCliente.SetPagamentosParciais(const Value
  : TObjectList<TPagamentoParcial>);
begin
  FPagamentosParciais := Value;
end;

procedure TContaCliente.SetSetor(const Value: TSetor);
begin
  FSetor := Value;
end;

procedure TContaCliente.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

procedure TContaCliente.SetTaxaServicoCobrada(const Value: Currency);
begin
  FTaxaServicoCobrada := Value;
end;

procedure TContaCliente.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

procedure TContaCliente.SetValorParcial(const Value: Currency);
begin
  FValorPacial := Value;
end;

procedure TContaCliente.SetVenda(const Value: TVenda);
begin
  FVenda := Value;
end;

procedure TContaCliente.SetVendaBalcao(const Value: String);
begin
  FVendaBalcao := Value;
end;

procedure TContaCliente.SetVendaDelivery(const Value: String);
begin
  FVendaDelivery := Value;
end;

function TContaCliente.TotalAdicionais: Currency;
var
  I: Integer;
begin
  Result := 0;

  for I := 0 to FItensContaCliente.Count - 1 do
    if FItensContaCliente.Items[I].Cancelado = 0 then
      Result := Result + FItensContaCliente.Items[I].TotalAdicionais;
end;

function TContaCliente.TotalMesa: Currency;
var
  I: Integer;
begin
  Result := 0;

  for I := 0 to FItensContaCliente.Count - 1 do
    if FItensContaCliente.Items[I].Cancelado = 0 then
      Result := Result + FItensContaCliente.Items[I].TotalItem;
end;

end.
