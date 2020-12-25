import 'package:app_tv/routers/application.dart';
import 'package:app_tv/services/authentication.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCubit extends Cubit<bool> {
  /// {@macro cubit}
  LoginCubit() : super(true);

  String _userName = "", _password = "";
  String _message;
  String email;

  void set userName(String _userName) => this._userName = _userName;

  void set password(String _password) => this._password = _password;

  String get message => _message;

  bool get hasAnyEmptyAttribute => _userName == "" || _password == "";

  Future<bool> login() async {
    emit(false);
    Map<String, dynamic> params = {
      "account": {"username": _userName, "password": _password}
    };
    final response = await AuthenticationService.login(params);
//    print(response);
    if (response.statusCode == 200) {
      var mapResponse = response.data;
      if (mapResponse["status"] == 200) {
        print(mapResponse['token']);
        Application.sharePreference
          ..putObject('userInfor', mapResponse['account'] as Map<String, dynamic>)
          ..putString('token', mapResponse['token'].toString());
      }
    }
    _message = (response.data['message']) != null ? "${response.data['message']}" : '';
    emit(true);
    return response.data['status'] == 200;
  }

  Future<bool> forgotPass() async {
    emit(false);
    Map<String, dynamic> params = {
      "email": email
    };
    final response = await AuthenticationService.forgotPass(params);
    print(response);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg:  "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    emit(true);
    return response.data['status'] == 200;
  }
}
