import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'game_screen.dart';

class PreGameScreen extends StatelessWidget {
  static String route = "/pre_game_screen";
  int index = -1;

  @override
  Widget build(BuildContext context) {

    index = ModalRoute.of(context).settings.arguments;

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
                        child: Padding(
                          padding: const EdgeInsets.only( bottom: 16.0),
                          child: Text('In order to get 3 stars\nfinish the level\nunder ${index < 10 ? '2.5' : index < 20 ? '1.5' : '1' } minutes', style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: "Dimbo",), textAlign: TextAlign.center,),
                        ),),
                      Align(alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: (){
                            nextScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only( bottom: 16.0),
                            child: Image.asset('assets/elements/play_btn.png', height: MediaQuery.of(context).size.width/10*1, width: MediaQuery.of(context).size.width/10*1.5,),
                          ),
                        ),),
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
    Navigator.pushNamed(context, GameScreen.route, arguments: index);
  }

}

