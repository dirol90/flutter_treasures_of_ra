import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardsView extends StatefulWidget {

  List<bool> _isVisibleList;
  List<bool> _covers;
  List<int> _coversIndex;
  Function f;
  int index;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  CardsView(this._covers, this._coversIndex, this._isVisibleList, this.f, this.index);

  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  @override
  Widget build(BuildContext context) {


    return widget._isVisibleList[widget.index] ? FlipCard(
      key: widget.cardKey,
      onFlip: (){
        changeState();
      },
      onFlipDone: (isFront) {
        bool isFlipped = !isFront;
        if (!isFlipped && widget._covers[widget.index]) widget.cardKey?.currentState?.toggleCard();
      },
      direction: FlipDirection.HORIZONTAL, // default
      front: Container(
        height: MediaQuery.of(context).size.width/6*1,
        width: MediaQuery.of(context).size.width/6*1,
        child: Stack(
          children: <Widget>[
            Align(alignment: Alignment.center, child: Image.asset('assets/elements/card_back.png', height: MediaQuery.of(context).size.width/6*1, width: MediaQuery.of(context).size.width/6*1, )),
          ],
        ),
      ),
      back: Container(
        height: MediaQuery.of(context).size.width/6*1,
        width: MediaQuery.of(context).size.width/6*1,
        child: Stack(
          children: <Widget>[
            Align(alignment: Alignment.center, child: Image.asset('assets/elements/card_${widget._coversIndex[widget.index]}.png', height: MediaQuery.of(context).size.width/6*1, width: MediaQuery.of(context).size.width/6*1, )),
          ],
        ),
      ),
    ) : Container();
  }

  void changeState(){
    setState(() {
      widget._covers[widget.index] = !widget._covers[widget.index];
      widget.f();
    });
  }
}
