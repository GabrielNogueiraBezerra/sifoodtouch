unit uItemVenda;

interface

uses
  uProduto, uEmpresa, uVendedor, uGrupoIcms, uGrupoPis, uGrupoCofins;

type
{$TYPEINFO ON}
  TItemVenda = class(TObject)
  private
    FProduto: TProduto;
    FObservacao: String;
    FAcrescimo: Currency;
    FDesconto: Currency;
    FValorCusto: Currency;
    FValor: Currency;
    FGrupoIcms: TGrupoIcms;
    FCancelado: Integer;
    FCodigo: Integer;
    FTotal: Currency;
    FVendedor: TVendedor;
    FCfop: Integer;
    FGrupoPis: TGrupoPis;
    FGrupoCofins: TGrupoCofins;
    FVendaCancelada: Integer;
    FPromocao: Boolean;
    FEmpresa: TEmpresa;
    FQuantidade: Currency;
    FOrdem: Integer;
    FValorImpostoAproximado: Currency;
    procedure SetAcrescimo(const Value: Currency);
    procedure SetCancelado(const Value: Integer);
    procedure SetCfop(const Value: Integer);
    procedure SetCodigo(const Value: Integer);
    procedure SetDesconto(const Value: Currency);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetGrupoCofins(const Value: TGrupoCofins);
    procedure SetGrupoIcms(const Value: TGrupoIcms);
    procedure SetGrupoPis(const Value: TGrupoPis);
    procedure SetObservacao(const Value: String);
    procedure SetOrdem(const Value: Integer);
    procedure SetProduto(const Value: TProduto);
    procedure SetPromocao(const Value: Boolean);
    procedure SetQuantidade(const Value: Currency);
    procedure SetTotal(const Value: Currency);
    procedure SetValor(const Value: Currency);
    procedure SetValorCusto(const Value: Currency);
    procedure setVendaCancelada(const Value: Integer);
    procedure SetVendedor(const Value: TVendedor);
    procedure SetValorImpostoAproximado(const Value: Currency);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;
    function totalItem: Currency;
    function totalTributoEstadual: Currency;
    function totalTributoNacional: Currency;
    function totalIcms: Currency;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property Produto: TProduto read FProduto write SetProduto;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property Ordem: Integer read FOrdem write SetOrdem;
    property Vendedor: TVendedor read FVendedor write SetVendedor;
    property Cfop: Integer read FCfop write SetCfop;
    property Quantidade: Currency read FQuantidade write SetQuantidade;
    property Promocao: Boolean read FPromocao write SetPromocao;
    property Valor: Currency read FValor write SetValor;
    property ValorCusto: Currency read FValorCusto write SetValorCusto;
    property Desconto: Currency read FDesconto write SetDesconto;
    property Acrescimo: Currency read FAcrescimo write SetAcrescimo;
    property Total: Currency read FTotal write SetTotal;
    property GrupoIcms: TGrupoIcms read FGrupoIcms write SetGrupoIcms;
    property GrupoPis: TGrupoPis read FGrupoPis write SetGrupoPis;
    property GrupoCofins: TGrupoCofins read FGrupoCofins write SetGrupoCofins;
    property Cancelado: Integer read FCancelado write SetCancelado;
    property VendaCancelada: Integer read FVendaCancelada
      write setVendaCancelada;
    property Observacao: String read FObservacao write SetObservacao;
    property ValorImpostoAproximado: Currency read FValorImpostoAproximado
      write SetValorImpostoAproximado;
  end;

implementation

uses
  System.SysUtils;

{ TItemVenda }

procedure TItemVenda.Clear;
begin
  FObservacao := '';
  FAcrescimo := 0;
  FDesconto := 0;
  FValorCusto := 0;
  FValor := 0;
  FCancelado := 0;
  FCodigo := 0;
  FTotal := 0;
  FCfop := 0;
  FVendaCancelada := 0;
  FPromocao := false;
  FQuantidade := 0;
  FOrdem := 0;
  FreeAndNil(FProduto);
  FreeAndNil(FGrupoIcms);
  FreeAndNil(FVendedor);
  FreeAndNil(FGrupoPis);
  FreeAndNil(FGrupoCofins);
  FreeAndNil(FEmpresa);
  FValorImpostoAproximado := 0;
end;

constructor TItemVenda.Create;
begin
  Clear;
  FProduto := TProduto.Create;
  FGrupoIcms := TGrupoIcms.Create;
  FGrupoPis := TGrupoPis.Create;
  FGrupoCofins := TGrupoCofins.Create;
  FVendedor := TVendedor.Create;
  FEmpresa := TEmpresa.Create;
end;

destructor TItemVenda.Destroy;
begin
  inherited;
  Clear;
end;

procedure TItemVenda.SetAcrescimo(const Value: Currency);
begin
  FAcrescimo := Value;
end;

procedure TItemVenda.SetCancelado(const Value: Integer);
begin
  FCancelado := Value;
end;

procedure TItemVenda.SetCfop(const Value: Integer);
begin
  FCfop := Value;
end;

procedure TItemVenda.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TItemVenda.SetDesconto(const Value: Currency);
begin
  FDesconto := Value;
end;

procedure TItemVenda.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TItemVenda.SetGrupoCofins(const Value: TGrupoCofins);
begin
  FGrupoCofins := Value;
end;

procedure TItemVenda.SetGrupoIcms(const Value: TGrupoIcms);
begin
  FGrupoIcms := Value;
end;

procedure TItemVenda.SetGrupoPis(const Value: TGrupoPis);
begin
  FGrupoPis := Value;
end;

procedure TItemVenda.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TItemVenda.SetOrdem(const Value: Integer);
begin
  FOrdem := Value;
end;

procedure TItemVenda.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TItemVenda.SetPromocao(const Value: Boolean);
begin
  FPromocao := Value;
end;

procedure TItemVenda.SetQuantidade(const Value: Currency);
begin
  FQuantidade := Value;
end;

procedure TItemVenda.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

procedure TItemVenda.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TItemVenda.SetValorCusto(const Value: Currency);
begin
  FValorCusto := Value;
end;

procedure TItemVenda.SetValorImpostoAproximado(const Value: Currency);
begin
  FValorImpostoAproximado := Value;
end;

procedure TItemVenda.setVendaCancelada(const Value: Integer);
begin
  FVendaCancelada := Value;
end;

procedure TItemVenda.SetVendedor(const Value: TVendedor);
begin
  FVendedor := Value;
end;

function TItemVenda.totalIcms: Currency;
begin
  result := (totalItem * Produto.GrupoIcms.Aliquota) / 100;
end;

function TItemVenda.totalItem: Currency;
begin
  result := (FQuantidade * FValor) - FDesconto + FAcrescimo;
end;

function TItemVenda.totalTributoEstadual: Currency;
begin
  result := (totalItem * Produto.IBTP.AliquotaEstadual) / 100;
end;

function TItemVenda.totalTributoNacional: Currency;
begin
  if (Produto.GrupoIcms.Origem = 0) or (Produto.GrupoIcms.Origem = 3) or
    (Produto.GrupoIcms.Origem = 4) or (Produto.GrupoIcms.Origem = 5) then
    result := (totalItem * Produto.IBTP.AliquotaNacional) / 100
  else
    result := ((totalItem * Produto.IBTP.AliquotaNacional) / 100) +
      ((totalItem * Produto.IBTP.AliquotaImportado) / 100);
end;

end.
