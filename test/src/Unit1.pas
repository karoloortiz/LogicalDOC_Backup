unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$r *.dfm}


uses
  Backup, Main, Logger,
  Klib.AsyncMethod,
  Klib.Types, KLib.Utils, KLib.Windows, KLib.WindowsService,
  IdFTPCommon,
  System.IOUtils, System.Zip;

procedure TForm2.Button1Click(Sender: TObject);
var
  _backup: TBackup;
  info: TBackupCreateInfo;
  callbacks: TCallBacks;
  backupFileName: string;
  ftpCredentials: TFTPCredentials;
begin
  with info do
  begin
    serviceName := 'DB_GO';
    pathDB := 'C:\Gestionale_Open\Files\data';
    //    pathDB := 'C:\Gestionale_Open\Files\Programma_GO\exe';
    pathInstallation := 'C:\Gestionale_Open\Files\Programma_GO';
  end;
  with callbacks do
  begin
    resolve := procedure(msg: string)
      begin
        showmessage('ok');
      end;
    reject := procedure(msg: string)
      begin
        showmessage('err');
      end;
  end;
  _backup := TBackup.create(info, callbacks);
  //  _backup.executeBackup;

  with ftpCredentials do
  begin
    server := 'ftp.gestionaleopen.it';
    with credentials do
    begin
      username := 'Karol';
      password := 'ftpgo2016';
    end;
    pathFTPDir := 'Karol/prove-backup/';
    transferType := ftBinary;
  end;
  backupFileName := 'C:\PROVA\' + TBackup.getBackupFileNameDateTime;

  _backup.executeBackup(backupFileName, true, ftpCredentials, true);
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  serviceName: string;
begin
  //  serviceName := 'DB_GO_80';

  //    if TWindowsService.stopIfExists(serviceName) then
  //    begin
  //      ShowMessage('running');
  //    end
  //    else
  //    begin
  //      ShowMessage('not running');
  //    end;

  //  try
  //    TWindowsService.stopIfExists(serviceName, '', true);
  //  except
  //    on E: Exception do
  //      ShowMessage(serviceName + ' not stopp�ed');
  //  end;

  serviceName := 'LogicalDOC_DB';
  try
    TWindowsService.stopIfExists(serviceName, '', true);
  except
    on E: Exception do
      ShowMessage(serviceName + ' not stopp�ed ' + e.Message);
  end;

  serviceName := 'LogicalDOC';
  try
    TWindowsService.stopIfExists(serviceName, '', true);
  except
    on E: Exception do
      ShowMessage(serviceName + ' not stopp�ed ' + e.Message);
  end;

  serviceName := 'LogicalDOC-Update';
  try
    TWindowsService.stopIfExists(serviceName, '', true);
  except
    on E: Exception do
      ShowMessage(serviceName + ' not stopp�ed ' + e.Message);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
//var
//  _main: tmain;
begin
  //  _main := TMain.create();
  //  _main.executeBackup;
end;

end.
