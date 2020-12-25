import 'package:app_tv/model/post/post.dart';
import 'package:app_tv/repositories/post/post.repository.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post.state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository;
  PostCubit(this._postRepository) : super(PostInitial()) {
    loadData();
  }

  List<Post> listPost = [];
  int tak = 10;
  void pull() {
    tak += 10;
    loadData(take: tak);
  }

  void reset() {
    tak = 10;
  }

  Future<void> loadData({int take = 10}) async {
    Map<String, dynamic> params = {
      "skip" : 0,
      "take" : take
    };
    try {
      emit(PostLoading());
      ListPost _listPost = await _postRepository.fetchListPost(params);
      listPost = _listPost.result.isNotEmpty ? _listPost.result : [];
      emit(ItemsPostLoaded(listPost));
    } on NetworkException {
      emit(PostError("Couldn't fetch data. Is the device online?"));
    }
  }

  Future<void> deletePost(String id) async {
    Map<String, dynamic> params = {
      "idPost" : id
    };
    try {
      emit(PostLoading());
      if (await _postRepository.deletePost(params)) {
        emit((ItemsPostUploaded()));
      } else {
        emit(PostError("Submit failed"));
      }
    } on NetworkException {
      emit(PostError("Error submitting data"));
    }
    loadData();
  }

  @override
  void onChange(Change<PostState> change) {
    super.onChange(change);
    print(change.nextState);
  }
}