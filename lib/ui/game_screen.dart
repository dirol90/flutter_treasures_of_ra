import 'dart:async';
import 'dart:math';

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
  List<bool> _isVisibleList = List();
  List<bool> _covers = List();
  List<int> _coversIndex = List();
  String _timeCounterText = "";
  int timeCounterInt = -1;
  Widget w;
  int index = -1;

  @override
  Widget build(BuildContext context) {

    index = ModalRoute.of(context).settings.arguments;
    _fillCovers(12);
    _fillCoversIndex(1, 6);
    _startTimeCounter(index < 10 ? 150 : index < 30 ? 90 : 60);

    if (w == null) {
      w = buildWidget();
    }
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
                    child: Text(
                      _timeCounterText,
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: "Dimbo"),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 64.0, bottom: 64.0),
                child: Container(
                  height: MediaQuery.of(context).size.height - 80,
                  width: MediaQuery.of(context).size.width,
                  child: w,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isNotPause = !_isNotPause;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Image.asset(
                        _isNotPause ? 'assets/elements/pause_btn.png' : 'assets/elements/play_btn.png',
                        height: MediaQuery.of(context).size.width / 10 * 1,
                        width: MediaQuery.of(context).size.width / 10 * 1.5,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _fillCovers(int count) {
    if (_covers.isEmpty) {
      for (int i = 0; i < count; i++) {
        _covers.add(false);
        _isVisibleList.add(true);
        }
    }
  }

  void _fillCoversIndex(int min, int max) {
    if (_coversIndex.isEmpty){
      var rng = new Random();

      for (int i = 0; i < _covers.length; i++) {
        _coversIndex.add(-1);
      }

      for (int i = 0; i < _covers.length; i++) {
        if (_coversIndex[i] == -1) {
          bool isFilled = false;
          do {

            int value = rng.nextInt(max) + min;
            if (!_coversIndex.contains(value)) {
              _coversIndex[i] = value;
              isFilled = true;

              bool isFilledInner = false;
              do {
                int index = rng.nextInt(_covers.length);
                if (_coversIndex[index] == -1) {
                  _coversIndex[index] = value;
                  isFilledInner = true;
                }
              } while (!isFilledInner);
            }
          } while (!isFilled);
        }
      }
    }
  }

  int maxTimeCounterValue = 0;
  int currentCounterValue = 0;
  Timer _timer;
  bool _isNotPause = true;

  void _startTimeCounter(int maxTime) {
    maxTimeCounterValue = maxTime;
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_isNotPause) {
          setState(() {
            currentCounterValue++;
            int minutes = (maxTimeCounterValue - currentCounterValue) ~/ 60;
            int seconds = (maxTimeCounterValue - currentCounterValue) % 60;
            _timeCounterText = "${format(minutes)}:${format(seconds)}";
            timeCounterInt++;
            if (maxTimeCounterValue - currentCounterValue < 0) {
              _timer.cancel();
              _timer = null;
              _timeCounterText = "";
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          LevelCompletedScreen(index: index, spendTime: timeCounterInt,)));
            }
          });
        }
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

  Timer _functionTimer;
  void checkIsSame (){
    _functionTimer = new Timer(const Duration(milliseconds: 1250), () {
      List<int> selectedIndexes = List();
      for (int i = 0; i < _covers.length; i++){
        if (_covers[i]){
          selectedIndexes.add(_coversIndex[i]);
        }
      }

      if (selectedIndexes.length > 1) {
        if (selectedIndexes[0] == selectedIndexes[1]){
          setState(() {
            for (int i = 0; i < _covers.length; i++){
              if (_covers[i]){
                _isVisibleList[i] = false;
                _covers[i] = false;
              }
            }
            w = buildWidget();
          });
        } else {
          setState(() {
            for (int i = 0; i < _covers.length; i++){
              _covers[i] = false;
            }
            w = buildWidget();
          });
        }
      }
      _functionTimer.cancel();

      bool isAnyVisible = false;
      for (int i = 0; i < _isVisibleList.length; i++){
        if (_isVisibleList[i]){
          isAnyVisible = true;
          break;
        }
      }

      if (!isAnyVisible) {
        _timer.cancel();
        _timer = null;
        _timeCounterText = "";

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    LevelCompletedScreen(index: index, spendTime: timeCounterInt,)));
      }


    });

  }

  Widget buildWidget(){
    return GridView.builder(
      itemCount: _covers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return CardsView(_covers, _coversIndex, _isVisibleList, checkIsSame, index);
      },
    );
  }
}
