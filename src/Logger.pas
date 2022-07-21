unit Logger;

interface

const
  FILENAME_LOG = 'log_backup.txt';

type
  TLogger = class
  private
    class procedure _writeInLogFile(msg: string);
  public
    class procedure writeInLogFile(msg: string);
    class procedure writeErrorInLogFile(msg: string);
  end;

implementation

uses
  KLib.Utils,
  System.SysUtils, System.IOUtils;

class procedure TLogger.writeInLogFile(msg: string);
begin
  _writeInLogFile(msg);
end;

class procedure TLogger.writeErrorInLogFile(msg: string);
var
  _msg: string;
begin
  _msg := 'ERRORE = ' + msg;
  _writeInLogFile(_msg);
end;

class procedure TLogger._writeInLogFile(msg: string);
var
  _file: TextFile;
  headLog: string;
begin
  headLog := sLineBreak + getCurrentTimeStamp + ' -';

  AssignFile(_file, FILENAME_LOG);
  if FileExists(FILENAME_LOG) then
  begin
    Append(_file);
  end
  else
  begin
    Rewrite(_file);
  end;
  Writeln(_file, headLog + msg);
  CloseFile(_file);
  //  TFile.AppendAllText(FILENAME_LOG, headLog + msg);
end;

end.
