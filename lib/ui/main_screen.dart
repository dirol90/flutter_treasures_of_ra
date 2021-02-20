import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
    super.initState();
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
                        _nextScreen(context);
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
    if (tapCounter >= 0){
      buildMainView();
    } else {
      buildUrlCreator();
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
}
