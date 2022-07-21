unit ConfigBackupIniManipulator;

interface

uses
  System.IniFiles;

type
  TConfigBackupProperties = record
    cartella_installazione: string;
    usernameMySQL: string;
    passwordMySQL: string;
    portaMySQL: integer;
    nome_servizioMySQL: string;
    usernameFTP: string;
    passwordFTP: string;
    serverFTP: string;
    cartella_backupFTP: string;
    cartella_backup_locale: string;
    nome_backup: string;
    mantieni_backup_locale: boolean;
  end;

  TConfigBackupIniManipulator = class(TIniFile)
  private
    function get_cartella_installazione: string;
    procedure set_cartella_installazione(value: string);
    function getUsernameMySQL: string;
    procedure setUsernameMySQL(value: string);
    function getPasswordMySQL: string;
    procedure setPasswordMySQL(value: string);
    function getPortaMySQL: integer;
    procedure setPortaMySQL(value: integer);
    function getNome_servizioMySQL: string;
    procedure setNome_servizioMySQL(value: string);
    function getUsernameFTP: string;
    procedure setUsernameFTP(value: string);
    function getPasswordFTP: string;
    procedure setPasswordFTP(value: string);
    function getServerFTP: string;
    procedure setServerFTP(value: string);
    function getCartella_backupFTP: string;
    procedure setCartella_backupFTP(value: string);
    function getCartella_backup_locale: string;
    procedure setCartella_backup_locale(value: string);
    function getNome_backup: string;
    procedure setNome_backup(value: string);
    function getMantieni_backup_locale: boolean;
    procedure validateNome_backup(value: string);
    procedure setMantieni_backup_locale(value: boolean);
    procedure validateMantieni_backup_locali(value: string);
  public
    constructor create; overload;
    function getProperties: TConfigBackupProperties;
    procedure setProperties(value: TConfigBackupProperties);
    property cartella_installazione: string read get_cartella_installazione write set_cartella_installazione;
    property usernameMySQL: string read getUsernameMySQL write setUsernameMySQL;
    property passwordMySQL: string read getPasswordMySQL write setPasswordMySQL;
    property portaMySQL: integer read getPortaMySQL write setPortaMySQL;
    property nome_servizioMySQL: string read getNome_servizioMySQL write setNome_servizioMySQL;
    property usernameFTP: string read getUsernameFTP write setUsernameFTP;
    property passwordFTP: string read getPasswordFTP write setPasswordFTP;
    property serverFTP: string read getServerFTP write setServerFTP;
    property cartella_backupFTP: string read getCartella_backupFTP write setCartella_backupFTP;
    property cartella_backup_locale: string read getCartella_backup_locale write setCartella_backup_locale;
    property nome_backup: string read getNome_backup write setNome_backup;
    property mantieni_backup_locale: boolean read getMantieni_backup_locale write setMantieni_backup_locale;
  end;

function getConfigBackupProperties: TConfigBackupProperties;
procedure setConfigBackupProperties(value: TConfigBackupProperties);

implementation


uses
  Klib.Utils, Klib.Windows,
  System.SysUtils, System.IOUtils;

const
  //TODO EXPORT
  DEFAULT_CARTELLA_INSTALLAZIONE_PROGRAMMA = 'C:\LogicalDOC';
  DEFAULT_USERNAME_MYSQL = 'root';
  DEFAULT_PASSWORD_MYSQL = 'masterkey';
  DEFAULT_PORT_MYSQL = 3306;
  DEFAULT_SERVICE_NAME_MYSQL = 'LogicalDOC_DB';

  //TODO ? ENV FILE ?
  PROGRAMMA_SECTION = 'programma';
  CARTELLA_INSTALLAZIONE_PROGRAMMA_PROPERTY = 'cartella_installazione';

  MYSQL_SECTION = 'mysql';
  USERNAME_MYSQL_PROPERTY = 'username';
  PASSWORD_MYSQL_PROPERTY = 'password';
  PORTA_MYSQL_PROPERTY = 'porta';
  NOME_SERVIZIO_MYSQL_PROPERTY = 'nome_servizio';

  FTP_SECTION = 'ftp';
  USERNAME_FTP_PROPERTY = 'username';
  PASSWORD_FTP_PROPERTY = 'password';
  SERVER_FTP_PROPERTY = 'server';
  CARTELLA_BACKUP_FTP_PROPERTY = 'cartella_backup';

  PREFERENZE_SECTION = 'preferenze';
  CARTELLA_BACKUP_LOCALE_PREFERENZE_PROPERTY = 'cartella_backup_locale';
  NOME_BACKUP_PREFERENZE_PROPERTY = 'nome_backup';
  MANTIENI_BACKUP_LOCALE_PREFERENZE_PROPERTY = 'mantieni_backup_locale';

function getConfigBackupProperties: TConfigBackupProperties;
var
  _configBackupIniManipulator: TConfigBackupIniManipulator;
  _configBackupProperties: TConfigBackupProperties;
begin
  _configBackupIniManipulator := TConfigBackupIniManipulator.create;
  _configBackupProperties := _configBackupIniManipulator.getProperties;
  _configBackupIniManipulator.setProperties(_configBackupProperties);
  FreeAndNil(_configBackupIniManipulator);

  Result := _configBackupProperties;
end;

procedure setConfigBackupProperties(value: TConfigBackupProperties);
var
  _configBackupIniManipulator: TConfigBackupIniManipulator;
begin
  _configBackupIniManipulator := TConfigBackupIniManipulator.create;
  _configBackupIniManipulator.setProperties(value);
  FreeAndNil(_configBackupIniManipulator);
end;

constructor TConfigBackupIniManipulator.create;
const
  FILENAME = 'configBackup.ini';
var
  _pathFile: string;
  _applicationDir: string;
begin
  _applicationDir := getDirExe;
  _pathFile := TPath.Combine(_applicationDir, FILENAME);
  createEmptyFileIfNotExists(_pathFile);
  inherited create(_pathFile);
end;

function TConfigBackupIniManipulator.getProperties: TConfigBackupProperties;
var
  _settings: TConfigBackupProperties;
begin
  with _settings do
  begin
    cartella_installazione := Self.cartella_installazione;
    usernameMySQL := Self.usernameMySQL;
    passwordMySQL := Self.passwordMySQL;
    portaMySQL := Self.portaMySQL;
    nome_servizioMySQL := Self.nome_servizioMySQL;
    usernameFTP := Self.usernameFTP;
    passwordFTP := Self.passwordFTP;
    serverFTP := Self.serverFTP;
    cartella_backupFTP := Self.cartella_backupFTP;
    cartella_backup_locale := Self.cartella_backup_locale;
    nome_backup := Self.nome_backup;
    mantieni_backup_locale := Self.mantieni_backup_locale;
  end;
  Result := _settings;
end;

procedure TConfigBackupIniManipulator.setProperties(value: TConfigBackupProperties);
begin
  with value do
  begin
    Self.cartella_installazione := cartella_installazione;
    Self.usernameMySQL := usernameMySQL;
    Self.passwordMySQL := passwordMySQL;
    Self.portaMySQL := portaMySQL;
    Self.nome_servizioMySQL := nome_servizioMySQL;
    Self.usernameFTP := usernameFTP;
    Self.passwordFTP := passwordFTP;
    Self.serverFTP := serverFTP;
    Self.cartella_backupFTP := cartella_backupFTP;
    Self.cartella_backup_locale := cartella_backup_locale;
    Self.nome_backup := nome_backup;
    Self.mantieni_backup_locale := mantieni_backup_locale;
  end;
end;

function TConfigBackupIniManipulator.get_cartella_installazione: string;
begin
  Result := ReadString(PROGRAMMA_SECTION, CARTELLA_INSTALLAZIONE_PROGRAMMA_PROPERTY, DEFAULT_CARTELLA_INSTALLAZIONE_PROGRAMMA);
end;

procedure TConfigBackupIniManipulator.set_cartella_installazione(value: string);
var
  _cartella_installazione: string;
begin
  _cartella_installazione := value;
  if _cartella_installazione = '' then
  begin
    _cartella_installazione := DEFAULT_CARTELLA_INSTALLAZIONE_PROGRAMMA;
  end;
  WriteString(PROGRAMMA_SECTION, CARTELLA_INSTALLAZIONE_PROGRAMMA_PROPERTY, _cartella_installazione);
end;

function TConfigBackupIniManipulator.getUsernameMySQL: string;
begin
  Result := ReadString(MYSQL_SECTION, USERNAME_MYSQL_PROPERTY, DEFAULT_USERNAME_MYSQL);
end;

procedure TConfigBackupIniManipulator.setUsernameMySQL(value: string);
var
  _usernameMySQL: string;
begin
  _usernameMySQL := value;
  if _usernameMySQL = '' then
  begin
    _usernameMySQL := DEFAULT_USERNAME_MYSQL;
  end;
  WriteString(MYSQL_SECTION, USERNAME_MYSQL_PROPERTY, _usernameMySQL);
end;

function TConfigBackupIniManipulator.getPasswordMySQL: string;
begin
  Result := ReadString(MYSQL_SECTION, PASSWORD_MYSQL_PROPERTY, DEFAULT_PASSWORD_MYSQL);
end;

procedure TConfigBackupIniManipulator.setPasswordMySQL(value: string);
var
  _passwordMySQL: string;
begin
  _passwordMySQL := value;
  if _passwordMySQL = '' then
  begin
    _passwordMySQL := DEFAULT_PASSWORD_MYSQL;
  end;
  WriteString(MYSQL_SECTION, PASSWORD_MYSQL_PROPERTY, _passwordMySQL);
end;

function TConfigBackupIniManipulator.getPortaMySQL: integer;
begin
  Result := ReadInteger(MYSQL_SECTION, PORTA_MYSQL_PROPERTY, DEFAULT_PORT_MYSQL);
end;

procedure TConfigBackupIniManipulator.setPortaMySQL(value: integer);
var
  _portMySQL: integer;
begin
  _portMySQL := value;
  if _portMySQL = 0 then
  begin
    _portMySQL := DEFAULT_PORT_MYSQL;
  end;
  WriteInteger(MYSQL_SECTION, PORTA_MYSQL_PROPERTY, _portMySQL);
end;

function TConfigBackupIniManipulator.getNome_servizioMySQL: string;
begin
  Result := ReadString(MYSQL_SECTION, NOME_SERVIZIO_MYSQL_PROPERTY, DEFAULT_SERVICE_NAME_MYSQL);
end;

procedure TConfigBackupIniManipulator.setNome_servizioMySQL(value: string);
var
  _nome_servizioMySQL: string;
begin
  _nome_servizioMySQL := value;
  if _nome_servizioMySQL = '' then
  begin
    _nome_servizioMySQL := DEFAULT_SERVICE_NAME_MYSQL;
  end;
  WriteString(MYSQL_SECTION, NOME_SERVIZIO_MYSQL_PROPERTY, _nome_servizioMySQL);
end;

function TConfigBackupIniManipulator.getUsernameFTP: string;
begin
  result := ReadString(FTP_SECTION, USERNAME_FTP_PROPERTY, '');
end;

procedure TConfigBackupIniManipulator.setUsernameFTP(value: string);
begin
  WriteString(FTP_SECTION, USERNAME_FTP_PROPERTY, value);
end;

function TConfigBackupIniManipulator.getPasswordFTP: string;
begin
  Result := ReadString(FTP_SECTION, PASSWORD_FTP_PROPERTY, '');
end;

procedure TConfigBackupIniManipulator.setPasswordFTP(value: string);
begin
  WriteString(FTP_SECTION, PASSWORD_FTP_PROPERTY, value);
end;

function TConfigBackupIniManipulator.getServerFTP: string;
begin
  Result := ReadString(FTP_SECTION, SERVER_FTP_PROPERTY, '');
end;

procedure TConfigBackupIniManipulator.setServerFTP(value: string);
begin
  WriteString(FTP_SECTION, SERVER_FTP_PROPERTY, value);
end;

function TConfigBackupIniManipulator.getCartella_backupFTP: string;
begin
  Result := ReadString(FTP_SECTION, CARTELLA_BACKUP_FTP_PROPERTY, '');
end;

procedure TConfigBackupIniManipulator.setCartella_backupFTP(value: string);
begin
  WriteString(FTP_SECTION, CARTELLA_BACKUP_FTP_PROPERTY, value);
end;

function TConfigBackupIniManipulator.getCartella_backup_locale: string;
var
  _path: string;
begin
  _path := ReadString(PREFERENZE_SECTION, CARTELLA_BACKUP_LOCALE_PREFERENZE_PROPERTY, '');
  _path := getValidFullPathInWindowsStyle(_path);
  Result := _path;
end;

procedure TConfigBackupIniManipulator.setCartella_backup_locale(value: string);
var
  _path: string;
begin
  _path := getValidFullPathInWindowsStyle(value);
  WriteString(PREFERENZE_SECTION, CARTELLA_BACKUP_LOCALE_PREFERENZE_PROPERTY, _path);
end;

function TConfigBackupIniManipulator.getNome_backup: string;
var
  _value: string;
begin
  _value := ReadString(PREFERENZE_SECTION, NOME_BACKUP_PREFERENZE_PROPERTY, 'data_ora');
  _value := LowerCase(_value);
  validateNome_backup(_value);
  Result := _value;
end;

procedure TConfigBackupIniManipulator.setNome_backup(value: string);
var
  _value: string;
begin
  _value := LowerCase(value);
  validateNome_backup(_value);
  WriteString(PREFERENZE_SECTION, NOME_BACKUP_PREFERENZE_PROPERTY, _value);
end;

procedure TConfigBackupIniManipulator.validateNome_backup(value: string);
begin
  if (value <> 'standard') and (value <> 'data_ora') and (value <> 'giorno_settimana') then
  begin
    raise Exception.Create('Valore non consentito per il campo "' +
      NOME_BACKUP_PREFERENZE_PROPERTY + '".');
  end;
end;

function TConfigBackupIniManipulator.getMantieni_backup_locale: boolean;
var
  _value: string;
  _result: boolean;
begin
  _value := ReadString(PREFERENZE_SECTION, MANTIENI_BACKUP_LOCALE_PREFERENZE_PROPERTY, 'si');
  _value := LowerCase(_value);
  validateMantieni_backup_locali(_value);
  if _value = 'si' then
  begin
    _result := true;
  end
  else
  begin
    _result := false;
  end;
  Result := _result;
end;

procedure TConfigBackupIniManipulator.setMantieni_backup_locale(value: boolean);
var
  _value: string;
begin
  if value then
  begin
    _value := 'si';
  end
  else
  begin
    _value := 'no';
  end;
  WriteString(PREFERENZE_SECTION, MANTIENI_BACKUP_LOCALE_PREFERENZE_PROPERTY, _value);
end;

procedure TConfigBackupIniManipulator.validateMantieni_backup_locali(value: string);
begin
  if (value <> 'si') and (value <> 'no') then
  begin
    raise Exception.Create('Valore non consentito per il campo "' +
      MANTIENI_BACKUP_LOCALE_PREFERENZE_PROPERTY + '".');
  end;
end;

end.
