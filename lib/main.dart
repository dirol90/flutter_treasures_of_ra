import 'package:flutter/material.dart';
import 'package:treasuresofra/ui/game_screen.dart';
import 'package:treasuresofra/ui/levels_screen.dart';
import 'package:treasuresofra/ui/main_screen.dart';
import 'package:treasuresofra/ui/pre_game_screen.dart';
import 'package:treasuresofra/ui/settings_screen.dart';
import 'package:treasuresofra/ui/splash_screen.dart';
import 'package:treasuresofra/ui/web_view_screen.dart';

import 'ui/level_complet_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treasures of Ra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        SplashScreen.route: (context) => SplashScreen(),
        MainScreen.route: (context) => MainScreen(),
        LevelScreen.route: (context) => LevelScreen(),
        SettingsScreen.route: (context) => SettingsScreen(),
        PreGameScreen.route: (context) => PreGameScreen(),
        GameScreen.route: (context) => GameScreen(),
        WebViewScreen.route: (context) => WebViewScreen(),
        LevelCompletedScreen.route: (context) => LevelCompletedScreen(),
      },
      initialRoute: SplashScreen.route,
    );
  }
}
