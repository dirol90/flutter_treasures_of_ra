import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasuresofra/ui/pre_game_screen.dart';

class LevelView extends StatefulWidget {

  int index;
  bool isOpened;
  int starsCounter;

  LevelView(this.index, this.isOpened, this.starsCounter);

  @override
  _LevelViewState createState() => _LevelViewState();
}

class _LevelViewState extends State<LevelView> {
  @override
  Widget build(BuildContext context) {

    if (widget.starsCounter == -1)
    _getSharedPref(widget.index).then((value) {
      if (value != null) {
        setState(() {
          widget.starsCounter = value == null ?  0 : value;
        });
      } else {
        widget.starsCounter = 0;
      }

    });

    return GestureDetector(
      onTap: (){
        nextScreen(context);
      },
      child: Container(
        height: MediaQuery.of(context).size.width/6*1,
        width: MediaQuery.of(context).size.width/6*1,
        child: Stack(
          children: <Widget>[
            Align(alignment: Alignment.center, child: Image.asset('assets/elements/element_bg.png', height: MediaQuery.of(context).size.width/6*1, width: MediaQuery.of(context).size.width/6*1,)),
            Align(alignment: Alignment.center, child: Text(widget.index.toString(), style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: "Dimbo"),)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width/6*0.25),
                child: widget.starsCounter != 0 ? Image.asset(
                  'assets/elements/stars_${widget.starsCounter}.png',
                  height: MediaQuery.of(context).size.width/6*0.75, width: MediaQuery.of(context).size.width/6*0.75,) :
                Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextScreen(BuildContext context){
    Navigator.pushNamed(context, PreGameScreen.route, arguments: widget.index);
  }

  Future<int> _getSharedPref(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = prefs.getInt('level$index');
    print('INDEX $i');
    return i == null ? 0 : i;
  }
}
