program LogicalDOC_Backup;

uses
  madExcept,
  Vcl.Forms,
  MainForm in 'MainForm.pas' {MyForm},
  Main in 'Main.pas',
  Config in 'Config.pas' {ConfigSettings},
  ConfigBackupIniManipulator in 'ConfigBackupIniManipulator.pas',
  FTPExplorer in 'FTPExplorer.pas' {FTPFormExplorer},
  Backup in 'Backup.pas',
  Logger in 'Logger.pas',
  KLib.WaitForm in 'boundaries\KLib\Delphi_FormUtils_Library\KLib.WaitForm.pas' {WaitForm},
  KLib.Async in 'boundaries\KLib\Delphi_Async_Library\KLib.Async.pas',
  KLib.MySQL.Info in 'boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.Info.pas',
  KLib.AsyncMethod in 'boundaries\KLib\Delphi_Async_Library\KLib.AsyncMethod.pas',
  KLib.MySQL.IniManipulator in 'boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.IniManipulator.pas',
  KLib.MySQL.Utils in 'boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.Utils.pas',
  KLib.MySQL.Validate in 'boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.Validate.pas',
  KLib.MySQL.DriverPort in 'boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.DriverPort.pas',
  KLib.Constants in 'boundaries\KLib\Delphi_Utils_Library\KLib.Constants.pas',
  KLib.Generic in 'boundaries\KLib\Delphi_Utils_Library\KLib.Generic.pas',
  KLib.Graphics in 'boundaries\KLib\Delphi_Utils_Library\KLib.Graphics.pas',
  KLib.Indy in 'boundaries\KLib\Delphi_Utils_Library\KLib.Indy.pas',
  KLib.IniFiles in 'boundaries\KLib\Delphi_Utils_Library\KLib.IniFiles.pas',
  KLib.Math in 'boundaries\KLib\Delphi_Utils_Library\KLib.Math.pas',
  KLib.MemoryRAM in 'boundaries\KLib\Delphi_Utils_Library\KLib.MemoryRAM.pas',
  KLib.MyIdFTP in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyIdFTP.pas',
  KLib.MyIdHTTP in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyIdHTTP.pas',
  KLib.MyString in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyString.pas',
  KLib.MyStringList in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyStringList.pas',
  KLib.StreamWriterUTF8NoBOMEncoding in 'boundaries\KLib\Delphi_Utils_Library\KLib.StreamWriterUTF8NoBOMEncoding.pas',
  KLib.Types in 'boundaries\KLib\Delphi_Utils_Library\KLib.Types.pas',
  KLib.Utils in 'boundaries\KLib\Delphi_Utils_Library\KLib.Utils.pas',
  KLib.Validate in 'boundaries\KLib\Delphi_Utils_Library\KLib.Validate.pas',
  KLib.VC_Redist in 'boundaries\KLib\Delphi_Utils_Library\KLib.VC_Redist.pas',
  KLib.Windows in 'boundaries\KLib\Delphi_Utils_Library\KLib.Windows.pas',
  KLib.WindowsService in 'boundaries\KLib\Delphi_Utils_Library\KLib.WindowsService.pas',
  KLib.XML in 'boundaries\KLib\Delphi_Utils_Library\KLib.XML.pas',
  KLib.MySQL.MyDAC in 'boundaries\KLib\Delphi_MySQL_Library\Devart\KLib.MySQL.MyDAC.pas';

{$r *.res}


begin
{$ifdef DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$endif}
  Application.Initialize;
  Application.Title := 'Programma di backup';
  Application.ShowMainForm := False;
  Application.CreateForm(TMyForm, MyForm);
  Application.MainFormOnTaskbar := True;
  Application.Run;

end.
