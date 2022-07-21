unit Config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, RzPanel, Vcl.StdCtrls,
  RzLabel, RzButton, RzRadChk, Vcl.Buttons, RzSpnEdt;

type
  TConfigSettings = class(TForm)
    _usernameMySQL_lbl: TRzLabel;
    usernameMySQL: TEdit;
    mysql_groupBox: TRzGroupBox;
    ftp_groupBox: TRzGroupBox;
    passwordMySQL: TEdit;
    _passwordMySQL_lbl: TRzLabel;
    nome_servizioMySQL: TEdit;
    _nome_servizioMySQL_lbl: TRzLabel;
    portaMySQL: TEdit;
    _portaMySQL_lbl: TRzLabel;
    usernameFTP: TEdit;
    _usernameFTP_lbl: TRzLabel;
    passwordFTP: TEdit;
    _passwordFTP_lbl: TRzLabel;
    serverFTP: TEdit;
    _serverFTP_lbl: TRzLabel;
    preferenze_groupBox: TRzGroupBox;
    mantieni_backup_locale: TRzCheckBox;
    salva_btn: TRzBitBtn;
    cartella_backupFTP: TEdit;
    _cartella_backupFTP_lbl: TRzLabel;
    cartella_backup_locale: TEdit;
    _cartella_backup_locale_lbl: TRzLabel;
    esci_btn: TRzBitBtn;
    nome_backup: TComboBox;
    _nomeBackup_lbl: TRzLabel;
    programma_groupBox: TRzGroupBox;
    cartella_installazione_lbl: TRzLabel;
    cartella_installazione: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure salva_btnClick(Sender: TObject);
    procedure esci_btnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure loadSettings;
    procedure saveSettings;
  public
    { Public declarations }
  end;

implementation

{$r *.dfm}


uses
  ConfigBackupIniManipulator;
//TODO:
//-TEST SERVICE EXISTS
//-CONNECTION MYSQL
//-CONNECTION FTP
//-WINDOWS SCHELUDER

procedure TConfigSettings.FormCreate(Sender: TObject);
CONST
  NOME_BACKUP_STANDARD = 'standard';
  NOME_BACKUP_DATA_ORA = 'data_ora';
  NOME_BACKUP_GIORNO_SETTIMANA = 'giorno_settimana';
begin
  nome_backup.Items.Clear;
  nome_backup.Items.Add(NOME_BACKUP_STANDARD);
  nome_backup.Items.Add(NOME_BACKUP_DATA_ORA);
  nome_backup.Items.Add(NOME_BACKUP_GIORNO_SETTIMANA);
  loadSettings;
end;

procedure TConfigSettings.loadSettings;
var
  _settings: TConfigBackupProperties;
begin
  _settings := getConfigBackupProperties;
  with _settings do
  begin
    Self.cartella_installazione.Text := cartella_installazione;
    Self.usernameMySQL.Text := usernameMySQL;
    Self.passwordMySQL.Text := passwordMySQL;
    Self.portaMySQL.Text := inttostr(portaMySQL);
    Self.nome_servizioMySQL.Text := nome_servizioMySQL;
    Self.usernameFTP.Text := usernameFTP;
    Self.passwordFTP.Text := passwordFTP;
    Self.serverFTP.Text := serverFTP;
    Self.cartella_backupFTP.Text := cartella_backupFTP;
    Self.cartella_backup_locale.Text := cartella_backup_locale;
    self.nome_backup.Text := nome_backup;
    self.mantieni_backup_locale.Checked := mantieni_backup_locale;
  end;
end;

procedure TConfigSettings.salva_btnClick(Sender: TObject);
begin
  saveSettings;
  close;
end;

procedure TConfigSettings.saveSettings;
var
  _settings: TConfigBackupProperties;
begin
  with _settings do
  begin
    cartella_installazione := Self.cartella_installazione.Text;
    usernameMySQL := Self.usernameMySQL.Text;
    passwordMySQL := Self.passwordMySQL.Text;
    portaMySQL := strtoint(Self.portaMySQL.Text);
    nome_servizioMySQL := Self.nome_servizioMySQL.Text;
    usernameFTP := Self.usernameFTP.Text;
    passwordFTP := Self.passwordFTP.Text;
    serverFTP := Self.serverFTP.Text;
    cartella_backupFTP := Self.cartella_backupFTP.Text;
    cartella_backup_locale := Self.cartella_backup_locale.Text;
    nome_backup := Self.nome_backup.Text;
    mantieni_backup_locale := Self.mantieni_backup_locale.Checked;
  end;
  setConfigBackupProperties(_settings);
end;

procedure TConfigSettings.esci_btnClick(Sender: TObject);
begin
  close;
end;

procedure TConfigSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
