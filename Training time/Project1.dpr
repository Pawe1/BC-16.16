program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Sigma.Topline2016.Decoder in 'Sigma.Topline2016.Decoder.pas',
  BikeComputer in 'BikeComputer.pas',
  Sigma.etc in 'Sigma.etc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
