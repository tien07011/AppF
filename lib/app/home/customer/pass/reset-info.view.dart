import 'dart:typed_data';

import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/home/customer/pass/pass.cubit.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/repositories/infor/infor.repositories.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/api.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http_parser/src/media_type.dart';

class ResetInfoView extends StatefulWidget {
  @override
  _ResetInfoViewState createState() => _ResetInfoViewState();
}

class _ResetInfoViewState extends State<ResetInfoView> {
  UserInfor _userInfo = Application.sharePreference.getUserInfor();
  List<String> listGender = ["Nam", 'Nữ'];
  String pass = "";
  PassCubit cubit = PassCubit(InforRepositories());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: staticAppbar(title: "Chỉnh sửa thông tin"),
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            (asset == null)
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        loadAssets();
                      },
                      child: CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 18,
                        backgroundImage: NetworkImage('${_userInfo.avatar}'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      loadAssets();
                    },
                    child: ClipOval(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: AssetThumb(asset: asset, width: 120, height: 120),
                      ),
                    ),
                  ),
            FormBuilderTextField(
              attribute: 'sac',
              decoration: InputDecoration(labelText: "Họ tên : "),
              readOnly: true,
              initialValue: "${_userInfo?.name ?? ""}",
              validators: [
                FormBuilderValidators.required(),
              ],
              // onChanged: (value) {
              //   _userInfo.name = value.toString();
              // },
            ),
            SizedBox(height: 10,),
            FormBuilderDateTimePicker(
              attribute: 'expiry_date',
              inputType: InputType.date,
              initialValue: (_userInfo.born == null) ? null : DateTime.parse(_userInfo.born),
              initialDate: DateTime.now(),
              decoration: InputDecoration(labelText: "Ngày sinh", suffixIcon: Icon(Icons.calendar_today)),
              format: DateFormat("dd-MM-yyyy"),
              onChanged: (value) {
                _userInfo.born = value.toString();
              },
            ),
            FormBuilderDropdown(
              attribute: "gender",
              decoration: InputDecoration(labelText: "Giới Tính"),
              initialValue: (_userInfo.gender) ? listGender[0] : listGender[1],
              validators: [FormBuilderValidators.required()],
              items: listGender.map((item) => DropdownMenuItem(value: item, child: Text("$item"))).toList(),
              onChanged: (value) {
                if (value.toString() == "Nam") {
                  _userInfo.gender = true;
                } else {
                  _userInfo.gender = false;
                }
              },
            ),
            FormBuilderTextField(
              attribute: 'email',
              decoration: InputDecoration(labelText: "Email : "),
              initialValue: "${_userInfo.email ?? ""}",
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                _userInfo.email = value.toString();
              },
            ),
            FormBuilderTextField(
              attribute: 'sdt',
              decoration: InputDecoration(labelText: "SĐT : "),
              initialValue: "${_userInfo.phoneNumber ?? ""}",
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                _userInfo.phoneNumber = value.toString();
              },
            ),
            // FormBuilderTextField(
            //   attribute: 'mk',
            //   decoration: InputDecoration(labelText: "Mật khẩu: "),
            //   validators: [
            //     FormBuilderValidators.required(),
            //   ],
            //   onChanged: (value) {
            //     pass = value.toString();
            //   },
            // ),
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
                          if (asset == null) {
                            showDialog(context: context,builder: (context) {
                              return CupertinoActivityIndicator(
                                radius: 30,
                                animating: true,
                              );
                            },);
                            if (await cubit.userUpdate(_userInfo.name, _userInfo.born, pass, _userInfo.email,
                                _userInfo.phoneNumber, _userInfo.gender)) {
                              Modular.navigator.pop();
                              Modular.navigator.pop();
                            }
                          } else {
                            showDialog(context: context,builder: (context) {
                              return CupertinoActivityIndicator(
                                radius: 30,
                                animating: true,
                              );
                            },);
                            print("hehe");
                            if (await uploadInfo()) {
                              Modular.navigator.pop();
                              Modular.navigator.pop();
                            } else  {
                              Modular.navigator.pop();
                            }
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
        ));
  }

  List<Asset> images = <Asset>[];
  MultipartFile multipartFile;
  Asset asset;

  Future<void> loadAssets() async {
    images.clear();
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
            actionBarColor: "#ff068189",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
            statusBarColor: "#ff068189"),
      );
    } on Exception catch (e) {
      print(e);
    }
    setState(() {
      if (!mounted) return;
      if (resultList.isNotEmpty) {
        setState(() {
          asset = resultList[0];
        });
        setFile(asset);
      }
    });
  }

  Future<void> setFile(Asset asset) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    multipartFile = MultipartFile.fromBytes(
      imageData,
      filename: 'status.png',
      contentType: MediaType("image", "png"),
    );
  }

  Future<bool> uploadInfo() async {
    FormData formData = FormData.fromMap(<String, dynamic>{
      'born' : _userInfo.born,
      'email' : _userInfo.email,
      'phoneNumber' : _userInfo.phoneNumber,
      'gender' : _userInfo.gender,
      'name' : _userInfo.name,
      'avatar' : multipartFile,
    });
    var response = await Application.api.dio.put("${API.baseUrl}/user/update", data: formData);
    if (response.statusCode == 200 && response.data["message"] == "Thành công") {
      if (response.data['result']['gender'].toString() == "true") {
        response.data['result']['gender'] = true;
      } else {
        response.data['result']['gender'] = false;
      }
      Application.sharePreference
        ..putObject('userInfor', response.data['result'] as Map<String, dynamic>);
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    }
    return false;
  }
}
