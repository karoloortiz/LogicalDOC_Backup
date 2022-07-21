unit Backup;

interface

uses
  KLib.MyIdFTP,
  KLib.Types;

type

  TBackupCreateInfo = record
    serviceName: string;
    pathDB: string;
    pathInstallation: string;
  end;

  TBackupFolderInfo = record
    pathFolder: string;
    backupFileName: string;
  end;

  TArrayOfBackupFolderInfo = array of TBackupFolderInfo;

  TBackup = class
  private
    info: TBackupCreateInfo;
    callBacks: TCallBacks;
    backupFileName: string;
    ftp: TMyIdFTP;
    isPathDBASubFolderOfInstallation: boolean;
    function getPathBackupDB: string;
    function getPathBackupInstallationGO: string;
    property backupDBFileName: string read getPathBackupDB;
    property backupInstallationFileName: string read getPathBackupInstallationGO;
    procedure createAsyncMethodsOfBackupFolders(onComplete: TCallBack);
    function getBackupFolderAnonymousMethods(backupFolderInfos: TArrayOfBackupFolderInfo): TArrayOfAnonymousMethods;
    function getBackupFolderAnonymousMethod(backupFolderInfo: TBackupFolderInfo): KLib.Types.TAnonymousMethod;
    procedure preBackupTasks;
    procedure postBackupTasks;
    procedure createBackupFile;
    procedure mergeBackupFiles;
    procedure deleteTempFiles;
    procedure tryToCopyInFTP(ftpCredentials: TFTPCredentials; keepLocalBackup: boolean);
    procedure resolveWithMsg;
    procedure rejectWithMessage(msg: string);
    class function getBackupFileName(nameBackup: string): string;
  public
    class function getBackupFileNameStandard: string;
    class function getBackupFileNameDayOfWeek: string;
    class function getBackupFileNameDateTime: string;
    constructor create(backupCreateInfo: TBackupCreateInfo; callbacks: TCallBacks);
    procedure executeBackup(backupFileName: string; ftpBackup: boolean; ftpCredentials: TFTPCredentials; keepLocalBackup: boolean);
  end;

implementation

uses
  KLib.AsyncMethod,
  KLib.Windows, KLib.Utils, KLib.Constants, KLib.WindowsService,
  Winapi.Windows,
  System.SysUtils, System.IOUtils, System.Zip;

class function TBackup.getBackupFileNameStandard: string;
var
  _nameBackup: string;
begin
  _nameBackup := getBackupFileName('LogicalDOC');
  result := _nameBackup;
end;

class function TBackup.getBackupFileNameDayOfWeek: string;
var
  _dayOfWeek: string;
  _nameBackup: string;
begin
  _dayOfWeek := getCurrentDayOfWeekAsString;
  _nameBackup := getBackupFileName(_dayOfWeek);
  result := _nameBackup;
end;

class function TBackup.getBackupFileNameDateTime: string;
var
  _dateTime: string;
  _nameBackup: string;
begin
  _dateTime := getCurrentDateTimeAsString;
  _nameBackup := getBackupFileName(_dateTime);
  result := _nameBackup;
end;

class function TBackup.getBackupFileName(nameBackup: string): string;
begin
  result := 'BCK_' + nameBackup + '.zip';
end;

constructor TBackup.create(backupCreateInfo: TBackupCreateInfo; callBacks: TCallBacks);
begin
  info := backupCreateInfo;
  with info do
  begin
    Self.isPathDBASubFolderOfInstallation := checkIfIsWindowsSubDir(pathDB, pathInstallation);
  end;
  Self.callBacks := callbacks;
end;

procedure TBackup.executeBackup(backupFileName: string; ftpBackup: boolean; ftpCredentials: TFTPCredentials; keepLocalBackup: boolean);
var
  onCompleteBackupFolders: TCallBack;
begin
  Self.backupFileName := backupFileName;

  deleteTempFiles;

  preBackupTasks;

  onCompleteBackupFolders := procedure(msg: string)
    begin
      try
        postBackupTasks;

        createBackupFile;
        deleteTempFiles;

        if ftpBackup then
        begin
          tryToCopyInFTP(ftpCredentials, keepLocalBackup);
        end;

        resolveWithMsg;
      except
        on E: Exception do
        begin
          rejectWithMessage(e.Message);
        end;
      end;
    end;
  createAsyncMethodsOfBackupFolders(onCompleteBackupFolders);
end;

//todo rename
procedure TBackup.createAsyncMethodsOfBackupFolders(onComplete: TCallBack);
var
  asyncMethods: TAsyncMethods;
  backupCallBacks: TCallBacks;
  _backupFolderInfo: TBackupFolderInfo;
  _backupFolderInfos: TArrayOfBackupFolderInfo;
  _backupFolderAnonymousMethods: TArrayOfAnonymousMethods;
begin
  if isPathDBASubFolderOfInstallation then
  begin
    SetLength(_backupFolderInfos, 1);
  end
  else
  begin
    SetLength(_backupFolderInfos, 2);
    with _backupFolderInfo do
    begin
      pathFolder := info.pathDB;
      backupFileName := Self.backupDBFileName;
    end;
    _backupFolderInfos[1] := _backupFolderInfo;
  end;
  with _backupFolderInfo do
  begin
    pathFolder := info.pathInstallation;
    backupFileName := Self.backupInstallationFileName;
  end;
  _backupFolderInfos[0] := _backupFolderInfo;

  _backupFolderAnonymousMethods := getBackupFolderAnonymousMethods(_backupFolderInfos);
  with backupCallBacks do
  begin
    resolve := procedure(value: String)
      const
        MSG_RESOLVE = 'Compressione cartelle completato';
      begin
        onComplete(MSG_RESOLVE);
      end;
    reject := procedure(value: String)
      var
        _errMsg: string;
      begin
        _errMsg := 'Errore compressione cartelle : ' + value;
        rejectWithMessage(_errMsg);
      end;
  end;
  asyncMethods := TAsyncMethods.Create(_backupFolderAnonymousMethods, backupCallBacks);
end;

function TBackup.getBackupFolderAnonymousMethods(backupFolderInfos: TArrayOfBackupFolderInfo): TArrayOfAnonymousMethods;
var
  i: Integer;
  _anonymousMethods: TArrayOfAnonymousMethods;
begin
  SetLength(_anonymousMethods, Length(backupFolderInfos));
  for i := 0 to Length(backupFolderInfos) - 1 do
  begin
    _anonymousMethods[i] := getBackupFolderAnonymousMethod(backupFolderInfos[i]);
  end;
  result := _anonymousMethods;
end;

function TBackup.getBackupFolderAnonymousMethod(backupFolderInfo: TBackupFolderInfo): KLib.Types.TAnonymousMethod;
var
  _errMsg: string;
begin
  Result := procedure
    begin
      try
        TZipFile.ZipDirectoryContents(backupFolderInfo.backupFileName, backupFolderInfo.pathFolder);
      except
        on E: Exception do
        begin
          _errMsg := 'File temporaneo ' + backupFolderInfo.backupFileName + ' non generato correttamente. -> ' + E.message;
          raise Exception.Create(_errMsg);
        end;
      end;
      if not TZipFile.IsValid(backupFolderInfo.backupFileName) then
      begin
        _errMsg := 'File temporaneo ' + backupFolderInfo.backupFileName + ' non valido.';
        raise Exception.Create(_errMsg);
      end;
    end;
end;

procedure TBackup.preBackupTasks;
  procedure stopDBService;
  const
    NAME_MACHINE = '';
    FORCE_STOP = TRUE;
    ERR_MSG = 'Impossibile fermare il servizio del database';
  begin
    try
      TWindowsService.stop(info.serviceName, NAME_MACHINE, FORCE_STOP);
    except
      on E: Exception do
      begin
        raise Exception.Create(ERR_MSG);
      end;
    end;
  end;

  procedure stopLogicalDOC;
  const
    ERR_MSG = 'Impossibile fermare il servizio LogicalDOC';
  var
    _LogicalDOC_fileName: string;
    _params: string;
  begin
    _LogicalDOC_fileName := getCombinedPath(info.pathInstallation, 'tomcat\bin\LogicalDOC.exe');
    _params := 'stop';
    try
      shellExecuteExAndWait(_LogicalDOC_fileName, _params, RUN_AS_ADMIN, _SW_HIDE, RAISE_EXCEPTION);
    except
      on E: Exception do
      begin
        raise Exception.Create(ERR_MSG);
      end;
    end;
  end;

begin
  stopDBService;
  stopLogicalDOC;
end;

procedure TBackup.postBackupTasks;
  procedure startDBService;
  const
    ERR_MSG = 'Impossibile riavviare il servizio del database';
  begin
    try
      TWindowsService.start(info.serviceName);
    except
      on E: Exception do
      begin
        raise Exception.Create(ERR_MSG);
      end;
    end;
  end;

  procedure startLogicalDOC;
  const
    ERR_MSG = 'Impossibile fermare il servizio LogicalDOC';
  var
    _LogicalDOC_fileName: string;
    _params: string;
  begin
    _LogicalDOC_fileName := getCombinedPath(info.pathInstallation, 'tomcat\bin\LogicalDOC.exe');
    _params := 'start';
    try
      shellExecuteExAndWait(_LogicalDOC_fileName, _params, RUN_AS_ADMIN, _SW_HIDE, RAISE_EXCEPTION);
    except
      on E: Exception do
      begin
        raise Exception.Create(ERR_MSG);
      end;
    end;
  end;

begin
  startDBService;
  startLogicalDOC;
end;

procedure TBackup.createBackupFile;
const
  ERR_MSG = 'Backup non eseguito correttamente';
begin
  if not isPathDBASubFolderOfInstallation then
  begin
    mergeBackupFiles;
  end
  else
  begin
    if not RenameFile(backupInstallationFileName, backupFileName) then
    begin
      raise Exception.Create(ERR_MSG);
    end;
  end;

  if not TZipFile.IsValid(backupFileName) then
  begin
    raise Exception.Create(ERR_MSG);
  end;
end;

procedure TBackup.mergeBackupFiles;
var
  _zip: TZipFile;
begin
  _zip := TZipFile.Create;
  _zip.Open(backupFileName, zmWrite);
  _zip.Add(backupInstallationFileName);
  _zip.Add(backupDBFileName);
  _zip.close;
  _zip.Free;
end;

procedure TBackup.deleteTempFiles;
begin
  deleteFileIfExists(backupDBFileName);
  deleteFileIfExists(backupInstallationFileName);
end;

procedure TBackup.tryToCopyInFTP(ftpCredentials: TFTPCredentials; keepLocalBackup: boolean);
var
  _nameBackup: string;
begin
  ftp := getValidMyIdFTP(ftpCredentials);

  _nameBackup := ExtractFileName(backupFileName);
  ftp.Connect;
  ftp.Put(backupFileName, _nameBackup, FORCE_OVERWRITE);
  ftp.Disconnect;
  ftp.Free;
  if not keepLocalBackup then
  begin
    deleteFileIfExists(backupFileName);
  end;
end;

procedure TBackup.resolveWithMsg;
var
  _msg: string;
  _nameBackup: string;
begin
  _msg := 'Backup = ' + ansiQuotedStr(backupFileName, '"') + ' eseguito correttamente';
  if Assigned(ftp) then
  begin
    _nameBackup := ExtractFileName(backupFileName);
    _msg := 'Backup = ' + ansiQuotedStr(_nameBackup, '"') + ' eseguito correttamente su server FTP';
  end;
  callBacks.resolve(_msg);
end;

procedure TBackup.rejectWithMessage(msg: string);
var
  _msg: string;
begin
  postBackupTasks;
  _msg := 'BACKUP = ' + ansiQuotedStr(backupFileName, '"') + ' NON ESEGUITO : ' + msg;
  callBacks.reject(_msg)
end;

function TBackup.getPathBackupDB: string;
var
  dirExecutedBackup: string;
  fileName: string;
begin
  dirExecutedBackup := ExtractFilePath(backupFileName);
  fileName := info.pathDB;
  fileName := ExtractFileName(fileName);
  fileName := fileName + '.zip';
  result := TPath.Combine(dirExecutedBackup, fileName)
end;

function TBackup.getPathBackupInstallationGO: string;
var
  dirExecutedBackup: string;
  fileName: string;
begin
  dirExecutedBackup := ExtractFilePath(backupFileName);
  fileName := info.pathInstallation;
  fileName := ExtractFileName(fileName);
  fileName := fileName + '.zip';
  result := TPath.Combine(dirExecutedBackup, fileName)
end;

end.
