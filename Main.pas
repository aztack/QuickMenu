unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, PaxScripter, BASE_PARSER, PaxJavaScript;
const
  WM_SHOW_MENU_MESSAGE = WM_USER + 42;{1066}

type
  TQuickMenuForm = class(TForm)
    qm: TPopupMenu;
    a1: TMenuItem;
    b1: TMenuItem;
    PaxScripter: TPaxScripter;
    PaxJavaScript: TPaxJavaScript;
    procedure FormCreate(Sender: TObject);
  private
  public
    Procedure WM_SHOW_MENU(var msg:TMessage);Message WM_SHOW_MENU_MESSAGE;
  end;

var
  QuickMenuForm: TQuickMenuForm;

implementation
uses
  IMP_Classes, IMP_Controls, IMP_StdCtrls, IMP_ComCtrls, IMP_Menus;
{$R *.dfm}

procedure TQuickMenuForm.FormCreate(Sender: TObject);
var path:String;
begin
  path := ExtractFileDir(Application.ExeName);
  path := path + '\default.js';
  PaxScripter.RegisterObject('Menu',qm);

  if FileExists(path) then begin
    PaxScripter.AddModule('main',PaxJavaScript.LanguageName);
    PaxScripter.AddCodeFromFile('main',path);
  end;
  PaxScripter.Run;
end;

procedure TQuickMenuForm.WM_SHOW_MENU;
var pos:TPoint;
begin
  GetCursorPos(pos);
  qm.Popup(pos.X,pos.Y);
end;



end.
