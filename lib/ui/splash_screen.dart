import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasuresofra/utils/decryptor.dart';

import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  static String route = "/";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //TODO EDIT HERE
  String bg = "assets/elements/bg.png";
  String logo = "assets/elements/app_logo.png";
  String appNameImage = "assets/elements/app_name.png";

  final flutterWebViewPlugin = FlutterWebviewPlugin();
  Widget _mainContainer;

  void createMainContainer(BuildContext context) {
    setState(() {
      _mainContainer = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
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
                    Image.asset(
                      logo,
                      height: MediaQuery.of(context).size.width / 3 * 2,
                      width: MediaQuery.of(context).size.width / 3 * 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Image.asset(
                        appNameImage,
                        width: MediaQuery.of(context).size.width / 3 * 1,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void createWebView(BuildContext context, String url) {
    setState(() {
      _mainContainer = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      FacebookDeeplinks().onDeeplinkReceived.listen(_onRedirected);

      FacebookDeeplinks().getInitialUrl().then((value) async {
        if (value == null || value.isEmpty) {
          _getSharedPref().then((value) async {
            nextScreen();
          });
        } else {
          _setSharedPref(await Decryptor.decrypt(value)).then((value) {
            nextScreen();
          });
        }
      });
    }

    AppTrackingTransparency.requestTrackingAuthorization().then((value) {
      if (Platform.isIOS) {
        _getSharedPref().then((value) async {
          if (value == null) {
            Firebase.initializeApp(
              name: 'testapp-84798',
              options: Platform.isAndroid
                  ? FirebaseOptions(
                      appId: '1:927368112125:android:8030efff38ba2b78765b94',
                      apiKey:
                          'AAAA1-tyZ_0:APA91bGK1TmVwpkdKBqFdhaaxtXnCw_VNcNk7wRg1FWacjDzCFfvCuEbmldMrg2hXP7SsUtsml2EuED0tM99cw7rrpR-06PgBRzPBnQLbpX64jc2XxzRpdBV1lcRiIGjvuMsVzXl9iGB',
                      projectId: 'testapp-84798',
                      messagingSenderId: '927368112125',
                      databaseURL: 'https://testapp-84798.firebaseio.com/',
                    )
                  : FirebaseOptions(
                      appId: '1:927368112125:ios:a654cf2722775d1e765b94',
                      apiKey:
                          'AAAA1-tyZ_0:APA91bGK1TmVwpkdKBqFdhaaxtXnCw_VNcNk7wRg1FWacjDzCFfvCuEbmldMrg2hXP7SsUtsml2EuED0tM99cw7rrpR-06PgBRzPBnQLbpX64jc2XxzRpdBV1lcRiIGjvuMsVzXl9iGB',
                      projectId: 'testapp-84798',
                      messagingSenderId: '927368112125',
                      databaseURL: 'https://testapp-84798.firebaseio.com/',
                    ),
            ).then((value) {
              FirebaseDatabase database = FirebaseDatabase(app: value);
              database
                  .reference()
                  .child("isReady")
                  .once()
                  .then((DataSnapshot snapshot) async {
                if (snapshot.value) {
                  database
                      .reference()
                      .child("url")
                      .once()
                      .then((DataSnapshot snapshot) async {
                    _setSharedPref(snapshot.value).then((value) {
                      nextScreen();
                    });
                  });
                } else {
                  nextScreen();
                }
              });
            });
          } else {
            nextScreen();
          }
        });
      }
    });

    // _encrypt("https://www.google.com/search?sxsrf=ALeKk02_a3OoPLbLAxwrI2i1sRi-AEd7ZA%3A1613813798912&ei=JtgwYIquN4WmaLXTuvgP&q=PlatformStringCryptor+%D0%B0%D0%B4%D0%B3%D0%B5%D0%B5%D1%83%D0%BA&oq=PlatformStringCryptor+%D0%B0%D0%B4%D0%B3%D0%B5%D0%B5%D1%83%D0%BA&gs_lcp=Cgdnd3Mtd2l6EAMyCQghEAoQoAEQKjIHCCEQChCgAVCrEFj6GGC6GWgBcAB4AIABhAGIAcsGkgEDMC43mAEAoAEBqgEHZ3dzLXdpesABAQ&sclient=gws-wiz&ved=0ahUKEwiK2d7xlPjuAhUFExoKHbWpDv8Q4dUDCA0&uact=5");
    // _onRedirected(
    //     'treasuresofra://base=VLOIdUov19/G/fU4EqPQfA..,iZhXghAqcjZK+ACka4XQSRptAMywjzc+SsTeLghZj1M.,/+H6mr4LQ2oAFiEg/zUq5zReUE0+ZUsBruNZ19jqjtCN4tM0A/Ih7mEJBWG1QmYqmO/BYyIHVNNS+9tZ6MyXW3mPu1BpyqDN2JtuPDIqbV+dTxlkyZX0L3JV5isPs3KB3hSANzy6S0erq+eo23Eos8nKD15pLeJKvOgqdhyarj1IF3HvGykRijMzrQ1V+d4sOXRlbfy6SltmttXJ37fSs4islpsRGL3dHy95Xr6JD3YbAQNOUcuub9vIxcueevIiUm38udAQOFcBsfqwBGPA7fVqi8orqY121FFy2uv1evit1BK0bDqrDHIGpP4Qo43aUXOLRUv1jLQwMV4u1wUIO8PV7CounBGPCs6ZAgRjQaPL9MB9pq38D9pUXD2ZdCfPws3VyRi4pmPuf4Tr2T02GDutz6jH44KiDNtMUiqn8b3wLh9/P4QQRJZtS0lvLnLYTTlS2MMJqgcnE3oQfkvp/38imnkYXsMV+F4t/c0yEDkT9CCzuVwRMKDbpoaUzP8nGm3lbWxS8aZNvscx0aXLySJHFByChIAc6/qWhzbm0bHzeI1+o3sESoh+oTMudseO');
  }

  @override
  Widget build(BuildContext context) {
    if (_mainContainer == null) {
      _mainContainer = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/elements/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/elements/app_logo.png',
              height: MediaQuery.of(context).size.width / 3 * 2,
              width: MediaQuery.of(context).size.width / 3 * 2,
            ),
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: _mainContainer,
    );
  }

  void nextScreen() {
    Timer(Duration(seconds: 3), () {
      _getSharedPref().then((value) async {
        if (value == null || value.isEmpty) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen()));
        } else {
          createWebView(context, value);
        }
      });
    });
  }

  Future<void> _onRedirected(String url) async {
    _setSharedPref(await Decryptor.decrypt(url)).then((value) {
      nextScreen();
    });
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
}
