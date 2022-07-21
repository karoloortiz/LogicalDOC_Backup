unit FTPExplorer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, RzListVw, RzShellCtrls,
  Vcl.StdCtrls,  Winapi.ShlObj, cxShellCommon, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxListView, cxShellListView, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, IdFTPCommon, RzShellDialogs, RzButton,
  Vcl.Buttons, RzSpnEdt,
  Klib.Types, KLib.MyIdFTP;

type
  TFTPFormExplorer = class(TForm)
    imageList: TcxImageList;
    btn_download: TRzBitBtn;
    listView_FTPBackups: TRzListView;
    lbl_serverFTP: TLabel;
    _lbl_serverFTP: TLabel;
    btn_delete: TRzBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure btn_downloadClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ftp: TMyIdFTP;
    procedure refreshListView;
    function getSelectedBackupFileName: string;
    procedure deleteBackup;
    procedure tryToDeleteBackup;
    function getDownloadBackupFileName: string;
    procedure downloadBackup;
  public
    constructor Create(ftpCredentials: TFTPCredentials); reintroduce; overload;
    property selectedBackupFileName: string read getSelectedBackupFileName;
  end;

var
  FTPFormExplorer: TFTPFormExplorer;

implementation

{$r *.dfm}


uses
  Klib.Utils,
  System.UITypes;

constructor TFTPFormExplorer.Create(ftpCredentials: TFTPCredentials);
begin
  Create(nil);
  ftp := getValidMyIdFTP(ftpCredentials);
  ftp.connect;
  refreshListView;
  lbl_serverFTP.Caption := ftp.Host + ftp.RetrieveCurrentDir;
end;

//TODO REFACTOR ? // duplicate code smell
procedure TFTPFormExplorer.btn_deleteClick(Sender: TObject);
begin
  if selectedBackupFileName <> '' then
  begin
    tryToDeleteBackup;
  end
  else
  begin
    ShowMessage('E'' neccessario selezionario un elemento prima di procedere.');
  end;
end;

procedure TFTPFormExplorer.tryToDeleteBackup;
var
  buttonSelected: Integer;
begin
  buttonSelected := messagedlg('Confermare la cancellazione del backup selezionato?', mtConfirmation, mbOKCancel, 0);
  if buttonSelected = mrOK then
  begin
    deleteBackup;
  end;
end;

procedure TFTPFormExplorer.deleteBackup;
begin
  ftp.Delete(selectedBackupFileName);
  ShowMessage('Backup eliminato');
  refreshListView;
end;

//TODO ADD DATE FILE IN LIST
procedure TFTPFormExplorer.refreshListView;
const
  VALID_BCK_FILE_PATTERN = 'BCK_*.zip';
var
  i: Integer;
begin
  listView_FTPBackups.Items.Clear;
  ftp.List(VALID_BCK_FILE_PATTERN, false);
  for i := 0 to ftp.DirectoryListing.Count - 1 do
  begin
    listView_FTPBackups.AddItem(ftp.DirectoryListing[i].FileName, nil);
  end;
end;

//TODO REFACTOR ?  // duplicate code smell
procedure TFTPFormExplorer.btn_downloadClick(Sender: TObject);
begin
  if selectedBackupFileName <> '' then
  begin
    downloadBackup;
  end
  else
  begin
    ShowMessage('E'' neccessario selezionario un elemento prima di procedere');
  end;
end;

procedure TFTPFormExplorer.downloadBackup;
var
  _downloadBackupFileName: string;
begin
  _downloadBackupFileName := getDownloadBackupFileName;
  if _downloadBackupFileName <> '' then
  begin
    ftp.Get(selectedBackupFileName, _downloadBackupFileName);
    ShowMessage('Backup scaricato');
  end;
end;

function TFTPFormExplorer.getDownloadBackupFileName: string;
var
  saveDialog: TSaveDialog;
  _downloadBackupFileName: string;
  _applicationDir: string;
begin
  saveDialog := TSaveDialog.Create(self);
  saveDialog.FileName := selectedBackupFileName;
  saveDialog.Title := 'Salva il backup';
  _applicationDir := getDirExe;
  saveDialog.InitialDir := GetCurrentDir;
  saveDialog.Filter := 'Zip file|*.zip';
  saveDialog.DefaultExt := 'zip';
  saveDialog.FilterIndex := 1;
  if saveDialog.Execute then
  begin
    _downloadBackupFileName := saveDialog.FileName;
  end
  else
  begin
    _downloadBackupFileName := '';
  end;
  saveDialog.Free;
  result := _downloadBackupFileName;
end;

function TFTPFormExplorer.getSelectedBackupFileName: string;
var
  _selectedBackupFileName: string;
begin
  _selectedBackupFileName := '';
  if listView_FTPBackups.ItemIndex >= 0 then
  begin
    _selectedBackupFileName := listView_FTPBackups.ItemFocused.Caption;
  end;
  result := _selectedBackupFileName;
end;

procedure TFTPFormExplorer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFTPFormExplorer.FormDestroy(Sender: TObject);
begin
  ftp.disconnect;
  ftp.Free;
end;

end.
