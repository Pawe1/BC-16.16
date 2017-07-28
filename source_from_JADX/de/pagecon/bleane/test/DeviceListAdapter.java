package de.pagecon.bleane.test;

import air.com.sigmasport.SIGMALink.C0003R;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.List;

public class DeviceListAdapter extends BaseAdapter {
    private List<BleDevice> contentList = new ArrayList();
    private Context context;
    private int selectedPosition = -1;

    private class ViewHolder {
        TextView tv;

        private ViewHolder() {
        }
    }

    public DeviceListAdapter(Context ctx) {
        this.context = ctx;
    }

    public void add(BleDevice device) {
        this.contentList.add(device);
    }

    public void clear() {
        this.selectedPosition = -1;
        this.contentList = new ArrayList();
    }

    public void setSelected(int position) {
        if (this.selectedPosition == position) {
            this.selectedPosition = -1;
        } else {
            this.selectedPosition = position;
        }
    }

    public BleDevice getSelectedItem() {
        if (this.selectedPosition < 0 || this.selectedPosition >= this.contentList.size()) {
            return null;
        }
        return (BleDevice) this.contentList.get(this.selectedPosition);
    }

    public int getCount() {
        return this.contentList.size();
    }

    public Object getItem(int position) {
        if (position < 0 || position >= this.contentList.size()) {
            return null;
        }
        return this.contentList.get(position);
    }

    public long getItemId(int position) {
        return (long) position;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder;
        View vi = convertView;
        if (convertView == null) {
            vi = LayoutInflater.from(this.context).inflate(C0003R.layout.com_facebook_login_fragment, null);
            holder = new ViewHolder();
            holder.tv = (TextView) vi.findViewById(2131230742);
            vi.setTag(holder);
        } else {
            holder = (ViewHolder) vi.getTag();
        }
        if (this.selectedPosition == -1 || position != this.selectedPosition) {
            holder.tv.setBackgroundColor(-1);
        } else {
            holder.tv.setBackgroundColor(-16776961);
        }
        holder.tv.setText(((BleDevice) this.contentList.get(position)).toString());
        return vi;
    }
}
