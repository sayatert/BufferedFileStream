unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Diagnostics;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  sw: TStreamWriter;
  I: integer;
begin
  sw := TStreamWriter.Create('test.txt', True, TEncoding.UTF8);
  try
    sw.WriteLine('Hello World');
    for I := 1 to 99999 do
      sw.WriteLine('Hello ' + I.ToString);
  finally
    sw.Free;
  end;
  Memo1.Lines.Add('File written');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  fStr: TFileStream;
  Total, I: integer;
  sw: TStopwatch;
  ch: Char;
begin
  sw := TStopwatch.StartNew;
  fStr := TFileStream.Create('test.txt',  fmOpenRead);
  try
    Total := 0;
    while fStr.Read(ch, 1) = 1 do
    begin
      if ch = #13 then
        Inc(Total);
    end;
    Memo1.Lines.Add('Lines: ' + Total.ToString);
  finally
    fStr.Free;
  end;
  sw.Stop;
  Memo1.Lines.Add('msec: ' + sw.ElapsedMilliseconds.ToString);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  fStr: TBufferedFileStream;
  Total, I: integer;
  sw: TStopwatch;
  ch: Char;
begin
  sw := TStopwatch.StartNew;
  fStr := TBufferedFileStream.Create('test.txt',  fmOpenRead);
  try
    Total := 0;
    while fStr.Read(ch, 1) = 1 do
    begin
      if ch = #13 then
        Inc(Total);
    end;
    Memo1.Lines.Add('Lines: ' + Total.ToString);
  finally
    fStr.Free;
  end;
  sw.Stop;
  Memo1.Lines.Add('msec: ' + sw.ElapsedMilliseconds.ToString);
end;

end.
