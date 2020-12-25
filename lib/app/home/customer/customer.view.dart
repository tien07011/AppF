import 'package:app_tv/app/app.module.dart';
import 'package:app_tv/app/components/date/date.component.dart';
import 'package:app_tv/app/home/customer/information/infor.view.dart';
import 'package:app_tv/app/home/home.module.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  UserInfor _userInfo = Application.sharePreference.getUserInfor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   height: SizeConfig.blockSizeVertical * 100,
          //   child: Image.asset(
          //     'assets/login.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  FlatButton(
                    onPressed: () {
                      Modular.link.pushNamed(HomeModule.inforView);
                    },
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: SizeConfig.blockSizeHorizontal * 10,
                              backgroundImage: NetworkImage('${_userInfo?.avatar ?? ""}'),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: SizeConfig.blockSizeHorizontal * 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${_userInfo?.name ?? ""}",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.teal)),
                                Text("Xem trang cá nhân của bạn")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Modular.link.pushNamed(HomeModule.resetInfo).then((value) {
                                setState(() {_userInfo = Application.sharePreference.getUserInfor();});
                              });
                            },
                            child: _info(
                                "Thay đổi thông tin cá nhân",
                                Icon(
                                  Icons.edit,
                                  color: Colors.deepOrange,
                                  size: 50,
                                ))),
                        SizedBox(height: 5.0),
                        FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Modular.link.pushNamed(HomeModule.passView);
                            },
                            child: _info(
                                "Đổi Mật Khẩu",
                                Icon(
                                  Icons.vpn_key_rounded,
                                  color: Colors.yellow[700],
                                  size: 50,
                                ))),
                        SizedBox(height: 5.0),
                        FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Application.sharePreference.clear().whenComplete(() => Modular.to.pushNamedAndRemoveUntil("/login", ModalRoute.withName(Modular.initialRoute)));
                            },
                            child: _info(
                                "Đăng Xuất",
                                Icon(
                                  Icons.logout,
                                  color: Colors.teal,
                                  size: 50,
                                ))),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String text, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        // shape: RoundedRectangleBorder(
        //   side: BorderSide(color: Colors.grey, width: 0.5),
        //   borderRadius: BorderRadius.circular(5.0),
        // ),
        elevation: 3.0,
        margin: EdgeInsets.zero,
        color: Color(0xFFF1F1F1),
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          padding: EdgeInsets.symmetric(vertical: 15.0),
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              icon,
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              Text("$text", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
