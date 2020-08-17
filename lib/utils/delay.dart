import 'dart:async';

class Delay {
  static void runPeriodicDelay(int delay, Function f){
    Timer.periodic(Duration(seconds: delay), (timer) {
      f();
    });
  }

  static void runOnceAfterDelay(int delay, Function f){
    Timer(Duration(seconds: delay), () {
      f();
    });
  }
}