unit uBandeiraCartaoDAO;

interface

uses
  uBandeiraCartao, uConexaoFiredac;

type
{$TYPEINFO ON}
  TBandeiraCartaoDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TBandeiraCartaoDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TBandeiraCartaoDAO;
    procedure buscar(BandeiraCartao: TBandeiraCartao);
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, uDMConexao, System.SysUtils;

{ TBandeiraCartaoDAO }

procedure TBandeiraCartaoDAO.buscar(BandeiraCartao: TBandeiraCartao);
var
  FDQuery: TFDQuery;
begin
  try
    try
      if Assigned(BandeiraCartao) then
      begin
        if BandeiraCartao.Codigo > 0 then
        begin
          FDQuery := FConnection.prepareStatement
            (' select BC.CODIGO_TEF, BC.TAXA_DEBITO, BC.ATIVO, ' +
            'BC.DESCRICAO, BC.CODIGO, BC.DIAS_CREDITO, BC.TIPO_CARTAO, ' +
            'BC.DIAS_DEBITO, BC.TAXA_CREDITO from BANDEIRAS_CARTAO BC ' +
            'where BC.CODIGO = :CODIGO ');
          FDQuery.ParamByName('CODIGO').AsInteger := BandeiraCartao.Codigo;
        end
        else
        begin
          FDQuery := FConnection.prepareStatement
            (' select BC.CODIGO_TEF, BC.TAXA_DEBITO, BC.ATIVO, BC.DESCRICAO, ' +
            'BC.CODIGO, BC.DIAS_CREDITO, BC.TIPO_CARTAO, BC.DIAS_DEBITO, BC.TAXA_CREDITO '
            + 'from BANDEIRAS_CARTAO BC where BC.DESCRICAO like ' +
            quotedstr('%' + BandeiraCartao.Descricao.Trim + '%'));
        end;

        with FDQuery do
        begin
          Close;
          SQL.Clear;

          Open;

          if RecordCount > 0 then
          begin
            BandeiraCartao.Codigo := FieldByName('CODIGO').AsInteger;
            BandeiraCartao.Descricao := FieldByName('DESCRICAO').AsString;
            BandeiraCartao.Ativo := DMConexao.Configuracao.StrToBool
              (FieldByName('ATIVO').AsString, 'S');
            BandeiraCartao.TaxaCredito := FieldByName('TAXA_CREDITO')
              .AsCurrency;
            BandeiraCartao.TaxaDebito := FieldByName('TAXA_DEBITO').AsCurrency;
            BandeiraCartao.DiasCredito := FieldByName('DIAS_CREDITO').AsInteger;
            BandeiraCartao.DiasDebito := FieldByName('DIAS_DEBITO').AsInteger;
            BandeiraCartao.TipoCartao := FieldByName('TIPO_CARTAO').AsString;
            BandeiraCartao.CodigoTef := FieldByName('CODIGO_TEF').AsString;
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

constructor TBandeiraCartaoDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TBandeiraCartaoDAO.getInstancia: TBandeiraCartaoDAO;
begin
  if FInstancia = nil then
    FInstancia := TBandeiraCartaoDAO.Create;

  Result := FInstancia;
end;

end.
