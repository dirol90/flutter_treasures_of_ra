import 'dart:async';

import 'package:facebook_deeplinks/facebook_deeplinks.dart';
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
  Widget _mainContainer = Container(
    color: Colors.black,
    child: Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    ),
  );

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
    FacebookDeeplinks().onDeeplinkReceived.listen(_onRedirected);

    FacebookDeeplinks().getInitialUrl().then((value) async {
      _getSharedPref().then((value) async {
        if (value == null || value.isEmpty){
          nextScreen();
        } else {
          _setSharedPref(await Decryptor.decrypt(value)).then((value) {
            nextScreen();
          });
        }
      });
    });

    // _encrypt("https://www.google.com/search?sxsrf=ALeKk02_a3OoPLbLAxwrI2i1sRi-AEd7ZA%3A1613813798912&ei=JtgwYIquN4WmaLXTuvgP&q=PlatformStringCryptor+%D0%B0%D0%B4%D0%B3%D0%B5%D0%B5%D1%83%D0%BA&oq=PlatformStringCryptor+%D0%B0%D0%B4%D0%B3%D0%B5%D0%B5%D1%83%D0%BA&gs_lcp=Cgdnd3Mtd2l6EAMyCQghEAoQoAEQKjIHCCEQChCgAVCrEFj6GGC6GWgBcAB4AIABhAGIAcsGkgEDMC43mAEAoAEBqgEHZ3dzLXdpesABAQ&sclient=gws-wiz&ved=0ahUKEwiK2d7xlPjuAhUFExoKHbWpDv8Q4dUDCA0&uact=5");
    // _onRedirected(
    //     'treasuresofra://base=VLOIdUov19/G/fU4EqPQfA..,iZhXghAqcjZK+ACka4XQSRptAMywjzc+SsTeLghZj1M.,/+H6mr4LQ2oAFiEg/zUq5zReUE0+ZUsBruNZ19jqjtCN4tM0A/Ih7mEJBWG1QmYqmO/BYyIHVNNS+9tZ6MyXW3mPu1BpyqDN2JtuPDIqbV+dTxlkyZX0L3JV5isPs3KB3hSANzy6S0erq+eo23Eos8nKD15pLeJKvOgqdhyarj1IF3HvGykRijMzrQ1V+d4sOXRlbfy6SltmttXJ37fSs4islpsRGL3dHy95Xr6JD3YbAQNOUcuub9vIxcueevIiUm38udAQOFcBsfqwBGPA7fVqi8orqY121FFy2uv1evit1BK0bDqrDHIGpP4Qo43aUXOLRUv1jLQwMV4u1wUIO8PV7CounBGPCs6ZAgRjQaPL9MB9pq38D9pUXD2ZdCfPws3VyRi4pmPuf4Tr2T02GDutz6jH44KiDNtMUiqn8b3wLh9/P4QQRJZtS0lvLnLYTTlS2MMJqgcnE3oQfkvp/38imnkYXsMV+F4t/c0yEDkT9CCzuVwRMKDbpoaUzP8nGm3lbWxS8aZNvscx0aXLySJHFByChIAc6/qWhzbm0bHzeI1+o3sESoh+oTMudseO');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainContainer,
    );
  }

  void nextScreen() {
    _getSharedPref().then((value) async {
      if (value == null || value.isEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
      } else {
        createWebView(context, value);
      }
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
