package com.adobe.air;

import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.DialogInterface.OnKeyListener;
import android.content.res.Resources;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore.Audio.Media;
import android.provider.MediaStore.Images;
import android.provider.MediaStore.Video;
import android.util.SparseBooleanArray;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.BaseExpandableListAdapter;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.EditText;
import android.widget.ExpandableListAdapter;
import android.widget.ExpandableListView;
import android.widget.ExpandableListView.OnChildClickListener;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.adobe.air.utils.Utils;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AIRExpandableFileChooser implements OnChildClickListener {
    private static final String FILEINFO = "FILEINFO";
    public static final String TAG = AIRExpandableFileChooser.class.toString();
    private static final String TYPE = "TYPE";
    private static final String USER_ACTION_CANCEL = "cancel";
    private static final String USER_ACTION_DONE = "done";
    private ExpandableListAdapter mAdapter;
    private boolean mAllowMultiple = false;
    private SparseBooleanArray mCheckedFiles = new SparseBooleanArray();
    private List<List<Map<String, FileInfo>>> mChildData = new ArrayList();
    private AndroidAlertDialog mFileChooserDialog = null;
    private FileChooserStub mFileChooserStub = null;
    private final String[] mFileProjection = new String[]{"_data", "_display_name"};
    private EditText mFileSaveName = null;
    private ArrayList<String> mFilenames = new ArrayList();
    private List<Map<String, String>> mGroupData = new ArrayList();
    private View mMultipleFileSelectionView = null;
    private LayoutInflater mRuntimeInflater = null;
    private Resources mRuntimeResources = null;
    private boolean mSave = false;
    private String mSelection = new String();

    class C00861 implements OnKeyListener {
        C00861() {
        }

        public boolean onKey(DialogInterface dialogInterface, int i, KeyEvent keyEvent) {
            if (keyEvent.getKeyCode() == 4) {
                AIRExpandableFileChooser.this.mFileChooserStub.SetUserAction(AIRExpandableFileChooser.USER_ACTION_CANCEL);
            }
            return false;
        }
    }

    class C00872 implements View.OnKeyListener {
        C00872() {
        }

        public boolean onKey(View view, int i, KeyEvent keyEvent) {
            if (keyEvent.getAction() != 0 || i != 66) {
                return false;
            }
            String obj = AIRExpandableFileChooser.this.mFileSaveName.getText().toString();
            if (obj.length() != 0) {
                AIRExpandableFileChooser.this.mFilenames.clear();
                AIRExpandableFileChooser.this.mFilenames.add(obj);
                AIRExpandableFileChooser.this.mFileChooserStub.SetUserAction(AIRExpandableFileChooser.USER_ACTION_DONE);
                AIRExpandableFileChooser.this.HideVirtualKeyboard(AIRExpandableFileChooser.this.mFileSaveName);
                AIRExpandableFileChooser.this.mFileChooserDialog.dismiss();
            }
            return true;
        }
    }

    class C00883 implements OnClickListener {
        C00883() {
        }

        public void onClick(View view) {
            String obj = AIRExpandableFileChooser.this.mFileSaveName.getText().toString();
            if (obj.length() != 0) {
                AIRExpandableFileChooser.this.mFilenames.clear();
                AIRExpandableFileChooser.this.mFilenames.add(obj);
                AIRExpandableFileChooser.this.mFileChooserStub.SetUserAction(AIRExpandableFileChooser.USER_ACTION_DONE);
                AIRExpandableFileChooser.this.HideVirtualKeyboard(AIRExpandableFileChooser.this.mFileSaveName);
                AIRExpandableFileChooser.this.mFileChooserDialog.dismiss();
            }
        }
    }

    class C00894 implements DialogInterface.OnClickListener {
        C00894() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            AIRExpandableFileChooser.this.mFilenames.clear();
            int size = AIRExpandableFileChooser.this.mGroupData.size();
            for (int i2 = 0; i2 < size; i2++) {
                int size2 = ((List) AIRExpandableFileChooser.this.mChildData.get(i2)).size();
                for (int i3 = 0; i3 < size2; i3++) {
                    if (AIRExpandableFileChooser.this.mCheckedFiles.get(AIRExpandableFileChooser.this.expandableListPositionToFlatPosition(i2, i3))) {
                        AIRExpandableFileChooser.this.mFilenames.add(((FileInfo) ((HashMap) AIRExpandableFileChooser.this.mAdapter.getChild(i2, i3)).get(AIRExpandableFileChooser.FILEINFO)).mFilePath);
                    }
                }
            }
            AIRExpandableFileChooser.this.mFileChooserStub.SetUserAction(AIRExpandableFileChooser.USER_ACTION_DONE);
        }
    }

    class C00905 implements DialogInterface.OnClickListener {
        C00905() {
        }

        public void onClick(DialogInterface dialogInterface, int i) {
            AIRExpandableFileChooser.this.uncheckAll();
            AIRExpandableFileChooser.this.mFileChooserStub.SetUserAction(AIRExpandableFileChooser.USER_ACTION_CANCEL);
        }
    }

    private class FileChooserExpandableListAdapter extends BaseExpandableListAdapter {
        private LayoutInflater mRuntimeInflater = null;
        private Resources mRuntimeResources = null;

        public FileChooserExpandableListAdapter(LayoutInflater layoutInflater, Resources resources) {
            this.mRuntimeInflater = layoutInflater;
            this.mRuntimeResources = resources;
        }

        public Object getChild(int i, int i2) {
            return ((List) AIRExpandableFileChooser.this.mChildData.get(i)).get(i2);
        }

        public long getChildId(int i, int i2) {
            return (long) i2;
        }

        public View getChildView(int i, int i2, boolean z, View view, ViewGroup viewGroup) {
            if (view == null || !(view instanceof FileChooserItem)) {
                view = new FileChooserItem(this.mRuntimeInflater, this.mRuntimeResources, viewGroup, i, i2);
            } else {
                FileChooserItem fileChooserItem = (FileChooserItem) view;
            }
            view.bindToData((FileInfo) ((Map) ((List) AIRExpandableFileChooser.this.mChildData.get(i)).get(i2)).get(AIRExpandableFileChooser.FILEINFO), i, i2);
            return view;
        }

        public int getChildrenCount(int i) {
            return ((List) AIRExpandableFileChooser.this.mChildData.get(i)).size();
        }

        public Object getGroup(int i) {
            return AIRExpandableFileChooser.this.mGroupData.get(i);
        }

        public int getGroupCount() {
            return AIRExpandableFileChooser.this.mGroupData.size();
        }

        public long getGroupId(int i) {
            return (long) i;
        }

        public View getGroupView(int i, boolean z, View view, ViewGroup viewGroup) {
            if (view == null) {
                view = this.mRuntimeInflater.inflate(17367046, viewGroup, false);
            }
            TextView textView = (TextView) view.findViewById(16908308);
            if (textView != null) {
                textView.setText((CharSequence) ((Map) AIRExpandableFileChooser.this.mGroupData.get(i)).get(AIRExpandableFileChooser.TYPE));
            }
            return view;
        }

        public boolean isChildSelectable(int i, int i2) {
            return true;
        }

        public boolean hasStableIds() {
            return true;
        }
    }

    private class FileChooserItem extends LinearLayout {
        private CompoundButton mFileCheckBox;
        private TextView mFileNameView;
        private TextView mFilePathView;
        private int mListFlatPosition = -1;
        private OnCheckedChangeListener mListener;

        FileChooserItem(LayoutInflater layoutInflater, Resources resources, ViewGroup viewGroup, int i, int i2) {
            super(AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity());
            View GetLayoutView;
            if (AIRExpandableFileChooser.this.mAllowMultiple) {
                GetLayoutView = Utils.GetLayoutView("expandable_multiple_chooser_row", resources, layoutInflater);
                Resources resources2 = GetLayoutView.getResources();
                this.mFileNameView = (TextView) Utils.GetWidgetInViewByNameFromPackage("filename", resources2, GetLayoutView);
                this.mFilePathView = (TextView) Utils.GetWidgetInViewByNameFromPackage("filepath", resources2, GetLayoutView);
                this.mFileCheckBox = (CompoundButton) Utils.GetWidgetInViewByNameFromPackage("filecheck", resources2, GetLayoutView);
                if (this.mFileNameView == null || this.mFilePathView == null || this.mFileCheckBox == null) {
                    this.mListFlatPosition = AIRExpandableFileChooser.this.expandableListPositionToFlatPosition(i, i2);
                    this.mListener = new OnCheckedChangeListener(AIRExpandableFileChooser.this) {
                        public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
                            if (FileChooserItem.this.mListFlatPosition >= 0) {
                                if (z) {
                                    AIRExpandableFileChooser.this.mCheckedFiles.put(FileChooserItem.this.mListFlatPosition, z);
                                } else {
                                    AIRExpandableFileChooser.this.mCheckedFiles.delete(FileChooserItem.this.mListFlatPosition);
                                }
                            }
                        }
                    };
                    addView(GetLayoutView);
                } else {
                    this.mListFlatPosition = AIRExpandableFileChooser.this.expandableListPositionToFlatPosition(i, i2);
                    this.mListener = /* anonymous class already generated */;
                    addView(GetLayoutView);
                }
                return;
            }
            GetLayoutView = Utils.GetLayoutView("expandable_chooser_row", resources, layoutInflater);
            resources2 = GetLayoutView.getResources();
            this.mFileNameView = (TextView) Utils.GetWidgetInViewByNameFromPackage("filename", resources2, GetLayoutView);
            this.mFilePathView = (TextView) Utils.GetWidgetInViewByNameFromPackage("filepath", resources2, GetLayoutView);
            if (this.mFileNameView == null || this.mFilePathView == null) {
                addView(GetLayoutView);
            } else {
                addView(GetLayoutView);
            }
        }

        public void bindToData(FileInfo fileInfo, int i, int i2) {
            this.mFileNameView.setText(fileInfo.mFileName);
            this.mFilePathView.setText(fileInfo.mFilePath);
            if (AIRExpandableFileChooser.this.mAllowMultiple) {
                this.mListFlatPosition = AIRExpandableFileChooser.this.expandableListPositionToFlatPosition(i, i2);
                this.mFileCheckBox.setOnCheckedChangeListener(null);
                this.mFileCheckBox.setChecked(AIRExpandableFileChooser.this.mCheckedFiles.get(this.mListFlatPosition));
                this.mFileCheckBox.setOnCheckedChangeListener(this.mListener);
                fileInfo.mParent = this;
            }
        }

        public void toggle() {
            if (AIRExpandableFileChooser.this.mAllowMultiple) {
                this.mListener.onCheckedChanged(this.mFileCheckBox, !this.mFileCheckBox.isChecked());
                this.mFileCheckBox.setOnCheckedChangeListener(null);
                this.mFileCheckBox.setChecked(AIRExpandableFileChooser.this.mCheckedFiles.get(this.mListFlatPosition));
                this.mFileCheckBox.setOnCheckedChangeListener(this.mListener);
            }
        }

        public void uncheck() {
            if (AIRExpandableFileChooser.this.mAllowMultiple) {
                this.mListener.onCheckedChanged(this.mFileCheckBox, false);
                this.mFileCheckBox.setOnCheckedChangeListener(null);
                this.mFileCheckBox.setChecked(false);
                this.mFileCheckBox.setOnCheckedChangeListener(this.mListener);
            }
        }
    }

    private class FileInfo {
        public String mFileName = new String();
        public String mFilePath = new String();
        public FileChooserItem mParent = null;

        public FileInfo(String str, String str2) {
            this.mFileName = str;
            this.mFilePath = str2;
        }
    }

    public AIRExpandableFileChooser(ArrayList<String> arrayList, boolean z, boolean z2, String str, FileChooserStub fileChooserStub) {
        this.mSave = z;
        this.mAllowMultiple = z2;
        this.mFileChooserStub = fileChooserStub;
        if (arrayList == null) {
            arrayList = new ArrayList();
            arrayList.add("*");
        }
        int size = arrayList.size();
        for (int i = 0; i < size; i++) {
            String str2 = (String) arrayList.get(i);
            if (str2.startsWith("*")) {
                str2 = str2.substring(1);
                if (str2.length() == 0) {
                    break;
                }
            }
            if (this.mSelection.length() != 0) {
                this.mSelection += " OR ";
            }
            this.mSelection += "_display_name LIKE '%" + str2 + "'";
        }
        AndroidActivityWrapper GetAndroidActivityWrapper = AndroidActivityWrapper.GetAndroidActivityWrapper();
        this.mFileChooserDialog = new AndroidAlertDialog(GetAndroidActivityWrapper.getActivity());
        Builder GetAlertDialogBuilder = this.mFileChooserDialog.GetAlertDialogBuilder();
        GetAlertDialogBuilder.setOnKeyListener(new C00861());
        GetAndroidActivityWrapper.getRuntimeContext();
        this.mRuntimeInflater = GetAndroidActivityWrapper.getActivity().getLayoutInflater();
        this.mRuntimeResources = GetAndroidActivityWrapper.getActivity().getResources();
        View GetLayoutView = Utils.GetLayoutView("main", this.mRuntimeResources, this.mRuntimeInflater);
        GetAlertDialogBuilder.setView(GetLayoutView);
        Resources resources = GetLayoutView.getResources();
        ExpandableListView expandableListView = (ExpandableListView) Utils.GetWidgetInView("list", resources, GetLayoutView);
        expandableListView.setOnChildClickListener(this);
        expandableListView.setEmptyView(GetAndroidActivityWrapper.getActivity().findViewById(16908292));
        RelativeLayout relativeLayout = (RelativeLayout) Utils.GetWidgetInViewByNameFromPackage("file_save_panel", resources, GetLayoutView);
        if (this.mSave) {
            GetAlertDialogBuilder.setTitle(Utils.GetResourceString("file_download", this.mRuntimeResources));
            relativeLayout.setVisibility(0);
            this.mFileSaveName = (EditText) Utils.GetWidgetInViewByNameFromPackage("file_save_name", resources, GetLayoutView);
            if (str != null) {
                this.mFileSaveName.setText(Utils.GetExternalStorageDirectory() + "/" + str);
            }
            this.mFileSaveName.setOnKeyListener(new C00872());
            ((Button) Utils.GetWidgetInViewByNameFromPackage("file_save_button", resources, GetLayoutView)).setOnClickListener(new C00883());
        } else {
            GetAlertDialogBuilder.setTitle(Utils.GetResourceString("file_upload", this.mRuntimeResources));
            relativeLayout.setVisibility(8);
        }
        AddMediaSubtree(Utils.GetResourceString("audio_files", this.mRuntimeResources), Media.EXTERNAL_CONTENT_URI);
        AddMediaSubtree(Utils.GetResourceString("image_files", this.mRuntimeResources), Images.Media.EXTERNAL_CONTENT_URI);
        AddMediaSubtree(Utils.GetResourceString("video_files", this.mRuntimeResources), Video.Media.EXTERNAL_CONTENT_URI);
        if (this.mGroupData.isEmpty()) {
            expandableListView.setVisibility(8);
        } else {
            this.mAdapter = new FileChooserExpandableListAdapter(this.mRuntimeInflater, this.mRuntimeResources);
            expandableListView.setAdapter(this.mAdapter);
            expandableListView.setItemsCanFocus(true);
            ((TextView) Utils.GetWidgetInViewByNameFromPackage("empty", resources, GetLayoutView)).setVisibility(8);
        }
        if (this.mAllowMultiple) {
            createInvisibleMultipleFileSelectionView();
        }
    }

    public boolean onChildClick(ExpandableListView expandableListView, View view, int i, int i2, long j) {
        if (!(view instanceof FileChooserItem)) {
            return false;
        }
        FileChooserItem fileChooserItem = (FileChooserItem) view;
        if (this.mAllowMultiple) {
            fileChooserItem.toggle();
        } else {
            HashMap hashMap = (HashMap) this.mAdapter.getChild(i, i2);
            if (this.mSave) {
                this.mFileSaveName.setText(((FileInfo) hashMap.get(FILEINFO)).mFilePath);
            } else {
                this.mFilenames.clear();
                this.mFilenames.add(((FileInfo) hashMap.get(FILEINFO)).mFilePath);
                this.mFileChooserStub.SetUserAction(USER_ACTION_DONE);
                this.mFileChooserDialog.dismiss();
            }
        }
        return true;
    }

    private int expandableListPositionToFlatPosition(int i, int i2) {
        int i3 = 0;
        if (i < 0 || i >= this.mChildData.size()) {
            return -1;
        }
        if (i2 < 0 || i2 >= ((List) this.mChildData.get(i)).size()) {
            return -1;
        }
        for (int i4 = 0; i4 < i; i4++) {
            i3 += ((List) this.mChildData.get(i4)).size();
        }
        return i3 + i2;
    }

    private void uncheckAll() {
        if (this.mAllowMultiple) {
            int size = this.mGroupData.size();
            for (int i = 0; i < size; i++) {
                int size2 = ((List) this.mChildData.get(i)).size();
                for (int i2 = 0; i2 < size2; i2++) {
                    FileChooserItem fileChooserItem = ((FileInfo) ((HashMap) this.mAdapter.getChild(i, i2)).get(FILEINFO)).mParent;
                    if (fileChooserItem != null) {
                        fileChooserItem.uncheck();
                    }
                }
            }
        }
    }

    private void createInvisibleMultipleFileSelectionView() {
        Builder GetAlertDialogBuilder = this.mFileChooserDialog.GetAlertDialogBuilder();
        GetAlertDialogBuilder.setPositiveButton(Utils.GetResourceString("button_ok", this.mRuntimeResources), new C00894());
        GetAlertDialogBuilder.setNegativeButton(Utils.GetResourceString("button_cancel", this.mRuntimeResources), new C00905());
    }

    private void AddMediaSubtree(String str, Uri uri) {
        Cursor managedQuery = AndroidActivityWrapper.GetAndroidActivityWrapper().getActivity().managedQuery(uri, this.mFileProjection, this.mSelection.length() == 0 ? null : this.mSelection, null, null);
        List arrayList = new ArrayList();
        if (managedQuery != null && managedQuery.moveToFirst()) {
            Map hashMap = new HashMap();
            hashMap.put(TYPE, str);
            this.mGroupData.add(hashMap);
            do {
                FileInfo fileInfo = new FileInfo(managedQuery.getString(managedQuery.getColumnIndex("_display_name")), managedQuery.getString(managedQuery.getColumnIndex("_data")));
                Map hashMap2 = new HashMap();
                arrayList.add(hashMap2);
                hashMap2.put(FILEINFO, fileInfo);
            } while (managedQuery.moveToNext());
            this.mChildData.add(arrayList);
        }
    }

    private void HideVirtualKeyboard(View view) {
        InputMethodManager inputMethodManager = (InputMethodManager) view.getContext().getSystemService("input_method");
        if (inputMethodManager != null) {
            inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }

    public AndroidAlertDialog GetDialog() {
        return this.mFileChooserDialog;
    }

    public ArrayList<String> GetFileNames() {
        return this.mFilenames;
    }
}
