import 'package:app_tv/model/post/post.dart';
import 'package:app_tv/services/infor/infor.service.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'infor.state.dart';

class InforCubit extends Cubit<InforState> {
  InforCubit() : super(InforInitial()) {
    loadPost();
  }
  List<Post> listPost = [];
  Future<void> loadPost() async {
    Map<String, dynamic> params = {
      'skip' : 0,
      'take' : 10,
    };
    try {
      emit(InforLoading());
      final response = await InforService.getPost(params);
      if (response.statusCode == 200) {
        ListPost _listPost = ListPost.fromJson(response.data as Map<String, dynamic>);
        listPost = _listPost.result.isNotEmpty ? _listPost.result : [];
        emit(InforLoaded(listPost));
      }
    } on NetworkException {
      emit(InforError("Couldn't fetch data. Is the device online?"));
    }
  }

}