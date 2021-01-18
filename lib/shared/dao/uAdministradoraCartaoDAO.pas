unit uAdministradoraCartaoDAO;

interface

uses
  uAdministradoraCartao, System.Generics.Collections, uConexaoFiredac;

type
{$TYPEINFO ON}
  TAdministradoraCartaoDAO = class(TObject)
  private
    { private declarations }
    FConnection: TConexaoFiredac;
    class var FInstancia: TAdministradoraCartaoDAO;
    constructor Create;
  protected
    { protected declarations }
  public
    { public declarations }
    class function getInstancia: TAdministradoraCartaoDAO;
    procedure buscar(AdministradoraCartao: TAdministradoraCartao);
    function buscaTodos: TObjectList<TAdministradoraCartao>;
  published
    { published declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, uBandeiraCartao,
  uBandeiraCartaoDAO;

{ TAdministradoraCartaoDAO }

procedure TAdministradoraCartaoDAO.buscar(AdministradoraCartao
  : TAdministradoraCartao);
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  BandeiraCartao: TBandeiraCartao;
begin
  try
    try
      if Assigned(AdministradoraCartao) then
      begin
        FDQuery := FConnection.prepareStatement
          (' select AC.CODIGO_TEF, AC.CNPJ, AC.DESCRICAO, AC.CODIGO, AC.CHAVE_REQUISICAO_VFPE '
          + 'from ADMINISTRADORA_CARTAO AC where AC.CODIGO = :CODIGO ');

        with FDQuery do
        begin
          ParamByName('CODIGO').AsInteger := AdministradoraCartao.Codigo;
          Open;

          if RecordCount > 0 then
          begin
            AdministradoraCartao.Codigo := FieldByName('CODIGO').AsInteger;
            AdministradoraCartao.Descricao := FieldByName('DESCRICAO').AsString;
            AdministradoraCartao.CodigoTef := FieldByName('CODIGO_TEF')
              .AsString;
            AdministradoraCartao.ChaveRequisicaoVFPE :=
              FieldByName('CHAVE_REQUISICAO_VFPE').AsString;
            AdministradoraCartao.Cnpj := FieldByName('CNPJ').AsString;
            AdministradoraCartao.Descricao := FieldByName('DESCRICAO').AsString;

            AdministradoraCartao.BandeirasCartao :=
              TObjectList<TBandeiraCartao>.Create;

            FDAux := FConnection.prepareStatement
              ('select BC.CODIGO from BANDEIRAS_CARTAO BC ' +
              'where BC.CODIGO_ADMINISTRADORA = :CODIGO  ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := AdministradoraCartao.Codigo;
              Open;

              while not FDAux.Eof do
              begin
                BandeiraCartao := TBandeiraCartao.Create;
                BandeiraCartao.Codigo := FDAux.FieldByName('CODIGO').AsInteger;

                TBandeiraCartaoDAO.getInstancia.buscar(BandeiraCartao);

                AdministradoraCartao.BandeirasCartao.Add(BandeiraCartao);

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

function TAdministradoraCartaoDAO.buscaTodos
  : TObjectList<TAdministradoraCartao>;
var
  FDQuery: TFDQuery;
  FDAux: TFDQuery;
  AdministradoraCartao: TAdministradoraCartao;
  AdministradorasCartao: TObjectList<TAdministradoraCartao>;
  BandeiraCartao: TBandeiraCartao;
begin
  AdministradorasCartao := TObjectList<TAdministradoraCartao>.Create;
  try
    try

      FDQuery := FConnection.prepareStatement
        (' select AC.CODIGO_TEF, AC.CNPJ, AC.DESCRICAO, AC.CODIGO, AC.CHAVE_REQUISICAO_VFPE '
        + 'from ADMINISTRADORA_CARTAO AC ');

      with FDQuery do
      begin
        Open;

        if FDQuery.RecordCount > 0 then
        begin
          while not FDQuery.Eof do
          begin
            AdministradoraCartao := TAdministradoraCartao.Create;
            AdministradoraCartao.Codigo := FieldByName('CODIGO').AsInteger;
            AdministradoraCartao.Descricao := FieldByName('DESCRICAO').AsString;
            AdministradoraCartao.CodigoTef := FieldByName('CODIGO_TEF')
              .AsString;
            AdministradoraCartao.ChaveRequisicaoVFPE :=
              FieldByName('CHAVE_REQUISICAO_VFPE').AsString;
            AdministradoraCartao.Cnpj := FieldByName('CNPJ').AsString;
            AdministradoraCartao.Descricao := FieldByName('DESCRICAO').AsString;

            AdministradoraCartao.BandeirasCartao :=
              TObjectList<TBandeiraCartao>.Create;

            FDAux := FConnection.prepareStatement
              ('select BC.CODIGO from BANDEIRAS_CARTAO BC ' +
              'where BC.CODIGO_ADMINISTRADORA = :CODIGO  ');

            with FDAux do
            begin
              ParamByName('CODIGO').AsInteger := AdministradoraCartao.Codigo;
              Open;

              while not FDAux.Eof do
              begin
                BandeiraCartao := TBandeiraCartao.Create;
                BandeiraCartao.Codigo := FDAux.FieldByName('CODIGO').AsInteger;

                TBandeiraCartaoDAO.getInstancia.buscar(BandeiraCartao);

                AdministradoraCartao.BandeirasCartao.Add(BandeiraCartao);

                FDAux.Next;
              end;
            end;

            if Assigned(FDAux) then
              FConnection.closeConnection(FDAux);

            AdministradorasCartao.Add(AdministradoraCartao);

            FDQuery.Next;
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
    result := AdministradorasCartao;
  end;
end;

constructor TAdministradoraCartaoDAO.Create;
begin
  FConnection := TConexaoFiredac.getInstancia;
end;

class function TAdministradoraCartaoDAO.getInstancia: TAdministradoraCartaoDAO;
begin
  if FInstancia = nil then
    FInstancia := TAdministradoraCartaoDAO.Create;

  result := FInstancia;
end;

end.
