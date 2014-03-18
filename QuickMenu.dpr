program QuickMenu;

uses
  Messages,Classes,Windows,Forms,Menus,SysUtils,ShellAPI,Graphics,Controls;

{$R *.res}
type
  TMethodPointer = packed record
      pMethod: Pointer;
      pObject: TObject;
  end;
var
  menu:TPopupMenu;
  item:TMenuItem;
  list,config,commands:TStringList;
  p:TPoint;
  s,path:string;
  i: Integer;
  method: TMethod;
  hico:HIcon;
  icon: TIcon;
  imageList : TImageList;
  IsExit: Boolean;

function fixStr(s:string;d:char):string;
begin
 Result := '"' + StringReplace(s, d, '"' + d + '"', [rfReplaceAll]) + '"';
end;
procedure OnClick(Sender:TObject);
var dir,path:string;index:Integer;
begin
     index := (Sender as TMenuItem).Tag;
     if index <> -1 then begin
       path := commands[index];
       dir := ExtractFileDir(path);
       ShellExecute(Application.Handle,'open',PChar(path),nil,PChar(dir),SW_NORMAL);
     end;
     IsExit:= true;
     //Application.Terminate; {not work once enter message loop}
end;
begin
  path := ParamStr(1);
  if path = '' then path := 'default.menu';
  if not FileExists(path) then
  begin
    Application.MessageBox(PChar(path + ' not found'), 'Error', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  IsExit:=False;
  Application.Initialize;
  list:=TStringList.Create;
  list.LoadFromFile(path);
  menu := TPopupMenu.Create(Application);

  imageList:=TImageList.Create(menu);
  menu.Images := imageList;
  menu.AutoHotkeys := maManual;

  commands := TStringList.Create;
  for i:=0 to list.Count -1 do
  begin
       config := TStringList.Create;
       s := list.Strings[i];
       config.CommaText := fixStr(s,config.Delimiter);
       config.NameValueSeparator := '=';
       item := TMenuItem.Create(menu);
       if s <> '-' then begin
         s := config.Values['Caption'];
         item.Caption := s;
         s := config.Values['Icon'];
         path := config.Values['Path'];
         icon := TIcon.Create;
         if StrLen(PChar(s)) = 0 then begin
           hico := ExtractIcon(Application.Handle,PChar(path),0);
         end else begin
           hico := ExtractIcon(Application.Handle,PChar(s),0);
         end;
         icon.Width := 16;
         icon.Height := 16;
         icon.Handle := hico;
         imageList.AddIcon(icon);

         item.ImageIndex := imageList.Count - 1;
         item.Tag := commands.Count;
         commands.Add(path);

         method.Code := @OnClick;
         method.Data := item;
         item.OnClick := TNotifyEvent(method);
       end else begin
         item.Caption := '-';
       end;
       menu.Items.Add(item);
  end;
  item := TMenuItem.Create(menu);
  item.Caption := 'E&xit';
  item.AutoHotkeys := maAutomatic;
  method.Data := item;
  item.OnClick := TNotifyEvent(method);
  item.Tag := -1;
  menu.Items.Add(item);
  GetCursorPos(p);
  menu.Popup(p.X,p.Y);
  while True and IsExit = False do Application.ProcessMessages;
end.
