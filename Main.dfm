object QuickMenuForm: TQuickMenuForm
  Left = 275
  Top = 561
  Width = 278
  Height = 102
  Caption = 'QuickMenu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = qm
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object qm: TPopupMenu
    Left = 72
    Top = 24
    object a1: TMenuItem
      Caption = 'a'
    end
    object b1: TMenuItem
      Caption = 'b'
    end
  end
  object PaxScripter: TPaxScripter
    OverrideHandlerMode = Replace
    StackSize = 16000
    Optimization = True
    OnRunningUpdateActive = False
    Left = 136
    Top = 16
  end
  object PaxJavaScript: TPaxJavaScript
    CompilerDirectives.Strings = (
      'WIN32')
    Container = PaxScripter
    LongStrLiterals = True
    CallConvention = ccStdCall
    NamespaceAsModule = False
    JavaScriptOperators = True
    DeclareVariables = False
    ZeroBasedStrings = False
    Backslash = True
    FileExt = 'js'
    LanguageName = 'paxJavaScript'
    Left = 176
    Top = 24
  end
end
