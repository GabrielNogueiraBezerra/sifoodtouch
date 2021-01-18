unit uVenda;

interface

uses
  System.Generics.Collections, uEmpresa, uCaixa, uTipoVenda, uUsuario,
  uVendedor, uIndicador, uLocalEstoque,
  uCliente, uItemVenda, uVendaFormaPagamento, uContaReceberCartao,
  uFormaPagamento;

type
{$TYPEINFO ON}
  TVenda = class(TObject)
  private
    FAcrescimo: Currency;
    FDesconto: Currency;
    FDataHora: TDateTime;
    FCupomFiscal: Integer;
    FCodigoNumericoCfe: Integer;
    FDataCancelado: TDate;
    FCodigo: Integer;
    FTotal: Currency;
    FLocalEstoque: TLocalEstoque;
    FUsuarioCancelamento: TUsuario;
    FIndicador: TIndicador;
    FVendedor: TVendedor;
    FCaixa: TCaixa;
    FCancelada: Integer;
    FEmpresa: TEmpresa;
    FUsuarioAuditoria: TUsuario;
    FCliente: TCliente;
    FMotivoCancelamento: String;
    FUsuario: TUsuario;
    FData: TDate;
    FCanceladaRetaguarda: Integer;
    FTipoVenda: TTipoVenda;
    FParcial: Currency;
    FObservacao: String;
    FItensVenda: TObjectList<TITemVenda>;
    FFormasPagamento: TObjectList<TVendaFormaPagamento>;
    FContasReceberCartao: TObjectList<TContaReceberCartao>;
    FSerie: String;
    FNumero: Integer;
    FChaveAcessoCfeNfce: String;
    FProtocoloCfeNfce: String;
    FNumeroSessaoSat: Integer;
    FChaveAcessoCancelCfeNfce: String;
    FJustificativaCancelNfce: String;
    FDataHoraCfe: TDateTime;
    FObservacao2: String;
    FObservacao3: String;
    FObservacao1: String;
    FNumeroMesa: Integer;
    FCodificacaoFiscal: String;
    FNumeroSessao: Integer;
    procedure SetAcrescimo(const Value: Currency);
    procedure SetCaixa(const Value: TCaixa);
    procedure SetCancelada(const Value: Integer);
    procedure SetCanceladaRetaguarda(const Value: Integer);
    procedure SetCodigo(const Value: Integer);
    procedure SetCliente(const Value: TCliente);
    procedure SetCodigoNumericoCfe(const Value: Integer);
    procedure SetCupomFiscal(const Value: Integer);
    procedure SetData(const Value: TDate);
    procedure SetDataCancelado(const Value: TDate);
    procedure SetDataHora(const Value: TDateTime);
    procedure SetDesconto(const Value: Currency);
    procedure SetEmpresa(const Value: TEmpresa);
    procedure SetIndicador(const Value: TIndicador);
    procedure SetLocalEstoque(const Value: TLocalEstoque);
    procedure SetMotivoCancelamento(const Value: String);
    procedure SetTipoVenda(const Value: TTipoVenda);
    procedure SetTotal(const Value: Currency);
    procedure SetUsuario(const Value: TUsuario);
    procedure SetUsuarioAuditoria(const Value: TUsuario);
    procedure SetVendedor(const Value: TVendedor);
    procedure SetParcial(const Value: Currency);
    procedure SetObservacao(const Value: String);
    procedure SetItensVenda(const Value: TObjectList<TITemVenda>);
    procedure SetUsuarioCancelamento(const Value: TUsuario);
    procedure SetFormasPagamento(const Value
      : TObjectList<TVendaFormaPagamento>);
    procedure SetContasReceberCartao(const Value
      : TObjectList<TContaReceberCartao>);
    procedure SetSerie(const Value: String);
    procedure SetNumero(const Value: Integer);
    procedure SetChaveAcessoCfeNfce(const Value: String);
    procedure SetProtocoloCfeNfce(const Value: String);
    procedure SetNumeroSessaoSat(const Value: Integer);
    procedure SetChaveAcessoCancelCfeNfce(const Value: String);
    procedure SetJustificativaCancelNfce(const Value: String);
    procedure SetDataHoraCfe(const Value: TDateTime);
    procedure SetObservacao1(const Value: String);
    procedure SetObservacao2(const Value: String);
    procedure SetObservacao3(const Value: String);
    procedure SetNumeroMesa(const Value: Integer);
    procedure SetCodificacaoFiscal(const Value: String);
    procedure SetNumeroSessao(const Value: Integer);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Clear;
    function TotalVenda: Currency;
    function totalContasAdmCartao(FormaPagamento: TFormaPagamento): Currency;
    function totalTributoEstadual: Currency;
    function totalTributoNacional: Currency;
    function totalICMS: Currency;
    function totalValorImpostoAproximado: Currency;
    function mensagem: String;
    function totalFormaPagamento(Tipo: String): Currency;
  published
    { published declarations }
    property Codigo: Integer read FCodigo write SetCodigo;
    property Data: TDate read FData write SetData;
    property DataHora: TDateTime read FDataHora write SetDataHora;
    property Empresa: TEmpresa read FEmpresa write SetEmpresa;
    property Caixa: TCaixa read FCaixa write SetCaixa;
    property Cliente: TCliente read FCliente write SetCliente;
    property TipoVenda: TTipoVenda read FTipoVenda write SetTipoVenda;
    property Usuario: TUsuario read FUsuario write SetUsuario;
    property UsuarioCancelamento: TUsuario read FUsuarioCancelamento
      write SetUsuarioCancelamento;
    property Vendedor: TVendedor read FVendedor write SetVendedor;
    property Indicador: TIndicador read FIndicador write SetIndicador;
    property LocalEstoque: TLocalEstoque read FLocalEstoque
      write SetLocalEstoque;
    property Desconto: Currency read FDesconto write SetDesconto;
    property Acrescimo: Currency read FAcrescimo write SetAcrescimo;
    property Total: Currency read FTotal write SetTotal;
    property CupomFiscal: Integer read FCupomFiscal write SetCupomFiscal;
    property CodigoNumericoCfe: Integer read FCodigoNumericoCfe
      write SetCodigoNumericoCfe;
    property Cancelada: Integer read FCancelada write SetCancelada;
    property CanceladaRetaguarda: Integer read FCanceladaRetaguarda
      write SetCanceladaRetaguarda;
    property MotivoCancelamento: String read FMotivoCancelamento
      write SetMotivoCancelamento;
    property DataCancelado: TDate read FDataCancelado write SetDataCancelado;
    property UsuarioAuditoria: TUsuario read FUsuarioAuditoria
      write SetUsuarioAuditoria;
    property Parcial: Currency read FParcial write SetParcial;
    property Observacao: String read FObservacao write SetObservacao;
    property ItensVenda: TObjectList<TITemVenda> read FItensVenda
      write SetItensVenda;
    property FormasPagamento: TObjectList<TVendaFormaPagamento>
      read FFormasPagamento write SetFormasPagamento;
    property ContasReceberCartao: TObjectList<TContaReceberCartao>
      read FContasReceberCartao write SetContasReceberCartao;
    property Serie: String read FSerie write SetSerie;
    property Numero: Integer read FNumero write SetNumero;
    property ChaveAcessoCfeNfce: String read FChaveAcessoCfeNfce
      write SetChaveAcessoCfeNfce;
    property ProtocoloCfeNfce: String read FProtocoloCfeNfce
      write SetProtocoloCfeNfce;
    property NumeroSessaoSat: Integer read FNumeroSessaoSat
      write SetNumeroSessaoSat;
    property ChaveAcessoCancelCfeNfce: String read FChaveAcessoCancelCfeNfce
      write SetChaveAcessoCancelCfeNfce;
    property JustificativaCancelNfce: String read FJustificativaCancelNfce
      write SetJustificativaCancelNfce;
    property DataHoraCfe: TDateTime read FDataHoraCfe write SetDataHoraCfe;
    property Observacao1: String read FObservacao1 write SetObservacao1;
    property Observacao2: String read FObservacao2 write SetObservacao2;
    property Observacao3: String read FObservacao3 write SetObservacao3;
    property NumeroMesa: Integer read FNumeroMesa write SetNumeroMesa;
    property CodificacaoFiscal: String read FCodificacaoFiscal
      write SetCodificacaoFiscal;
    property NumeroSessao: Integer read FNumeroSessao write SetNumeroSessao;
  end;

implementation

uses
  System.SysUtils, uDMConexao;

{ TVenda }

procedure TVenda.Clear;
begin
  FAcrescimo := 0;
  FDesconto := 0;
  FCupomFiscal := 0;
  FCodigoNumericoCfe := 0;
  FCodigo := 0;
  FTotal := 0;
  FreeAndNil(FLocalEstoque);
  FreeAndNil(FUsuarioCancelamento);
  FreeAndNil(FIndicador);
  FreeAndNil(FVendedor);
  FreeAndNil(FCaixa);
  FCancelada := 0;
  FParcial := 0;
  FObservacao := '';
  FreeAndNil(FEmpresa);
  FreeAndNil(FUsuarioAuditoria);
  FreeAndNil(FCliente);

  FMotivoCancelamento := '';
  FreeAndNil(FUsuario);
  FCanceladaRetaguarda := 0;
  FreeAndNil(FTipoVenda);
  FreeAndNil(FItensVenda);
  FreeAndNil(FFormasPagamento);

  FreeAndNil(FContasReceberCartao);
  FSerie := '';
  FNumero := 0;
  FChaveAcessoCfeNfce := '';
  FProtocoloCfeNfce := '';
  FNumeroSessaoSat := 0;
  FChaveAcessoCancelCfeNfce := '';
  FJustificativaCancelNfce := '';

  FObservacao1 := '';
  FObservacao2 := '';
  FObservacao3 := '';

  FNumeroMesa := 0;
  FNumeroSessao := 0;
end;

constructor TVenda.Create;
begin
  Clear;
  FLocalEstoque := TLocalEstoque.Create;
  FUsuarioCancelamento := TUsuario.Create;
  FUsuarioAuditoria := TUsuario.Create;
  FUsuario := TUsuario.Create;
  FIndicador := TIndicador.Create;
  FVendedor := TVendedor.Create;
  FCaixa := TCaixa.Create;
  FEmpresa := TEmpresa.Create;
  FTipoVenda := TTipoVenda.Create;
  FCliente := TCliente.Create;
  FItensVenda := TObjectList<TITemVenda>.Create;
  FFormasPagamento := TObjectList<TVendaFormaPagamento>.Create;
  FContasReceberCartao := TObjectList<TContaReceberCartao>.Create;
end;

destructor TVenda.Destroy;
begin
  inherited;
  Clear;
end;

function TVenda.mensagem: String;
var
  sMensagem, sLinha1, sLinha2, sLinha3, sLinha4: String;
begin

  sMensagem := '';

  sLinha1 := 'Val.Aprox.dos Tributos ' + 'Fed.: R$' +
    FormatCurr('0.00', totalTributoNacional) + '(' +
    FormatCurr('0.00', totalTributoNacional / TotalVenda) + '%)' + ' Est.: R$' +
    FormatCurr('0.00', totalTributoEstadual) + '(' +
    FormatCurr('0.00', totalTributoEstadual / TotalVenda) + '%) Fonte:IBPT';

  if DMConexao.Configuracao.Caixa.Linha1.Trim <> '' then
  begin
    if DMConexao.Configuracao.InformarObservacaoVendaECF then
      sLinha2 := Self.FObservacao1 + '|'
    else
      sLinha2 := DMConexao.Configuracao.Caixa.Linha1 + '|';
  end
  else if Self.FObservacao1 <> '' then
    sLinha2 := Self.FObservacao1 + '|'
  else
    sLinha2 := '';

  if DMConexao.Configuracao.Caixa.Linha2 <> '' then
  begin
    if DMConexao.Configuracao.InformarObservacaoVendaECF then
      sLinha3 := Self.FObservacao2 + '|'
    else
      sLinha3 := DMConexao.Configuracao.Caixa.Linha2 + '|';
  end
  else if Self.FObservacao2 <> '' then
    sLinha3 := Self.FObservacao2 + '|'
  else
    sLinha3 := '';

  if DMConexao.Configuracao.Caixa.Linha3 <> '' then
  begin
    if DMConexao.Configuracao.InformarObservacaoVendaECF then
      sLinha4 := Self.FObservacao3 + '|'
    else
      sLinha4 := DMConexao.Configuracao.Caixa.Linha3 + '|';
  end
  else if Self.FObservacao3 <> '' then
    sLinha4 := Self.FObservacao3 + '|'
  else
    sLinha4 := '';

  sLinha4 := sLinha4 + 'Mesa Num.: ' + IntToStr(Self.FNumeroMesa) + '|';

  sMensagem := sMensagem + '|' + sLinha2 + sLinha3 + sLinha4 + 'Operador: ' +
    DMConexao.Usuario.Nome;

  sMensagem := StringReplace(sMensagem, '|', #10, [rfReplaceAll, rfIgnoreCase]);

end;

procedure TVenda.SetAcrescimo(const Value: Currency);
begin
  FAcrescimo := Value;
end;

procedure TVenda.SetCaixa(const Value: TCaixa);
begin
  FCaixa := Value;
end;

procedure TVenda.SetCancelada(const Value: Integer);
begin
  FCancelada := Value;
end;

procedure TVenda.SetCanceladaRetaguarda(const Value: Integer);
begin
  FCanceladaRetaguarda := Value;
end;

procedure TVenda.SetChaveAcessoCancelCfeNfce(const Value: String);
begin
  FChaveAcessoCancelCfeNfce := Value;
end;

procedure TVenda.SetChaveAcessoCfeNfce(const Value: String);
begin
  FChaveAcessoCfeNfce := Value;
end;

procedure TVenda.SetCodificacaoFiscal(const Value: String);
begin
  FCodificacaoFiscal := Value;
end;

procedure TVenda.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TVenda.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TVenda.SetCodigoNumericoCfe(const Value: Integer);
begin
  FCodigoNumericoCfe := Value;
end;

procedure TVenda.SetContasReceberCartao(const Value
  : TObjectList<TContaReceberCartao>);
begin
  FContasReceberCartao := Value;
end;

procedure TVenda.SetCupomFiscal(const Value: Integer);
begin
  FCupomFiscal := Value;
end;

procedure TVenda.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TVenda.SetDataCancelado(const Value: TDate);
begin
  FDataCancelado := Value;
end;

procedure TVenda.SetDataHora(const Value: TDateTime);
begin
  FDataHora := Value;
end;

procedure TVenda.SetDataHoraCfe(const Value: TDateTime);
begin
  FDataHoraCfe := Value;
end;

procedure TVenda.SetDesconto(const Value: Currency);
begin
  FDesconto := Value;
end;

procedure TVenda.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;

procedure TVenda.SetFormasPagamento(const Value
  : TObjectList<TVendaFormaPagamento>);
begin
  FFormasPagamento := Value;
end;

procedure TVenda.SetIndicador(const Value: TIndicador);
begin
  FIndicador := Value;
end;

procedure TVenda.SetItensVenda(const Value: TObjectList<TITemVenda>);
begin
  FItensVenda := Value;
end;

procedure TVenda.SetJustificativaCancelNfce(const Value: String);
begin
  FJustificativaCancelNfce := Value;
end;

procedure TVenda.SetLocalEstoque(const Value: TLocalEstoque);
begin
  FLocalEstoque := Value;
end;

procedure TVenda.SetMotivoCancelamento(const Value: String);
begin
  FMotivoCancelamento := Value;
end;

procedure TVenda.SetNumero(const Value: Integer);
begin
  FNumero := Value;
end;

procedure TVenda.SetNumeroMesa(const Value: Integer);
begin
  FNumeroMesa := Value;
end;

procedure TVenda.SetNumeroSessao(const Value: Integer);
begin
  FNumeroSessao := Value;
end;

procedure TVenda.SetNumeroSessaoSat(const Value: Integer);
begin
  FNumeroSessaoSat := Value;
end;

procedure TVenda.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TVenda.SetObservacao1(const Value: String);
begin
  FObservacao1 := Value;
end;

procedure TVenda.SetObservacao2(const Value: String);
begin
  FObservacao2 := Value;
end;

procedure TVenda.SetObservacao3(const Value: String);
begin
  FObservacao3 := Value;
end;

procedure TVenda.SetParcial(const Value: Currency);
begin
  FParcial := Value;
end;

procedure TVenda.SetProtocoloCfeNfce(const Value: String);
begin
  FProtocoloCfeNfce := Value;
end;

procedure TVenda.SetSerie(const Value: String);
begin
  FSerie := Value;
end;

procedure TVenda.SetTipoVenda(const Value: TTipoVenda);
begin
  FTipoVenda := Value;
end;

procedure TVenda.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

procedure TVenda.SetUsuario(const Value: TUsuario);
begin
  FUsuario := Value;
end;

procedure TVenda.SetUsuarioAuditoria(const Value: TUsuario);
begin
  FUsuarioAuditoria := Value;
end;

procedure TVenda.SetUsuarioCancelamento(const Value: TUsuario);
begin
  FUsuarioCancelamento := Value;
end;

procedure TVenda.SetVendedor(const Value: TVendedor);
begin
  FVendedor := Value;
end;

function TVenda.totalContasAdmCartao(FormaPagamento: TFormaPagamento): Currency;
var
  I: Integer;
begin
  Result := 0;

  if Assigned(FContasReceberCartao) then
    for I := 0 to FContasReceberCartao.Count - 1 do
      if FormaPagamento.Codigo = FContasReceberCartao.Items[I].FormaPagamento.Codigo
      then
        Result := Result + FContasReceberCartao.Items[I].Valor;

  Result := Round(Result);
end;

function TVenda.totalFormaPagamento(Tipo: String): Currency;
var
  I: Integer;
begin
  Result := 0;
  if Tipo = 'TODAS' then
  begin
    if Assigned(FFormasPagamento) then
      for I := 0 to FFormasPagamento.Count - 1 do
        if FFormasPagamento.Items[I].Valor > 0 then
          Result := Result + FFormasPagamento.Items[I].Valor;
  end
  else
  begin
    if Assigned(FFormasPagamento) then
      for I := 0 to FFormasPagamento.Count - 1 do
        if FFormasPagamento.Items[I].FormaPagamento.Tipo = Tipo then
          if FFormasPagamento.Items[I].Valor > 0 then
            Result := Result + FFormasPagamento.Items[I].Valor;
  end;
end;

function TVenda.totalICMS: Currency;
var
  I: Integer;
begin
  Result := 0;

  for I := 0 to FItensVenda.Count - 1 do
    if FItensVenda.Items[I].Cancelado = 0 then
      if (FItensVenda.Items[I].Produto.Servico and
        (FItensVenda.Items[I].Produto.Nbs > 0)) or
        ((not FItensVenda.Items[I].Produto.Servico) and
        (FItensVenda.Items[I].Produto.Ncm <> '')) then
        Result := Result + FItensVenda.Items[I].totalICMS;

end;

function TVenda.totalTributoEstadual: Currency;
var
  I: Integer;
begin
  Result := 0;

  for I := 0 to FItensVenda.Count - 1 do
    if FItensVenda.Items[I].Cancelado = 0 then
      if (FItensVenda.Items[I].Produto.Servico and
        (FItensVenda.Items[I].Produto.Nbs > 0)) or
        ((not FItensVenda.Items[I].Produto.Servico) and
        (FItensVenda.Items[I].Produto.Ncm <> '')) then
        Result := Result + FItensVenda.Items[I].totalTributoEstadual;
end;

function TVenda.totalTributoNacional: Currency;
var
  I: Integer;
begin
  for I := 0 to FItensVenda.Count - 1 do
    if FItensVenda.Items[I].Cancelado = 0 then
      if (FItensVenda.Items[I].Produto.Servico and
        (FItensVenda.Items[I].Produto.Nbs > 0)) or
        ((not FItensVenda.Items[I].Produto.Servico) and
        (FItensVenda.Items[I].Produto.Ncm <> '')) then
        Result := Result + FItensVenda.Items[I].totalTributoNacional;
end;

function TVenda.totalValorImpostoAproximado: Currency;
var
  I: Integer;
begin

  Result := 0;

  for I := 0 to FItensVenda.Count - 1 do
  begin
    Result := Result + FItensVenda.Items[I].ValorImpostoAproximado;
  end;

end;

function TVenda.TotalVenda: Currency;
var
  I: Integer;
begin
  for I := 0 to FItensVenda.Count - 1 do
    if FItensVenda.Items[I].Cancelado = 0 then
      if (FItensVenda.Items[I].Produto.Servico and
        (FItensVenda.Items[I].Produto.Nbs > 0)) or
        ((not FItensVenda.Items[I].Produto.Servico) and
        (FItensVenda.Items[I].Produto.Ncm <> '')) then
        Result := Result + FItensVenda.Items[I].totalItem;
end;

end.
