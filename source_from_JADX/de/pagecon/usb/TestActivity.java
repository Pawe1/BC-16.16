package de.pagecon.usb;

import air.com.sigmasport.SIGMALink.C0003R;
import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.List;

public class TestActivity extends Activity implements ManagerListener {
    AttachedDeviceListAdapter mAttachedDeviceListAdapter;
    ListView mAttachedDevicesListView;
    Button mConnectButton;
    ConnectedDeviceListAdapter mConnectedDeviceListAdapter;
    ListView mConnectedDevicesListView;
    Button mDisconnectButton;
    ArrayAdapter<String> mLogListAdapter;
    ListView mLogListView;
    private Manager mManager;
    Button mRefreshAttachedButton;
    Button mRefreshConnectedButton;
    Button mSendButton;
    EditText mSendText;
    int selectedAttachedDeviceListItemIndex;
    int selectedConnectedDeviceListItemIndex;

    class C04541 implements OnItemClickListener {
        C04541() {
        }

        public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
            TestActivity.this.setSelectedAttachedListItemIndex(position);
            TestActivity.this.mAttachedDeviceListAdapter.notifyDataSetChanged();
        }
    }

    class C04552 implements OnItemClickListener {
        C04552() {
        }

        public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
            TestActivity.this.setSelectedConnectedListItemIndex(position);
            TestActivity.this.mConnectedDeviceListAdapter.notifyDataSetChanged();
        }
    }

    private class AttachedDeviceListAdapter extends ArrayAdapter<String> {
        Context context;
        List<SigmaDevice> devices = new ArrayList();

        public AttachedDeviceListAdapter(Context context) {
            super(context, 17367043);
            this.context = context;
        }

        public void updateDataSet() {
            TestActivity.this.setSelectedAttachedListItemIndex(-1);
            this.devices = TestActivity.this.mManager.getAttachedDevices();
        }

        public int getCount() {
            return this.devices.size();
        }

        public SigmaDevice getItemForPosition(int position) {
            if (position < 0 || position >= this.devices.size()) {
                return null;
            }
            return (SigmaDevice) this.devices.get(position);
        }

        public View getView(int position, View convertView, ViewGroup parent) {
            View row = convertView;
            row = ((Activity) this.context).getLayoutInflater().inflate(17367043, parent, false);
            TextView tv = (TextView) row.findViewById(16908308);
            SigmaDevice sd = (SigmaDevice) this.devices.get(position);
            tv.setText("ID: " + sd.getID() + " VID: " + sd.getVendorID() + " PID: " + sd.getProductID());
            if (TestActivity.this.selectedAttachedDeviceListItemIndex == -1 || TestActivity.this.selectedAttachedDeviceListItemIndex != position) {
                tv.setBackgroundColor(-1);
            } else {
                tv.setBackgroundColor(-16776961);
            }
            return row;
        }
    }

    private class ConnectedDeviceListAdapter extends ArrayAdapter<String> {
        Context context;
        List<SigmaDevice> devices = new ArrayList();

        public ConnectedDeviceListAdapter(Context context) {
            super(context, 17367043);
            this.context = context;
        }

        public void updateDataSet() {
            TestActivity.this.setSelectedConnectedListItemIndex(-1);
            this.devices = TestActivity.this.mManager.getConnectedDevices();
        }

        public int getCount() {
            return this.devices.size();
        }

        public SigmaDevice getItemForPosition(int position) {
            if (position < 0 || position >= this.devices.size()) {
                return null;
            }
            return (SigmaDevice) this.devices.get(position);
        }

        public View getView(int position, View convertView, ViewGroup parent) {
            View row = convertView;
            row = ((Activity) this.context).getLayoutInflater().inflate(17367043, parent, false);
            TextView tv = (TextView) row.findViewById(16908308);
            SigmaDevice sd = (SigmaDevice) this.devices.get(position);
            tv.setText("ID: " + sd.getID() + " VID: " + sd.getVendorID() + " PID: " + sd.getProductID());
            if (TestActivity.this.selectedConnectedDeviceListItemIndex == -1 || TestActivity.this.selectedConnectedDeviceListItemIndex != position) {
                tv.setBackgroundColor(-1);
            } else {
                tv.setBackgroundColor(-16776961);
            }
            return row;
        }
    }

    protected void onCreate(Bundle savedInstanceState) {
        Log.i("USB-ANE Android Layer", "entering onCreate()");
        super.onCreate(savedInstanceState);
        this.mManager = Manager.createManager(getApplicationContext(), this);
        ArrayList<VIDPIDPair> supportedDevices = new ArrayList();
        supportedDevices.add(new VIDPIDPair(7581, 4113));
        supportedDevices.add(new VIDPIDPair(1155, 22336));
        supportedDevices.add(new VIDPIDPair(7581, 4096));
        supportedDevices.add(new VIDPIDPair(1105, 5802));
        this.mManager.setSupportedDeviceIDs(supportedDevices);
        setContentView(C0003R.layout.com_facebook_activity_layout);
        this.mAttachedDevicesListView = (ListView) findViewById(C0003R.id.automatic);
        this.mConnectedDevicesListView = (ListView) findViewById(C0003R.id.large);
        this.mLogListView = (ListView) findViewById(C0003R.id.unknown);
        this.mRefreshAttachedButton = (Button) findViewById(C0003R.id.display_always);
        this.mRefreshConnectedButton = (Button) findViewById(C0003R.id.normal);
        this.mConnectButton = (Button) findViewById(C0003R.id.never_display);
        this.mDisconnectButton = (Button) findViewById(C0003R.id.small);
        this.mSendButton = (Button) findViewById(C0003R.id.page);
        this.mSendText = (EditText) findViewById(C0003R.id.open_graph);
        this.mAttachedDeviceListAdapter = new AttachedDeviceListAdapter(this);
        this.mAttachedDevicesListView.setAdapter(this.mAttachedDeviceListAdapter);
        this.mAttachedDevicesListView.setOnItemClickListener(new C04541());
        this.mConnectedDeviceListAdapter = new ConnectedDeviceListAdapter(this);
        this.mConnectedDevicesListView.setAdapter(this.mConnectedDeviceListAdapter);
        this.mConnectedDevicesListView.setOnItemClickListener(new C04552());
        setSelectedAttachedListItemIndex(-1);
        setSelectedConnectedListItemIndex(-1);
        this.mLogListAdapter = new ArrayAdapter(this, 17367043);
        this.mLogListView.setAdapter(this.mLogListAdapter);
        this.mAttachedDeviceListAdapter.updateDataSet();
        this.mAttachedDeviceListAdapter.notifyDataSetChanged();
        debugInfo("init complete");
    }

    protected void onStart() {
        Log.i("USB-ANE Android Layer", "entering onStart()");
        super.onStart();
    }

    protected void onRestart() {
        Log.i("USB-ANE Android Layer", "entering onRestart()");
        super.onRestart();
    }

    protected void onResume() {
        Log.i("USB-ANE Android Layer", "entering onResume()");
        super.onResume();
    }

    protected void onPostResume() {
        Log.i("USB-ANE Android Layer", "entering onPostResume()");
        super.onPostResume();
    }

    protected void onPause() {
        Log.i("USB-ANE Android Layer", "entering onPause()");
        super.onPause();
    }

    protected void onStop() {
        Log.i("USB-ANE Android Layer", "entering onStop()");
        super.onStop();
    }

    protected void onDestroy() {
        Log.i("USB-ANE Android Layer", "entering onDestroy()");
        super.onDestroy();
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(C0003R.dimen.com_facebook_likeview_text_size, menu);
        return true;
    }

    private void setSelectedAttachedListItemIndex(int selectedListItemIndex) {
        this.selectedAttachedDeviceListItemIndex = selectedListItemIndex;
        if (selectedListItemIndex < 0) {
            this.mConnectButton.setEnabled(false);
        } else {
            this.mConnectButton.setEnabled(true);
        }
    }

    private void setSelectedConnectedListItemIndex(int selectedListItemIndex) {
        this.selectedConnectedDeviceListItemIndex = selectedListItemIndex;
        if (selectedListItemIndex < 0) {
            this.mDisconnectButton.setEnabled(false);
            this.mSendButton.setEnabled(false);
            return;
        }
        this.mDisconnectButton.setEnabled(true);
        this.mSendButton.setEnabled(true);
    }

    public void btn_refresh_attached_clicked(View view) {
        this.mAttachedDeviceListAdapter.updateDataSet();
        this.mAttachedDeviceListAdapter.notifyDataSetChanged();
    }

    public void btn_refresh_connected_clicked(View view) {
        this.mConnectedDeviceListAdapter.updateDataSet();
        this.mConnectedDeviceListAdapter.notifyDataSetChanged();
    }

    public void btn_connect_clicked(View view) {
        SigmaDevice sd = this.mAttachedDeviceListAdapter.getItemForPosition(this.selectedAttachedDeviceListItemIndex);
        if (sd != null) {
            switch (this.mManager.connectDevice(sd.getID().intValue())) {
                case 11:
                    debugInfo("Device already connected " + sd.getID());
                    return;
                case 12:
                    debugInfo("Trying to connect " + sd.getID());
                    return;
                case 13:
                    debugInfo("Requesting permission for " + sd.getID());
                    return;
                case 14:
                    debugInfo("Device not found " + sd.getID());
                    return;
                default:
                    return;
            }
        }
    }

    public void btn_disconnect_clicked(View view) {
        SigmaDevice sd = this.mConnectedDeviceListAdapter.getItemForPosition(this.selectedConnectedDeviceListItemIndex);
        if (sd != null) {
            this.mManager.disconnectDevice(sd.getID().intValue());
            debugInfo("Trying to disconnect " + sd.getID());
        }
    }

    public void btn_send_clicked(View view) {
        SigmaDevice sd = this.mConnectedDeviceListAdapter.getItemForPosition(this.selectedConnectedDeviceListItemIndex);
        if (sd != null) {
            String s = this.mSendText.getText().toString();
            this.mManager.sendData(sd.getID().intValue(), hexStringToByteArray(s));
            debugInfo("sending to " + sd.getID() + ": " + s);
        }
    }

    public void debugInfo(String info) {
        this.mLogListAdapter.insert("debugInfo: " + info, 0);
    }

    public void dataReceived(int deviceID, byte[] data) {
        debugInfo(new StringBuilder(String.valueOf(deviceID)).append(" says: ").append(SigmaDevice.bytesToHex(data)).toString());
    }

    public void deviceConnected(SigmaDevice sd) {
        debugInfo("device " + sd.getID() + " connected");
        this.mConnectedDeviceListAdapter.updateDataSet();
        this.mConnectedDeviceListAdapter.notifyDataSetChanged();
    }

    public void deviceDisconnected(SigmaDevice sd) {
        debugInfo("device " + sd.getID() + " disconnected");
        this.mConnectedDeviceListAdapter.updateDataSet();
        this.mConnectedDeviceListAdapter.notifyDataSetChanged();
    }

    public void deviceConnectionLost(SigmaDevice sd) {
        debugInfo("device " + sd.getID() + " connection lost");
        this.mConnectedDeviceListAdapter.updateDataSet();
        this.mConnectedDeviceListAdapter.notifyDataSetChanged();
    }

    public void deviceAttached(SigmaDevice sd) {
        debugInfo("device " + sd.getID() + " attached");
        this.mAttachedDeviceListAdapter.updateDataSet();
        this.mAttachedDeviceListAdapter.notifyDataSetChanged();
    }

    public void deviceDetached(SigmaDevice sd) {
        debugInfo("device " + sd.getID() + " detached");
        this.mAttachedDeviceListAdapter.updateDataSet();
        this.mAttachedDeviceListAdapter.notifyDataSetChanged();
    }

    public void deviceConnectionFailed(SigmaDevice sd) {
        debugInfo("device " + sd.getID() + " connection failed");
        this.mAttachedDeviceListAdapter.updateDataSet();
        this.mAttachedDeviceListAdapter.notifyDataSetChanged();
    }

    public static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        byte[] data = new byte[(len / 2)];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i + 1), 16));
        }
        return data;
    }
}
