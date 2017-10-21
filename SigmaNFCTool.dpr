program SigmaNFCTool;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  Androidapi.JNI.NFC in 'JNI wrappers\API level 23\Androidapi.JNI.NFC.pas',
  Androidapi.JNI.NFC.CardEmulation in 'JNI wrappers\API level 23\Androidapi.JNI.NFC.CardEmulation.pas',
  Androidapi.JNI.NFC.Tech in 'JNI wrappers\API level 23\Androidapi.JNI.NFC.Tech.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
