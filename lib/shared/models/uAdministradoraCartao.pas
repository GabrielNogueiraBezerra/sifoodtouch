unit uAdministradoraCartao;

interface

uses
  System.Generics.Collections, uBandeiraCartao;

type
{$TYPEINFO ON}
  TAdministradoraCartao = class(TObject)
  private
    FCodigoTef: String;
    FCnpj: String;
    FDescricao: String;
    FCodigo: Integer;
    FChaveRequisicaoVFPE: String;
    FBandeirasCartao: TObjectList<TBandeiraCartao>;
    procedure SetChaveRequisicaoVFPE(const Value: String);
    procedure SetCnpj(const Value: String);
    procedure SetCodigo(const Value: Integer);
    procedure SetCodigoTef(const Value: String);
    procedure SetDescricao(const Value: String);
    procedure SetBandeirasCartao(const Value: TObjectList<TBandeiraCartao>);
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
    property Descricao: String read FDescricao write SetDescricao;
    property CodigoTef: String read FCodigoTef write SetCodigoTef;
    property ChaveRequisicaoVFPE: String read FChaveRequisicaoVFPE
      write SetChaveRequisicaoVFPE;
    property Cnpj: String read FCnpj write SetCnpj;
    property BandeirasCartao: TObjectList<TBandeiraCartao> read FBandeirasCartao
      write SetBandeirasCartao;

  end;

implementation

uses
  System.SysUtils;

{ TAdministradoraCartao }

procedure TAdministradoraCartao.Clear;
begin
  FCodigo := 0;
  FDescricao := '';
  FCnpj := '';
  FChaveRequisicaoVFPE := '';
  FCodigoTef := '';
  FreeAndNil(FBandeirasCartao);
end;

constructor TAdministradoraCartao.Create;
begin
  Clear;
  FBandeirasCartao := TObjectList<TBandeiraCartao>.Create;
end;

destructor TAdministradoraCartao.Destroy;
begin
  inherited;
  Clear;
end;

procedure TAdministradoraCartao.SetBandeirasCartao
  (const Value: TObjectList<TBandeiraCartao>);
begin
  FBandeirasCartao := Value;
end;

procedure TAdministradoraCartao.SetChaveRequisicaoVFPE(const Value: String);
begin
  FChaveRequisicaoVFPE := Value;
end;

procedure TAdministradoraCartao.SetCnpj(const Value: String);
begin
  FCnpj := Value;
end;

procedure TAdministradoraCartao.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TAdministradoraCartao.SetCodigoTef(const Value: String);
begin
  FCodigoTef := Value;
end;

procedure TAdministradoraCartao.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
