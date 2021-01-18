unit uTipoVenda;

interface

type
{$TYPEINFO ON}
  TTipoVenda = class(TObject)
  private
    FPercentualEntrada: Currency;
    FCodigo: Integer;
    FPossuiEntrada: Boolean;
    FGeraCarne: Boolean;
    FParcelas: Integer;
    FDiasPrimeiraParcela: Integer;
    FDiasEntreParcelas: Integer;
    FNome: String;
    FCodigoClassificacao: Integer;
    FAVista: Boolean;
    procedure SetCodigo(const Value: Integer);
    procedure SetDiasEntreParcelas(const Value: Integer);
    procedure SetDiasPrimeirasParcela(const Value: Integer);
    procedure SetGeraCarne(const Value: Boolean);
    procedure SetNome(const Value: String);
    procedure SetParcelas(const Value: Integer);
    procedure SetPercentualEntrada(const Value: Currency);
    procedure SetPossuiEntrada(const Value: Boolean);
    procedure SetCodigoClassificacao(const Value: Integer);
    procedure SetAVista(const Value: Boolean);
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
    property Nome: String read FNome write SetNome;
    property Parcelas: Integer read FParcelas write SetParcelas;
    property DiasPrimeiraParcela: Integer read FDiasPrimeiraParcela
      write SetDiasPrimeirasParcela;
    property DiasEntreParcelas: Integer read FDiasEntreParcelas
      write SetDiasEntreParcelas;
    property PossuiEntrada: Boolean read FPossuiEntrada write SetPossuiEntrada;
    property GeraCarne: Boolean read FGeraCarne write SetGeraCarne;
    property PercentualEntrada: Currency read FPercentualEntrada
      write SetPercentualEntrada;
    property CodigoClassificacao: Integer read FCodigoClassificacao
      write SetCodigoClassificacao;
    property AVista: Boolean read FAVista write SetAVista;
  end;

implementation

{ TTipoVenda }

procedure TTipoVenda.Clear;
begin
  FCodigo := 0;
  FPossuiEntrada := False;
  FGeraCarne := False;
  FParcelas := 0;
  FDiasPrimeiraParcela := 0;
  FDiasEntreParcelas := 0;
  FNome := '';
  FCodigoClassificacao := 0;
  FAVista := False;
end;

constructor TTipoVenda.Create;
begin
  Clear;
end;

destructor TTipoVenda.Destroy;
begin
  inherited;
  Clear;
end;

procedure TTipoVenda.SetAVista(const Value: Boolean);
begin
  FAVista := Value;
end;

procedure TTipoVenda.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TTipoVenda.SetCodigoClassificacao(const Value: Integer);
begin
  FCodigoClassificacao := Value;
end;

procedure TTipoVenda.SetDiasEntreParcelas(const Value: Integer);
begin
  FDiasEntreParcelas := Value;
end;

procedure TTipoVenda.SetDiasPrimeirasParcela(const Value: Integer);
begin
  FDiasPrimeiraParcela := Value;
end;

procedure TTipoVenda.SetGeraCarne(const Value: Boolean);
begin
  FGeraCarne := Value;
end;

procedure TTipoVenda.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TTipoVenda.SetParcelas(const Value: Integer);
begin
  FParcelas := Value;
end;

procedure TTipoVenda.SetPercentualEntrada(const Value: Currency);
begin
  FPercentualEntrada := Value;
end;

procedure TTipoVenda.SetPossuiEntrada(const Value: Boolean);
begin
  FPossuiEntrada := Value;
end;

end.
