unit uClienteDAO;

interface

uses
  uCliente, System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TClienteDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TClienteDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TClienteDAO;
    procedure buscar(Cliente: TCliente);
    function buscarTodos(Nome: String): TObjectList<TCliente>;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils, uContaReceber,
  uContaReceberDAO, Vcl.Forms;

{ TClienteDAO }

procedure TClienteDAO.buscar(Cliente: TCliente);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  ContaReceber: TContaReceber;
begin
  try
    try
      if Assigned(Cliente) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select C.COD_CLI, C.FJ_CLI, C.ESTRES_CLI, C.NUMRES_CLI, C.NOME_CLI, C.NOME_FANTASIA, C.ATIVO_CLI, '
          + 'C.ENDRES_CLI, C.BAIRES_CLI, C.CIDRES_CLI, C.CEPRES_CLI, C.TELRES_CLI, '
          + 'C.CNPJ_CLI, C.SEXO_CLI, C.BLOQUEADO_CLI, C.CONTROLAR_LIMITE, C.LIMITE_CLI from CLIENTE C where C.COD_CLI = :CODIGO    ');

        FDQuery.ParamByName('CODIGO').AsInteger := Cliente.Codigo;
        FDQuery.Open;
        with FDQuery do
        begin
          if RecordCount > 0 then
          begin
            Cliente.Codigo := FieldByName('COD_CLI').AsInteger;
            Cliente.Numero := FieldByName('NUMRES_CLI').AsString;
            Cliente.UF := FieldByName('ESTRES_CLI').AsString;
            Cliente.Tipo := FieldByName('FJ_CLI').AsString;
            Cliente.NomeCliente := FieldByName('NOME_CLI').AsString;
            Cliente.NomeFantasia := FieldByName('NOME_FANTASIA').AsString;
            Cliente.Ativo := DMConexao.Configuracao.StrToBool
              (FieldByName('ATIVO_CLI').AsString, 'S');
            Cliente.Endereco := FieldByName('ENDRES_CLI').AsString;
            Cliente.Bairro := FieldByName('BAIRES_CLI').AsString;
            Cliente.Cidade := FieldByName('CIDRES_CLI').AsString;
            Cliente.Cep := FieldByName('CEPRES_CLI').AsString;
            Cliente.Telefone := FieldByName('TELRES_CLI').AsString;
            Cliente.Cnpj := FieldByName('CNPJ_CLI').AsString;
            Cliente.Sexo := FieldByName('SEXO_CLI').AsString;
            Cliente.Bloqueado := DMConexao.Configuracao.StrToBool
              (FieldByName('BLOQUEADO_CLI').AsString, 'S');
            Cliente.ControlaLimite := DMConexao.Configuracao.StrToBool
              (FieldByName('CONTROLAR_LIMITE').AsString, 'S');
            Cliente.LimiteCliente := FieldByName('LIMITE_CLI').AsCurrency;

            Cliente.ContasReceber := TObjectList<TContaReceber>.Create;

            FDAux := FConnection.prepareStatement
              ('  select COD_CTR, SEQUENCIA_CTR  ' +
              'from CONTAS_RECEBER where COD_CLI = :CODCLI and DTPAGTO_CTR is null '
              + 'order by VENCTO_CTR ');

            FDAux.ParamByName('CODCLI').AsInteger := Cliente.Codigo;
            FDAux.Open;
            with FDAux do
            begin
              while not FDAux.Eof do
              begin
                ContaReceber := TContaReceber.Create;
                ContaReceber.Codigo := FDAux.FieldByName('COD_CTR').AsInteger;
                ContaReceber.Sequencia := FDAux.FieldByName('SEQUENCIA_CTR')
                  .AsInteger;

                TContaReceberDAO.getInstancia.buscar(ContaReceber);
                Cliente.ContasReceber.Add(ContaReceber);
                FDAux.Next;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);
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

function TClienteDAO.buscarTodos(Nome: String): TObjectList<TCliente>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  Cliente: TCliente;
  ContaReceber: TContaReceber;
begin
  Result := TObjectList<TCliente>.Create;
  try
    try

      FDQuery := FConnection.prepareStatement
        (' select C.COD_CLI, C.FJ_CLI, C.ESTRES_CLI, C.NUMRES_CLI, C.NOME_CLI, C.NOME_FANTASIA, '
        + 'C.ATIVO_CLI, C.ENDRES_CLI, C.BAIRES_CLI, C.CIDRES_CLI, C.CEPRES_CLI, C.TELRES_CLI, '
        + 'C.CNPJ_CLI, C.SEXO_CLI, C.BLOQUEADO_CLI, C.CONTROLAR_LIMITE, C.LIMITE_CLI '
        + 'from CLIENTE C where C.NOME_CLI like :nome ');

      FDQuery.ParamByName('nome').AsString := '%' + Nome + '%';
      FDQuery.Open;
      with FDQuery do
      begin
        if FDQuery.RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            Cliente := TCliente.Create;
            Cliente.Codigo := FieldByName('COD_CLI').AsInteger;
            Cliente.Numero := FieldByName('NUMRES_CLI').AsString;
            Cliente.UF := FieldByName('ESTRES_CLI').AsString;
            Cliente.Tipo := FieldByName('FJ_CLI').AsString;
            Cliente.NomeCliente := FieldByName('NOME_CLI').AsString;
            Cliente.NomeFantasia := FieldByName('NOME_FANTASIA').AsString;
            Cliente.Ativo := DMConexao.Configuracao.StrToBool
              (FieldByName('ATIVO_CLI').AsString, 'S');
            Cliente.Endereco := FieldByName('ENDRES_CLI').AsString;
            Cliente.Bairro := FieldByName('BAIRES_CLI').AsString;
            Cliente.Cidade := FieldByName('CIDRES_CLI').AsString;
            Cliente.Cep := FieldByName('CEPRES_CLI').AsString;
            Cliente.Telefone := FieldByName('TELRES_CLI').AsString;
            Cliente.Cnpj := FieldByName('CNPJ_CLI').AsString;
            Cliente.Sexo := FieldByName('SEXO_CLI').AsString;
            Cliente.Bloqueado := DMConexao.Configuracao.StrToBool
              (FieldByName('BLOQUEADO_CLI').AsString, 'S');
            Cliente.ControlaLimite := DMConexao.Configuracao.StrToBool
              (FieldByName('CONTROLAR_LIMITE').AsString, 'S');
            Cliente.LimiteCliente := FieldByName('LIMITE_CLI').AsCurrency;

            Cliente.ContasReceber := TObjectList<TContaReceber>.Create;

            FDAux := FConnection.prepareStatement
              ('  select COD_CTR, SEQUENCIA_CTR  ' +
              'from CONTAS_RECEBER where COD_CLI = :CODCLI and DTPAGTO_CTR is null '
              + 'order by VENCTO_CTR ');
            FDAux.ParamByName('CODCLI').AsInteger := Cliente.Codigo;
            FDAux.Open;

            with FDAux do
            begin
              while not FDAux.Eof do
              begin
                ContaReceber := TContaReceber.Create;
                ContaReceber.Codigo := FDAux.FieldByName('COD_CTR').AsInteger;
                ContaReceber.Sequencia := FDAux.FieldByName('SEQUENCIA_CTR')
                  .AsInteger;

                TContaReceberDAO.getInstancia.buscar(ContaReceber);
                Cliente.ContasReceber.Add(ContaReceber);
                FDAux.Next;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            Result.Add(Cliente);

            FDQuery.Next;
            Application.ProcessMessages;
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

constructor TClienteDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TClienteDAO.getInstancia: TClienteDAO;
begin
  if FInstancia = nil then
    FInstancia := TClienteDAO.Create;

  Result := FInstancia;
end;

end.
