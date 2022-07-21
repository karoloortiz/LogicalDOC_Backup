program test;

uses
  madExcept,
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form2},
  Backup in '..\..\src\Backup.pas',
  Logger in '..\..\src\Logger.pas',
  Main in '..\..\src\Main.pas',
  ConfigBackupIniManipulator in '..\..\src\ConfigBackupIniManipulator.pas',
  KLib.WaitForm in '..\..\src\boundaries\KLib\Delphi_FormUtils_Library\KLib.WaitForm.pas' {WaitForm},
  RegistroGO in '..\..\src\RegistroGO.pas',
  KLib.Constants in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Constants.pas',
  KLib.Generic in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Generic.pas',
  KLib.Graphics in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Graphics.pas',
  KLib.Indy in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Indy.pas',
  KLib.IniFiles in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.IniFiles.pas',
  KLib.Math in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Math.pas',
  KLib.MemoryRAM in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.MemoryRAM.pas',
  KLib.MyIdFTP in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.MyIdFTP.pas',
  KLib.MyIdHTTP in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.MyIdHTTP.pas',
  KLib.MyString in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.MyString.pas',
  KLib.MyStringList in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.MyStringList.pas',
  KLib.StreamWriterUTF8NoBOMEncoding in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.StreamWriterUTF8NoBOMEncoding.pas',
  KLib.Types in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Types.pas',
  KLib.Utils in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Utils.pas',
  KLib.Validate in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Validate.pas',
  KLib.VC_Redist in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.VC_Redist.pas',
  KLib.Windows in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.Windows.pas',
  KLib.WindowsService in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.WindowsService.pas',
  KLib.XML in '..\..\src\boundaries\KLib\Delphi_Utils_Library\KLib.XML.pas',
  KLib.Async in '..\..\src\boundaries\KLib\Delphi_Async_Library\KLib.Async.pas',
  KLib.AsyncMethod in '..\..\src\boundaries\KLib\Delphi_Async_Library\KLib.AsyncMethod.pas',
  KLib.MySQL.CLIUtilities in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.CLIUtilities.pas',
  KLib.MySQL.DriverPort in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.DriverPort.pas',
  KLib.MySQL.Info in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.Info.pas',
  KLib.MySQL.IniManipulator in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.IniManipulator.pas',
  KLib.MySQL.Process in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.Process.pas',
  KLib.MySQL.ProcessManager in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.ProcessManager.pas',
  KLib.MySQL.Service in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.Service.pas',
  KLib.MySQL.TemporaryTable in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.TemporaryTable.pas',
  KLib.MySQL.Utils in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.Utils.pas',
  KLib.MySQL.Validate in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\KLib.MySQL.Validate.pas',
  KLib.MySQL.MyDAC in '..\..\src\boundaries\KLib\Delphi_MySQL_Library\Devart\KLib.MySQL.MyDAC.pas';

{$r *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;

end.
