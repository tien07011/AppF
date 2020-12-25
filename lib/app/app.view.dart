import 'package:app_tv/app/landing/landing.view.dart';
import 'package:app_tv/app/login/login.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/api.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    Application.api = API();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'App TV',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.white,
        accentColor: Colors.redAccent,
        fontFamily: "Quicksand",
      ),
      home: Landing(),
      navigatorKey: Modular.navigatorKey,
      // add Modular to manage the routing system
      onGenerateRoute: Modular.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
