import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResetPassView extends StatefulWidget {
  _ResetPassView createState() => _ResetPassView();
}

class _ResetPassView extends State<ResetPassView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: staticAppbar(title: "Đổi Mật Khẩu"),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          _textFiled('Mật khẩu cũ'),
          _textFiled('Mật khẩu mới'),
          SizedBox(height: SizeConfig.blockSizeVertical * 10),
          Row(
            children: [
              SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
              Expanded(
                  child: FlatButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        Modular.navigator.pop();
                      },
                      child: Text(
                        "Hủy",
                        style: TextStyle(color: Colors.white),
                      ))),
              Spacer(),
              Expanded(
                  child: FlatButton(
                      color: Color(0xff068189),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        Modular.navigator.pop();
                      },
                      child: Text(
                        "Xác nhận",
                        style: TextStyle(color: Colors.white),
                      ))),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
            ],
          )
        ],
      ),
    );
  }

  Widget _textFiled(String _tile) {
    return FormBuilderTextField(
      attribute: 'sach',
      decoration: InputDecoration(labelText: "${_tile} : "),
      validators: [
        FormBuilderValidators.required(),
      ],
    );
  }
}
