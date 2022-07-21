unit Main;

interface

uses
  ConfigBackupIniManipulator, Backup,
  KLib.Types,
  KLib.MySQL.Info;

type
  TMain = class
  private
    callBacks: TCallBacks;
    settings: TConfigBackupProperties;
    mysqlCredentials: TMySQLCredentials;
    DB_path: string;
    procedure setSettings;
    procedure setMySQLCredentials;
    procedure setFTPCredentials;
    procedure setEnabled;
    procedure validatePaths;
    procedure validatePathCartella_backup_locale;
    procedure validatePathDB;
    procedure setPathDB;
    procedure validate_installation_path;
    procedure setFTPEnabled;
    function getTBackup: TBackup;
  public
    FTPCredentials: TFTPCredentials;
    FTPEnabled: boolean;
    enabled: boolean;
    constructor create(callbacks: TCallBacks; forceCloseAfterExecute: boolean = false); overload;
    constructor create(forceCloseAfterExecute: boolean = false); overload;
    procedure loadSettings;
    procedure executeBackup(ftpBackup: boolean; backupFileName: string = '');
    function getDefaultBackupFileName: string;
  end;

implementation

uses
  Logger,
  KLib.MySQL.Validate, KLib.MySQL.Utils,
  Klib.Utils, KLib.Windows, KLib.Validate, KLib.WindowsService,
  System.SysUtils, System.IOUtils;

constructor TMain.create(callbacks: TCallBacks; forceCloseAfterExecute: boolean = false);
var
  newCallbacks: TCallBacks;
  _defaultCallbacks: TCallBacks;
begin
  create(forceCloseAfterExecute);
  _defaultCallbacks := self.callBacks;
  with newCallbacks do
  begin
    resolve := procedure(msg: string)
      begin
        _defaultCallbacks.resolve(msg);
        callbacks.resolve(msg);
      end;
    reject := procedure(msg: string)
      begin
        _defaultCallbacks.reject(msg);
        callbacks.reject(msg);
      end;
  end;
  self.callBacks := newCallbacks;
end;

constructor TMain.create(forceCloseAfterExecute: boolean = false);
begin
  with callbacks do
  begin
    resolve := procedure(msg: string)
      begin
        TLogger.writeInLogFile(msg);
        if forceCloseAfterExecute then
        begin
          halt(0);
        end;
      end;
    reject := procedure(msg: string)
      begin
        TLogger.writeErrorInLogFile(msg);
        if forceCloseAfterExecute then
        begin
          halt(1);
        end;
      end;
  end;
  loadSettings;
end;

procedure TMain.loadSettings;
begin
  setSettings;
  setEnabled; //TODO : NOT EXECUTE IF ONLYVIEW PROPERTY IS SET, TODO DISABLE SECTION CONFIG MYSQL
  setFTPEnabled;
end;

procedure TMain.setSettings;
begin
  settings := getConfigBackupProperties;
  setMySQLCredentials;
  setFTPCredentials;
end;

procedure TMain.setMySQLCredentials;
begin
  with settings do
  begin
    with mysqlCredentials do
    begin
      with credentials do
      begin
        username := usernameMySQL;
        password := passwordMySQL;
      end;
      server := 'localhost';
      port := portaMySQL;
      database := '';
    end;
  end;
end;

procedure TMain.setFTPCredentials;
begin
  with settings do
  begin
    with FTPCredentials do
    begin
      server := serverFTP;
      with credentials do
      begin
        username := usernameFTP;
        password := passwordFTP;
      end;
      pathFTPDir := cartella_backupFTP;
      transferType := ftBinary;
    end;
  end;
end;

procedure TMain.setEnabled;
const
  ERR_MSG_SERVICE_NOT_EXISTS = 'Servizio inesistente.';
begin
  try
    validateMysqlCredentials(mysqlCredentials);
    validateThatServiceExists(settings.nome_servizioMySQL, ERR_MSG_SERVICE_NOT_EXISTS);
    validatePaths;
    enabled := true;
  except
    on E: Exception do
    begin
      enabled := false;
      callBacks.reject(e.Message);
    end;
  end;
end;

procedure TMain.validatePaths;
begin
  validatePathCartella_backup_locale;
  validatePathDB;
  validate_installation_path;
end;

procedure TMain.validatePathCartella_backup_locale;
const
  ERR_MSG = 'Cartella backup locale inesistente.';
var
  _applicationDir: string;
begin
  if settings.cartella_backup_locale = '' then
  begin
    _applicationDir := getDirExe;
    settings.cartella_backup_locale := getValidFullPathInWindowsStyle(_applicationDir);
  end
  else
  begin
    validateThatDirExists(settings.cartella_backup_locale, ERR_MSG);
  end;
end;

procedure TMain.validatePathDB;
const
  ERR_MSG = 'Cartella datadir inesistente sul PC.';
begin
  setPathDB;
  validateThatDirExists(DB_path, ERR_MSG);
end;

procedure TMain.setPathDB;
begin
  DB_path := getMySQLDataDir(mysqlCredentials);
  DB_path := getValidFullPathInWindowsStyle(DB_path);
end;

procedure TMain.validate_installation_path;
const
  ERR_MSG = 'Cartella installazione non esistente';
begin
  validateThatDirExists(settings.cartella_installazione, ERR_MSG);
end;

procedure TMain.setFTPEnabled;
begin
  try
    validateFTPCredentials(FTPCredentials);
    FTPEnabled := true;
  except
    on E: Exception do
    begin
      FTPCredentials.clear;
      FTPEnabled := false;
    end;
  end;
end;

procedure TMain.executeBackup(ftpBackup: boolean; backupFileName: string = '');
const
  ERR_MSG = 'Impostazioni non corrette.';
var
  _backupFileName: string;
  _backup: TBackup;
begin
  if enabled then
  begin
    _backupFileName := backupFileName;
    if backupFileName = '' then
    begin
      _backupFileName := getDefaultBackupFileName;
    end;
    _backup := getTBackup;
    _backup.executeBackup(_backupFileName, ftpBackup, FTPCredentials, settings.mantieni_backup_locale);
  end
  else
  begin
    callBacks.reject(ERR_MSG);
  end;
end;

function TMain.getTBackup: TBackup;
var
  backup: TBackup;
  _backupCreateInfo: TBackupCreateInfo;
begin
  with _backupCreateInfo do
  begin
    serviceName := settings.nome_servizioMySQL;
    pathDB := Self.DB_path;
    pathInstallation := settings.cartella_installazione;
  end;
  backup := TBackup.create(_backupCreateInfo, callbacks);
  Result := backup;
end;

function TMain.getDefaultBackupFileName: string;
var
  defaultBackupFileName: string;
begin
  if settings.nome_backup = 'standard' then
  begin
    defaultBackupFileName := TBackup.getBackupFileNameStandard;
  end
  else if settings.nome_backup = 'data_ora' then
  begin
    defaultBackupFileName := TBackup.getBackupFileNameDateTime;
  end
  else if settings.nome_backup = 'giorno_settimana' then
  begin
    defaultBackupFileName := TBackup.getBackupFileNameDayOfWeek;
  end;

  result := TPath.Combine(settings.cartella_backup_locale, defaultBackupFileName);
end;

end.
