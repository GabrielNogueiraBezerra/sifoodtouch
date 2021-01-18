unit uEmpresa;

interface

uses
  uEndereco, uContato, uClass;

type
{$TYPEINFO ON}
  TEmpresa = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FTipo: String;
    FRazao: String;
    FFantasia: String;
    FEndereco: TEndereco;
    FContato: TContato;
    FCnpj: String;
    FInscricaoEstadual: String;
    FInscricaoMunicipal: String;
    FTipoEmpresa: TTipoEmpresa;
    FRegimeTributadoISSQN: Integer;
    FIndiceRatISSQN: Integer;
    FChaveAcessoVFPE: String;
    FSegmento: Integer;
    FUFContMfe: String;
    procedure SetCodigo(const Value: Integer);
    procedure SetTipo(const Value: String);
    procedure SetChaveAcessoVFPE(const Value: String);
    procedure SetCnpj(const Value: String);
    procedure SetContato(const Value: TContato);
    procedure SetEndereco(const Value: TEndereco);
    procedure SetFantasia(const Value: String);
    procedure SetIndiceRatISSQN(const Value: Integer);
    procedure SetInscricaoEstadual(const Value: String);
    procedure SetInscricaoMunicipal(const Value: String);
    procedure SetRazao(const Value: String);
    procedure SetRegimeTributadoISSQN(const Value: Integer);
    procedure SetSegmento(const Value: Integer);
    procedure SetTipoEmpresa(const Value: TTipoEmpresa);
    procedure SetUFContMfe(const Value: String);

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
    property Tipo: String read FTipo write SetTipo;
    property Razao: String read FRazao write SetRazao;
    property Fantasia: String read FFantasia write SetFantasia;
    property Endereco: TEndereco read FEndereco write SetEndereco;
    property Contato: TContato read FContato write SetContato;
    property Cnpj: String read FCnpj write SetCnpj;
    property InscricaoEstadual: String read FInscricaoEstadual
      write SetInscricaoEstadual;
    property InscricaoMunicipal: String read FInscricaoMunicipal
      write SetInscricaoMunicipal;
    property TipoEmpresa: TTipoEmpresa read FTipoEmpresa write SetTipoEmpresa;
    property RegimeTributadoISSQN: Integer read FRegimeTributadoISSQN
      write SetRegimeTributadoISSQN;
    property IndiceRatISSQN: Integer read FIndiceRatISSQN
      write SetIndiceRatISSQN;
    property ChaveAcessoVFPE: String read FChaveAcessoVFPE
      write SetChaveAcessoVFPE;
    property Segmento: Integer read FSegmento write SetSegmento;
    property UFContMfe: String read FUFContMfe write SetUFContMfe;
  end;

implementation

uses
  System.SysUtils;

{ TEmpresa }

procedure TEmpresa.Clear;
begin
  FCodigo := 0;
  FTipo := '';
  FRazao := '';
  FFantasia := '';
  FreeAndNil(FEndereco);
  FreeAndNil(FEndereco);
  FreeAndNil(FContato);
  FreeAndNil(FContato);
  FCnpj := '';
  FInscricaoEstadual := '';
  FInscricaoMunicipal := '';
  FTipoEmpresa := opSimplesNacional;
  FRegimeTributadoISSQN := -1;
  FIndiceRatISSQN := -1;
  FChaveAcessoVFPE := '';
  FSegmento := -1;
  FUFContMfe := '';
end;

constructor TEmpresa.Create;
begin
  FEndereco := TEndereco.Create;
  FContato := TContato.Create;
end;

destructor TEmpresa.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TEmpresa.SetChaveAcessoVFPE(const Value: String);
begin
  FChaveAcessoVFPE := Value;
end;

procedure TEmpresa.SetCnpj(const Value: String);
begin
  FCnpj := Value;
end;

procedure TEmpresa.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TEmpresa.SetContato(const Value: TContato);
begin
  FContato := Value;
end;

procedure TEmpresa.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TEmpresa.SetFantasia(const Value: String);
begin
  FFantasia := Value;
end;

procedure TEmpresa.SetIndiceRatISSQN(const Value: Integer);
begin
  FIndiceRatISSQN := Value;
end;

procedure TEmpresa.SetInscricaoEstadual(const Value: String);
begin
  FInscricaoEstadual := Value;
end;

procedure TEmpresa.SetInscricaoMunicipal(const Value: String);
begin
  FInscricaoMunicipal := Value;
end;

procedure TEmpresa.SetRazao(const Value: String);
begin
  FRazao := Value;
end;

procedure TEmpresa.SetRegimeTributadoISSQN(const Value: Integer);
begin
  FRegimeTributadoISSQN := Value;
end;

procedure TEmpresa.SetSegmento(const Value: Integer);
begin
  FSegmento := Value;
end;

procedure TEmpresa.SetTipo(const Value: String);
begin
  FTipo := Value;
end;

procedure TEmpresa.SetTipoEmpresa(const Value: TTipoEmpresa);
begin
  FTipoEmpresa := Value;
end;

procedure TEmpresa.SetUFContMfe(const Value: String);
begin
  FUFContMfe := Value;
end;

end.
