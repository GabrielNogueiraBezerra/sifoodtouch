unit uCaixa;

interface

uses
  uEmpresa, uClass;

type
{$TYPEINFO ON}
  TCaixa = class(TObject)
  private
    { private declarations }
    FCodigo: Integer;
    FEmpresa: TEmpresa;
    FTipoCaixa: TTipoCaixa;
    FNumeroCaixa: Integer;
    FAmbienteSAT: TTipoAmbienteSAT;
    FCodigoAtivacaoSat: String;
    FNumeroCaixaSat: Integer;
    FVersaoSat: String;
    FAssinaturaSWHouseSat: String;
    FIndiceGaveta: Integer;
    FTefCaixa: String;
    FIpServidorTef: String;
    FCodigoLojaTef: String;
    FCodigoTerminalTef: String;
    FVelocidade: Integer;
    FGp: Integer;
    FIndiceCnfCelular: String;
    FSinalInvertidoGaveta: String;
    FIndiceBalanca: Integer;
    FPortaBalanca: Integer;
    FBaudBalanca: Integer;
    FCaminhoInputMfe: String;
    FCaminhoOutputMfe: String;
    FComunicaIntegracaoCaixa: Boolean;
    FUsaIntegradorNfce: String;
    FR01CnpjUsuario: String;
    FR01IeUsuario: String;
    FDescricaoCaixa: String;
    FLinha2: String;
    FLinha3: String;
    FLinha1: String;
    FPastaInputMFE: String;
    FPastaOutputMFe: String;
    procedure SetCodigo(const Value: Integer);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetAmbienteSAT(const Value: TTipoAmbienteSAT);
    procedure SetAssinaturaSWHouseSat(const Value: String);
    procedure SetCodigoAtivacaoSat(const Value: String);
    procedure SetIndiceGaveta(const Value: Integer);
    procedure SetIpServidorTef(const Value: String);
    procedure SetNumeroCaixa(const Value: Integer);
    procedure SetNumeroCaixaSat(const Value: Integer);
    procedure SetTefCaixa(const Value: String);
    procedure SetTipoCaixa(const Value: TTipoCaixa);
    procedure SetVersaoSat(const Value: String);
    procedure SetBaudBalanca(const Value: Integer);
    procedure SetCaminhoInputMfe(const Value: String);
    procedure SetCaminhoOutputMfe(const Value: String);
    procedure SetCodigoLojaTef(const Value: String);
    procedure SetCodigoTerminalTef(const Value: String);
    procedure SetComunicaIntegracaoCaixa(const Value: Boolean);
    procedure SetGp(const Value: Integer);
    procedure SetIndiceBalanca(const Value: Integer);
    procedure SetIndiceCnfCelular(const Value: String);
    procedure SetPortaBalanca(const Value: Integer);
    procedure SetR01CnpjUsuario(const Value: String);
    procedure SetR01IeUsuario(const Value: String);
    procedure SetSinalInvertidoGaveta(const Value: String);
    procedure SetUsaIntegradorNfce(const Value: String);
    procedure SetVelocidade(const Value: Integer);
    procedure SetDescricaoCaixa(const Value: String);
    procedure SetLinha1(const Value: String);
    procedure SetLinha2(const Value: String);
    procedure SetLinha3(const Value: String);
    procedure SetPastaInputMFE(const Value: String);
    procedure SetPastaOutputMFE(const Value: String);

  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property TipoCaixa: TTipoCaixa read FTipoCaixa write SetTipoCaixa;
    property NumeroCaixa: Integer read FNumeroCaixa write SetNumeroCaixa;
    property AmbienteSat: TTipoAmbienteSAT read FAmbienteSAT
      write SetAmbienteSAT;
    property CodigoAtivacaoSat: String read FCodigoAtivacaoSat
      write SetCodigoAtivacaoSat;
    property NumeroCaixaSat: Integer read FNumeroCaixaSat
      write SetNumeroCaixaSat;
    property VersaoSat: String read FVersaoSat write SetVersaoSat;
    property AssinaturaSWHouseSat: String read FAssinaturaSWHouseSat
      write SetAssinaturaSWHouseSat;
    property IndiceGaveta: Integer read FIndiceGaveta write SetIndiceGaveta;
    property TefCaixa: String read FTefCaixa write SetTefCaixa;
    property IpServidorTef: String read FIpServidorTef write SetIpServidorTef;
    property CodigoLojaTef: String read FCodigoLojaTef write SetCodigoLojaTef;
    property CodigoTerminalTef: String read FCodigoTerminalTef
      write SetCodigoTerminalTef;
    property Velocidade: Integer read FVelocidade write SetVelocidade;
    property Gp: Integer read FGp write SetGp;
    property IndiceCnfCelular: String read FIndiceCnfCelular
      write SetIndiceCnfCelular;
    property SinalInvertidoGaveta: String read FSinalInvertidoGaveta
      write SetSinalInvertidoGaveta;
    property IndiceBalanca: Integer read FIndiceBalanca write SetIndiceBalanca;
    property PortaBalanca: Integer read FPortaBalanca write SetPortaBalanca;
    property BaudBalanca: Integer read FBaudBalanca write SetBaudBalanca;
    property CaminhoInputMfe: String read FCaminhoInputMfe
      write SetCaminhoInputMfe;
    property CaminhoOutputMfe: String read FCaminhoOutputMfe
      write SetCaminhoOutputMfe;
    property ComunicaIntegracaoCaixa: Boolean read FComunicaIntegracaoCaixa
      write SetComunicaIntegracaoCaixa;
    property UsaIntegradorNfce: String read FUsaIntegradorNfce
      write SetUsaIntegradorNfce;
    property R01CnpjUsuario: String read FR01CnpjUsuario
      write SetR01CnpjUsuario;
    property R01IeUsuario: String read FR01IeUsuario write SetR01IeUsuario;
    property DescricaoCaixa: String read FDescricaoCaixa
      write SetDescricaoCaixa;
    property Linha1: String read FLinha1 write SetLinha1;
    property Linha2: String read FLinha2 write SetLinha2;
    property Linha3: String read FLinha3 write SetLinha3;
    property PastaInputMFE: String read FPastaInputMFE write SetPastaInputMFE;
    property PastaOutputMFE: String read FPastaOutputMFe
      write SetPastaOutputMFE;
  end;

implementation

uses
  System.SysUtils;

{ TCaixa }

procedure TCaixa.Clear;
begin
  FCodigo := 0;
  FEmpresa.Clear;
  FreeAndNil(FEmpresa);
  FTipoCaixa := opNaoFiscal;
  FNumeroCaixa := -1;
  FAmbienteSAT := opProducao;
  FCodigoAtivacaoSat := '';
  FNumeroCaixaSat := -1;
  FVersaoSat := '';
  FAssinaturaSWHouseSat := '';
  FIndiceGaveta := -1;
  FTefCaixa := '';
  FIpServidorTef := '';
  FCodigoLojaTef := '';
  FCodigoTerminalTef := '';
  FVelocidade := -1;
  FGp := -1;
  FIndiceCnfCelular := '';
  FSinalInvertidoGaveta := '';
  FIndiceBalanca := -1;
  FPortaBalanca := -1;
  FBaudBalanca := -1;
  FCaminhoInputMfe := '';
  FCaminhoOutputMfe := '';
  FComunicaIntegracaoCaixa := false;
  FUsaIntegradorNfce := '';
  FR01CnpjUsuario := '';
  FR01IeUsuario := '';
  FLinha1 := '';
  FLinha2 := '';
  FLinha3 := '';
  FPastaInputMFE := '';
  FPastaOutputMFe := '';
end;

constructor TCaixa.Create;
begin
  FEmpresa := TEmpresa.Create;
end;

destructor TCaixa.Destroy;
begin
  inherited;
  self.Clear;
end;

procedure TCaixa.SetAmbienteSAT(const Value: TTipoAmbienteSAT);
begin
  FAmbienteSAT := Value;
end;

procedure TCaixa.SetAssinaturaSWHouseSat(const Value: String);
begin
  FAssinaturaSWHouseSat := Value;
end;

procedure TCaixa.SetBaudBalanca(const Value: Integer);
begin
  FBaudBalanca := Value;
end;

procedure TCaixa.SetCaminhoInputMfe(const Value: String);
begin
  FCaminhoInputMfe := Value;
end;

procedure TCaixa.SetCaminhoOutputMfe(const Value: String);
begin
  FCaminhoOutputMfe := Value;
end;

procedure TCaixa.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TCaixa.SetCodigoAtivacaoSat(const Value: String);
begin
  FCodigoAtivacaoSat := Value;
end;

procedure TCaixa.SetCodigoLojaTef(const Value: String);
begin
  FCodigoLojaTef := Value;
end;

procedure TCaixa.SetCodigoTerminalTef(const Value: String);
begin
  FCodigoTerminalTef := Value;
end;

procedure TCaixa.SetComunicaIntegracaoCaixa(const Value: Boolean);
begin
  FComunicaIntegracaoCaixa := Value;
end;

procedure TCaixa.SetDescricaoCaixa(const Value: String);
begin
  FDescricaoCaixa := Value;
end;

procedure TCaixa.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TCaixa.SetGp(const Value: Integer);
begin
  FGp := Value;
end;

procedure TCaixa.SetIndiceBalanca(const Value: Integer);
begin
  FIndiceBalanca := Value;
end;

procedure TCaixa.SetIndiceCnfCelular(const Value: String);
begin
  FIndiceCnfCelular := Value;
end;

procedure TCaixa.SetIndiceGaveta(const Value: Integer);
begin
  FIndiceGaveta := Value;
end;

procedure TCaixa.SetIpServidorTef(const Value: String);
begin
  FIpServidorTef := Value;
end;

procedure TCaixa.SetLinha1(const Value: String);
begin
  FLinha1 := Value;
end;

procedure TCaixa.SetLinha2(const Value: String);
begin
  FLinha2 := Value;
end;

procedure TCaixa.SetLinha3(const Value: String);
begin
  FLinha3 := Value;
end;

procedure TCaixa.SetNumeroCaixa(const Value: Integer);
begin
  FNumeroCaixa := Value;
end;

procedure TCaixa.SetNumeroCaixaSat(const Value: Integer);
begin
  FNumeroCaixaSat := Value;
end;

procedure TCaixa.SetPastaInputMFE(const Value: String);
begin
  FPastaInputMFE := Value;
end;

procedure TCaixa.SetPastaOutputMFE(const Value: String);
begin
  FPastaOutputMFe := Value;
end;

procedure TCaixa.SetPortaBalanca(const Value: Integer);
begin
  FPortaBalanca := Value;
end;

procedure TCaixa.SetR01CnpjUsuario(const Value: String);
begin
  FR01CnpjUsuario := Value;
end;

procedure TCaixa.SetR01IeUsuario(const Value: String);
begin
  FR01IeUsuario := Value;
end;

procedure TCaixa.SetSinalInvertidoGaveta(const Value: String);
begin
  FSinalInvertidoGaveta := Value;
end;

procedure TCaixa.SetTefCaixa(const Value: String);
begin
  FTefCaixa := Value;
end;

procedure TCaixa.SetTipoCaixa(const Value: TTipoCaixa);
begin
  FTipoCaixa := Value;
end;

procedure TCaixa.SetUsaIntegradorNfce(const Value: String);
begin
  FUsaIntegradorNfce := Value;
end;

procedure TCaixa.SetVelocidade(const Value: Integer);
begin
  FVelocidade := Value;
end;

procedure TCaixa.SetVersaoSat(const Value: String);
begin
  FVersaoSat := Value;
end;

end.
