program QuickMenu;

uses
  Forms,
  Main in 'Main.pas' {QuickMenuForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TQuickMenuForm, QuickMenuForm);
  Application.Run;
end.
