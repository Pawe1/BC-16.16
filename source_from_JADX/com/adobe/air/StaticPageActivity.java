package com.adobe.air;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebSettings.LayoutAlgorithm;
import android.webkit.WebView;

public class StaticPageActivity extends Activity {
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(2130903071);
        WebView webView = (WebView) findViewById(2131558580);
        webView.getSettings().setSupportZoom(true);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setLayoutAlgorithm(LayoutAlgorithm.NORMAL);
        webView.getSettings().setLoadWithOverviewMode(true);
        webView.getSettings().setUseWideViewPort(true);
        webView.loadUrl("file:///android_asset/index.html");
    }
}
