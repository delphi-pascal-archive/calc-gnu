program Calc;

uses
  Forms,
  NP in 'NP.pas' {MainFrm},
  AP in 'AP.pas' {AboutFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����������� GNU';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TAboutFrm, AboutFrm);
  Application.Run;
end.
