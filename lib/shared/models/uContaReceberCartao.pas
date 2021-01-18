unit uContaReceberCartao;

interface

uses
  uBandeiraCartao, uCaixa, uEmpresa, uCliente, uFormaPagamento;

type
{$TYPEINFO ON}
  TContaReceberCartao = class(TObject)
  private
    FBandeiraCartao: TBandeiraCartao;
    FCodigo: Integer;
    FNumeroAutorizacao: String;
    FTaxa: Currency;
    FValor: Currency;
    FCliente: TCliente;
    FVencimento: TDate;
    FCaixa: TCaixa;
    FEmpresa: TEmpresa;
    FEmissao: TDate;
    FParcela: Integer;
    FObservacao: String;
    FFormaPagamento: TFormaPagamento;
    FIDPagamento: Integer;
    FBin: String;
    FDonoCartao: String;
    FInstituicaoFinanceira: String;
    FDataExpiracao: String;
    FUltimosQuatroDigitos: Integer;
    FParcelas: Integer;
    FCodigoAutorizacaoVFPe: String;
    FTipo: String;
    FCodigoPagamento: String;
    procedure SetBandeiraCartao(const Value: TBandeiraCartao);
    procedure SetCodigo(const Value: Integer);
    procedure SetCaixa(const Value: TCaixa);
    procedure SetCliente(const Value: TCliente);
    procedure SetEmissao(const Value: TDate);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetNumeroAutorizacao(const Value: String);
    procedure SetParcela(const Value: Integer);
    procedure SetTaxa(const Value: Currency);
    procedure SetValor(const Value: Currency);
    procedure SetVencimento(const Value: TDate);
    procedure SetObservacao(const Value: String);
    procedure SetFormaPagamento(const Value: TFormaPagamento);
    procedure SetIDPagamento(const Value: Integer);
    procedure SetBin(const Value: String);
    procedure SetDonoCartao(const Value: String);
    procedure SetDataExpiracao(const Value: String);
    procedure SetInstituicaoFinanceira(const Value: String);
    procedure SetParcelas(const Value: Integer);
    procedure SetUltimosQuatroDigitos(const Value: Integer);
    procedure SetCodigoAutorizacaoVFPe(const Value: String);
    procedure SetCodigoPagamento(const Value: String);
    procedure SetTipo(const Value: String);
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
    property BandeiraCartao: TBandeiraCartao read FBandeiraCartao
      write SetBandeiraCartao;
    property Emissao: TDate read FEmissao write SetEmissao;
    property Vencimento: TDate read FVencimento write SetVencimento;
    property Caixa: TCaixa read FCaixa write SetCaixa;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property Valor: Currency read FValor write SetValor;
    property Taxa: Currency read FTaxa write SetTaxa;
    property Cliente: TCliente read FCliente write SetCliente;
    property Parcela: Integer read FParcela write SetParcela;
    property NumeroAutorizacao: String read FNumeroAutorizacao
      write SetNumeroAutorizacao;
    property Observacao: String read FObservacao write SetObservacao;
    property FormaPagamento: TFormaPagamento read FFormaPagamento
      write SetFormaPagamento;
    property IDPagamento: Integer read FIDPagamento write SetIDPagamento;
    property Bin: String read FBin write SetBin;
    property DonoCartao: String read FDonoCartao write SetDonoCartao;
    property DataExpiracao: String read FDataExpiracao write SetDataExpiracao;
    property InstituicaoFinanceira: String read FInstituicaoFinanceira
      write SetInstituicaoFinanceira;
    property Parcelas: Integer read FParcelas write SetParcelas;
    property UltimosQuatroDigitos: Integer read FUltimosQuatroDigitos
      write SetUltimosQuatroDigitos;
    property CodigoPagamento: String read FCodigoPagamento
      write SetCodigoPagamento;
    property Tipo: String read FTipo write SetTipo;
    property CodigoAutorizacaoVFPe: String read FCodigoAutorizacaoVFPe
      write SetCodigoAutorizacaoVFPe;
  end;

implementation

uses
  System.SysUtils;

{ TContaReceberCartao }

procedure TContaReceberCartao.Clear;
begin
  FCodigo := 0;
  FreeAndNil(FBandeiraCartao);
  FNumeroAutorizacao := '';
  FTaxa := 0;
  FValor := 0;
  FreeAndNil(FCliente);
  FreeAndNil(FCaixa);
  FreeAndNil(FEmpresa);
  FParcela := 0;
  FBin := '';
  FDonoCartao := '';
  FInstituicaoFinanceira := '';
  FDataExpiracao := '';
  FUltimosQuatroDigitos := 0;
  FParcelas := 0;
  FUltimosQuatroDigitos := 0;
  FCodigoPagamento := '';
  FTipo := '';
  FCodigoAutorizacaoVFPe := '';
end;

constructor TContaReceberCartao.Create;
begin
  Clear;
  FBandeiraCartao := TBandeiraCartao.Create;
  FCliente := TCliente.Create;
  FCaixa := TCaixa.Create;
  FEmpresa := TEmpresa.Create;
end;

destructor TContaReceberCartao.Destroy;
begin
  inherited;
  Clear;
end;

procedure TContaReceberCartao.SetBandeiraCartao(const Value: TBandeiraCartao);
begin
  FBandeiraCartao := Value;
end;

procedure TContaReceberCartao.SetBin(const Value: String);
begin
  FBin := Value;
end;

procedure TContaReceberCartao.SetCaixa(const Value: TCaixa);
begin
  FCaixa := Value;
end;

procedure TContaReceberCartao.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TContaReceberCartao.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TContaReceberCartao.SetCodigoAutorizacaoVFPe(const Value: String);
begin
  FCodigoAutorizacaoVFPe := Value;
end;

procedure TContaReceberCartao.SetCodigoPagamento(const Value: String);
begin
  FCodigoPagamento := Value;
end;

procedure TContaReceberCartao.SetDataExpiracao(const Value: String);
begin
  FDataExpiracao := Value;
end;

procedure TContaReceberCartao.SetDonoCartao(const Value: String);
begin
  FDonoCartao := Value;
end;

procedure TContaReceberCartao.SetEmissao(const Value: TDate);
begin
  FEmissao := Value;
end;

procedure TContaReceberCartao.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TContaReceberCartao.SetFormaPagamento(const Value: TFormaPagamento);
begin
  FFormaPagamento := Value;
end;

procedure TContaReceberCartao.SetIDPagamento(const Value: Integer);
begin
  FIDPagamento := Value;
end;

procedure TContaReceberCartao.SetInstituicaoFinanceira(const Value: String);
begin
  FInstituicaoFinanceira := Value;
end;

procedure TContaReceberCartao.SetNumeroAutorizacao(const Value: String);
begin
  FNumeroAutorizacao := Value;
end;

procedure TContaReceberCartao.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TContaReceberCartao.SetParcela(const Value: Integer);
begin
  FParcela := Value;
end;

procedure TContaReceberCartao.SetParcelas(const Value: Integer);
begin
  FParcelas := Value;
end;

procedure TContaReceberCartao.SetTaxa(const Value: Currency);
begin
  FTaxa := Value;
end;

procedure TContaReceberCartao.SetTipo(const Value: String);
begin
  FTipo := Value;
end;

procedure TContaReceberCartao.SetUltimosQuatroDigitos(const Value: Integer);
begin
  FUltimosQuatroDigitos := Value;
end;

procedure TContaReceberCartao.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TContaReceberCartao.SetVencimento(const Value: TDate);
begin
  FVencimento := Value;
end;

end.
