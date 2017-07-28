package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import android.os.AsyncTask;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

@TargetApi(18)
public class AnotherAneFunction implements FREFunction {

    private class AnotherAneFunctionTask extends AsyncTask<Void, Void, Void> {
        private AnotherAneFunctionTask() {
        }

        protected Void doInBackground(Void... params) {
            return null;
        }
    }

    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        try {
            new AnotherAneFunctionTask().execute(new Void[0]);
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        return null;
    }
}
