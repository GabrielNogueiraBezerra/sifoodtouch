unit uObservable;

interface

uses uObserver;

type
  ITObservable = interface
    procedure Attach(Observer: ITObserver);
    procedure Dettach(Observer: ITObserver);
    procedure NotifyAll;
  end;

implementation

end.

