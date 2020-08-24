import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treasuresofra/ui/settings_screen.dart';
import 'package:treasuresofra/views/level_view.dart';

class LevelScreen extends StatelessWidget {
  static String route = "/levels_screen";
  List _levels = new List();


  @override
  Widget build(BuildContext context) {

    fillList(25);

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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                        child: Image.asset('assets/elements/back_btn.png', height: MediaQuery.of(context).size.width/10*1, width: MediaQuery.of(context).size.width/10*1.5,),
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        nextScreen(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                        child: Image.asset('assets/elements/settings_btn.png', height: MediaQuery.of(context).size.width/10*1, width: MediaQuery.of(context).size.width/10*1.5,),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height-80,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    itemCount: _levels.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return LevelView(index+1, false, -1);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fillList(int count){
    if (_levels.isEmpty){
      for (int i = 0; i < count; i++){
        _levels.add((i+1).toString());
      }
    }
  }

  void nextScreen(BuildContext context){
    Navigator.pushNamed(context, SettingsScreen.route);
  }

  void popBack(BuildContext context){
    Navigator.pop(context);
  }

}
