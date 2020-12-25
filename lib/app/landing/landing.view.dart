import 'dart:async';

import 'package:app_tv/app/app.module.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    startTime();
    print(Application.sharePreference.getKeys());
  }

  Future<Timer> startTime() async =>
      Timer(Duration(seconds: 3), navigationPage);

  void navigationPage() => Application.sharePreference.hasKey('token')
      ? Modular.to.pushReplacementNamed(AppModule.home)
      : Modular.to.pushReplacementNamed(AppModule.login);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _buildVerticalLayout();
  }

  Widget _buildVerticalLayout() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * 100,
            child: Image.asset(
              'assets/login.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: <Widget>[
              Spacer(),
              Image.asset('assets/logo_tv.png',
                  height: SizeConfig.safeBlockVertical * 30),
              Text(
                'Thư viện Hội sinh viên - UET',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff000000),
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 10),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
