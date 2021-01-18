unit uProduto;

interface

uses
  uImpressora, uSecao, System.Generics.Collections, uEstoque, uLocalEstoque,
  uUnidadeMedida, uGrupoIcms, uGrupoPis, uGrupoCofins, uIBTP;

type
{$TYPEINFO ON}
  TProduto = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FCodigoBarras: String;
    FReferencia: String;
    FNome: String;
    FDescricaoCupom: String;
    FPrecoCusto: Currency;
    FMargemLucro: Currency;
    FPrecoVista: Currency;
    FPrecoPrazo: Currency;
    FAtivo: Boolean;
    FCozinhaBalcao: String;
    FImprimeBalcao: String;
    FImpressora: TImpressora;
    FCaminhoFoto: String;
    FSecao: TSecao;
    FCobrarTaxaServicoRestaurante: String;
    FControlaEstoque: Boolean;
    FEstoques: TObjectList<TEstoque>;
    FGrupoIcms: TGrupoIcms;
    FUnidadeMedida: TUnidadeMedida;
    FGrupoPis: TGrupoPis;
    FGrupoCofins: TGrupoCofins;
    FPromocao: Currency;
    FFatorConversao: Currency;
    FCfop: Integer;
    FNbs: Integer;
    FNcm: String;
    FServico: Boolean;
    FIBTP: TIBTP;
    FCEST: String;
    FQuantidadeComposicao: Integer;
    procedure SetCodigo(const Value: Integer);
    procedure SetCodigoBarras(const Value: String);
    procedure SetReferencia(const Value: String);
    procedure SetDescricaoCupom(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetPrecoCusto(const Value: Currency);
    procedure SetPrecoVista(const Value: Currency);
    procedure SetAtivo(const Value: Boolean);
    procedure SetCozinhaBalcao(const Value: String);
    procedure SetImprimeBalcao(const Value: String);
    procedure SetCaminhoFoto(const Value: String);
    procedure SetImpressora(const Value: TImpressora);
    procedure SetMargemLucro(const Value: Currency);
    procedure SetSecao(const Value: TSecao);
    procedure SetCobrarTaxaServicoRestaurante(const Value: String);
    procedure SetControlaEstoque(const Value: Boolean);
    procedure SetEstoques(const Value: TObjectList<TEstoque>);
    procedure SetGrupoCofins(const Value: TGrupoCofins);
    procedure SetGrupoIcms(const Value: TGrupoIcms);
    procedure SetGrupoPis(const Value: TGrupoPis);
    procedure SetUnidadeMedida(const Value: TUnidadeMedida);
    procedure SetPromocao(const Value: Currency);
    procedure SetFatorConversao(const Value: Currency);
    procedure SetCfop(const Value: Integer);
    procedure SetNbs(const Value: Integer);
    procedure SetNcm(const Value: String);
    procedure SetServico(const Value: Boolean);
    procedure SetIBTP(const Value: TIBTP);
    procedure SetCEST(const Value: String);
    procedure SetQuantidadeComposicao(const Value: Integer);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;

    function estoque(LocalEstoque: TLocalEstoque): Currency;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property CodigoBarras: String read FCodigoBarras write SetCodigoBarras;
    property Referencia: String read FReferencia write SetReferencia;
    property Nome: String read FNome write SetNome;
    property DescricaoCupom: String read FDescricaoCupom
      write SetDescricaoCupom;
    property PrecoCusto: Currency read FPrecoCusto write SetPrecoCusto;
    property MargemLucro: Currency read FMargemLucro write SetMargemLucro;
    property PrecoVista: Currency read FPrecoVista write SetPrecoVista;
    property Ativo: Boolean read FAtivo write SetAtivo;
    property CozinhaBalcao: String read FCozinhaBalcao write SetCozinhaBalcao;
    property ImprimeBalcao: String read FImprimeBalcao write SetImprimeBalcao;
    property Impressora: TImpressora read FImpressora write SetImpressora;
    property CaminhoFoto: String read FCaminhoFoto write SetCaminhoFoto;
    property Secao: TSecao read FSecao write SetSecao;
    property CobrarTaxaServicoRestaurante: String
      read FCobrarTaxaServicoRestaurante write SetCobrarTaxaServicoRestaurante;
    property ControlaEstoque: Boolean read FControlaEstoque
      write SetControlaEstoque;
    property Estoques: TObjectList<TEstoque> read FEstoques write SetEstoques;
    property UnidadeMedida: TUnidadeMedida read FUnidadeMedida
      write SetUnidadeMedida;
    property GrupoIcms: TGrupoIcms read FGrupoIcms write SetGrupoIcms;
    property GrupoPis: TGrupoPis read FGrupoPis write SetGrupoPis;
    property GrupoCofins: TGrupoCofins read FGrupoCofins write SetGrupoCofins;
    property Promocao: Currency read FPromocao write SetPromocao;
    property FatorConversao: Currency read FFatorConversao
      write SetFatorConversao;
    property Cfop: Integer read FCfop write SetCfop;
    property Ncm: String read FNcm write SetNcm;
    property Nbs: Integer read FNbs write SetNbs;
    property Servico: Boolean read FServico write SetServico;
    property IBTP: TIBTP read FIBTP write SetIBTP;
    property CEST: String read FCEST write SetCEST;
    property QuantidadeComposicao: Integer read FQuantidadeComposicao
      write SetQuantidadeComposicao;
  end;

implementation

uses
  System.SysUtils;

{ TProduto }

procedure TProduto.Clear;
begin
  FCodigo := 0;
  FCodigoBarras := '';
  FReferencia := '';
  FNome := '';
  FDescricaoCupom := '';
  FPrecoCusto := 0.0;
  FMargemLucro := 0.0;
  FPrecoVista := 0.0;
  FPrecoPrazo := 0.0;
  FAtivo := false;
  FCozinhaBalcao := '';
  FImprimeBalcao := '';
  FreeAndNil(FImpressora);
  FCaminhoFoto := '';
  FreeAndNil(FSecao);
  FControlaEstoque := false;
  FreeAndNil(FEstoques);
  FreeAndNil(FUnidadeMedida);
  FreeAndNil(FGrupoIcms);
  FreeAndNil(FGrupoPis);
  FreeAndNil(FGrupoCofins);
  FPromocao := 0;
  FFatorConversao := 0;
  FNcm := '';
  FNbs := 0;
  FServico := false;
  FreeAndNil(FIBTP);
  FCEST := '';
end;

constructor TProduto.Create;
begin
  FImpressora := TImpressora.Create;
  FSecao := TSecao.Create;
  FEstoques := TObjectList<TEstoque>.Create;
  FUnidadeMedida := TUnidadeMedida.Create;
  FGrupoIcms := TGrupoIcms.Create;
  FGrupoPis := TGrupoPis.Create;
  FGrupoCofins := TGrupoCofins.Create;
  FIBTP := TIBTP.Create;
end;

destructor TProduto.Destroy;
begin
  inherited;
  Self.Clear;
end;

function TProduto.estoque(LocalEstoque: TLocalEstoque): Currency;
var
  I: Integer;
begin

  Result := 0;

  if Assigned(FEstoques) then
    for I := 0 to FEstoques.Count - 1 do
      if FEstoques.Items[I].LocalEstoque.Codigo = LocalEstoque.Codigo then
        Result := FEstoques.Items[I].estoque;
end;

procedure TProduto.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TProduto.SetCaminhoFoto(const Value: String);
begin
  FCaminhoFoto := Value;
end;

procedure TProduto.SetCEST(const Value: String);
begin
  FCEST := Value;
end;

procedure TProduto.SetCfop(const Value: Integer);
begin
  FCfop := Value;
end;

procedure TProduto.SetCobrarTaxaServicoRestaurante(const Value: String);
begin
  FCobrarTaxaServicoRestaurante := Value;
end;

procedure TProduto.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TProduto.SetCodigoBarras(const Value: String);
begin
  FCodigoBarras := Value;
end;

procedure TProduto.SetControlaEstoque(const Value: Boolean);
begin
  FControlaEstoque := Value;
end;

procedure TProduto.SetCozinhaBalcao(const Value: String);
begin
  FCozinhaBalcao := Value;
end;

procedure TProduto.SetDescricaoCupom(const Value: String);
begin
  FDescricaoCupom := Value;
end;

procedure TProduto.SetEstoques(const Value: TObjectList<TEstoque>);
begin
  FEstoques := Value;
end;

procedure TProduto.SetFatorConversao(const Value: Currency);
begin
  FFatorConversao := Value;
end;

procedure TProduto.SetGrupoCofins(const Value: TGrupoCofins);
begin
  FGrupoCofins := Value;
end;

procedure TProduto.SetGrupoIcms(const Value: TGrupoIcms);
begin
  FGrupoIcms := Value;
end;

procedure TProduto.SetGrupoPis(const Value: TGrupoPis);
begin
  FGrupoPis := Value;
end;

procedure TProduto.SetIBTP(const Value: TIBTP);
begin
  FIBTP := Value;
end;

procedure TProduto.SetImpressora(const Value: TImpressora);
begin
  FImpressora := Value;
end;

procedure TProduto.SetImprimeBalcao(const Value: String);
begin
  FImprimeBalcao := Value;
end;

procedure TProduto.SetMargemLucro(const Value: Currency);
begin
  FMargemLucro := Value;
end;

procedure TProduto.SetNbs(const Value: Integer);
begin
  FNbs := Value;
end;

procedure TProduto.SetNcm(const Value: String);
begin
  FNcm := Value;
end;

procedure TProduto.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TProduto.SetPrecoCusto(const Value: Currency);
begin
  FPrecoCusto := Value;
end;

procedure TProduto.SetPrecoVista(const Value: Currency);
begin
  FPrecoVista := Value;
end;

procedure TProduto.SetPromocao(const Value: Currency);
begin
  FPromocao := Value;
end;

procedure TProduto.SetQuantidadeComposicao(const Value: Integer);
begin
  FQuantidadeComposicao := Value;
end;

procedure TProduto.SetReferencia(const Value: String);
begin
  FReferencia := Value;
end;

procedure TProduto.SetSecao(const Value: TSecao);
begin
  FSecao := Value;
end;

procedure TProduto.SetServico(const Value: Boolean);
begin
  FServico := Value;
end;

procedure TProduto.SetUnidadeMedida(const Value: TUnidadeMedida);
begin
  FUnidadeMedida := Value;
end;

end.
