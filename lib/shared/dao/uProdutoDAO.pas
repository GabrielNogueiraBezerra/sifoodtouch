unit uProdutoDAO;

interface

uses
  uProduto, uDMConexao, uImpressoraDAO, System.Generics.Collections, uSecao,
  uConexaoFiredac, FireDAC.Comp.Client;

type
{$TYPEINFO ON}
  TProdutoDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TProdutoDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TProdutoDAO;
    procedure buscar(Produto: TProduto);
    procedure buscaProdutoCOmanda(Produto: TProduto);
    function buscarTodos: TObjectList<TProduto>; overload;
    function buscarMaisUsados: TObjectList<TProduto>;
    function buscarProdutosMaisUsados: TFDQuery;
    function buscaProdutosDesc(Value: String): TFDQuery;
    function buscarTodos(Secao: TSecao): TObjectList<TProduto>; overload;
    function buscaProdutos(Secao: TSecao): TFDQuery overload;
    function buscarTodos(Secao: TSecao; Produtos: TObjectList<TProduto>)
      : TObjectList<TProduto>; overload;
    function buscarTodos(Secao: TSecao; nome: String)
      : TObjectList<TProduto>; overload;
  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils, FMX.Forms, uSecaoDAO, uEstoque,
  uLocalEstoqueDAO, uUnidadeMedidaDAO, uGrupoIcmsDAO, uGrupoPisDAO,
  uGrupoCofinsDAO;

{ TProdutoDAO }

function TProdutoDAO.buscaProdutosDesc(Value: String): TFDQuery;
var
  sSQL: String;
begin
  try

    sSQL := ' select P.COD_PRO, P.NOME_PRO, P.DESC_CUPOM, P.CAMINHO_FOTO_PRO, '
      + '    (select count(PC.COD_PRO) as TOTAL ' +
      '    from PRODUTOS_COMPOSICAO PC ' +
      '   where PC.COD_PRO = P.COD_PRO) as TOTAL_PRODUTOS_COMPOSICAO ' +
      'from PRODUTO P ';

    if Value <> '' then
    begin
      if DMConexao.IsInteger(Value) then
      begin
        sSQL := sSQL + ' where P.COD_PRO = ' + quotedstr(Value) +
          ' or P.NOME_PRO like ' + quotedstr('%' + Value + '%') +
          ' or P.DESC_CUPOM like ' + quotedstr('%' + Value + '%');
        if Value.Length <= 70 then
        begin
          if Value.Length <= 14 then
            sSQL := sSQL + ' or P.CODIGO_BARRA_PRO = ' + quotedstr(Value)
          else
            sSQL := sSQL + ' or P.CODIGO_BARRA_PRO = ' + quotedstr(Value) +
              ' or P.REFERENCIA_PRO = ' + quotedstr(Value);
        end;
      end
      else
      begin
        sSQL := sSQL + ' where P.NOME_PRO like ' + quotedstr('%' + Value + '%')
          + ' or P.DESC_CUPOM like ' + quotedstr('%' + Value + '%');
        if Value.Length <= 70 then
        begin
          if Value.Length <= 14 then
            sSQL := sSQL + ' or P.CODIGO_BARRA_PRO = ' + quotedstr(Value)
          else
            sSQL := sSQL + ' or P.CODIGO_BARRA_PRO = ' + quotedstr(Value) +
              ' or P.REFERENCIA_PRO = ' + quotedstr(Value);
        end;
      end;
    end;

    result := FConnection.prepareStatement(sSQL);
    result.Open;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TProdutoDAO.buscar(Produto: TProduto);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  Estoque: TEstoque;
begin
  try
    try
      if Assigned(Produto) then
      begin
        FDQuery := FConnection.prepareStatement('select P.COD_PRO, P.COD_CEST, '
          + 'coalesce(P.COD_NCM, ' + quotedstr('') +
          ') as COD_NCM, coalesce(P.NBS, 0) as NBS, coalesce((select TP.SERVICO '
          + 'from TIPO_PRODUTO TP where TP.CODIGO = P.COD_PRO), ' +
          quotedstr('N') + ') as SERVICO, ' +
          'P.CODIGO_BARRA_PRO, P.REFERENCIA_PRO, P.NOME_PRO, P.DESC_CUPOM, ' +
          'P.PRECO_CUSTO, P.MARGEM_LUCRO_PRO, P.VALOR_PRO, P.ATIVO_PRO, P.COZINHA_BALCAO, '
          + 'P.IMPRIME_BALCAO, P.COD_IMP_REST, P.CAMINHO_FOTO_PRO, P.COD_SEC, P.COBRAR_TAXA_SERVICO_RESTAURANTE, '
          + 'P.CONTROLA_ESTOQUE_PRO, P.ICMS_CF_EST, P.COD_GRP_PIS, P.COD_GRP_COFINS, P.CODIGO_UNIDADE_SAIDA, P.PROMOCAO_PRO '
          + ', P.QUANT_UNIDADE_ENTRADA, P.CFOP_VENDAS_CF_EST from PRODUTO P ' +
          'inner join GRUPO_ICMS GI on (P.ICMS_CF_EST = GI.COD_GRP)  ' +
          'left join GRUPO_PIS GP on (P.COD_GRP_PIS = GP.COD_GRUPO_PIS) ' +
          'left join GRUPO_COFINS GC on (P.COD_GRP_COFINS = GC.COD_GRUPO_COFINS) where P.COD_PRO = :CODPRO   ');

        FDQuery.ParamByName('CODPRO').AsInteger := Produto.CODIGO;
        FDQuery.Open;

        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            Produto.Ncm := FieldByName('COD_NCM').AsString;
            Produto.CEST := FieldByName('COD_CEST').AsString;
            Produto.Nbs := FieldByName('NBS').AsInteger;
            Produto.Servico := DMConexao.Configuracao.StrToBool
              (FieldByName('SERVICO').AsString, 'S');
            Produto.Cfop := FieldByName('CFOP_VENDAS_CF_EST').AsInteger;
            Produto.CodigoBarras := FieldByName('CODIGO_BARRA_PRO').AsString;
            Produto.Referencia := FieldByName('REFERENCIA_PRO').AsString;
            Produto.nome := FieldByName('NOME_PRO').AsString;
            Produto.DescricaoCupom := FieldByName('DESC_CUPOM').AsString;
            Produto.PrecoCusto := FieldByName('PRECO_CUSTO').AsCurrency;
            Produto.MargemLucro := FieldByName('MARGEM_LUCRO_PRO').AsCurrency;
            Produto.PrecoVista := FieldByName('VALOR_PRO').AsCurrency;
            Produto.Ativo := DMConexao.Configuracao.StrToBool
              (FieldByName('ATIVO_PRO').AsString, 'S');
            Produto.CozinhaBalcao := FieldByName('COZINHA_BALCAO').AsString;
            Produto.ImprimeBalcao := FieldByName('IMPRIME_BALCAO').AsString;
            Produto.CaminhoFoto := FieldByName('CAMINHO_FOTO_PRO').AsString;
            Produto.Impressora.CODIGO := FieldByName('COD_IMP_REST').AsInteger;
            Produto.CobrarTaxaServicoRestaurante :=
              FieldByName('COBRAR_TAXA_SERVICO_RESTAURANTE').AsString;
            TImpressoraDAO.getInstancia.buscar(Produto.Impressora);
            Produto.Secao.CODIGO := FieldByName('COD_SEC').AsInteger;
            Produto.ControlaEstoque := DMConexao.Configuracao.StrToBool
              (FieldByName('CONTROLA_ESTOQUE_PRO').AsString, 'S');

            Produto.Estoques := TObjectList<TEstoque>.Create;

            FDAux := FConnection.prepareStatement
              ('SELECT E.COD_EMP, E.COD_PRO, E.ESTOQUE, E.CODIGO_LOCAL_ESTOQUE FROM ESTOQUE '
              + 'E WHERE E.COD_EMP = :COD_EMP AND E.COD_PRO = :COD_PRO');

            FDAux.ParamByName('COD_EMP').AsInteger := DMConexao.Empresa.CODIGO;
            FDAux.ParamByName('COD_PRO').AsInteger := Produto.CODIGO;
            FDAux.Open;
            with FDAux do
            begin
              while not FDAux.Eof do
              begin

                Estoque := TEstoque.Create;
                Estoque.Empresa := DMConexao.Empresa;
                Estoque.Estoque := FDAux.FieldByName('ESTOQUE').AsCurrency;
                Estoque.LocalEstoque.CODIGO :=
                  FDAux.FieldByName('CODIGO_LOCAL_ESTOQUE').AsInteger;

                TLocalEstoqueDAO.getInstancia.buscar(Estoque.LocalEstoque);

                Produto.Estoques.Add(Estoque);

                FDAux.Next;
                Application.processMessages;

              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' select count(PC.COD_PRO) as TOTAL from PRODUTOS_COMPOSICAO PC  '
              + 'where PC.COD_PRO = :CODIGO ');

            FDAux.ParamByName('CODIGO').AsInteger := Produto.CODIGO;
            FDAux.Open;
            with FDAux do
            begin
              Produto.QuantidadeComposicao := FDAux.FieldByName('TOTAL')
                .AsInteger;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' SELECT IB.ALIQNAC, IB.ALIQIMP, IB.ALIQEST, IB.ALIQMUN FROM IBPT IB WHERE IB.CODIGO = :CODIGO ');

            if Produto.Servico then
              FDAux.ParamByName('CODIGO').AsInteger := Produto.Nbs
            else if Produto.Ncm <> '' then
              FDAux.ParamByName('CODIGO').AsInteger := StrToInt(Produto.Ncm)
            else
              FDAux.ParamByName('CODIGO').AsInteger := 0;

            FDAux.Open;

            with FDAux do
            begin
              Produto.IBTP.AliquotaNacional := FieldByName('ALIQNAC')
                .AsCurrency;
              Produto.IBTP.AliquotaImportado := FieldByName('ALIQIMP')
                .AsCurrency;
              Produto.IBTP.AliquotaEstadual := FieldByName('ALIQEST')
                .AsCurrency;
              Produto.IBTP.AliquotaMunicipal := FieldByName('ALIQMUN')
                .AsCurrency;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            Produto.Promocao := FieldByName('PROMOCAO_PRO').AsCurrency;

            Produto.UnidadeMedida.CODIGO := FieldByName('CODIGO_UNIDADE_SAIDA')
              .AsInteger;
            TUnidadeMedidaDAO.getInstancia.buscar(Produto.UnidadeMedida);

            if FieldByName('ICMS_CF_EST').IsNull then
              Produto.GrupoIcms := nil
            else
            begin
              Produto.GrupoIcms.CODIGO := FieldByName('ICMS_CF_EST').AsInteger;
              TGrupoIcmsDAO.getInstancia.buscar(Produto.GrupoIcms);
            end;

            if FieldByName('COD_GRP_PIS').IsNull then
              Produto.GrupoPis := nil
            else
            begin
              Produto.GrupoPis.CODIGO := FieldByName('COD_GRP_PIS').AsInteger;
              TgrupoPisDAO.getInstancia.buscar(Produto.GrupoPis);
            end;

            if FieldByName('COD_GRP_COFINS').IsNull then
              Produto.GrupoCofins := nil
            else
            begin
              Produto.GrupoCofins.CODIGO := FieldByName('COD_GRP_COFINS')
                .AsInteger;
              TgrupoCofinsDAO.getInstancia.buscar(Produto.GrupoCofins);
            end;

            Produto.FatorConversao := FieldByName('QUANT_UNIDADE_ENTRADA')
              .AsCurrency;

            TImpressoraDAO.getInstancia.buscar(Produto.Impressora);
            TSecaoDAO.getInstancia.buscar(Produto.Secao);
          end;
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

function TProdutoDAO.buscarTodos: TObjectList<TProduto>;
var
  FDQuery: TFDQuery;
  Produto: TProduto;
  Produtos: TObjectList<TProduto>;
  FDAux: TFDQuery;
  Estoque: TEstoque;
begin
  Produtos := TObjectList<TProduto>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement('select P.COD_PRO, P.COD_CEST, ' +
        'coalesce(P.COD_NCM, ' + quotedstr('') +
        ') as COD_NCM, coalesce(P.NBS, 0) as NBS, coalesce((select TP.SERVICO '
        + 'from TIPO_PRODUTO TP where TP.CODIGO = P.COD_PRO), ' + quotedstr('N')
        + ') as SERVICO, ' +
        ' P.CODIGO_BARRA_PRO, P.REFERENCIA_PRO, P.NOME_PRO, P.DESC_CUPOM, ' +
        'P.PRECO_CUSTO, P.MARGEM_LUCRO_PRO, P.VALOR_PRO, P.ATIVO_PRO, P.COZINHA_BALCAO, '
        + 'P.IMPRIME_BALCAO, P.COD_IMP_REST, P.CAMINHO_FOTO_PRO, P.COD_SEC, P.COBRAR_TAXA_SERVICO_RESTAURANTE, '
        + 'P.CONTROLA_ESTOQUE_PRO, P.ICMS_CF_EST, P.COD_GRP_PIS, P.COD_GRP_COFINS, '
        + 'P.CODIGO_UNIDADE_SAIDA, P.PROMOCAO_PRO, P.QUANT_UNIDADE_ENTRADA, P.CFOP_VENDAS_CF_EST from PRODUTO P  '
        + ' inner join GRUPO_ICMS GI on (P.ICMS_CF_EST = GI.COD_GRP) ' +
        'left join GRUPO_PIS GP on ' +
        '(P.COD_GRP_PIS = GP.COD_GRUPO_PIS) left join GRUPO_COFINS GC on (P.COD_GRP_COFINS = GC.COD_GRUPO_COFINS) '
        + 'where (P.CODIGO_TIPO = 6 or P.CODIGO_TIPO = 1) and ' +
        'P.ATIVO_PRO = :S   ');

      FDQuery.ParamByName('S').AsString := 'S';
      FDQuery.Open;

      with FDQuery do
      begin

        if RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            Produto := TProduto.Create;
            Produto.CEST := FieldByName('COD_CEST').AsString;
            Produto.Ncm := FieldByName('COD_NCM').AsString;
            Produto.Nbs := FieldByName('NBS').AsInteger;
            Produto.Servico := DMConexao.Configuracao.StrToBool
              (FieldByName('SERVICO').AsString, 'S');
            Produto.Cfop := FieldByName('CFOP_VENDAS_CF_EST').AsInteger;
            Produto.CODIGO := FieldByName('COD_PRO').AsInteger;
            Produto.CodigoBarras := FieldByName('CODIGO_BARRA_PRO').AsString;
            Produto.Referencia := FieldByName('REFERENCIA_PRO').AsString;
            Produto.nome := FieldByName('NOME_PRO').AsString;
            Produto.DescricaoCupom := FieldByName('DESC_CUPOM').AsString;
            Produto.PrecoCusto := FieldByName('PRECO_CUSTO').AsCurrency;
            Produto.MargemLucro := FieldByName('MARGEM_LUCRO_PRO').AsCurrency;
            Produto.PrecoVista := FieldByName('VALOR_PRO').AsCurrency;
            Produto.Ativo := DMConexao.Configuracao.StrToBool
              (FieldByName('ATIVO_PRO').AsString, 'S');
            Produto.CozinhaBalcao := FieldByName('COZINHA_BALCAO').AsString;
            Produto.ImprimeBalcao := FieldByName('IMPRIME_BALCAO').AsString;
            Produto.CaminhoFoto := FieldByName('CAMINHO_FOTO_PRO').AsString;
            Produto.Impressora.CODIGO := FieldByName('COD_IMP_REST').AsInteger;
            Produto.CobrarTaxaServicoRestaurante :=
              FieldByName('COBRAR_TAXA_SERVICO_RESTAURANTE').AsString;
            Produto.Secao.CODIGO := FieldByName('COD_SEC').AsInteger;
            Produto.ControlaEstoque := DMConexao.Configuracao.StrToBool
              (FieldByName('CONTROLA_ESTOQUE_PRO').AsString, 'S');
            TImpressoraDAO.getInstancia.buscar(Produto.Impressora);
            TSecaoDAO.getInstancia.buscar(Produto.Secao);

            Produto.Estoques := TObjectList<TEstoque>.Create;

            FDAux := FConnection.prepareStatement
              ('SELECT E.COD_EMP, E.COD_PRO, E.ESTOQUE, E.CODIGO_LOCAL_ESTOQUE FROM ESTOQUE '
              + 'E WHERE E.COD_EMP = :COD_EMP AND E.COD_PRO = :COD_PRO');
            FDAux.ParamByName('COD_EMP').AsInteger := DMConexao.Empresa.CODIGO;
            FDAux.ParamByName('COD_PRO').AsInteger := Produto.CODIGO;
            FDAux.Open;

            with FDAux do
            begin
              while not FDAux.Eof do
              begin

                Estoque := TEstoque.Create;
                Estoque.Empresa := DMConexao.Empresa;
                Estoque.Estoque := FDAux.FieldByName('ESTOQUE').AsCurrency;
                Estoque.LocalEstoque.CODIGO :=
                  FDAux.FieldByName('CODIGO_LOCAL_ESTOQUE').AsInteger;

                TLocalEstoqueDAO.getInstancia.buscar(Estoque.LocalEstoque);

                Produto.Estoques.Add(Estoque);

                FDAux.Next;
                Application.processMessages;

              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' select count(PC.COD_PRO) as TOTAL from PRODUTOS_COMPOSICAO PC  '
              + 'where PC.COD_PRO = :CODIGO ');

            FDAux.ParamByName('CODIGO').AsInteger := Produto.CODIGO;
            FDAux.Open;
            with FDAux do
            begin
              Produto.QuantidadeComposicao := FDAux.FieldByName('TOTAL')
                .AsInteger;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' SELECT IB.ALIQNAC, IB.ALIQIMP, IB.ALIQEST, IB.ALIQMUN FROM IBPT IB WHERE IB.CODIGO = :CODIGO ');

            if Produto.Servico then
              FDAux.ParamByName('CODIGO').AsInteger := Produto.Nbs
            else
              FDAux.ParamByName('CODIGO').AsInteger := StrToInt(Produto.Ncm);

            FDAux.Open;
            with FDAux do
            begin
              Produto.IBTP.AliquotaNacional := FieldByName('ALIQNAC')
                .AsCurrency;
              Produto.IBTP.AliquotaImportado := FieldByName('ALIQIMP')
                .AsCurrency;
              Produto.IBTP.AliquotaEstadual := FieldByName('ALIQEST')
                .AsCurrency;
              Produto.IBTP.AliquotaMunicipal := FieldByName('ALIQMUN')
                .AsCurrency;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            Produto.Promocao := FieldByName('PROMOCAO_PRO').AsCurrency;

            Produto.UnidadeMedida.CODIGO := FieldByName('CODIGO_UNIDADE_SAIDA')
              .AsInteger;
            TUnidadeMedidaDAO.getInstancia.buscar(Produto.UnidadeMedida);

            if FieldByName('ICMS_CF_EST').IsNull then
              Produto.GrupoIcms := nil
            else
            begin
              Produto.GrupoIcms.CODIGO := FieldByName('ICMS_CF_EST').AsInteger;
              TGrupoIcmsDAO.getInstancia.buscar(Produto.GrupoIcms);
            end;

            if FieldByName('COD_GRP_PIS').IsNull then
              Produto.GrupoPis := nil
            else
            begin
              Produto.GrupoPis.CODIGO := FieldByName('COD_GRP_PIS').AsInteger;
              TgrupoPisDAO.getInstancia.buscar(Produto.GrupoPis);
            end;

            if FieldByName('COD_GRP_COFINS').IsNull then
              Produto.GrupoCofins := nil
            else
            begin
              Produto.GrupoCofins.CODIGO := FieldByName('COD_GRP_COFINS')
                .AsInteger;
              TgrupoCofinsDAO.getInstancia.buscar(Produto.GrupoCofins);
            end;

            Produto.FatorConversao := FieldByName('QUANT_UNIDADE_ENTRADA')
              .AsCurrency;

            Produtos.Add(Produto);
            FDQuery.Next;
            Application.processMessages;
          end;
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
    result := Produtos;
  end;
end;

function TProdutoDAO.buscarTodos(Secao: TSecao): TObjectList<TProduto>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  Produto: TProduto;
  Produtos: TObjectList<TProduto>;
  Estoque: TEstoque;
begin
  Produtos := TObjectList<TProduto>.Create;
  try
    try
      if Assigned(Secao) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select P.COD_PRO, P.NOME_PRO, P.DESC_CUPOM, P.CAMINHO_FOTO_PRO ' +
          'from PRODUTO P where P.COD_SEC = :SECAO  ');

        FDQuery.ParamByName('SECAO').AsInteger := Secao.CODIGO;
        FDQuery.Open;

        with FDQuery do
        begin
          if FDQuery.RecordCount > 0 then
          begin
            while not FDQuery.Eof do
            begin
              Produto := TProduto.Create;
              Produto.CODIGO := FieldByName('COD_PRO').AsInteger;
              Produto.nome := FieldByName('NOME_PRO').AsString;
              Produto.DescricaoCupom := FieldByName('DESC_CUPOM').AsString;
              Produto.CaminhoFoto := FieldByName('CAMINHO_FOTO_PRO').AsString;

              FDAux := FConnection.prepareStatement
                (' select count(PC.COD_PRO) as TOTAL from PRODUTOS_COMPOSICAO PC  '
                + 'where PC.COD_PRO = :CODIGO ');
              FDAux.ParamByName('CODIGO').AsInteger := Produto.CODIGO;
              FDAux.Open;

              with FDAux do
              begin
                Produto.QuantidadeComposicao := FDAux.FieldByName('TOTAL')
                  .AsInteger;
              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);

              Produtos.Add(Produto);
              FDQuery.Next;
              Application.processMessages;
            end;
          end;
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
    result := Produtos;
  end;
end;

constructor TProdutoDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TProdutoDAO.getInstancia: TProdutoDAO;
begin
  if FInstancia = nil then
    FInstancia := TProdutoDAO.Create;

  result := FInstancia;
end;

function TProdutoDAO.buscarMaisUsados: TObjectList<TProduto>;
var
  FDQuery: TFDQuery;
  Produto: TProduto;
  Produtos: TObjectList<TProduto>;
  FDAux: TFDQuery;
  Estoque: TEstoque;
begin
  Produtos := TObjectList<TProduto>.Create;
  try
    try
      FDQuery := FConnection.prepareStatement
        (' select * from SP_BUSCA_MAIS_USADOS (:DATAINI, :DATAFIN) ');
      FDQuery.ParamByName('DATAINI').AsDateTime := Date - 2;
      FDQuery.ParamByName('DATAFIN').AsDateTime := Date;
      FDQuery.Open;
      with FDQuery do
      begin
        if FDQuery.RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            Produto := TProduto.Create;
            Produto.CEST := FieldByName('COD_CEST').AsString;
            Produto.Ncm := FieldByName('COD_NCM').AsString;
            Produto.Nbs := FieldByName('NBS').AsInteger;
            Produto.Servico := DMConexao.Configuracao.StrToBool
              (FieldByName('SERVICO').AsString, 'S');
            Produto.Cfop := FieldByName('CFOP_VENDAS_CF_EST').AsInteger;
            Produto.CODIGO := FieldByName('COD_PRO').AsInteger;
            Produto.CodigoBarras := FieldByName('CODIGO_BARRA_PRO').AsString;
            Produto.Referencia := FieldByName('REFERENCIA_PRO').AsString;
            Produto.nome := FieldByName('NOME_PRO').AsString;
            Produto.DescricaoCupom := FieldByName('DESC_CUPOM').AsString;
            Produto.PrecoCusto := FieldByName('PRECO_CUSTO').AsCurrency;
            Produto.MargemLucro := FieldByName('MARGEM_LUCRO_PRO').AsCurrency;
            Produto.PrecoVista := FieldByName('VALOR_PRO').AsCurrency;
            Produto.Ativo := DMConexao.Configuracao.StrToBool
              (FieldByName('ATIVO_PRO').AsString, 'S');
            Produto.CozinhaBalcao := FieldByName('COZINHA_BALCAO').AsString;
            Produto.ImprimeBalcao := FieldByName('IMPRIME_BALCAO').AsString;
            Produto.CaminhoFoto := FieldByName('CAMINHO_FOTO_PRO').AsString;
            Produto.Impressora.CODIGO := FieldByName('COD_IMP_REST').AsInteger;
            Produto.CobrarTaxaServicoRestaurante :=
              FieldByName('COBRAR_TAXA_SERVICO_RESTAURANTE').AsString;
            Produto.Secao.CODIGO := FieldByName('COD_SEC').AsInteger;
            Produto.ControlaEstoque := DMConexao.Configuracao.StrToBool
              (FieldByName('CONTROLA_ESTOQUE_PRO').AsString, 'S');
            TImpressoraDAO.getInstancia.buscar(Produto.Impressora);
            TSecaoDAO.getInstancia.buscar(Produto.Secao);

            Produto.Estoques := TObjectList<TEstoque>.Create;

            FDAux := FConnection.prepareStatement
              ('SELECT E.COD_EMP, E.COD_PRO, E.ESTOQUE, E.CODIGO_LOCAL_ESTOQUE FROM ESTOQUE '
              + 'E WHERE E.COD_EMP = :COD_EMP AND E.COD_PRO = :COD_PRO');

            FDAux.ParamByName('COD_EMP').AsInteger := DMConexao.Empresa.CODIGO;
            FDAux.ParamByName('COD_PRO').AsInteger := Produto.CODIGO;
            FDAux.Open;
            with FDAux do
            begin
              while not FDAux.Eof do
              begin

                Estoque := TEstoque.Create;
                Estoque.Empresa := DMConexao.Empresa;
                Estoque.Estoque := FDAux.FieldByName('ESTOQUE').AsCurrency;
                Estoque.LocalEstoque.CODIGO :=
                  FDAux.FieldByName('CODIGO_LOCAL_ESTOQUE').AsInteger;

                TLocalEstoqueDAO.getInstancia.buscar(Estoque.LocalEstoque);

                Produto.Estoques.Add(Estoque);

                FDAux.Next;
                Application.processMessages;

              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' select count(PC.COD_PRO) as TOTAL from PRODUTOS_COMPOSICAO PC  '
              + 'where PC.COD_PRO = :CODIGO ');

            FDAux.ParamByName('CODIGO').AsInteger := Produto.CODIGO;
            FDAux.Open;
            with FDAux do
            begin
              Produto.QuantidadeComposicao := FDAux.FieldByName('TOTAL')
                .AsInteger;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            FDAux := FConnection.prepareStatement
              (' SELECT IB.ALIQNAC, IB.ALIQIMP, IB.ALIQEST, IB.ALIQMUN FROM IBPT IB WHERE IB.CODIGO = :CODIGO ');

            if Produto.Servico then
              FDAux.ParamByName('CODIGO').AsInteger := Produto.Nbs
            else
              FDAux.ParamByName('CODIGO').AsInteger := StrToInt(Produto.Ncm);

            FDAux.Open;

            with FDAux do
            begin
              Produto.IBTP.AliquotaNacional := FieldByName('ALIQNAC')
                .AsCurrency;
              Produto.IBTP.AliquotaImportado := FieldByName('ALIQIMP')
                .AsCurrency;
              Produto.IBTP.AliquotaEstadual := FieldByName('ALIQEST')
                .AsCurrency;
              Produto.IBTP.AliquotaMunicipal := FieldByName('ALIQMUN')
                .AsCurrency;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            Produto.Promocao := FieldByName('PROMOCAO_PRO').AsCurrency;

            Produto.UnidadeMedida.CODIGO := FieldByName('CODIGO_UNIDADE_SAIDA')
              .AsInteger;
            TUnidadeMedidaDAO.getInstancia.buscar(Produto.UnidadeMedida);

            if FieldByName('ICMS_CF_EST').IsNull then
              Produto.GrupoIcms := nil
            else
            begin
              Produto.GrupoIcms.CODIGO := FieldByName('ICMS_CF_EST').AsInteger;
              TGrupoIcmsDAO.getInstancia.buscar(Produto.GrupoIcms);
            end;

            if FieldByName('COD_GRP_PIS').IsNull then
              Produto.GrupoPis := nil
            else
            begin
              Produto.GrupoPis.CODIGO := FieldByName('COD_GRP_PIS').AsInteger;
              TgrupoPisDAO.getInstancia.buscar(Produto.GrupoPis);
            end;

            if FieldByName('COD_GRP_COFINS').IsNull then
              Produto.GrupoCofins := nil
            else
            begin
              Produto.GrupoCofins.CODIGO := FieldByName('COD_GRP_COFINS')
                .AsInteger;
              TgrupoCofinsDAO.getInstancia.buscar(Produto.GrupoCofins);
            end;

            Produto.FatorConversao := FieldByName('QUANT_UNIDADE_ENTRADA')
              .AsCurrency;

            Produtos.Add(Produto);
            FDQuery.Next;
            Application.processMessages;
          end;
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
    result := Produtos;
  end;
end;

function TProdutoDAO.buscarProdutosMaisUsados: TFDQuery;
begin
  try
    result := FConnection.prepareStatement
      (' select * from SP_BUSCA_MAIS_USADOS (:DATAINI, :DATAFIN) ');
    result.ParamByName('DATAINI').AsDateTime := Date - 2;
    result.ParamByName('DATAFIN').AsDateTime := Date;
    result.Open;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TProdutoDAO.buscarTodos(Secao: TSecao; nome: String)
  : TObjectList<TProduto>;
var
  FDQuery: TFDQuery;
  Produto: TProduto;
  FDAux: TFDQuery;
  Produtos: TObjectList<TProduto>;
begin
  Produtos := TObjectList<TProduto>.Create;
  try
    try
      if Assigned(Secao) then
      begin
        FDQuery := FConnection.prepareStatement
          ('select P.COD_PRO, P.CODIGO_BARRA_PRO, P.REFERENCIA_PRO, P.NOME_PRO, '
          + 'P.DESC_CUPOM, P.PRECO_CUSTO, P.MARGEM_LUCRO_PRO, P.VALOR_PRO, ' +
          'P.ATIVO_PRO, P.COZINHA_BALCAO, P.IMPRIME_BALCAO, P.COD_IMP_REST, ' +
          'P.CAMINHO_FOTO_PRO, P.COD_SEC, P.COBRAR_TAXA_SERVICO_RESTAURANTE, P.CONTROLA_ESTOQUE_PRO from PRODUTO P where (P.CODIGO_TIPO = 6 or P.CODIGO_TIPO = 1) '
          + 'and P.ATIVO_PRO = :S and P.COD_SEC = :SECAO and P.NOME_PRO LIKE ' +
          quotedstr('%' + nome + '%'));
        FDQuery.ParamByName('S').AsString := 'S';
        FDQuery.ParamByName('SECAO').AsInteger := Secao.CODIGO;
        FDQuery.Open;

        with FDQuery do
        begin
          if FDQuery.RecordCount > 0 then
          begin
            while not FDQuery.Eof do
            begin
              Produto := TProduto.Create;
              Produto.CODIGO := FieldByName('COD_PRO').AsInteger;
              Produto.CodigoBarras := FieldByName('CODIGO_BARRA_PRO').AsString;
              Produto.Referencia := FieldByName('REFERENCIA_PRO').AsString;
              Produto.nome := FieldByName('NOME_PRO').AsString;
              Produto.DescricaoCupom := FieldByName('DESC_CUPOM').AsString;
              Produto.PrecoCusto := FieldByName('PRECO_CUSTO').AsCurrency;
              Produto.MargemLucro := FieldByName('MARGEM_LUCRO_PRO').AsCurrency;
              Produto.PrecoVista := FieldByName('VALOR_PRO').AsCurrency;
              Produto.Ativo := DMConexao.Configuracao.StrToBool
                (FieldByName('ATIVO_PRO').AsString, 'S');
              Produto.CozinhaBalcao := FieldByName('COZINHA_BALCAO').AsString;
              Produto.ImprimeBalcao := FieldByName('IMPRIME_BALCAO').AsString;
              Produto.CaminhoFoto := FieldByName('CAMINHO_FOTO_PRO').AsString;
              Produto.Impressora.CODIGO := FieldByName('COD_IMP_REST')
                .AsInteger;
              Produto.Secao.CODIGO := FieldByName('COD_SEC').AsInteger;
              Produto.CobrarTaxaServicoRestaurante :=
                FieldByName('COBRAR_TAXA_SERVICO_RESTAURANTE').AsString;
              Produto.ControlaEstoque := DMConexao.Configuracao.StrToBool
                (FieldByName('CONTROLA_ESTOQUE_PRO').AsString, 'S');

              FDAux := FConnection.prepareStatement
                (' SELECT IB.ALIQNAC, IB.ALIQIMP, IB.ALIQEST, IB.ALIQMUN IB FROM IBPT IB WHERE IB.CODIGO = :CODIGO ');

              if Produto.Servico then
                FDAux.ParamByName('CODIGO').AsInteger := Produto.Nbs
              else
                FDAux.ParamByName('CODIGO').AsInteger := StrToInt(Produto.Ncm);

              FDAux.Open;

              with FDAux do
              begin
                Produto.IBTP.AliquotaNacional := FieldByName('ALIQNAC')
                  .AsCurrency;
                Produto.IBTP.AliquotaImportado := FieldByName('ALIQIMP')
                  .AsCurrency;
                Produto.IBTP.AliquotaEstadual := FieldByName('ALIQEST')
                  .AsCurrency;
                Produto.IBTP.AliquotaMunicipal := FieldByName('ALIQMUN')
                  .AsCurrency;
              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);

              FDAux := FConnection.prepareStatement
                (' select count(PC.COD_PRO) as TOTAL from PRODUTOS_COMPOSICAO PC  '
                + 'where PC.COD_PRO = :CODIGO ');

              FDAux.ParamByName('CODIGO').AsInteger := Produto.CODIGO;
              FDAux.Open;

              with FDAux do
              begin
                Produto.QuantidadeComposicao := FDAux.FieldByName('TOTAL')
                  .AsInteger;
              end;

              if Assigned(FDAux) then
                FConnection.closeConnection(FDAux);

              TImpressoraDAO.getInstancia.buscar(Produto.Impressora);
              TSecaoDAO.getInstancia.buscar(Produto.Secao);
              Produtos.Add(Produto);
              FDQuery.Next;
              Application.processMessages;
            end;
          end;
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if Assigned(FDQuery) then
      FConnection.closeConnection(FDQuery);
    result := Produtos;
  end;
end;

procedure TProdutoDAO.buscaProdutoCOmanda(Produto: TProduto);
begin

end;

function TProdutoDAO.buscaProdutos(Secao: TSecao): TFDQuery;
begin
  try
    if Assigned(Secao) then
    begin
      result := FConnection.prepareStatement
        ('select P.COD_PRO, P.NOME_PRO, P.DESC_CUPOM, P.CAMINHO_FOTO_PRO, P.VALOR_PRO, '
        + '       (select count(PC.COD_PRO) as TOTAL ' +
        '        from PRODUTOS_COMPOSICAO PC ' +
        '        where PC.COD_PRO = P.COD_PRO) as TOTAL_PRODUTOS_COMPOSICAO ' +
        'from PRODUTO P where P.COD_SEC = :SECAO   ');

      result.ParamByName('SECAO').AsInteger := Secao.CODIGO;
      result.Open;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TProdutoDAO.buscarTodos(Secao: TSecao; Produtos: TObjectList<TProduto>)
  : TObjectList<TProduto>;
var
  I: Integer;
begin
  result := TObjectList<TProduto>.Create;

  for I := 0 to Produtos.Count - 1 do
    if Secao.CODIGO = Produtos.Items[I].Secao.CODIGO then
      result.Add(Produtos.Items[I]);
end;

end.
