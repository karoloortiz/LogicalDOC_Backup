object ConfigSettings: TConfigSettings
  Left = 0
  Top = 0
  Caption = 'ConfigSettings'
  ClientHeight = 509
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mysql_groupBox: TRzGroupBox
    Left = 0
    Top = 71
    Width = 329
    Height = 166
    Align = alTop
    Caption = 'Impostazioni MySQL'
    TabOrder = 1
    VisualStyle = vsClassic
    object _usernameMySQL_lbl: TRzLabel
      Left = 15
      Top = 23
      Width = 48
      Height = 13
      Caption = 'Username'
    end
    object _passwordMySQL_lbl: TRzLabel
      Left = 15
      Top = 68
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object _nome_servizioMySQL_lbl: TRzLabel
      Left = 165
      Top = 23
      Width = 67
      Height = 13
      Caption = 'Nome Servizio'
    end
    object _portaMySQL_lbl: TRzLabel
      Left = 15
      Top = 113
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object usernameMySQL: TEdit
      Left = 15
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'root'
    end
    object passwordMySQL: TEdit
      Left = 15
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'masterkey'
    end
    object nome_servizioMySQL: TEdit
      Left = 165
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'DB_GO'
    end
    object portaMySQL: TEdit
      Left = 15
      Top = 130
      Width = 121
      Height = 21
      NumbersOnly = True
      OEMConvert = True
      TabOrder = 3
      Text = '3307'
    end
  end
  object ftp_groupBox: TRzGroupBox
    Left = 0
    Top = 237
    Width = 329
    Height = 125
    Align = alTop
    Caption = 'Impostazioni FTP'
    TabOrder = 2
    VisualStyle = vsClassic
    object _usernameFTP_lbl: TRzLabel
      Left = 15
      Top = 23
      Width = 48
      Height = 13
      Caption = 'Username'
    end
    object _passwordFTP_lbl: TRzLabel
      Left = 15
      Top = 68
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object _serverFTP_lbl: TRzLabel
      Left = 165
      Top = 23
      Width = 32
      Height = 13
      Caption = 'Server'
    end
    object _cartella_backupFTP_lbl: TRzLabel
      Left = 165
      Top = 68
      Width = 74
      Height = 13
      Caption = 'Cartella backup'
    end
    object usernameFTP: TEdit
      Left = 15
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object passwordFTP: TEdit
      Left = 15
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object serverFTP: TEdit
      Left = 165
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object cartella_backupFTP: TEdit
      Left = 165
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
  object preferenze_groupBox: TRzGroupBox
    Left = 0
    Top = 362
    Width = 329
    Height = 95
    Align = alTop
    Caption = 'Preferenze'
    TabOrder = 3
    VisualStyle = vsClassic
    object _cartella_backup_locale_lbl: TRzLabel
      Left = 15
      Top = 22
      Width = 104
      Height = 13
      Caption = 'Cartella backup locale'
    end
    object _nomeBackup_lbl: TRzLabel
      Left = 170
      Top = 22
      Width = 64
      Height = 13
      Caption = 'Nome backup'
    end
    object mantieni_backup_locale: TRzCheckBox
      Left = 15
      Top = 70
      Width = 126
      Height = 15
      Caption = 'Mantieni backup locale'
      State = cbUnchecked
      TabOrder = 0
    end
    object cartella_backup_locale: TEdit
      Left = 15
      Top = 39
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object nome_backup: TComboBox
      Left = 170
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'standard'
      Items.Strings = (
        '')
    end
  end
  object salva_btn: TRzBitBtn
    Left = 15
    Top = 463
    Width = 121
    Height = 33
    Hint = 'conferma l'#39'elaborazione'
    Caption = 'Salva impostazioni'
    TabOrder = 4
    OnClick = salva_btnClick
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000000000FCFBFB00FCF9
      F700FCF8F400FCF9F500FCF8F100FCFBF900F9F6ED00FCFBF800F6F8F200F1F7
      EE00D3EBD000BDE2B900DFF0DD00C7E7C500A9B5A900A9AFA900A9AEA900C3C5
      C300C3C4C3000C560E000B4F0D000B4D0C000E5D1000126C1400116514001D79
      22001B611E001E6321001E5A200048714A0012961B000F781500188B20001A8C
      220062C069002E5A31004A8D4E0068C26F0073C679004D8551004D7B50004C70
      4E004E7250004C6E4E00BEE5C100219C2C0024A030003183380044B24E0048B5
      510049B653004AB755004DB756004FB858004FB7580051B85A0052B95C0053B9
      5B0052B85A0055B95D0058BC620057BB5F0058BB600052A55A006EC67600ABDF
      B000A7BBA900EBF7EC00149F2400179E260019A32A001DA22D0020AB31002FAC
      3C0037A744003DB24B0042B54F0043B6510044B5510045B5510046B6520048B6
      54004BB756004DB858004E9E570070C779009BD9A20022AE360024B2370024A9
      350025AC380029AC3A002CAE3F0034AE440038B0470039B148003FB34F0041B6
      51004EAD5B005AB6660077CB820099D9A200AEE1B500ACC3AF0026B23C0025AD
      3C0027AD3C0028AE3D0028AC3C0029AD3D002DB1420033B046003FB8520042B8
      54008DD699001CAD38001CAC38001DAC37001EAC37001FAE39001FAD39001FAD
      3A0020B03C0022B33E0021AE3C0021AD3B0021AD3C0022AE3C0023AD3C0024AE
      3D0025B03E0024AD3C002BB845002CB244003AC9550036B64C0057C26B0063C0
      750087D49600C5EBCC001CAD39001DAE3C001DAD3A001EB03C001FB23E001FB1
      3E0020B33F001FAE3B003ABE550040CF5F0040C25B005EC673006DCC8100A0DF
      AD00B5E5BF00B1C8B6001FB2400020B3420021B6440021B5420021B5440022B7
      460021B3420028BB4A002ABE4D0031C4540032C455003CCC5C0063C6790021B6
      460023B8490023B7480024B94A0024B8480024B84A0048D66D0052D27300C3C7
      C40062D6830073D08C0078D691007DD99900B5CDBD00C5C8C600C3C6C400FCFC
      FC00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BABABABA0F28
      1B14151C2A10BABABABABABA11271F475B5F4B492D132B12BABABA112F456C5D
      40263C343930202312BABA54465A5C5602040622363B3A2129BA4244766B6601
      0302040B32353D3116106277818B0507010302042533373E2E1D6D917499B900
      724103020D4F52385E1A689C8D7A9A9869700803025550534E1884A0918D7375
      7D6A6501030A4D51601794AB9D918F73788087090103644C6F19A8A3A99D908F
      7379838A07010C6159249BA7ACA99F908F8C7E8543072C711E0EBAB3A5AAA99F
      908F8E7C97886E483FBABAB7B2A6AEA19F908F937F82574AB8BABABAB7B5AFA4
      AD9EA2927B5863B1BABABABABABAB6B4B09586968967BABABABA}
  end
  object esci_btn: TRzBitBtn
    Left = 165
    Top = 463
    Width = 121
    Height = 33
    Hint = 'esci dal programma'
    Caption = 'Esci senza salvare'
    TabOrder = 5
    OnClick = esci_btnClick
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000000000FCF9F600FCEE
      DB00FCF2E400FCF6ED00FCEBD100FCEDD600FCF1DF00FCF8F100FCF5E800FCFC
      FB00AFB6CF005E78E0005F77DE00AEB4CC00C4C5C9002143E200314FE100415F
      E2005A71DA001B38DC001C3ADB001F3EE0004C62E8004A60E4004F65E8005067
      E800566AD500172DD000273DD600293FD5003246D7003348D800364ADB003548
      D600374CDB003C53E2003C51DF003D52E0003F56E4003C4FDB004156E0004358
      E000455BE4007986DD001328CA001328C9001427CB001A2BCA001F30C7002233
      CC002437D3002638CF002839CF002A3DD400293BD0002C3FD4002D40D4002E41
      D4002D3ED1002E3FD1003043D4003041D1003346D6003548D9005462CF005965
      D200616DD400707BD700747ED800747ED700747FD7007B86DD007E87DB00949B
      DC00AAADC8000D1AB9000E1CBB00101DBD00101DBB00101CB6001323C5001420
      BC001521BE001727C5001825BB001725B7001C2AC6001C2ABF003E49C500414C
      C6004F58C300555FCE005560CC00555FCA005660CB005862CE005962CE005B65
      D0006871D2007079D600727BD700959BDC000A12AC000B16B7000B16B6000D19
      BB000C15B2000C16B1000C15AE000D16AC000D15AB000E17AC00101AB300131A
      9F00131A9E002F38B9004850C2005158C400545BC500A6A7BB000A10A9000A11
      A9000A11A6000A0FA5000A10A5000A0FA3000A10A3000A0FA2000A10A2000B12
      AB000A0EA0000A0FA0000A0E9F000A0F9F000A0E9B000C12AB000B11A5000B10
      8E00181B84002C319C00353AB1003A3EB300494DAF004C50AF0046489A00575A
      BE00575BBE00A9AAC2000A0D9B000A0D9A000A0D98000A0C93000B0D92000B0D
      69000C0E6F000A0B5E000D0E76000A0B5A000D0E6F0018196A001B1C6E001B1C
      60002A2A65004B4C94004B4C8600464677004949750049497400494A7400A9A9
      B400A6A6AF00A6A6AE00C3C3C700C3C3C600C3C3C400FCFCFC00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B0B0B0B0A9A4
      A09B9DA1A8ABB0B0B0B0B0B0ADA3894F2F371F325599A7AEB0B0B0AD8B6C5333
      383F242A162372A2AEB0B08F6A5263413439202547651871A6B093676B610703
      43363C48050449269AAA7468785900070364440601052B1954A556667C795B00
      0703080206482817359F2E80837B815C00070308453E2729229E1B8586827B5E
      09000703453A21271E9C1C7A968676AFAF09000703463B21318A1A4B978DAFAF
      AF5D5F000703423D51900D139692AFAF757D6E60000764308777B0122C98918C
      94847E6D5862574E8EB0B00E112D9697969584886F704D73ACB0B0B00E0B0F4C
      7C7F7C6669505AACB0B0B0B0B0B00A0C1015141D404AB0B0B0B0}
    Margin = -1
  end
  object programma_groupBox: TRzGroupBox
    Left = 0
    Top = 0
    Width = 329
    Height = 71
    Align = alTop
    Caption = 'Impostazioni Programma'
    TabOrder = 0
    VisualStyle = vsClassic
    object cartella_installazione_lbl: TRzLabel
      Left = 15
      Top = 23
      Width = 98
      Height = 13
      Caption = 'Cartella installazione'
    end
    object cartella_installazione: TEdit
      Left = 15
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 0
    end
  end
end
