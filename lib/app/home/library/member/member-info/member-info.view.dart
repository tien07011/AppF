import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/components/date/date.component.dart';
import 'package:app_tv/app/home/library/member/member.cubit.dart';
import 'package:app_tv/model/member/list_member.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class MemberInfoView extends StatefulWidget {
  final Member member;
  final MemberCubit cubit;

  const MemberInfoView({this.member, this.cubit}) : super();

  @override
  _MemberInfoViewState createState() => _MemberInfoViewState();
}

class _MemberInfoViewState extends State<MemberInfoView> {
  UserInfor _userInfo = Application.sharePreference.getUserInfor();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: staticAppbar(action: [
          _userInfo.role.isCreateOrEditUser ? IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              if (_userInfo.role.isCreateOrEditUser) {
                showDialog(context: context, builder: (_) => _edit());
              } else {
                Fluttertoast.showToast(
                  msg: "Bạn không thể làm điều này !!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
          ) : SizedBox(),
        ], title: "Thông Tin Thành Viên"),
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: CircleAvatar(
              radius: SizeConfig.blockSizeHorizontal * 40,
              backgroundImage: NetworkImage('${widget.member.avatar}'),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 13),
              color: Color(0xFFF1F1F1),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 86,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                    Text("${widget.member?.name ?? ""}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _info(
                    "${widget.member.role?.name}",
                    Icon(
                      Icons.person_outline,
                      size: 25,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                  _info(
                      "${widget.member.GenCode}",
                      Icon(
                        Icons.support_agent_sharp,
                        size: 25,
                        color: Colors.redAccent,
                      )),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _info(
                    "${widget.member.department.name}",
                    Icon(
                      Icons.home,
                      size: 25,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                  _info(
                    (widget.member.gender) ? "Nam" : "Nữ",
                    Icon(
                      Icons.fiber_manual_record_rounded,
                      size: 25,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _info(
                    dateFormat("${widget.member?.born ?? ""}"),
                    Icon(
                      Icons.today_rounded,
                      size: 25,
                      color: Colors.pink,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                  _info(
                    "${widget.member.phoneNumber}",
                    Icon(
                      Icons.call,
                      size: 25,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 13),
              color: Color(0xFFF1F1F1),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 86,
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                    Icon(
                      Icons.email,
                      size: 25,
                      color: Colors.green,
                    ),
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                    Text("${widget.member?.email ?? ""}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int roleId;
  int departmentId;

  Widget _edit() {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilderDropdown(
              attribute: "vt",
              decoration: InputDecoration(labelText: "Vai trò"),
              validators: [FormBuilderValidators.required()],
              items: widget.cubit.roles
                  .map((item) => DropdownMenuItem(value: item, child: Text("${item['name']}")))
                  .toList(),
              onChanged: (value) {
                roleId = int.parse(value['id'].toString());
              },
            ),
            FormBuilderDropdown(
              attribute: "vt",
              decoration: InputDecoration(labelText: "Ban"),
              validators: [FormBuilderValidators.required()],
              items: widget.cubit.departments
                  .map((item) => DropdownMenuItem(value: item, child: Text("${item['name']}")))
                  .toList(),
              onChanged: (value) {
                departmentId = int.parse(value['id'].toString());
              },
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Modular.navigator.pop();
            },
            child: Text("Close", style: TextStyle(color: Colors.grey))),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 30),
        FlatButton(
            onPressed: () async {
              showDialog(context: context,builder: (context) {
                return CupertinoActivityIndicator(
                  radius: 30,
                  animating: true,
                );
              },);
              if (await widget.cubit.updateUser(user: widget.member.id, departmentId: departmentId, roleId: roleId)) {
                Modular.navigator.pop();
                Modular.navigator.pop();
                Modular.navigator.pop();
              }
            },
            child: Text("Save", style: TextStyle(color: Colors.teal)))
      ],
    );
  }

  Widget _info(String text, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        color: Color(0xFFF1F1F1),
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 42,
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              icon,
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              Text("$text", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
