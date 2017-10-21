unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  System.Messaging,
  FMX.Platform,   // TApplicationEvent
  FMX.Platform.Android,
  Androidapi.Jni,
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
//  Androidapi.JNI.JavaTypes,
//  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.Helpers,
  Androidapi.JNI.NFC,

  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
  private
    FNfcAdapter: JNfcAdapter;
    FPendingIntent: JPendingIntent;
    FNFCSettingsChecked: Boolean;

    procedure SubscribeToStuff;
    procedure EnableForegroundDispatch;

    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;

    procedure HandleActivityMessage(const Sender: TObject; const M: TMessage);
    function HandleIntent(const Intent: JIntent): Boolean;
    procedure OnNewNfcIntent(Intent: JIntent);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.TypInfo;   // GetEnumName

  procedure Toast(x: string);   // dummy
begin
  Log.d(x);
end;



procedure TForm1.SubscribeToStuff;
var
  MessageSubscriptionID: Integer;
begin
  // Register the type of intent action that we want to be able to receive.
  // Note: A corresponding <action> tag must also exist in the <intent-filter> section of AndroidManifest.template.xml.

  MainActivity.registerIntentAction(TJIntent.JavaClass.ACTION_VIEW);
//  MainActivity.registerIntentAction(TJNfcAdapter.JavaClass.ACTION_NDEF_DISCOVERED);
  MainActivity.registerIntentAction(TJNfcAdapter.JavaClass.ACTION_TECH_DISCOVERED);
  MainActivity.registerIntentAction(TJNfcAdapter.JavaClass.ACTION_TAG_DISCOVERED);

  MessageSubscriptionID := TMessageManager.DefaultManager.SubscribeToMessage(
    TMessageReceivedNotification, HandleActivityMessage);
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if FNfcAdapter <> nil then
  begin
    if CheckBox1.IsChecked then
      EnableForegroundDispatch
    else
      FNfcAdapter.disableForegroundDispatch(TAndroidHelper.Activity)
  end;
end;

{$REGION 'JNI substitute for calling NfcAdapter.enableForegroundDispatch'}
procedure TForm1.EnableForegroundDispatch;
var
  PEnv: PJniEnv;
  AdapterClass: JNIClass;
  NfcAdapterObject, PendingIntentObject: JNIObject;
  MethodID: JNIMethodID;
begin
  // We can't just call the imported NfcAdapter method enableForegroundDispatch
  // as it will crash due to a shortcoming in the JNI Bridge, which does not
  // support 2D array parameters. So instead we call it via a manual JNI call.
  PEnv := TJNIResolver.GetJNIEnv;
  NfcAdapterObject := (FNfcAdapter as ILocalObject).GetObjectID;
  PendingIntentObject := (FPendingIntent as ILocalObject).GetObjectID;
  AdapterClass := PEnv^.GetObjectClass(PEnv, NfcAdapterObject);
  // Get the signature with:
  // javap -s -classpath <path_to_android_platform_jar> android.nfc.NfcAdapter
  MethodID := PEnv^.GetMethodID(
    PEnv, AdapterClass, 'enableForegroundDispatch',
    '(Landroid/app/Activity;Landroid/app/PendingIntent;' +
    '[Landroid/content/IntentFilter;[[Ljava/lang/String;)V');
  // Clean up
  PEnv^.DeleteLocalRef(PEnv, AdapterClass);
  // Finally call the target Java method
  PEnv^.CallVoidMethodA(PEnv, NfcAdapterObject, MethodID,
    PJNIValue(ArgsToJNIValues([JavaContext, PendingIntentObject, nil, nil])));
end;
{$ENDREGION}

function TForm1.HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
var
  StartupIntent: JIntent;
begin
  Log.d('', Self, 'ApplicationEventHandler', Format('+ %s',
    [GetEnumName(TypeInfo(TApplicationEvent), Integer(AAppEvent))]));

  Result := True;  //  Result := False;

  case AAppEvent of
    TApplicationEvent.BecameActive:
    begin                                       // czy nie TAndroidHelper.Activity?
      StartupIntent := MainActivity.getIntent;   // ORYGINALNE - uewniæ siê co do kolejnoœci
      if StartupIntent <> nil then
        HandleIntent(StartupIntent);



      if FNfcAdapter <> nil then
      begin
        if not FNfcAdapter.isEnabled then
        begin
          if not FNFCSettingsChecked then
          begin
            Toast('NFC is not enabled.' + LineFeed + 'Launching NFC settings.');
            TAndroidHelper.Activity.startActivity(
              TJIntent.JavaClass.init(StringToJString('android.settings.NFC_SETTINGS')));
            FNFCSettingsChecked := True;
          end
          else
          begin
            CheckBox1.Enabled := False;
            Toast('NFC functionality not available in this application due to system settings.');
          end;
        end
        else if CheckBox1.IsChecked then
          EnableForegroundDispatch
      end;
    end;

    TApplicationEvent.WillBecomeInactive:
    begin
      if CheckBox1.IsChecked and (FNfcAdapter <> nil) then
        FNfcAdapter.disableForegroundDispatch(TAndroidHelper.Activity);
    end;
  end;
end;

procedure TForm1.HandleActivityMessage(const Sender: TObject; const M: TMessage);
var
  Intent: JIntent;
begin
  if M is TMessageReceivedNotification then
  begin
    Intent := TMessageReceivedNotification(M).Value;
    HandleIntent(Intent);
  end;
end;

function TForm1.HandleIntent(const Intent: JIntent): Boolean;
var
  Extras: JBundle;
begin
  Result := False;
  if Intent <> nil then
  begin
    if TJNfcAdapter.JavaClass.ACTION_NDEF_DISCOVERED.equals(Intent.getAction) or
       TJNfcAdapter.JavaClass.ACTION_TECH_DISCOVERED.equals(Intent.getAction) or
       TJNfcAdapter.JavaClass.ACTION_TAG_DISCOVERED.equals(Intent.getAction) then
    begin
      OnNewNfcIntent(Intent);
    end;

    Memo1.ClearContent;
    Extras := Intent.getExtras;
    if Extras <> nil then
      Memo1.Text := JStringToString(Extras.getString(TJIntent.JavaClass.EXTRA_TEXT));
    Invalidate;
  end;
end;

procedure TForm1.OnNewNfcIntent(Intent: JIntent);
begin
  ShowMessage('tadaaa');
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ClassIntent: JIntent;

  AppEventService: IFMXApplicationEventService;
begin
  Log.d('OnCreate');
  FNFCSettingsChecked := False;

  //Set up event that triggers when app is brought back to foreground
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, AppEventService) then
    AppEventService.SetApplicationEventHandler(HandleAppEvent);

  // Subscribe to the FMX message that is sent when onNewIntent is called
  // with an intent containing any of these 3 intent actions.
  SubscribeToStuff;

  FNfcAdapter := TJNfcAdapter.JavaClass.getDefaultAdapter(TAndroidHelper.Context);
  if FNfcAdapter = nil then
  begin
    // Could do with exiting here maybe...
    raise Exception.Create('No NFC adapter present');
  end;
  // Set up the pending intent needed for enabling NFC foreground dispatch
  ClassIntent := TJIntent.JavaClass.init(TAndroidHelper.Context, TAndroidHelper.Activity.getClass);
  FPendingIntent := TJPendingIntent.JavaClass.getActivity(TAndroidHelper.Context, 0,
    ClassIntent.addFlags(TJIntent.JavaClass.FLAG_ACTIVITY_SINGLE_TOP), 0);




//NfcManager manager = (NfcManager) context.getSystemService(Context.NFC_SERVICE);
//NfcAdapter adapter = manager.getDefaultAdapter();
//if (adapter != null && adapter.isEnabled()) {
//
//    //Yes NFC available
//}else{
//
//   //Your device doesn't support NFC
//}end;

//1) Add "uses-feature" element in AndroidMenifeast file, so that your application shows up in Google Play only for devices that have NFC hardware
//
//<uses-feature android:name="android.hardware.nfc" android:required="true" />
//2) If your application uses NFC functionality, but that functionality is not crucial to your application, you can omit the uses-feature element and check for NFC avalailbility at runtime
//
//**Option 1:**
//NfcManager nfcManager = (NfcManager) context.getSystemService(Context.NFC_SERVICE);
//NfcAdapter nfcAdapter = nfcManager.getDefaultAdapter();
//if (nfcAdapter == null) {
//    // Device not compatible for NFC support
//}
//
//**Option 2:**
//if (!getPackageManager().hasSystemFeature(PackageManager.FEATURE_NFC)) {
//    // Device not compatible for NFC support
//}
//3) Check if NFC is enabled... If "False" applications can request Settings UI allowing the user to toggle/enable NFC from Settings
//
//startActivity(new Intent(android.provider.Settings.ACTION_WIRELESS_SETTINGS));

end.

