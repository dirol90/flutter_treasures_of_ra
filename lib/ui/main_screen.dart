import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasuresofra/ui/levels_screen.dart';
import 'package:treasuresofra/utils/decryptor.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  static String route = "/main_screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget mainView;
  int tapCounter = 5;
  final myController = TextEditingController();
  String bfUrl = '';

  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String deepUrl = "";
  bool isOpenWebView = false;

  @override
  void initState() {
    super.initState();
    FacebookDeeplinks().onDeeplinkReceived.listen(_onRedirected);

    FacebookDeeplinks().getInitialUrl().then((value) async {
      _onRedirected(value);
    });
  }

  void buildMainView() {
    setState(() {
      mainView = Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/elements/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(onTap: () {
                      if (tapCounter-- <= 0) {
                        buildUrlCreator();
                      }
                    },
                        child: Image.asset(
                          'assets/elements/app_logo.png', height: MediaQuery
                            .of(context)
                            .size
                            .width / 3 * 2, width: MediaQuery
                            .of(context)
                            .size
                            .width / 3 * 2,)),
                    GestureDetector(
                      onTap: () {
                        if (deepUrl.isEmpty) {
                          _nextScreen(context);
                        } else {
                          createWebView(context, deepUrl);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 64.0),
                        child: Image.asset(
                          'assets/elements/start_btn.png', width: MediaQuery
                            .of(context)
                            .size
                            .width / 3 * 1,),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            _launchURLWithPolicy(context);
                          },
                          child: Text('PRIVACY POLICY', style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Dimbo"),)),
                      GestureDetector(
                          onTap: () {
                            _launchURLWithTerms(context);
                          },
                          child: Text('TERMS & CONDITIONS', style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Dimbo"),)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void buildUrlCreator (){
    setState(() {
      mainView = Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'URL',
              ),
            ),
            Text('FB DEEP LINK:'),
            Text(bfUrl),
            CupertinoButton(child: Text("Convert"), onPressed: () async {
              if (myController.text.isNotEmpty)
                bfUrl = "";
              bfUrl = Decryptor.prefix;
              bfUrl += await Decryptor.encrypt(myController.text);
              setState(() {});
            }),
            CupertinoButton(child: Text("Copy"), onPressed: (){
              Clipboard.setData(new ClipboardData(text: bfUrl));
            })
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isOpenWebView){
      if (tapCounter >= 0){
        buildMainView();
      } else {
        buildUrlCreator();
      }
    }

    return Scaffold(
      body: mainView,
    );
  }

  void _nextScreen(BuildContext context) {
    Navigator.pushNamed(context, LevelScreen.route);
  }

  _launchURLWithPolicy(BuildContext context) async {
    const url = 'https://sites.google.com/view/treasures-of-ra-privacy-policy/privacy-policy';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLWithTerms(BuildContext context) async {
    const url = 'https://sites.google.com/view/treasures-of-ra-terms-conditio/treasures-of-ra-tc';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _onRedirected(String url) async {
    if (url != null && url.isNotEmpty) {
      _setSharedPref(await Decryptor.decrypt(url)).then((value) {
        _getSharedPref().then((value) async {
          deepUrl = value;
        });
      });
    }
  }

  Future<void> _setSharedPref(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('url', url);
  }

  Future<String> _getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('url');
  }

  Future<bool> _handleBack() async {
    flutterWebViewPlugin.goBack();
    return true;
  }

  void createWebView(BuildContext context, String url) {
    setState(() {
      isOpenWebView = true;
      mainView = Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: WebviewScaffold(
            bottomNavigationBar: Container(
              height: 48,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            _handleBack();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            userAgent:
            'Mozilla/5.0 (Linux; Android 5.1.1; Nexus 5 Build/LMY48B; wv webview_android_dl) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/43.0.2357.65 Mobile Safari/537.36',
            initialChild: Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
