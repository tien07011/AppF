import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/home/library/member/member.cubit.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';


class NewMemberView extends StatefulWidget {
  final MemberCubit cubit;

  const NewMemberView({this.cubit}) : super();
  @override
  _NewMemberViewState createState() => _NewMemberViewState();
}

class _NewMemberViewState extends State<NewMemberView> {

  String name ="";
  String date = "";
  bool gender = true;
  String gen = "";
  String user = "";
  String email = "";
  String sdt = "";
  int roleId = 0;
  int departmentId = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: staticAppbar(title: "Thêm thành viên "),
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            FormBuilderTextField(
              attribute: 'sach',
              decoration: InputDecoration(labelText: "Họ tên : "),
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                name = value.toString();
              },
            ),
            FormBuilderDateTimePicker(
              attribute: 'expiry_date',
              inputType: InputType.date,
              initialDate: DateTime.now(),
              decoration: InputDecoration(labelText: "Ngày sinh", suffixIcon: Icon(Icons.calendar_today)),
              format: DateFormat("dd-MM-yyyy"),
              onChanged: (value) {
                date = value.toString();
              },
            ),
            FormBuilderDropdown(
              attribute: "bank",
              decoration: InputDecoration(labelText: "Giới Tính"),
              validators: [FormBuilderValidators.required()],
              items: ['Nam', 'nữ'].map((item) => DropdownMenuItem(value: item, child: Text("$item"))).toList(),
              onChanged: (value) {
                if (value.toString() == "Nam") {
                  gender = true;
                } else {
                  gender = false;
                }
              },
            ),
            FormBuilderTextField(
              attribute: 'sach',
              decoration: InputDecoration(labelText: "Gen : "),
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                gen = value.toString();
              },
            ),
            FormBuilderTextField(
              attribute: 'email',
              decoration: InputDecoration(labelText: "Email : "),
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                email = value.toString();
              },
            ),
            FormBuilderTextField(
              attribute: 'sdt',
              decoration: InputDecoration(labelText: "SĐT : "),
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                sdt = value.toString();
              },
            ),
            FormBuilderTextField(
              attribute: 'sach',
              decoration: InputDecoration(labelText: "User name : "),
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                user = value.toString();
              },
            ),
            FormBuilderDropdown(
              attribute: "vt",
              decoration: InputDecoration(labelText: "Vai trò"),
              validators: [FormBuilderValidators.required()],
              items: widget.cubit.roles.map((item) => DropdownMenuItem(value: item, child: Text("${item['name']}"))).toList(),
              onChanged: (value) {
                roleId = int.parse(value['id'].toString());
              },
            ),
            FormBuilderDropdown(
              attribute: "vt",
              decoration: InputDecoration(labelText: "Ban"),
              validators: [FormBuilderValidators.required()],
              items: widget.cubit.departments.map((item) => DropdownMenuItem(value: item, child: Text("${item['name']}"))).toList(),
              onChanged: (value) {
                departmentId = int.parse(value['id'].toString());
              },
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 10),
            Row(
              children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
                Expanded(
                    child: FlatButton(
                        color: Colors.red,
                        onPressed: () {
                          Modular.navigator.pop();
                        },
                        child: Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
                        ))),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
                Expanded(
                    child: FlatButton(
                        color: Color(0xff068189),
                        onPressed: () async {
                          showDialog(context: context,builder: (context) {
                            return CupertinoActivityIndicator(
                              radius: 30,
                              animating: true,
                            );
                          },);
                          if (await widget.cubit.newUser(name, date, gender, gen, user, email,sdt, roleId, departmentId)) {
                            Modular.navigator.pop();
                            Modular.navigator.pop();
                          }
                        },
                        child: Text(
                          "Lưu",
                          style: TextStyle(color: Colors.white),
                        ))),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
              ],
            )
          ],
        ),
      ),
    );
  }
}
