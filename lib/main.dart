import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
    OneSignal.shared.init(
        "b2f7f966-d8cc-11e4-bed1-df8f05be55ba",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

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
