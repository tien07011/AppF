import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_tv/app/app.module.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  Application.sharePreference = await SpUtil.getInstance();
  runApp(ModularApp(module: AppModule()));
}
