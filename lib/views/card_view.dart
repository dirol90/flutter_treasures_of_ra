import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardsView extends StatefulWidget {

  bool isOpened;

  CardsView(this.isOpened);

  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      onFlip: (){
        changeState();
      },
      direction: FlipDirection.HORIZONTAL, // default
      front: Container(
        height: MediaQuery.of(context).size.width/6*1,
        width: MediaQuery.of(context).size.width/6*1,
        child: Stack(
          children: <Widget>[
            Align(alignment: Alignment.center, child: ColorFiltered(colorFilter: ColorFilter.mode(widget.isOpened ? Colors.white: Colors.red, BlendMode.color), child: Image.asset('assets/elements/element_bg.png', height: MediaQuery.of(context).size.width/6*1, width: MediaQuery.of(context).size.width/6*1, ))),
          ],
        ),
      ),
      back: Container(
        height: MediaQuery.of(context).size.width/6*1,
        width: MediaQuery.of(context).size.width/6*1,
        child: Stack(
          children: <Widget>[
            Align(alignment: Alignment.center, child: ColorFiltered(colorFilter: ColorFilter.mode(widget.isOpened ? Colors.white: Colors.red, BlendMode.color), child: Image.asset('assets/elements/element_bg.png', height: MediaQuery.of(context).size.width/6*1, width: MediaQuery.of(context).size.width/6*1, ))),
          ],
        ),
      ),
    );
  }

  void changeState(){
    setState(() {
      widget.isOpened = !widget.isOpened;
    });
  }
}
