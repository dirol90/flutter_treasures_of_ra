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
            userAgent: 'Mozilla/5.0 (Linux; Android 7.0; SM-G930F Build/MMB29K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.91 Mobile Safari/537.36 webview_android_dl',

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

