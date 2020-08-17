import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsScreen extends StatelessWidget {
  static String route = "/settings_screen";

  @override
  Widget build(BuildContext context) {

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
                       Align(alignment: Alignment.bottomCenter,
                         child: Padding(
                           padding: const EdgeInsets.only( bottom: 16.0),
                           child: Image.asset('assets/elements/play_btn.png', height: MediaQuery.of(context).size.width/10*1, width: MediaQuery.of(context).size.width/10*1.5,),
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
}

