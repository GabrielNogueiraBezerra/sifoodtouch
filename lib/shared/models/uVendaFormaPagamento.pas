unit uVendaFormaPagamento;

interface

uses
  uFormaPagamento;

type
{$TYPEINFO ON}
  TVendaFormaPagamento = class(TObject)
  private
    FValor: Currency;
    FFormaPagamento: TFormaPagamento;
    procedure SetFormaPagamento(const Value: TFormaPagamento);
    procedure SetValor(const Value: Currency);
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
    property FormaPagamento: TFormaPagamento read FFormaPagamento
      write SetFormaPagamento;
    property Valor: Currency read FValor write SetValor;

  end;

implementation

uses
  System.SysUtils;

{ TVendaFormaPagamento }

procedure TVendaFormaPagamento.Clear;
begin
  FreeAndNil(FFormaPagamento);
  FValor := 0;
end;

constructor TVendaFormaPagamento.Create;
begin
  Clear;
  FFormaPagamento := TFormaPagamento.Create;
end;

destructor TVendaFormaPagamento.Destroy;
begin
  Clear;
  inherited;
end;

procedure TVendaFormaPagamento.SetFormaPagamento(const Value: TFormaPagamento);
begin
  FFormaPagamento := Value;
end;

procedure TVendaFormaPagamento.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
