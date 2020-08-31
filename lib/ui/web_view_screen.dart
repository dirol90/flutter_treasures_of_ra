import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewScreen extends StatelessWidget {
  static String route = "/web_view_screen";
  String url;

  WebViewScreen({this.url = ""});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: SafeArea(
          child: WebviewScaffold(
            url: url,
            withZoom: false,
            displayZoomControls: false,
            withLocalStorage: false,
            hidden: false,
            withJavascript: true,
            clearCache: false,
            clearCookies: false,
            scrollBar: true,
            supportMultipleWindows: true,
            withOverviewMode: true,
            appCacheEnabled: true,
            useWideViewPort: true,
            ignoreSSLErrors: true,
            userAgent: 'Mozilla/5.0 (Linux; Android 5.1.1; Nexus 5 Build/LMY48B; wv webview_android_dl) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/43.0.2357.65 Mobile Safari/537.36',

            initialChild: Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void popBack(BuildContext context){
    Navigator.pop(context);
  }
}

