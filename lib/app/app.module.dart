// app_module.dart
import 'package:app_tv/app/home/home.module.dart';
import 'package:app_tv/app/home/search/search.module.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_tv/app/app.view.dart';

import 'landing/landing.view.dart';
import 'login/login.view.dart';

class AppModule extends MainModule {
  static Inject get to => Inject<AppModule>.of();
  static String home = "/home";
  static String login = "/login";

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter(home, module: HomeModule(), transition: TransitionType.rightToLeftWithFade),
        ModularRouter(login, child: (context, args) => LoginWidget(), transition: TransitionType.downToUp),
        ModularRouter('/', child: (context, args) => Landing(), transition: TransitionType.scale),
      ];

  // Provide the root widget associated with your module
  // In this case, it's the widget you created in the first step
  @override
  Widget get bootstrap => AppWidget();
}
