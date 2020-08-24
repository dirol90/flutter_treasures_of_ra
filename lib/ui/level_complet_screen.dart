import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game_screen.dart';

class LevelCompletedScreen extends StatelessWidget {
  static String route = "/level_completed_screen";

  int index = -1;
  int spendTime = -1;
  LevelCompletedScreen({this.index, this.spendTime});

  @override
  Widget build(BuildContext context) {
    _setSharedPref();
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      popBack(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Container(
                        child: Image.asset('assets/elements/back_btn.png', height: MediaQuery.of(context).size.width/10*1, width: MediaQuery.of(context).size.width/10*1.5,),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/10*8,
                  height: MediaQuery.of(context).size.width/10*8,
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/elements/dialog_bg.png', width: MediaQuery.of(context).size.width/10*8,),
                      Align(alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset('assets/elements/stars_${(index < 10 && spendTime < 60 || index < 20 && spendTime < 45 || index > 20 && spendTime < 30) ? '3' :
                              (index < 10 && spendTime < 90 || index < 20 && spendTime < 60 || index > 20 && spendTime < 45) ? '2' : '1'
                              }.png', width: MediaQuery.of(context).size.width/3*1,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Level 1  complete!', style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: "Dimbo",), textAlign: TextAlign.center,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    nextScreen(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(height: 64, width: 128, child: Image.asset('assets/elements/next.png', width: MediaQuery.of(context).size.width/3*1,)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    popBack(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(height: 64, width: 128, child: Image.asset('assets/elements/restart.png', width: MediaQuery.of(context).size.width/3*1,)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void popBack(BuildContext context){
    Navigator.pop(context);
  }

  void nextScreen(BuildContext context){
    Navigator.pushNamed(context, GameScreen.route, arguments: index+1);
  }

  Future<void> _setSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('level$index', (index < 10 && spendTime < 60 || index < 20 && spendTime < 45 || index > 20 && spendTime < 30) ? 3 :
    (index < 10 && spendTime < 90 || index < 20 && spendTime < 60 || index > 20 && spendTime < 45) ? 2 : 1);
  }


}

