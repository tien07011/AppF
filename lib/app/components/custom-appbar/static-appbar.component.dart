import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/material.dart';

AppBar staticAppbar({String title, PreferredSize bottomWidget, List<Widget> action, bool containBackButton = false}) =>
    AppBar(
      leading: BackButton(
        color: Colors.white,
      ),
      // title: Container(
      //   padding: EdgeInsets.symmetric(vertical: 8,horizontal: 13.0),
      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Color(0xff068189)),
      //     child: Text("$title")),
      title: Text("$title"),
      centerTitle: true,
      backgroundColor: Colors.teal,
      elevation: 0,
      bottom: bottomWidget,
      actions: action,
    );
