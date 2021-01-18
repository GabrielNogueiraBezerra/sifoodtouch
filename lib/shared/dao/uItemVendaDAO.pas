unit uItemVendaDAO;

interface

uses
  uItemVenda, uConexaoFiredac;

type
{$TYPEINFO ON}
  TItemVendaDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TItemVendaDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TItemVendaDAO;
    procedure buscar(ItemVenda: TItemVenda);
    procedure inserir(ItemVenda: TItemVenda);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.Variants, System.SysUtils,
  uGrupoIcms, uGrupoCofins, uGrupoPis, uProdutoDAO, uEmpresaDAO, uVendedorDAO,
  uGrupoIcmsDAO, uGrupoPisDAO, uGrupoCofinsDAO;

{ TItemVendaDAO }

procedure TItemVendaDAO.buscar(ItemVenda: TItemVenda);
var
  FDQuery: TFDQuery;
begin
  if Assigned(ItemVenda) then
  begin
    try
      try

        FDQuery := FConnection.prepareStatement
          (' select IV.COD_PRO, IV.OBSERVACAO, IV.ACRESCIMO, IV.DESCONTO, IV.VALOR_CUSTO, '
          + 'IV.VALOR, IV.COD_GRP_ICMS, GI.NOME_GRP as NOME_ICMS, ' +
          'IV.ALIQICMS, IV.CANCELADO, IV.COD_VEN, (IV.VALOR * IV.QUANT) as VALOR_TOTAL, IV.COD_VEND, IV.CFOP, '
          + 'IV.COD_GRP_PIS, GP.NOME_GRUPO as NOME_PIS, ' +
          'IV.ALIQ_PIS, IV.COD_GRP_COFINS, GC.NOME_GRUPO as NOME_COFINS, IV.ALIQ_COFINS, IV.VENDA_CANCELADA, '
          + 'IV.PRODUTO_PROMOCAO, ' +
          'IV.COD_EMP, IV.QUANT, IV.ORDEM from ITENS_VENDA IV ' +
          'inner join GRUPO_ICMS GI on (IV.COD_GRP_ICMS = GI.COD_GRP) ' +
          'left join GRUPO_PIS GP on (IV.COD_GRP_PIS = GP.COD_GRUPO_PIS) ' +
          'left join GRUPO_COFINS GC on (IV.COD_GRP_COFINS = GC.COD_GRUPO_COFINS) '
          + 'where IV.COD_VEN = :CODIGO and IV.ORDEM = :ORDEM ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := ItemVenda.Codigo;
          ParamByName('ORDEM').AsInteger := ItemVenda.Ordem;
          Open;

          if RecordCount > 0 then
          begin
            ItemVenda.Codigo := FieldByName('COD_VEN').AsInteger;

            ItemVenda.Produto.Codigo := FieldByName('COD_PRO').AsInteger;
            TProdutoDAO.getInstancia.buscar(ItemVenda.Produto);

            ItemVenda.Empresa.Codigo := FieldByName('COD_EMP').AsInteger;
            TEmpresaDAO.getInstancia.buscar(ItemVenda.Empresa);

            ItemVenda.Ordem := FieldByName('ORDEM').AsInteger;

            ItemVenda.Vendedor.Codigo := FieldByName('COD_VEN').AsInteger;
            TVendedorDAO.getInstancia.buscar(ItemVenda.Vendedor);

            ItemVenda.Cfop := FieldByName('CFOP').AsInteger;
            ItemVenda.Quantidade := FieldByName('QUANT').AsCurrency;
            ItemVenda.Promocao := DMConexao.Configuracao.StrToBool
              (FieldByName('PRODUTO_PROMOCAO').AsString, 'S');
            ItemVenda.Valor := FieldByName('VALOR').AsCurrency;
            ItemVenda.ValorCusto := FieldByName('VALOR_CUSTO').AsCurrency;
            ItemVenda.Desconto := FieldByName('DESCONTO').AsCurrency;
            ItemVenda.Acrescimo := FieldByName('ACRESCIMO').AsCurrency;

            ItemVenda.Total := FieldByName('VALOR_TOTAL').AsCurrency;

            if FieldByName('COD_GRP_ICMS').IsNull then
              ItemVenda.GrupoIcms := nil
            else
            begin
              ItemVenda.GrupoIcms.Codigo := FieldByName('COD_GRP_ICMS')
                .AsInteger;

              TGrupoICMSDAO.getInstancia.buscar(ItemVenda.GrupoIcms);

              ItemVenda.GrupoIcms.Descricao := FieldByName('NOME_ICMS')
                .AsString;
              ItemVenda.GrupoIcms.Aliquota := FieldByName('ALIQICMS')
                .AsCurrency;
            end;

            if FieldByName('COD_GRP_PIS').IsNull then
              ItemVenda.GrupoPis := nil
            else
            begin
              ItemVenda.GrupoPis.Codigo := FieldByName('COD_GRP_PIS').AsInteger;

              TGrupoPisDAO.getInstancia.buscar(ItemVenda.GrupoPis);

              ItemVenda.GrupoPis.Descricao := FieldByName('NOME_PIS').AsString;
              ItemVenda.GrupoPis.Aliquota := FieldByName('ALIQ_PIS').AsCurrency;
            end;

            if FieldByName('COD_GRP_COFINS').IsNull then
              ItemVenda.GrupoCofins := nil
            else
            begin
              ItemVenda.GrupoCofins.Codigo := FieldByName('COD_GRP_COFINS')
                .AsInteger;

              TGrupoCofinsDAO.getInstancia.buscar(ItemVenda.GrupoCofins);

              ItemVenda.GrupoCofins.Descricao :=
                FieldByName('NOME_COFINS').AsString;
              ItemVenda.GrupoCofins.Aliquota := FieldByName('ALIQ_COFINS')
                .AsCurrency;
            end;

            ItemVenda.Cancelado := FieldByName('CANCELADO').AsInteger;
            ItemVenda.VendaCancelada := FieldByName('VENDA_CANCELADA')
              .AsInteger;
            ItemVenda.Observacao := FieldByName('OBSERVACAO').AsString;
          end;
        end;

      except
        on E: Exception do
          raise Exception.Create(E.Message);
      end;
    finally
      if Assigned(FDQuery) then
        FConnection.closeConnection(FDQuery);
    end;
  end;
end;

constructor TItemVendaDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TItemVendaDAO.getInstancia: TItemVendaDAO;
begin
  if FInstancia = nil then
    FInstancia := TItemVendaDAO.Create;

  Result := FInstancia;
end;

procedure TItemVendaDAO.inserir(ItemVenda: TItemVenda);
var
  FDQuery: TFDQuery;
begin
  try
    try
      FDQuery := FConnection.prepareStatement
        (' insert into ITENS_VENDA (COD_VEN, COD_PRO, COD_EMP, ORDEM, COD_VEND, CFOP, '
        + 'QUANT, PRODUTO_PROMOCAO, VALOR, VALOR_CUSTO, DESCONTO, ACRESCIMO, VALOR_TOTAL, UNIDADE, '
        + 'FATOR_CONVERSAO, COD_GRP_ICMS, ALIQICMS, COD_GRP_PIS, ALIQ_PIS, ' +
        'COD_GRP_COFINS, ALIQ_COFINS,  ALIQ_TRIBUTOS, CANCELADO, VENDA_CANCELADA, '
        + 'STATUS_EXPORTA, DESC_PESSOA_AUTORIZADA, SINCRONIZADO, EAD, OBSERVACAO) '
        + 'values (:CODVEN, :CODPRO, :CODEMP, :ORDEM, :CODVEND, :CFOP, :QUANT, :PRODUTOPROMOCAO, :VALOR, :VALORCUSTO, '
        + ':DESCONTO, :ACRESCIMO, :VALORTOTAL, :UNIDADE, :FATORCONVERSAO, :CODGRPICMS, :ALIQICMS, :CODGRPPIS, '
        + ':ALIQPIS, :CODGRPCOFINS, :ALIQCOFINS, :ALIQTRIBUTOS, :CANCELADO, :VENDACANCELADA, :STATUSEXPORTA, '
        + ':DESCPESSOAAUTORIZADA, :SINCRONIZADO, :EAD, :OBSERVACAO)   ');

      if Assigned(ItemVenda) then
      begin
        with FDQuery do
        begin
          ParamByName('codven').AsInteger := ItemVenda.Codigo;
          ParamByName('codpro').AsInteger := ItemVenda.Produto.Codigo;
          ParamByName('codemp').AsInteger := ItemVenda.Empresa.Codigo;
          ParamByName('ordem').AsInteger := ItemVenda.Ordem;

          ParamByName('codvend').AsInteger := ItemVenda.Vendedor.Codigo;

          if ItemVenda.Cfop > 0 then
            ParamByName('cfop').AsInteger := ItemVenda.Cfop
          else
            ParamByName('cfop').Value := Null;

          ParamByName('quant').AsCurrency := ItemVenda.Quantidade;

          if ItemVenda.Produto.Promocao > 0 then
            ParamByName('produtopromocao').AsString := 'S'
          else
            ParamByName('produtopromocao').AsString := 'N';

          ParamByName('valor').AsCurrency := ItemVenda.Valor;
          ParamByName('valorcusto').AsCurrency := ItemVenda.Produto.PrecoCusto;
          ParamByName('desconto').AsCurrency := 0;
          ParamByName('acrescimo').AsCurrency := 0;
          ParamByName('valortotal').Value := Null;
          ParamByName('unidade').AsString :=
            ItemVenda.Produto.UnidadeMedida.Descricao;
          ParamByName('fatorconversao').AsCurrency :=
            ItemVenda.Produto.FatorConversao;
          ParamByName('codgrpicms').AsInteger := ItemVenda.GrupoIcms.Codigo;
          ParamByName('aliqicms').AsCurrency := ItemVenda.GrupoIcms.Aliquota;

          if Assigned(ItemVenda.GrupoPis) then
          begin
            ParamByName('codgrppis').AsInteger := ItemVenda.GrupoPis.Codigo;
            ParamByName('aliqpis').AsCurrency := ItemVenda.GrupoPis.Aliquota;
          end
          else
          begin
            ParamByName('codgrppis').Value := Null;
            ParamByName('aliqpis').AsCurrency := 0;
          end;

          if Assigned(ItemVenda.GrupoCofins) then
          begin
            ParamByName('CODGRPCOFINS').AsInteger :=
              ItemVenda.GrupoCofins.Codigo;
            ParamByName('ALIQCOFINS').AsCurrency :=
              ItemVenda.GrupoCofins.Aliquota;
          end
          else
          begin
            ParamByName('CODGRPCOFINS').Value := Null;
            ParamByName('ALIQCOFINS').AsCurrency := 0;
          end;

          ParamByName('aliqtributos').AsCurrency := 0;
          ParamByName('cancelado').AsInteger := 0;
          ParamByName('vendacancelada').AsInteger := 0;
          ParamByName('statusexporta').Value := Null;
          ParamByName('descpessoaautorizada').Value := Null;
          ParamByName('sincronizado').Value := Null;
          ParamByName('ead').Value := Null;
          ParamByName('observacao').AsString := ItemVenda.Observacao;

          ExecSQL;
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
  end;
end;

end.
