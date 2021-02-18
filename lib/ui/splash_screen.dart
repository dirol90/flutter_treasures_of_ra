import 'dart:async';

import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasuresofra/ui/web_view_screen.dart';

import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  static String route = "/";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  final cryptor = new PlatformStringCryptor();
  final password = "aMHp7UwTeAUf7JYTi+Opcg==:aOTvlL2z6iP/2DPczLdBr0jJMp1bmIOO6Cp9LMcr5jQ=";

  var prefix = "treasuresofra://base=";

  @override
  Widget build(BuildContext context) {
    FacebookDeeplinks().onDeeplinkReceived.listen(_onRedirected);

    FacebookDeeplinks().getInitialUrl().then((value) async {
     _setSharedPref(await _decrypt(value)).then((value) {
       nextScreen(context);
     });
   });

    // _onRedirected('treasuresofra://base=OnEQrWX0cYIrY1aMPcjLoA==:G+eo3CYDbHBFQEPSb2brarWMguXTCZaEnx29sqABXYo=:V5A43Vrxv5rPXghKWG84FAvUxx9Vi81MypUq5CZa+xQ=?al_applink_data=abc');

    _timer = Timer(Duration(seconds: 5), () {
      nextScreen(context);
      _timer.cancel();
    });


    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                    Image.asset('assets/elements/app_logo.png', height: MediaQuery.of(context).size.width/3*2, width: MediaQuery.of(context).size.width/3*1.5,),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Image.asset('assets/elements/app_name.png', width: MediaQuery.of(context).size.width/3*1,),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void nextScreen(BuildContext context){
//    _encrypt('URL_HERE');
    _getSharedPref().then((value) {

    if (value == null || value.isEmpty){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    } else {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => WebViewScreen(url: value)));
    }
    });
  }

  Future<void> _onRedirected(String url) async {
    _setSharedPref(await _decrypt(url)).then((value) {
    nextScreen(context);
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

  Future<void> _encrypt(String s) async {
    final String encrypted = await cryptor.encrypt(s, password);
    print("ENCRYOTED: $encrypted");
    _decrypt(encrypted);
  }

  Future<String> _decrypt(String encrypted) async {

    try {if (encrypted.contains(prefix)) encrypted = encrypted.replaceRange(0, prefix.length, '');} catch (e) {e;}
    try {encrypted = encrypted.replaceRange(encrypted.indexOf('?al_applink_data'), encrypted.length, '');} catch (e) {e;}

    if (encrypted != null) {
      try {
        final String decrypted = await cryptor.decrypt(encrypted, password);
        print("DECRYPTED: $decrypted");
        return decrypted;
      } on MacMismatchException {
        // unable to decrypt (wrong key or forged data)
        return '';
      }
    } else {
      return '';
    }

  }

}

