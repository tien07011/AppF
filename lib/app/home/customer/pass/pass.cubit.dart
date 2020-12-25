import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/repositories/infor/infor.repositories.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/services/infor/infor.service.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'pass.state.dart';

class PassCubit extends Cubit<PassState> {
  final InforRepositories _inforRepositories;
  UserInfor _userInfo = Application.sharePreference.getUserInfor();

  PassCubit(this._inforRepositories) : super(PassInitial()) {
    loadUserInfo();
  }



  Future<bool> resetPass(String oldPass,String newPass) async {
    Map<String, dynamic> params = {
      'account' : {
        'password' : oldPass,
        'newPassword' : newPass
      }
    };
    try {
      emit(PassUploading());
      if (await _inforRepositories.resetPass(params)) {
        emit((ItemsPassUploaded()));
        return true;
      } else {
        emit(PassError("Submit failed"));
        return false;

      }
    } on NetworkException {
      emit(PassError("Error submitting data"));
      return false;
    }
  }

  Future<bool> userUpdate(String name,String born,String password,String email,String phoneNumber,bool gender,) async {
    Map<String, dynamic> params = {
      'born' : born,
      'email' : email,
      'phoneNumber' : phoneNumber,
      'gender' : gender,
      'name' : name
    };
    try {
      emit(PassUploading());
      if (await _inforRepositories.userUpdate(params)) {
        emit((ItemsPassUploaded()));
        return true;
      } else {
        emit(PassError("Submit failed"));
        return false;
      }
    } on NetworkException {
      emit(PassError("Error submitting data"));
      return false;
    }
  }

  Future<void> loadUserInfo() async {
    Map<String, dynamic> params = {
      'id' : _userInfo.id
    };
    try {
      emit(PassLoading());
      final response = await InforService.getUserInfo(params);
      print(response);
      if (response.statusCode == 200) {}
    } on NetworkException {
      emit(PassError("Couldn't fetch data. Is the device online?"));
    }
  }
}