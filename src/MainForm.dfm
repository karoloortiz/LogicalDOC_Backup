object MyForm: TMyForm
  Left = 0
  Top = 0
  ParentCustomHint = False
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Programma di backup'
  ClientHeight = 205
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  StyleElements = []
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_title: TLabel
    Left = 0
    Top = 0
    Width = 440
    Height = 35
    Align = alTop
    Alignment = taCenter
    Caption = 'Utilit'#224' di backup LogicalDOC'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 361
  end
  object lbl_error: TLabel
    Left = 0
    Top = 35
    Width = 440
    Height = 16
    Align = alTop
    Alignment = taCenter
    Caption = 'Impostazioni non configurate corretamente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 246
  end
  object btn_executeBackup: TButton
    Left = 110
    Top = 59
    Width = 211
    Height = 25
    Caption = 'Esegui backup'
    TabOrder = 0
    OnClick = btn_executeBackupClick
  end
  object btn_openFTPExplorer: TButton
    Left = 110
    Top = 129
    Width = 211
    Height = 25
    Caption = 'Visualizza backup presenti sul server FTP'
    TabOrder = 1
    OnClick = btn_openFTPExplorerClick
  end
  object btn_openSettings: TButton
    Left = 110
    Top = 164
    Width = 211
    Height = 25
    Caption = 'Configura impostazioni'
    TabOrder = 2
    OnClick = btn_openSettingsClick
  end
  object btn_executeFTPBackup: TButton
    Left = 110
    Top = 94
    Width = 211
    Height = 25
    Caption = 'Esegui backup ftp'
    TabOrder = 3
    OnClick = btn_executeFTPBackupClick
  end
end
