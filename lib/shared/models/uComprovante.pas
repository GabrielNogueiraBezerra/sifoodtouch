unit uComprovante;

interface

uses
  System.SysUtils, System.Classes, StrUtils, Vcl.Forms,
  ACBrPosPrinter, uDmConexao;

type
{$TYPEINFO ON}
  TComprovante = class(TObject)
  private
    { private declarations }

    { Atributos }
    FComprovante: TStringList;
    FTitulo: String;
    FNumeroColunas: Integer;
    FImpressora: String;
    FAssinatura: String;
    FCabecalho: Boolean;
    FTipoTitulo: String;
    FUsaTitulo: Boolean;

    { Procedures }
    procedure dadosEmpresa;
    procedure configuraImpressora(const configuraManual: Boolean = false;
      const Modelo: String = ''; const PaginaCodigo: String = '';
      const Porta: String = ''; const ParamString: String = '';
      const Colunas: String = ''; const EspacoEntreLinhas: String = '';
      const ControlePorta: Boolean = false;
      const CortaPapel: Boolean = false); overload;
    procedure linhaOperadorCaixa;
    procedure setNumeroColunas(const Value: Integer);
    procedure setImpressora(const Value: String);
    procedure setTitulo(const Value: String);
    procedure setAssinatura(const Value: String);
    procedure setCabecalho(const Value: Boolean);
    procedure tituloCabecalho;
    procedure setTipoTitulo(const Value: String);
    procedure setUsaTitulo(const Value: Boolean);

    { Funções }
    function corteTotal: String;
    function numeroColunasT(TipoLetra: String): Integer;
    function tipoFonteTextoComprovante(Texto, TipoFonte: String): String;
    function alinhamentoTextoComprovante(Texto, TipoAlinhamento
      : String): String;
    function Alinhamento(iTamanhoRestoDesc, iColunas: Integer): Integer;
    function Space(Tamanho: Integer): string;

  protected
    { protected declarations }

  public
    { public declarations }
    { Construtor }
    constructor Create; reintroduce;
    { Destrutor }
    destructor Destroy; override;
    { Procedures }
    procedure Clear;
    procedure linhaAssinatura;
    procedure linha;
    procedure abreComprovante(const configuraManual: Boolean = false;
      const Modelo: String = ''; const PaginaCodigo: String = '';
      const Porta: String = ''; const ParamString: String = '';
      const Colunas: String = ''; const EspacoEntreLinhas: String = '';
      const ControlePorta: Boolean = false; const CortaPapel: Boolean = false);
    procedure imprimeTextoComprovante(Texto: String;
      const Alinhamento: String = 'E'; const quebraLinhaTexto: Boolean = false;
      const TipoFonte: String = 'N');
    procedure imprimeTextoComprovanteValor(Texto: String; Valor: String;
      TipoLetra: String = 'N'; CortaTexto: Boolean = false);
    procedure imprimeTextoComprovanteEspaco(PrimeiroTexto: String;
      SegundoTexto: String);
    procedure imprimeTextoComprovanteCentroDireita(Texto: String; Valor: String;
      const TipoLetra: String = 'N');
    procedure fechaComprovante(const assinatura: Boolean = false;
      const operadorCaixa: Boolean = false; const totalAvancoPapel: Integer = 1;
      const imprimeComprovante: Boolean = true);
    procedure linhaCompleta;
    procedure avancoManual(iTotalLinhas: Integer);
    procedure imprimeTextoTitulo(titulo: String);
    procedure imprimeTextoNegrito(Texto: String;
      const Alinhamento: String = 'E');

    { Funcions }
    function centerText(Texto: String): String;
    function leftText(Texto: String): String;
    function rightText(Texto: String): String;
    function boldText(Texto: String): String;
    function expandedText(Texto: String): String;
    function fontBText(Texto: String): String;
    function condensedText(Texto: String): String;
    function linhaSimples: String;
    function linhaDupla: String;
    function linhaPontilhada: String;
    class function FormataStringD(Valor, Tamanho, Complemento: string): string;
    class function FormataStringE(Valor, Tamanho, Complemento: string): string;

  published
    { published declarations }
    property NumeroColunas: Integer read FNumeroColunas write setNumeroColunas;
    property titulo: String read FTitulo write setTitulo;
    property Impressora: String read FImpressora write setImpressora;
    property assinatura: String read FAssinatura write setAssinatura;
    property cabecalho: Boolean read FCabecalho write setCabecalho;
    property tipoTitulo: String read FTipoTitulo write setTipoTitulo;
    property usaTitulo: Boolean read FUsaTitulo write setUsaTitulo;
  end;

implementation

{ TComprovante }

procedure TComprovante.abreComprovante(const configuraManual: Boolean;
  const Modelo: String; const PaginaCodigo: String; const Porta: String;
  const ParamString: String; const Colunas: String;
  const EspacoEntreLinhas: String; const ControlePorta: Boolean;
  const CortaPapel: Boolean);
begin
  configuraImpressora(configuraManual, Modelo, PaginaCodigo, Porta, ParamString,
    Colunas, EspacoEntreLinhas, ControlePorta, CortaPapel);

  if FCabecalho then
    dadosEmpresa;

  if FUsaTitulo then
    tituloCabecalho;
end;

procedure TComprovante.linha;
begin
  FComprovante.add(' ');
end;

procedure TComprovante.linhaAssinatura;
var
  I: Integer;
  sAssinatura: String;
begin
  sAssinatura := '';
  avancoManual(2);

  for I := 0 to (FNumeroColunas) do
  begin
    sAssinatura := sAssinatura + '_';
  end;

  if FNumeroColunas < 40 then
  begin
    FComprovante.add(leftText(fontBText(sAssinatura)));
    FComprovante.add('     ' + leftText(fontBText(FAssinatura)));
  end
  else
  begin
    FComprovante.add(centerText(fontBText(sAssinatura)));
    FComprovante.add(centerText(fontBText(FAssinatura)));
  end;
end;

procedure TComprovante.linhaCompleta;
var
  linha: String;
  I: Integer;
begin
  for I := 0 to (FNumeroColunas) do
  begin
    linha := linha + '_';
  end;

  FComprovante.add(linha);
end;

function TComprovante.Alinhamento(iTamanhoRestoDesc, iColunas: Integer)
  : Integer;
begin
  if iColunas > iTamanhoRestoDesc then
    Result := iColunas - iTamanhoRestoDesc
  else
    Result := iTamanhoRestoDesc - iColunas;
end;

function TComprovante.alinhamentoTextoComprovante(Texto, TipoAlinhamento
  : String): String;
begin
  Texto := Trim(Texto);
  case AnsiIndexStr(TipoAlinhamento, ['E', 'D', 'C']) of
    0, -1:
      Result := leftText(Texto);
    1:
      Result := rightText(Texto);
    2:
      Result := centerText(Texto);
  end;
end;

procedure TComprovante.avancoManual(iTotalLinhas: Integer);
var
  I: Integer;
begin
  for I := 0 to iTotalLinhas do
  begin
    FComprovante.add(' ');
  end;
end;

function TComprovante.boldText(Texto: String): String;
begin
  Result := '<n>' + Texto + '</n>';
end;

function TComprovante.centerText(Texto: String): String;
begin
  Result := '</ce>' + Texto + '</ae>';
end;

procedure TComprovante.Clear;
begin
  FreeAndNil(FComprovante);
  FTitulo := '';
  FNumeroColunas := 0;
end;

function TComprovante.condensedText(Texto: String): String;
begin
  Result := '<c>' + Texto + '</c></ae>';
end;

procedure TComprovante.configuraImpressora(const configuraManual: Boolean;
  const Modelo: String; const PaginaCodigo: String; const Porta: String;
  const ParamString: String; const Colunas: String;
  const EspacoEntreLinhas: String; const ControlePorta: Boolean;
  const CortaPapel: Boolean);
begin
  { Configura Impressora }
  DMConexao.FAcbrPosPrinter.Desativar;
  if configuraManual then
  begin
    if Modelo <> '' then
      DMConexao.FAcbrPosPrinter.Modelo :=
        TACBrPosPrinterModelo(strtoint(Modelo));

    if PaginaCodigo <> '' then
      DMConexao.FAcbrPosPrinter.PaginaDeCodigo :=
        TACBrPosPaginaCodigo(strtoint(PaginaCodigo));

    if Porta <> '' then
      DMConexao.FAcbrPosPrinter.Porta := Porta;

    if ParamString <> '' then
      DMConexao.FAcbrPosPrinter.Device.ParamsString := ParamString;

    if Colunas <> '' then
      DMConexao.FAcbrPosPrinter.ColunasFonteNormal := strtoint(Colunas);

    FNumeroColunas := strtoint(Colunas);

    if EspacoEntreLinhas <> '' then
      DMConexao.FAcbrPosPrinter.EspacoEntreLinhas :=
        strtoint(EspacoEntreLinhas);

    if ControlePorta then
      DMConexao.FAcbrPosPrinter.ControlePorta := true
    else
      DMConexao.FAcbrPosPrinter.ControlePorta := false;

    if CortaPapel then
      DMConexao.FAcbrPosPrinter.CortaPapel := true
    else
      DMConexao.FAcbrPosPrinter.CortaPapel := false;
  end
  else
  begin
    DMConexao.FAcbrPosPrinter.Desativar;
    DMConexao.FAcbrPosPrinter.Modelo :=
      TACBrPosPrinterModelo(strtoint(DMConexao.Configuracao.LeIni('Impressora' +
      FImpressora, 'Modelo')));
    DMConexao.FAcbrPosPrinter.PaginaDeCodigo :=
      TACBrPosPaginaCodigo(strtoint(DMConexao.Configuracao.LeIni('Impressora' +
      FImpressora, 'PaginaDeCodigo')));
    DMConexao.FAcbrPosPrinter.Porta :=
      Trim(DMConexao.Configuracao.LeIni('Impressora' + FImpressora, 'Porta'));

    DMConexao.FAcbrPosPrinter.Device.ParamsString :=
      DMConexao.Descriptografa(DMConexao.Configuracao.LeIni('Impressora' +
      FImpressora, 'ParamsString'));

    DMConexao.FAcbrPosPrinter.ColunasFonteNormal :=
      strtoint(DMConexao.Configuracao.LeIni('Impressora' + FImpressora,
      'Colunas'));

    DMConexao.FAcbrPosPrinter.EspacoEntreLinhas :=
      strtoint(DMConexao.Configuracao.LeIni('Impressora' + FImpressora,
      'EspacoEntreLinhas'));
    DMConexao.FAcbrPosPrinter.ControlePorta :=
      Trim(DMConexao.Configuracao.LeIni('Impressora' + FImpressora,
      'ControlePorta')) = '1';
    DMConexao.FAcbrPosPrinter.CortaPapel :=
      Trim(DMConexao.Configuracao.LeIni('Impressora' + FImpressora,
      'CortarPapel')) = '1';
  end;

  if not DMConexao.FAcbrPosPrinter.Ativo then
    DMConexao.FAcbrPosPrinter.Ativar;
end;

function TComprovante.corteTotal: String;
begin
  Result := '</corte_total>';
end;

constructor TComprovante.Create;
begin
  FComprovante := TStringList.Create;
  FImpressora := 'PADRAO';
  FAssinatura := 'ASSINATURA';
  FTitulo := 'RECIBO';
  FCabecalho := true;
  FTipoTitulo := 'P';
  FUsaTitulo := true;

  FNumeroColunas :=
    strtoint(DMConexao.RemoveChar(Trim(DMConexao.Configuracao.LeIni('Impressora'
    + FImpressora, 'Colunas'))));
end;

procedure TComprovante.dadosEmpresa;
var
  sRazaoEmp, sEndNumBaiEmp, sCepCidEstEmp, sCNPJEmp, sIEEmp: string;
  sNumComp, sTelEmp: string;
begin

  { dados da empresa }

  sRazaoEmp := copy(DMConexao.Empresa.Razao.Trim, 1, 64);
  sEndNumBaiEmp := copy(DMConexao.Empresa.Endereco.Endereco.Trim + ', ' +
    DMConexao.Empresa.Endereco.Numero.Trim + ', ' +
    DMConexao.Empresa.Endereco.Bairro.Trim, 1, 64);
  sCepCidEstEmp := copy(DMConexao.Empresa.Endereco.Cep.Trim + ' - ' +
    DMConexao.Empresa.Endereco.Cidade.Descricao.Trim + ' - ' +
    DMConexao.Empresa.Endereco.Cidade.UF.Trim, 1, 64);

  if DMConexao.Empresa.Tipo.Trim = 'F' then
    sCNPJEmp := 'CNPJ: ' + copy(DMConexao.Empresa.Cnpj.Trim, 1, 3) + '.' +
      copy(DMConexao.Empresa.Cnpj.Trim, 4, 3) + '.' +
      copy(DMConexao.Empresa.Cnpj.Trim, 7, 3) + '-' +
      copy(DMConexao.Empresa.Cnpj.Trim, 10, 2)
  else
    sCNPJEmp := copy(DMConexao.Empresa.Cnpj.Trim, 1, 2) + '.' +
      copy(DMConexao.Empresa.Cnpj.Trim, 3, 3) + '.' +
      copy(DMConexao.Empresa.Cnpj.Trim, 6, 3) + '/' +
      copy(DMConexao.Empresa.Cnpj.Trim, 9, 4) + '-' +
      copy(DMConexao.Empresa.Cnpj.Trim, 13, 2);

  sIEEmp := 'IE: ' + DMConexao.Empresa.InscricaoEstadual.Trim;

  sTelEmp := 'TEL.: ' + DMConexao.Empresa.Contato.Telefone.Trim;

  if FNumeroColunas < 40 then
  begin
    FComprovante.add(leftText(copy(sRazaoEmp, 1, FNumeroColunas)));
    FComprovante.add(leftText(copy(sTelEmp, 1, FNumeroColunas)));
    FComprovante.add(leftText(copy(sEndNumBaiEmp, 1, FNumeroColunas)));
    FComprovante.add(leftText(copy(sCepCidEstEmp, 1, FNumeroColunas)));
    FComprovante.add(leftText(copy(sCNPJEmp + '  ' + sIEEmp, 1,
      FNumeroColunas)));
    FComprovante.add(linhaSimples);
    FComprovante.add(leftText(fontBText('Emissao: ' + DateToStr(date) + '  ' +
      timetostr(time))));
    FComprovante.add(linhaSimples);
  end
  else
  begin
    FComprovante.add(centerText(copy(sRazaoEmp, 1, FNumeroColunas)));
    FComprovante.add(centerText(copy(sTelEmp, 1, FNumeroColunas)));
    FComprovante.add(centerText(copy(sEndNumBaiEmp, 1, FNumeroColunas)));
    FComprovante.add(centerText(copy(sCepCidEstEmp, 1, FNumeroColunas)));
    FComprovante.add(centerText(copy(sCNPJEmp + '  ' + sIEEmp, 1,
      FNumeroColunas)));
    FComprovante.add(linhaSimples);
    FComprovante.add(leftText(fontBText('Emissao: ' + DateToStr(date) + '  ' +
      timetostr(time))));
    FComprovante.add(linhaSimples);
  end;
end;

destructor TComprovante.Destroy;
begin
  Self.Clear;
  inherited;
end;

function TComprovante.expandedText(Texto: String): String;
begin
  Result := '<e>' + Texto + '</e>';
end;

procedure TComprovante.fechaComprovante(const assinatura,
  operadorCaixa: Boolean; const totalAvancoPapel: Integer;
  const imprimeComprovante: Boolean);
begin
  if assinatura then
    linhaAssinatura;

  if operadorCaixa then
    linhaOperadorCaixa;

  avancoManual(totalAvancoPapel);

  if DMConexao.Configuracao.AcionarGuilhotina then
    FComprovante.add(corteTotal);

  if imprimeComprovante then
    DMConexao.FAcbrPosPrinter.Imprimir(FComprovante.Text);

  FreeAndNil(FComprovante);
  DMConexao.FAcbrPosPrinter.Desativar;
end;

function TComprovante.fontBText(Texto: String): String;
begin
  Result := '</fb>' + Texto + '</fn>';
end;

class function TComprovante.FormataStringD(Valor, Tamanho,
  Complemento: string): string;
var
  X, Y: Integer;
begin
  Y := Length(Valor);
  for X := Y to strtoint(Tamanho) do
  begin
    if (X <> strtoint(Tamanho)) then
      Valor := Complemento + Valor
    else
      Valor := '' + Valor;
  end;
  Result := Valor;
end;

class function TComprovante.FormataStringE(Valor, Tamanho,
  Complemento: string): string;
var
  X, Y: Integer;
begin
  Y := Length(Valor);
  for X := Y to strtoint(Tamanho) do
  begin
    if (X <> strtoint(Tamanho)) then
      Valor := Valor + Complemento
    else
      Valor := Valor + '';
  end;
  Result := Valor;
end;

procedure TComprovante.imprimeTextoComprovante(Texto: String;
  const Alinhamento: String; const quebraLinhaTexto: Boolean;
  const TipoFonte: String);
var
  iTotalCaracteres, iNumeroCaracteres: Integer;
begin
  if quebraLinhaTexto then
  begin
    iTotalCaracteres := Length(Trim(Texto));
    iNumeroCaracteres := 1;

    while iTotalCaracteres > 0 do
    begin
      FComprovante.add(tipoFonteTextoComprovante(alinhamentoTextoComprovante
        (copy(Texto, iNumeroCaracteres, numeroColunasT(TipoFonte)),
        Alinhamento), TipoFonte));

      iTotalCaracteres := iTotalCaracteres - numeroColunasT(TipoFonte);
      iNumeroCaracteres := iNumeroCaracteres + numeroColunasT(TipoFonte);
      Application.ProcessMessages;
    end;

  end
  else
  begin

    if pos('<n>', Texto) > 0 then
    begin
      Texto := stringreplace(Texto, '<n>', '', [rfReplaceAll, rfIgnoreCase]);
      Texto := stringreplace(Texto, '</n>', '', [rfReplaceAll, rfIgnoreCase]);
      Texto := copy(Trim(Texto), 1, numeroColunasT(TipoFonte));
      Texto := boldText(Texto);
    end
    else
      Texto := copy(Trim(Texto), 1, numeroColunasT(TipoFonte));

    FComprovante.add(tipoFonteTextoComprovante(alinhamentoTextoComprovante
      (Texto, Alinhamento), TipoFonte));
  end;
end;

procedure TComprovante.imprimeTextoComprovanteCentroDireita(Texto,
  Valor: String; const TipoLetra: String);
var
  TamanhoResto, I: Integer;
  sColunas, sColunasResto: String;
begin
  sColunas := '';

  for I := 0 to (numeroColunasT(TipoLetra) div 3) + 3 do
    sColunas := sColunas + ' ';

  sColunasResto := '';

  for I := 0 to (numeroColunasT(TipoLetra) - (Length(sColunas) + Length(Texto) +
    Length(Valor))) - 1 do
    sColunasResto := sColunasResto + ' ';

  Texto := boldText(Trim(tipoFonteTextoComprovante(Texto, TipoLetra)));
  Valor := boldText(Trim(tipoFonteTextoComprovante(Valor, TipoLetra)));

  FComprovante.add(sColunas + Texto + sColunasResto + Valor);
end;

procedure TComprovante.imprimeTextoComprovanteEspaco(PrimeiroTexto,
  SegundoTexto: String);
var
  iTamanhoEspaco: Integer;
begin
  iTamanhoEspaco := Alinhamento(Length(PrimeiroTexto) + Length(SegundoTexto),
    FNumeroColunas);

  FComprovante.add(PrimeiroTexto + Space(iTamanhoEspaco) + SegundoTexto);
end;

procedure TComprovante.imprimeTextoComprovanteValor(Texto: String;
  Valor: String; TipoLetra: String; CortaTexto: Boolean);
var
  TamanhoResto: Integer;
  iTotalCaracteres, iNumeroCaracteres: Integer;
begin

  if CortaTexto then
  begin
    Texto := Trim(Texto);
    iTotalCaracteres := Length(Texto) + Length(Valor);

    iNumeroCaracteres := 1;

    while iTotalCaracteres > 0 do
    begin
      if (iTotalCaracteres > numeroColunasT(TipoLetra)) then
      begin
        FComprovante.add(tipoFonteTextoComprovante
          (leftText(Trim(copy(Texto, iNumeroCaracteres,
          numeroColunasT(TipoLetra)))), TipoLetra));
      end
      else
      begin
        Self.imprimeTextoComprovanteValor(copy(Texto, iNumeroCaracteres,
          numeroColunasT(TipoLetra)), Valor, TipoLetra, false);
      end;

      iTotalCaracteres := iTotalCaracteres - numeroColunasT(TipoLetra);
      iNumeroCaracteres := iNumeroCaracteres + numeroColunasT(TipoLetra);
      Application.ProcessMessages;
    end;
  end
  else
  begin

    Texto := Trim(Texto);

    TamanhoResto := Alinhamento(Length(Valor) +
      Length(copy(FormataStringE(Texto, IntToStr(numeroColunasT(TipoLetra)),
      ' '), 1, (numeroColunasT(TipoLetra)))), numeroColunasT(TipoLetra));

    FComprovante.add(tipoFonteTextoComprovante
      (leftText(copy(copy(FormataStringE(Texto,
      IntToStr(numeroColunasT(TipoLetra)), ' '), 1, numeroColunasT(TipoLetra)),
      1, Length(copy(FormataStringE(Texto, IntToStr(numeroColunasT(TipoLetra)),
      ' '), 1, numeroColunasT(TipoLetra))) - TamanhoResto) +
      FormataStringD(Valor, '0', ' ')), TipoLetra));
  end;

end;

procedure TComprovante.imprimeTextoNegrito(Texto: String;
  const Alinhamento: String);
begin
  Texto := boldText(Trim(Texto));
  case AnsiIndexStr(Alinhamento, ['E', 'D', 'C']) of
    0, -1:
      FComprovante.add(leftText(Trim(Texto)));
    1:
      FComprovante.add(rightText(Trim(Texto)));
    2:
      FComprovante.add(centerText(Trim(Texto)));
  end;
end;

procedure TComprovante.imprimeTextoTitulo(titulo: String);
begin

  FComprovante.add(linhaSimples);

  if Trim(titulo) <> '' then
    if FNumeroColunas < 40 then
    begin
      FComprovante.add(centerText(expandedText(copy(titulo, 1, 16))));

      if (Trim(copy(titulo, 17, 16)) <> '') and
        (Length(Trim(copy(titulo, 17, 16))) >= 2) then
        FComprovante.add(expandedText(centerText(Trim(copy(titulo, 17, 16)))));
    end
    else
    begin
      FComprovante.add(expandedText(centerText(copy(titulo, 1, 24))));

      if (Trim(copy(titulo, 25, 24)) <> '') and
        (Length(Trim(copy(titulo, 25, 24))) >= 2) then
        FComprovante.add(expandedText(centerText(Trim(copy(titulo, 25, 24)))));
    end;

  FComprovante.add(linhaSimples);
end;

function TComprovante.leftText(Texto: String): String;
begin
  Result := '</ae>' + Texto;
end;

function TComprovante.linhaDupla: String;
begin
  Result := '</linha_dupla>';
end;

procedure TComprovante.linhaOperadorCaixa;
var
  descricaoCaixa: String;
  linhaOperador: String;
begin
  avancoManual(1);

  { Busca nome do caixa }

  descricaoCaixa :=
    copy(DMConexao.Configuracao.Caixa.descricaoCaixa.Trim, 1, 23);

  linhaOperador := 'OPERADOR: ' + DMConexao.Usuario.Nome + ' ' +
    Space(trunc(((DMConexao.FAcbrPosPrinter.ColunasFontecondensada - 18) / 2)) -
    Length(DMConexao.Usuario.Nome)) +
    Space(trunc(((DMConexao.FAcbrPosPrinter.ColunasFontecondensada - 18) / 2)) -
    Length(descricaoCaixa)) + 'CAIXA: ' + descricaoCaixa;

  if (DMConexao.FAcbrPosPrinter.ColunasFontecondensada) > Length(linhaOperador)
  then
  begin
    linhaOperador := 'OPERADOR: ' + DMConexao.Usuario.Nome + ' ' +
      Space(trunc(((DMConexao.FAcbrPosPrinter.ColunasFontecondensada - 18) / 2))
      - Length(DMConexao.Usuario.Nome)) +
      Space((trunc(((DMConexao.FAcbrPosPrinter.ColunasFontecondensada - 18) / 2)
      ) + (DMConexao.FAcbrPosPrinter.ColunasFontecondensada) -
      Length(linhaOperador)) - Length(descricaoCaixa)) + 'CAIXA: ' +
      descricaoCaixa;

    FComprovante.add(linhaSimples);
    FComprovante.add(linhaOperador);
  end
  else if (DMConexao.FAcbrPosPrinter.ColunasFontecondensada) <
    Length(linhaOperador) then
  begin
    linhaOperador := 'OPERADOR: ' + DMConexao.Usuario.Nome + ' ' +
      Space(trunc(((DMConexao.FAcbrPosPrinter.ColunasFontecondensada - 18) / 2))
      - Length(DMConexao.Usuario.Nome)) +
      Space((trunc(((DMConexao.FAcbrPosPrinter.ColunasFontecondensada - 18) / 2)
      ) - (DMConexao.FAcbrPosPrinter.ColunasFontecondensada) -
      Length(linhaOperador)) - Length(descricaoCaixa)) + 'CAIXA: ' +
      descricaoCaixa;

    FComprovante.add(linhaSimples);
    FComprovante.add(linhaOperador);
  end
  else
  begin
    FComprovante.add(linhaSimples);
    FComprovante.add('OPERADOR: ' + DMConexao.Usuario.Nome + ' ' +
      Space(trunc(((DMConexao.FAcbrPosPrinter.ColunasFontecondensada - 18) / 2))
      - Length(DMConexao.Usuario.Nome)) +
      Space(trunc(((DMConexao.FAcbrPosPrinter.ColunasFontecondensada - 18) / 2))
      - Length(descricaoCaixa)) + 'CAIXA: ' + descricaoCaixa);
    FComprovante.add(linhaSimples);
  end;

end;

function TComprovante.linhaPontilhada: String;
var
  I: Integer;
  sLinha: String;
begin
  for I := 0 to numeroColunasT('C') - 1 do
  begin
    sLinha := sLinha + '.';
  end;

  FComprovante.add(leftText(fontBText(sLinha)));
end;

function TComprovante.linhaSimples: String;
begin
  Result := '</fn></ae></linha_simples>';
end;

function TComprovante.numeroColunasT(TipoLetra: String): Integer;
begin
  Result := FNumeroColunas;
  case AnsiIndexStr(TipoLetra, ['N', 'C', 'E']) of
    0:
      Result := FNumeroColunas;
    1:
      Result := ((FNumeroColunas * 134) div 100);
    2:
      Result := (FNumeroColunas div 2);
  end;
end;

function TComprovante.rightText(Texto: String): String;
begin
  Result := '</ad>' + Texto + '</ae>';
end;

procedure TComprovante.setAssinatura(const Value: String);
begin
  FAssinatura := Value;
end;

procedure TComprovante.setCabecalho(const Value: Boolean);
begin
  FCabecalho := Value;
end;

procedure TComprovante.setImpressora(const Value: String);
begin
  FImpressora := Value;

  FNumeroColunas :=
    strtoint(DMConexao.RemoveChar(Trim(DMConexao.Configuracao.LeIni('Impressora'
    + FImpressora, 'Colunas'))));
end;

procedure TComprovante.setNumeroColunas(const Value: Integer);
begin
  FNumeroColunas := Value;
end;

procedure TComprovante.setTipoTitulo(const Value: String);
begin
  FTipoTitulo := Value;
end;

procedure TComprovante.setTitulo(const Value: String);
begin
  FTitulo := Value;
end;

procedure TComprovante.setUsaTitulo(const Value: Boolean);
begin
  FUsaTitulo := Value;
end;

function TComprovante.Space(Tamanho: Integer): string;
begin
  Result := StringOfChar(' ', Tamanho);
end;

function TComprovante.tipoFonteTextoComprovante(Texto,
  TipoFonte: String): String;
begin
  Texto := Trim(Texto);
  case AnsiIndexStr(TipoFonte, ['N', 'C', 'E']) of
    0, -1:
      Result := Texto;
    1:
      Result := condensedText(Texto);
    2:
      Result := expandedText(Texto);
  end;
end;

procedure TComprovante.tituloCabecalho;
begin
  if Trim(FTitulo) <> '' then
  begin
    case AnsiIndexStr(FTipoTitulo, ['P', 'G']) of
      0:
        begin
          if FNumeroColunas < 40 then
            FComprovante.add(boldText(leftText(FTitulo)))
          else
            FComprovante.add(boldText(centerText(FTitulo)));
        end;
      1:
        begin
          if FNumeroColunas < 40 then
          begin
            FComprovante.add(leftText(expandedText(copy(FTitulo, 1, 16))));

            if (Trim(copy(FTitulo, 17, 16)) <> '') and
              (Length(Trim(copy(FTitulo, 17, 16))) >= 2) then
              FComprovante.add
                (expandedText(leftText(Trim(copy(FTitulo, 17, 16)))));
          end
          else
          begin
            FComprovante.add(expandedText(centerText(copy(FTitulo, 1, 24))));

            if (Trim(copy(FTitulo, 25, 24)) <> '') and
              (Length(Trim(copy(FTitulo, 25, 24))) >= 2) then
              FComprovante.add
                (expandedText(centerText(Trim(copy(FTitulo, 25, 24)))));
          end;
        end;
    end;
  end;
  avancoManual(1);
end;

end.
