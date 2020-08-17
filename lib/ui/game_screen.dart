import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treasuresofra/views/card_view.dart';

import 'level_complet_screen.dart';

class GameScreen extends StatefulWidget {
  static String route = "/game_screen";

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<bool> _covers = List();
  String _timeCounterText = "";

  @override
  Widget build(BuildContext context) {
    _fillCovers(12);
    _startTimeCounter(90);

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
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(_timeCounterText, style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: "Dimbo"),),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 64.0, bottom: 64.0),
                child: Container(
                  height: MediaQuery.of(context).size.height-80,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    itemCount: _covers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return CardsView(_covers[index]);
                    },
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Image.asset('assets/elements/pause_btn.png', height: MediaQuery.of(context).size.width/10*1, width: MediaQuery.of(context).size.width/10*1.5,),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fillCovers(int count){
    if (_covers.isEmpty){
      for (int i = 0; i < count; i++){
        _covers.add(false);
      }
    }
  }

  int maxTimeCounterValue = 0;
  int currentCounterValue = 0;
  Timer _timer;
  void _startTimeCounter(int maxTime) {
    maxTimeCounterValue = maxTime;
    if (_timer == null){
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          currentCounterValue++;
          int minutes =(maxTimeCounterValue - currentCounterValue) ~/ 60;
          int seconds =(maxTimeCounterValue - currentCounterValue) % 60;
          _timeCounterText = "${format(minutes)}:${format(seconds)}";
          if (maxTimeCounterValue - currentCounterValue < 0){
            _timer.cancel();
            _timer = null;
            _timeCounterText = "";
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LevelCompletedScreen()));
          }
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  String format(int n) {
    return n < 10 ? "0$n" : n.toString();
  }
}