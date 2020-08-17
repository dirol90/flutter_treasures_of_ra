import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treasuresofra/ui/main_screen.dart';

class SplashScreen extends StatelessWidget {
  static String route = "/";
  Timer _timer;

  @override
  Widget build(BuildContext context) {

    _timer = Timer(Duration(seconds: 3), () {
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
                    Image.asset('assets/elements/app_logo.png', height: MediaQuery.of(context).size.width/3*2, width: MediaQuery.of(context).size.width/3*2,),
                    Image.asset('assets/elements/app_name.png', width: MediaQuery.of(context).size.width/3*2,)
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  }

}

