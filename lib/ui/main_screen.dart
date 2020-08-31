import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treasuresofra/ui/levels_screen.dart';
import 'package:treasuresofra/ui/web_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatelessWidget {
  static String route = "/main_screen";

  @override
  Widget build(BuildContext context) {

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
                    Image.asset('assets/elements/app_logo.png', height: MediaQuery.of(context).size.width/3*2, width: MediaQuery.of(context).size.width/3*2,),
                    GestureDetector(
                      onTap: (){
                        _nextScreen(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 64.0),
                        child: Image.asset('assets/elements/start_btn.png', width: MediaQuery.of(context).size.width/3*1,),
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
                          onTap: (){
                            _launchURLWithPolicy(context);
                          },
                          child: Text('PRIVACY POLICY', style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: "Dimbo"),)),
                      GestureDetector(
                          onTap: (){
                            _launchURLWithTerms(context);
                          },
                          child: Text('TERMS & CONDITIONS', style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: "Dimbo"),)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _nextScreen(BuildContext context){
    Navigator.pushNamed(context, LevelScreen.route);
  }

  _launchURLWithPolicy(BuildContext context) async {
    const url = 'https://sites.google.com/view/treasures-of-ra-privacy-policy/privacy-policy';
    if (await canLaunch(url)) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => WebViewScreen(url: url)));
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLWithTerms(BuildContext context) async {
    const url = 'https://sites.google.com/view/treasures-of-ra-terms-conditio/treasures-of-ra-tc';
    if (await canLaunch(url)) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => WebViewScreen(url: url)));
    } else {
      throw 'Could not launch $url';
    }
  }

}
