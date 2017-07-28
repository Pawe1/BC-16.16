package de.pagecon.bleane.test;

import air.com.sigmasport.SIGMALink.C0003R;
import android.app.Activity;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.res.Configuration;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.text.method.ScrollingMovementMethod;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import de.pagecon.bleane.extension.BleHWListener;
import de.pagecon.bleane.extension.Manager;
import de.pagecon.bleane.extension.ManagerListener;
import de.pagecon.bleane.util.Helper;
import java.util.ArrayList;
import java.util.List;

public class TestActivity extends Activity implements ManagerListener, BleHWListener {
    private static final String BATTERY_LEVEL_CHARACTERISTIC_UUID = "2a19";
    private static final String BATTERY_SERVICE_UUID = "180f";
    private static final String HR_MEASUREMENT_CHARACTERISTIC_UUID = "2a37";
    private static final String HR_PRIMARY_SERVICE_UUID = "180d";
    public static final String KEY_HR_SENSOR_ID = "HR_SENSOR_ID";
    public static final String KEY_PC2813_ID = "PC2813_ID";
    private static final String PC2813_PRIMARY_SERVICE_UUID = "5762";
    private static final String PC2813_RECEIVE_CHARACTERISTIC_UUID = "C1B6";
    private static final String PC2813_SEND_CHARACTERISTIC_UUID = "B3BA";
    protected static final char[] hexArray = "0123456789ABCDEF".toCharArray();
    private Manager bleManager;
    private Button btnConnect;
    private Button btnDisconnectHr;
    private Button btnDisconnectPC2813;
    private Button btnEnableBle;
    private Button btnForgetHr;
    private Button btnForgetPC2813;
    private Button btnReadBattery;
    private Button btnReadEeprom;
    private Button btnRemember;
    private Button btnStartScan;
    private Button btnStopScan;
    private CheckBox cbConnectHr;
    private CheckBox cbConnectPC2813;
    private boolean hrSensorConnected = false;
    private String hrSensorId;
    DeviceListAdapter listAdapter;
    private ListView lvDiscoveredDevices;
    private int numBytesReceived;
    private boolean pc2813Connected = false;
    private String pc2813Id;
    SharedPreferences prefs;
    private long readStartedTime;
    private Boolean ready = Boolean.valueOf(false);
    private TextView tvBatteryLevel;
    private TextView tvData;
    private TextView tvEnabledHw;
    private TextView tvHr;
    private TextView tvLog;
    private TextView tvReadByteCounter;
    private TextView tvReadDuration;
    private TextView tvSelectedHw;

    class C04301 implements OnClickListener {
        C04301() {
        }

        public void onClick(View v) {
            if (TestActivity.this.bleManager != null) {
                int result = TestActivity.this.bleManager.askUserToEnableBle();
                TestActivity.this.addStateTextToLog("asking user to enable BLE: ", result);
                if (result == -20) {
                    Toast.makeText(TestActivity.this, "Please plug in the SIGMA BLE Dongle!", 1).show();
                }
            }
            TestActivity.this.updateUI();
        }
    }

    class C04312 implements OnClickListener {
        C04312() {
        }

        public void onClick(View v) {
            TestActivity.this.listAdapter.clear();
            TestActivity.this.listAdapter.notifyDataSetChanged();
            List<String> primaryServiceUuids = new ArrayList();
            primaryServiceUuids.add(TestActivity.PC2813_PRIMARY_SERVICE_UUID);
            primaryServiceUuids.add(TestActivity.HR_PRIMARY_SERVICE_UUID);
            TestActivity.this.addStateTextToLog("trying to start scan", TestActivity.this.bleManager.startScan(primaryServiceUuids));
            TestActivity.this.updateUI();
        }
    }

    class C04323 implements OnClickListener {
        C04323() {
        }

        public void onClick(View v) {
            TestActivity.this.bleManager.stopScan();
            TestActivity.this.addLogText("trying to stop scan");
            TestActivity.this.updateUI();
        }
    }

    class C04334 implements OnItemClickListener {
        C04334() {
        }

        public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
            TestActivity.this.listAdapter.setSelected(position);
            TestActivity.this.listAdapter.notifyDataSetChanged();
            TestActivity.this.updateUI();
        }
    }

    class C04345 implements OnClickListener {
        C04345() {
        }

        public void onClick(View v) {
            BleDevice bleDevice = TestActivity.this.listAdapter.getSelectedItem();
            if (bleDevice != null) {
                Editor editor;
                if (Helper.stringEqualsIgnoreCase(bleDevice.primaryServiceUuid, TestActivity.PC2813_PRIMARY_SERVICE_UUID)) {
                    TestActivity.this.pc2813Id = bleDevice.deviceID;
                    editor = TestActivity.this.prefs.edit();
                    editor.putString(TestActivity.KEY_PC2813_ID, TestActivity.this.pc2813Id);
                    editor.commit();
                } else if (Helper.stringEqualsIgnoreCase(bleDevice.primaryServiceUuid, TestActivity.HR_PRIMARY_SERVICE_UUID)) {
                    TestActivity.this.hrSensorId = bleDevice.deviceID;
                    editor = TestActivity.this.prefs.edit();
                    editor.putString(TestActivity.KEY_HR_SENSOR_ID, TestActivity.this.hrSensorId);
                    editor.commit();
                }
            }
            TestActivity.this.updateUI();
        }
    }

    class C04356 implements OnClickListener {
        C04356() {
        }

        public void onClick(View v) {
            if (TestActivity.this.pc2813Id != null) {
                TestActivity.this.addStateTextToLog("trying to disconnect PC28.13", TestActivity.this.bleManager.disconnect(TestActivity.this.pc2813Id));
            }
            TestActivity.this.updateUI();
        }
    }

    class C04367 implements OnClickListener {
        C04367() {
        }

        public void onClick(View v) {
            if (TestActivity.this.pc2813Id != null) {
                if (TestActivity.this.pc2813Connected) {
                    TestActivity.this.addStateTextToLog("trying to disconnect PC28.13", TestActivity.this.bleManager.disconnect(TestActivity.this.pc2813Id));
                }
                TestActivity.this.pc2813Id = null;
                Editor editor = TestActivity.this.prefs.edit();
                editor.remove(TestActivity.KEY_PC2813_ID);
                editor.commit();
            }
            TestActivity.this.updateUI();
        }
    }

    class C04378 implements OnClickListener {
        C04378() {
        }

        public void onClick(View v) {
            if (TestActivity.this.hrSensorId != null) {
                TestActivity.this.addStateTextToLog("trying to disconnect HR-Sensor", TestActivity.this.bleManager.disconnect(TestActivity.this.hrSensorId));
            }
            TestActivity.this.updateUI();
        }
    }

    class C04389 implements OnClickListener {
        C04389() {
        }

        public void onClick(View v) {
            if (TestActivity.this.hrSensorId != null) {
                if (TestActivity.this.hrSensorConnected) {
                    TestActivity.this.addStateTextToLog("trying to disconnect PC28.13", TestActivity.this.bleManager.disconnect(TestActivity.this.hrSensorId));
                }
                TestActivity.this.hrSensorId = null;
                Editor editor = TestActivity.this.prefs.edit();
                editor.remove(TestActivity.KEY_HR_SENSOR_ID);
                editor.commit();
            }
            TestActivity.this.updateUI();
        }
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(C0003R.layout.com_facebook_activity_layout);
        this.listAdapter = new DeviceListAdapter(this);
        this.btnEnableBle = (Button) findViewById(C0003R.color.com_facebook_blue);
        this.btnEnableBle.setOnClickListener(new C04301());
        this.tvEnabledHw = (TextView) findViewById(C0003R.color.com_facebook_likeview_text_color);
        this.tvSelectedHw = (TextView) findViewById(C0003R.color.com_facebook_likeboxcountview_border_color);
        this.btnStartScan = (Button) findViewById(C0003R.color.com_facebook_likeboxcountview_text_color);
        this.btnStartScan.setOnClickListener(new C04312());
        this.btnStopScan = (Button) findViewById(C0003R.color.com_facebook_share_button_text_color);
        this.btnStopScan.setOnClickListener(new C04323());
        this.lvDiscoveredDevices = (ListView) findViewById(C0003R.color.com_facebook_button_background_color);
        this.lvDiscoveredDevices.setAdapter(this.listAdapter);
        this.lvDiscoveredDevices.setOnItemClickListener(new C04334());
        this.btnRemember = (Button) findViewById(C0003R.color.com_facebook_button_background_color_disabled);
        this.btnRemember.setOnClickListener(new C04345());
        this.cbConnectPC2813 = (CheckBox) findViewById(C0003R.color.com_facebook_button_background_color_pressed);
        this.btnDisconnectPC2813 = (Button) findViewById(C0003R.color.com_facebook_button_like_background_color_selected);
        this.btnDisconnectPC2813.setOnClickListener(new C04356());
        this.btnForgetPC2813 = (Button) findViewById(C0003R.color.com_facebook_button_login_silver_background_color);
        this.btnForgetPC2813.setOnClickListener(new C04367());
        this.btnReadEeprom = (Button) findViewById(C0003R.color.com_facebook_button_login_silver_background_color_pressed);
        this.tvReadDuration = (TextView) findViewById(C0003R.color.com_facebook_button_send_background_color);
        this.tvReadByteCounter = (TextView) findViewById(C0003R.color.com_facebook_button_send_background_color_pressed);
        this.tvData = (TextView) findViewById(C0003R.color.opaque_blue);
        this.cbConnectHr = (CheckBox) findViewById(2131230734);
        this.btnDisconnectHr = (Button) findViewById(2131230735);
        this.btnDisconnectHr.setOnClickListener(new C04378());
        this.btnForgetHr = (Button) findViewById(2131230736);
        this.btnForgetHr.setOnClickListener(new C04389());
        this.btnReadBattery = (Button) findViewById(2131230737);
        this.btnReadBattery.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                TestActivity.this.addStateTextToLog("trying to read battery level from HR-Sensor", TestActivity.this.bleManager.read(TestActivity.this.hrSensorId, TestActivity.BATTERY_SERVICE_UUID, TestActivity.BATTERY_LEVEL_CHARACTERISTIC_UUID));
                TestActivity.this.updateUI();
            }
        });
        this.tvBatteryLevel = (TextView) findViewById(2131230738);
        this.tvHr = (TextView) findViewById(2131230739);
        this.btnConnect = (Button) findViewById(2131230740);
        this.btnConnect.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                int error = TestActivity.this.bleManager.cancelConnectionRequests();
                TestActivity.this.addStateTextToLog("trying to cancel connection requests", error);
                if (error != 0) {
                    List<String> deviceIds = new ArrayList();
                    if (TestActivity.this.cbConnectHr.isChecked() && TestActivity.this.hrSensorId != null) {
                        deviceIds.add(TestActivity.this.hrSensorId);
                    }
                    if (TestActivity.this.cbConnectPC2813.isChecked() && TestActivity.this.pc2813Id != null) {
                        deviceIds.add(TestActivity.this.pc2813Id);
                    }
                    if (deviceIds.size() > 0) {
                        TestActivity.this.addStateTextToLog("start connecting", TestActivity.this.bleManager.connect(deviceIds));
                    }
                }
            }
        });
        this.tvLog = (TextView) findViewById(2131230741);
        this.tvLog.setMovementMethod(new ScrollingMovementMethod());
        this.bleManager = Manager.create(this, this, this);
        this.bleManager.setBleNotificationFilterParams(false, 0);
        if (this.bleManager.isBleSupported()) {
            this.prefs = PreferenceManager.getDefaultSharedPreferences(this);
            this.pc2813Id = this.prefs.getString(KEY_PC2813_ID, null);
            this.hrSensorId = this.prefs.getString(KEY_HR_SENSOR_ID, null);
            if (this.pc2813Id == null && this.hrSensorId == null) {
                this.ready = Boolean.valueOf(true);
            } else {
                this.ready = Boolean.valueOf(false);
                List<String> ids = new ArrayList();
                if (this.pc2813Id != null) {
                    ids.add(this.pc2813Id);
                }
                if (this.hrSensorId != null) {
                    ids.add(this.hrSensorId);
                }
                String text = "Checking Device-IDs:";
                for (String id : ids) {
                    text = new StringBuilder(String.valueOf(text)).append("\n").append(id).toString();
                }
                addLogText(text);
                this.bleManager.checkIds(ids);
            }
        } else {
            this.ready = Boolean.valueOf(false);
        }
        updateUI();
    }

    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
    }

    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        if (getResources().getConfiguration().orientation == 2) {
            setRequestedOrientation(1);
        } else {
            setRequestedOrientation(1);
        }
    }

    private void updateUI() {
        if (this.ready.booleanValue()) {
            this.btnStartScan.setEnabled(true);
            this.btnStopScan.setEnabled(true);
            if (this.listAdapter.getSelectedItem() != null) {
                this.btnRemember.setEnabled(true);
            } else {
                this.btnRemember.setEnabled(false);
            }
            if (this.hrSensorId == null) {
                this.cbConnectHr.setEnabled(false);
                this.btnDisconnectHr.setEnabled(false);
                this.btnReadBattery.setEnabled(false);
                this.btnForgetHr.setEnabled(false);
            } else if (this.hrSensorConnected) {
                this.cbConnectHr.setEnabled(false);
                this.btnDisconnectHr.setEnabled(true);
                this.btnReadBattery.setEnabled(true);
                this.btnForgetHr.setEnabled(false);
            } else {
                this.cbConnectHr.setEnabled(true);
                this.btnDisconnectHr.setEnabled(false);
                this.btnReadBattery.setEnabled(false);
                this.btnForgetHr.setEnabled(true);
            }
            if (this.pc2813Id == null) {
                this.cbConnectPC2813.setEnabled(false);
                this.btnDisconnectPC2813.setEnabled(false);
                this.btnDisconnectPC2813.setEnabled(true);
                this.btnReadEeprom.setEnabled(false);
                this.btnForgetPC2813.setEnabled(false);
            } else if (this.pc2813Connected) {
                this.cbConnectPC2813.setEnabled(false);
                this.btnDisconnectPC2813.setEnabled(true);
                this.btnReadEeprom.setEnabled(true);
                this.btnForgetPC2813.setEnabled(false);
            } else {
                this.cbConnectPC2813.setEnabled(true);
                this.btnDisconnectPC2813.setEnabled(false);
                this.btnDisconnectPC2813.setEnabled(true);
                this.btnReadEeprom.setEnabled(false);
                this.btnForgetPC2813.setEnabled(true);
            }
            switch (this.bleManager.getEnabledBleHw()) {
                case 1:
                    this.tvEnabledHw.setText("enabled Ble-HW: internal");
                    break;
                case 2:
                    this.tvEnabledHw.setText("enabled Ble-HW: cc2540");
                    break;
                case 3:
                    this.tvEnabledHw.setText("enabled Ble-HW: internal and cc2540");
                    break;
                default:
                    this.tvEnabledHw.setText("enabled Ble-HW: none");
                    break;
            }
            switch (this.bleManager.getSelectedBleHw()) {
                case 1:
                    this.tvSelectedHw.setText("selected Ble-HW: internal");
                    return;
                case 2:
                    this.tvSelectedHw.setText("selected Ble-HW: cc2540");
                    return;
                default:
                    this.tvSelectedHw.setText("selected Ble-HW: none");
                    return;
            }
        }
        this.btnStartScan.setEnabled(false);
        this.btnStopScan.setEnabled(false);
        this.btnRemember.setEnabled(false);
        this.cbConnectPC2813.setEnabled(false);
        this.btnDisconnectPC2813.setEnabled(false);
        this.btnForgetPC2813.setEnabled(false);
        this.btnReadEeprom.setEnabled(false);
        this.cbConnectHr.setEnabled(false);
        this.btnDisconnectHr.setEnabled(false);
        this.btnForgetHr.setEnabled(false);
        this.btnReadBattery.setEnabled(false);
    }

    public static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[(bytes.length * 2)];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 255;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[(j * 2) + 1] = hexArray[v & 15];
        }
        return new String(hexChars);
    }

    private byte calculateChecksum(byte[] data) {
        byte chk = (byte) 0;
        if (data == null || data.length <= 0) {
            return (byte) 0;
        }
        for (byte b : data) {
            chk = (byte) (b + chk);
        }
        return (byte) (chk ^ -1);
    }

    private void addStateTextToLog(String prefix, int errorCode) {
        switch (errorCode) {
            case Manager.ERROR_BLE_STILL_SCANNING /*-21*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Still scanning").toString());
                return;
            case Manager.ERROR_BLE_OPERATION_NOT_SUPPORTED /*-20*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Operation not supported").toString());
                return;
            case Manager.ERROR_BLE_STOP_SCAN_FAILED /*-19*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Stop Scan Failed").toString());
                return;
            case Manager.ERROR_BLE_START_SCAN_FAILED /*-18*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Start Scan Failed").toString());
                return;
            case Manager.ERROR_BLE_DEVICE_UNKNOWN /*-17*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Device unknown").toString());
                return;
            case Manager.ERROR_BLE_INVALID_CHARACTERISTIC_UUID /*-16*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Invalid characteristic UUID").toString());
                return;
            case Manager.ERROR_BLE_INVALID_SERVICE_UUID /*-15*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Invalid service UUID").toString());
                return;
            case Manager.f399x9af1bb7 /*-14*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Device doesn't contain specified characteristic or service").toString());
                return;
            case Manager.ERROR_BLE_ALREADY_ENABLED /*-13*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: BLE already enabled").toString());
                return;
            case Manager.ERROR_BLE_WRITE_FAILED /*-12*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Write failed").toString());
                return;
            case Manager.ERROR_BLE_READ_FAILED /*-11*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Read failed").toString());
                return;
            case Manager.ERROR_BLE_DISCONNECT_FAILED /*-8*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Disconnect failed").toString());
                return;
            case Manager.ERROR_BLE_CONNECT_FAILED /*-7*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Connect failed").toString());
                return;
            case Manager.ERROR_BLE_DEVICE_NOT_CONNECTED /*-6*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Device not connected").toString());
                return;
            case Manager.ERROR_BLE_DEVICE_ALREADY_CONNECTED /*-5*/:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Already connected").toString());
                return;
            case -4:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Invalid device ID").toString());
                return;
            case -3:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: Operation failed").toString());
                return;
            case -2:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: BLE not enabled").toString());
                return;
            case -1:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" ERROR: BLE not supported").toString());
                return;
            case 0:
                addLogText(new StringBuilder(String.valueOf(prefix)).append(" SUCCESS").toString());
                return;
            default:
                return;
        }
    }

    private void addLogText(String text) {
        this.tvLog.setText(new StringBuilder(String.valueOf(text)).append("\n\n").append(this.tvLog.getText().toString()).toString());
    }

    public void dataReceived(String id, String serviceUUID, String charUUID, byte[] data) {
        if (Helper.stringEqualsIgnoreCase(id, this.pc2813Id)) {
            if (data.length > 4) {
                this.numBytesReceived += data.length - 4;
                this.tvReadByteCounter.setText(this.numBytesReceived);
                this.tvData.setText(bytesToHex(data));
                this.tvReadDuration.setText(String.format("%.3f sec", new Object[]{Double.valueOf(((double) (System.currentTimeMillis() - this.readStartedTime)) / 1000.0d)}));
            }
        } else if (!Helper.stringEqualsIgnoreCase(id, this.hrSensorId)) {
        } else {
            if (Helper.stringEqualsIgnoreCase(charUUID, HR_MEASUREMENT_CHARACTERISTIC_UUID)) {
                int heartrate;
                if ((data[0] & 1) == 0) {
                    heartrate = data[1] & 255;
                } else {
                    heartrate = ((data[1] & 255) * 16) + (data[2] & 255);
                }
                this.tvHr.setText(new StringBuilder(String.valueOf(heartrate)).append(" bpm").toString());
            } else if (Helper.stringEqualsIgnoreCase(charUUID, BATTERY_LEVEL_CHARACTERISTIC_UUID)) {
                this.tvBatteryLevel.setText(new StringBuilder(String.valueOf(data[0] & 255)).append(" %").toString());
            }
        }
    }

    public void dataWritten(String id, String serviceUUID, String charUUID) {
        addLogText(String.format("characteristic written: %s", new Object[]{id}));
        updateUI();
    }

    public void deviceConnected(String id, String primaryServiceUUID) {
        addLogText(String.format("device connected: %s", new Object[]{id}));
        if (Helper.stringEqualsIgnoreCase(id, this.pc2813Id)) {
            this.pc2813Connected = true;
        } else if (Helper.stringEqualsIgnoreCase(id, this.hrSensorId)) {
            this.hrSensorConnected = true;
            this.bleManager.setNotify(this.hrSensorId, HR_PRIMARY_SERVICE_UUID, HR_MEASUREMENT_CHARACTERISTIC_UUID, true);
        }
        updateUI();
    }

    public void deviceDisconnected(String id) {
        addLogText(String.format("device disconnected: %s", new Object[]{id}));
        if (Helper.stringEqualsIgnoreCase(id, this.pc2813Id)) {
            this.pc2813Connected = false;
        } else if (Helper.stringEqualsIgnoreCase(id, this.hrSensorId)) {
            this.hrSensorConnected = false;
        }
        updateUI();
    }

    public void deviceDiscovered(String id, String primaryServiceUUID, String name) {
        addLogText(String.format("device discovered\nName: %s\nid: %s\nprimary service: %s", new Object[]{name, id, primaryServiceUUID}));
        this.listAdapter.add(new BleDevice(name, id, primaryServiceUUID));
        this.listAdapter.notifyDataSetChanged();
    }

    public void error(int errCode, String message, String id, String serviceUUID, String charUUID) {
        String prefix = "";
        if (message != null) {
            prefix = new StringBuilder(String.valueOf(prefix)).append("message: ").append(message).append("\n").toString();
        }
        if (id != null) {
            prefix = new StringBuilder(String.valueOf(prefix)).append("ID: ").append(id).append(" ").toString();
        }
        if (serviceUUID != null) {
            prefix = new StringBuilder(String.valueOf(prefix)).append("suuid: ").append(serviceUUID).append(" ").toString();
        }
        if (charUUID != null) {
            prefix = new StringBuilder(String.valueOf(prefix)).append("cuuid: ").append(charUUID).append(" ").toString();
        }
        addStateTextToLog(prefix, errCode);
    }

    public void idsChecked(List<String> validIds) {
        addLogText(String.format("IDs checked", new Object[0]));
        boolean pc2813Found = false;
        boolean hrSensorFound = false;
        for (int i = 0; i < validIds.size(); i++) {
            String id = (String) validIds.get(i);
            if (Helper.stringEqualsIgnoreCase(id, this.hrSensorId)) {
                hrSensorFound = true;
            } else if (Helper.stringEqualsIgnoreCase(id, this.pc2813Id)) {
                pc2813Found = true;
            }
        }
        if (!pc2813Found) {
            this.pc2813Id = null;
            Editor editor = this.prefs.edit();
            editor.remove(KEY_PC2813_ID);
            editor.commit();
        }
        if (!hrSensorFound) {
            this.hrSensorId = null;
            editor = this.prefs.edit();
            editor.remove(KEY_HR_SENSOR_ID);
            editor.commit();
        }
        this.ready = Boolean.valueOf(true);
        String text = "Device Ids checked. Valid IDs:";
        for (int j = 0; j < validIds.size(); j++) {
            text = new StringBuilder(String.valueOf(text)).append("\n").append((String) validIds.get(j)).toString();
        }
        addLogText(text);
        updateUI();
    }

    public void info(String info) {
        addLogText("INFO: " + info);
    }

    public void bleEnabledStateChanged(int enabled) {
        addLogText("Enable state changed");
        updateUI();
    }

    public void scanningStateChanged(boolean scanningState) {
        addLogText("Scanning state changed: " + scanningState);
    }

    public void connectionRequestsCanceled() {
        addLogText("Connection requests canceled");
        List<String> deviceIds = new ArrayList();
        if (this.cbConnectHr.isChecked() && this.hrSensorId != null) {
            deviceIds.add(this.hrSensorId);
        }
        if (this.cbConnectPC2813.isChecked() && this.pc2813Id != null) {
            deviceIds.add(this.pc2813Id);
        }
        if (deviceIds.size() > 0) {
            addStateTextToLog("start connecting", this.bleManager.connect(deviceIds));
        }
    }

    public void selectedBleHWChanged(int selected) {
        addLogText("Selected state changed");
        updateUI();
    }
}
