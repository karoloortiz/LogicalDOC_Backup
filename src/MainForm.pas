unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Main,
  Klib.Types, Klib.WaitForm;

type
  TMyForm = class(TForm)
    lbl_title: TLabel;
    lbl_error: TLabel;
    btn_executeBackup: TButton;
    btn_openFTPExplorer: TButton;
    btn_openSettings: TButton;
    btn_executeFTPBackup: TButton;
    procedure btn_openSettingsClick(Sender: TObject);
    procedure btn_openFTPExplorerClick(Sender: TObject);
    procedure btn_executeBackupClick(Sender: TObject);
    procedure btn_executeFTPBackupClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    main: TMain;
    waitForm: TWaitForm;
    callBacks: TCallBacks;

    shellParameters: string;
    onlyViewBackupsParameter: boolean;
    silentParameter: boolean;
    ftpParameter: boolean;
    procedure assignShellParameters;
    procedure tryToRestartWithAdminPrivileges;

    procedure reloadSettings;
    procedure setVisibilityOfComponents;
    procedure showModalWaitForm;
    procedure closeWaitForm;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  MyForm: TMyForm;

implementation

{$r *.dfm}


uses
  Config,
  FTPExplorer,
  Logger,
  Winapi.ShellApi,
  KLib.Utils, Klib.Windows;

const
  FTP_ENABLED = true;
  FTP_NOT_ENABLED = false;

constructor TMyForm.Create(AOwner: TComponent);
const
  FORCE_CLOSE_AFTER_EXECUTE = true;
begin
  inherited Create(AOwner);
  assignShellParameters;
  if not onlyViewBackupsParameter then
  begin
    tryToRestartWithAdminPrivileges;
  end;
  if silentParameter and not onlyViewBackupsParameter then
  begin
    main := TMain.create(FORCE_CLOSE_AFTER_EXECUTE);
    if ftpParameter then
    begin
      main.executeBackup(FTP_ENABLED);
    end
    else
    begin
      main.executeBackup(FTP_NOT_ENABLED);
    end;
  end
  else
  begin
    with callBacks do
    begin
      resolve := procedure(msg: string)
        begin
          ShowMessage(msg);
          closeWaitForm;
        end;
      reject := procedure(msg: string)
        begin
          ShowMessage(msg);
          closeWaitForm;
        end;
    end;
    main := TMain.create(callBacks);
    setVisibilityOfComponents;
    Show;
  end;
end;

procedure TMyForm.assignShellParameters;
{
  --only-view-backups overwrites all others parameter.
  --silent does a backup according config file
  --ftp works only if --silent parameter is setting
}
const
  ONLY_VIEW_BACKUPS_PARAMETER = '--only-view-backups';
  SILENT_PARAMETER = '--silent';
  FTP_PARAMETER = '--ftp';
var
  i: integer;
begin
  onlyViewBackupsParameter := false;
  silentParameter := false;
  ftpParameter := false;
  shellParameters := '';
  for i := 1 to ParamCount do
  begin
    if (paramstr(i) = ONLY_VIEW_BACKUPS_PARAMETER) then
    begin
      onlyViewBackupsParameter := true;
    end
    else if (paramstr(i) = SILENT_PARAMETER) then
    begin
      silentParameter := true;
    end
    else if (paramstr(i) = FTP_PARAMETER) then
    begin
      ftpParameter := true;
    end;
    shellParameters := shellParameters + paramstr(i) + '';
  end;
end;

procedure TMyForm.tryToRestartWithAdminPrivileges;
const
  EXCEPTION_IF_FUNCTION_FAIL = true;
begin
  if not IsUserAnAdmin then
  begin
    shellExecuteExeAsAdmin(Application.ExeName, shellParameters, _SW_SHOWNORMAL, EXCEPTION_IF_FUNCTION_FAIL);
    Halt(2);
  end;
end;

procedure TMyForm.btn_executeBackupClick(Sender: TObject);
var
  saveDialog: TSaveDialog;
  backupFileName: string;
  _fileName: string;
  _path: string;
begin
  backupFileName := main.getDefaultBackupFileName;
  _fileName := ExtractFileName(backupFileName);
  _path := ExtractFilePath(backupFileName);
  saveDialog := TSaveDialog.Create(self);
  saveDialog.FileName := _fileName;
  saveDialog.Title := 'Salva il backup';
  saveDialog.InitialDir := _path;
  saveDialog.Filter := 'Zip file|*.zip';
  saveDialog.DefaultExt := 'zip';
  saveDialog.FilterIndex := 1;
  if saveDialog.Execute then
  begin
    backupFileName := saveDialog.FileName;
    main.executeBackup(FTP_NOT_ENABLED, backupFileName);
    showModalWaitForm;
  end;
  saveDialog.Free;
end;

procedure TMyForm.btn_executeFTPBackupClick(Sender: TObject);
begin
  main.executeBackup(FTP_ENABLED);
  showModalWaitForm;
end;

procedure TMyForm.showModalWaitForm;
begin
  waitForm := TWaitForm.Create(self);
  waitForm.title := 'Backup in corso';
  waitForm.ShowModal;
end;

procedure TMyForm.closeWaitForm;
begin
  if Assigned(waitForm) then
  begin
    if waitForm.Visible then
    begin
      waitForm.close;
    end;
  end;
end;

procedure TMyForm.btn_openFTPExplorerClick(Sender: TObject);
begin
  TFTPFormExplorer.Create(main.FTPCredentials).ShowModal;
end;

procedure TMyForm.btn_openSettingsClick(Sender: TObject);
begin
  TConfigSettings.Create(nil).ShowModal;
  reloadSettings;
end;

procedure TMyForm.reloadSettings;
begin
  main.loadSettings;
  setVisibilityOfComponents;
end;

procedure TMyForm.setVisibilityOfComponents;
const
  ERR_MSG = 'Impostazioni non configurate correttamente';
  FTP_NOT_ENABLED = 'FTP non configurato correttamente';
begin
  btn_executeBackup.Enabled := (main.enabled) and (not onlyViewBackupsParameter);
  btn_executeFTPBackup.Enabled := (main.FTPEnabled) and (main.enabled) and (not onlyViewBackupsParameter);
  btn_openFTPExplorer.Enabled := main.FTPEnabled;
  btn_openSettings.Enabled := (not onlyViewBackupsParameter);
  lbl_error.Visible := ((not main.enabled) or (not main.FTPEnabled)) and (not onlyViewBackupsParameter) or ((not main.FTPEnabled) and onlyViewBackupsParameter);

  if ((main.enabled) and (not main.FTPEnabled)) or (onlyViewBackupsParameter) then
  begin
    lbl_error.Caption := FTP_NOT_ENABLED;
  end
  else
  begin
    lbl_error.Caption := ERR_MSG;
  end;
end;

procedure TMyForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(main);
end;

end.
