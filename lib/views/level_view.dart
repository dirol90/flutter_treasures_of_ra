import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treasuresofra/ui/pre_game_screen.dart';

class LevelView extends StatelessWidget {

  int index;
  bool isOpened;
  int starsCounter;

  LevelView(this.index, this.isOpened, this.starsCounter);

  @override
  Widget build(BuildContext context) {
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
            Align(alignment: Alignment.center, child: Text(index.toString(), style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: "Dimbo"),)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width/6*0.25),
                child: Image.asset(
                  'assets/elements/stars_$starsCounter.png',
                  height: MediaQuery.of(context).size.width/6*0.75, width: MediaQuery.of(context).size.width/6*0.75,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextScreen(BuildContext context){
    Navigator.pushNamed(context, PreGameScreen.route);
  }
}
