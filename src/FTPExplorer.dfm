object FTPFormExplorer: TFTPFormExplorer
  Left = 0
  Top = 0
  Caption = 'Backup FTP'
  ClientHeight = 396
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_serverFTP: TLabel
    Left = 45
    Top = 23
    Width = 286
    Height = 18
    AutoSize = False
    Caption = 'ftp.xxxxxxx.xx/...../.../'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object _lbl_serverFTP: TLabel
    Left = 45
    Top = 5
    Width = 73
    Height = 16
    Caption = 'Server FTP :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btn_download: TRzBitBtn
    Left = 45
    Top = 51
    Width = 136
    Height = 33
    Hint = 'conferma l'#39'elaborazione'
    Caption = 'Scarica backup'#13'selezionato'
    TabOrder = 1
    OnClick = btn_downloadClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      000000000002000000090000000E0000000F0000000F00000010000000100000
      0010000000100000000F0000000A000000020000000000000000000000000000
      0000000000081E5943C0287657FF277355FF267052FF256D50FF256C4EFF246A
      4BFF226749FF226547FF174733C10000000A0000000000000000000000000000
      000000000009389C79FF61E1BFFF47D3ADFF44D0A9FF42CEA5FF40CCA2FF3ECA
      9FFF3CC79CFF38C599FF267052FF0000000A0000000000000000000000000000
      00000000000430856AC140B28DFF3FAE8AFF3DAB87FF3CA884FF3BA581FF39A2
      7FFF389E7BFF369B79FF266D54C1000000040000000000000000000000000000
      000000000000000000010000000200000002000000030B20176D0A1B136F0000
      0004000000030000000200000002000000000000000000000000000000000000
      000000000000000000000000000000000003040C092E21664AF41C583FF6030A
      072F000000030000000000000000000000000000000000000000000000000000
      00000000000000000000000000010001010C1B4F39CA2FB084FF2CAB7EFF143F
      2BCD0001010D0000000100000000000000000000000000000000000000000000
      000000000000000000010000000512352788329C78FF35CA99FF35C999FF298E
      6AFF0E291D8B0000000600000001000000000000000000000000000000000000
      00000000000000000003091A1343328968FD42CEA2FF38CC9DFF37CB9CFF3CCB
      9DFF256F53FD07140E4700000003000000000000000000000000000000000000
      00000000000102060413297156E24FCCA5FF41D1A4FF3ECFA2FF3CCEA1FF3DCE
      A0FF3FC198FF1D553DE302050417000000010000000000000000000000000000
      0000000000031F5641AA65C4A7FF8BE9CFFF86E7CEFF74E4C5FF73E4C5FF66DF
      BDFF6CDFBEFF5DB69AFF153E2DAE000000040000000000000000000000000000
      0000000000033FA280FF3FA07FFF3E9F7FFFB8F5E6FF8CEDD6FF8CEDD5FF9BEF
      DBFF389071FF388F71FF378E6FFF000000040000000000000000000000000000
      000000000001000000030000000741A585FFC9F9EFFF9EF4E1FF9EF3E0FFADF5
      E6FF3B9878FF0000000900000004000000010000000000000000000000000000
      000000000000000000000000000344AC89FFDEFCF7FFDEFCF7FFDEFCF7FFDEFC
      F7FF3F9E7EFF0000000400000000000000000000000000000000000000000000
      0000000000000000000000000002308569BF41B48EFF41B48EFF41B48EFF41B4
      8EFF2E8166B90000000200000000000000000000000000000000000000000000
      0000000000000000000000000000000000010000000200000002000000020000
      0002000000020000000000000000000000000000000000000000}
  end
  object listView_FTPBackups: TRzListView
    Left = 45
    Top = 90
    Width = 286
    Height = 291
    Columns = <
      item
        Width = -1
        WidthType = (
          -1)
      end>
    HeaderDefaultDrawing = False
    ShowColumnHeaders = False
    SmallImages = imageList
    TabOrder = 0
    ViewStyle = vsReport
    FillLastColumn = False
  end
  object btn_delete: TRzBitBtn
    Left = 195
    Top = 51
    Width = 136
    Height = 33
    Hint = 'Cancella'
    Caption = 'Cancella backup'#13'selezionato'
    TabOrder = 2
    OnClick = btn_deleteClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000020000000A00000010000000090000000200000000000000000000
      00020000000A000000120000000C000000030000000000000000000000000000
      00020000000F0F0742921D0F7EEF0603347A0000000E00000002000000020000
      000F0804347C1D0F7EF00F084194000000120000000200000000000000000000
      0008120B47923233AFFF3648CCFF1D1EA5FF0603357A0000000F0000000F0703
      357C1F20A5FF3747CCFF2D2FAEFF120B46950000000B00000000000000000000
      000C281C8DF1596CD8FF3B51D3FF3A4FD2FF1E22A6FF0602347D0502357E2022
      A6FF3A50D3FF3A50D3FF4C5FD4FF291D8CF10000001000000000000000000000
      0006130F3C734D4FBAFF667EE0FF415AD6FF415AD7FF1F24A7FF2529A8FF415A
      D7FF415AD7FF5B72DEFF484AB8FF130F3C790000000900000000000000000000
      00010000000A16123F73585CC1FF758DE6FF4A64DBFF4A65DBFF4A65DBFF4A64
      DBFF6983E3FF5356C0FF16123F780000000C0000000200000000000000000000
      0000000000010000000A191643755D63C7FF6783E5FF5774E2FF5774E2FF5774
      E2FF565CC6FF1916437A0000000D000000020000000000000000000000000000
      00000000000100000009100E3D734A50BEFF7492EBFF6383E7FF6483E7FF6383
      E7FF3840B6FF0B0839780000000C000000020000000000000000000000000000
      0001000000071413416E555CC5FF85A1EFFF7897EDFF9CB6F4FF9DB7F5FF7997
      EEFF7796EDFF414ABCFF0E0C3C730000000A0000000100000000000000000000
      00041818456B636CCFFF93AFF3FF83A1F1FFA6BFF7FF676DCAFF7E87DDFFAFC7
      F8FF83A3F2FF83A1F1FF5058C4FF121040710000000600000000000000000000
      00065759C3EFAFC6F6FF8EADF4FFABC4F8FF6F76D0FF1817456F24244F70868E
      E1FFB5CCF9FF8DACF4FFA1B8F4FF5758C3EF0000000900000000000000000000
      000331326B8695A0EAFFC0D3F9FF7880D7FF1C1C496B00000006000000072527
      526C8B93E6FFC1D3F9FF949EE9FF303168870000000500000000000000000000
      00010000000431336B825E62CBEC1F204D680000000500000001000000010000
      00052728536B5E62CBEC31326883000000070000000100000000000000000000
      0000000000000000000200000004000000020000000100000000000000000000
      0001000000030000000500000004000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    Margin = -1
  end
  object imageList: TcxImageList
    FormatVersion = 1
    DesignInfo = 18022746
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000002B2B2BB73C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF2B2B2BB700000000000000000000
          00000000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF00000000000000000000
          00000000000000000000000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF00000000000000000000
          00000000000000000000000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF0000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF0000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF0000000000000000000000003C3C3CFF3C3C3CFF00000000000000000000
          00000000000000000000000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF0000000000000000000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF0000000000000000000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF000000003C3C3CFF000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C
          3CFF0000000000000000000000002C2C2CBD3C3C3CFF000000003C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF2C2C2CBD000000003C3C3CFF3C3C
          3CFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000003C3C3CFF3C3C
          3CFF000000000000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF3C3C3CFF00000000000000000000000000000000000000003C3C3CFF3C3C
          3CFF000000000000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
          3CFF1E1E1E7E00000000000000000000000000000000000000003C3C3CFF3C3C
          3CFF000000000000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF1E1E
          1E7E0000000000000000000000000000000000000000000000003C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E0000
          00000000000000000000000000000000000000000000000000003C3C3CFF3C3C
          3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
end