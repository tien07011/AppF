import 'package:app_tv/model/comment/comment.dart';
import 'package:app_tv/model/post/post.dart';
import 'package:app_tv/repositories/post/post.repository.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comment.state.dart';

class CommentCubit extends Cubit<CommentState> {
  final PostRepository _postRepository;

  CommentCubit(this._postRepository) : super(CommentInitial()) {}

  Comment comment;

  Post post;

  Future<void> loadComment(int _id) async {
    Map<String, dynamic> params = {"idPost": _id};
    try {
      emit(CommentLoading());
      Comment _comment = await _postRepository.fetchComment(params);
      comment = _comment;
      emit(ItemsCommentLoaded(_comment));
    } on NetworkException {
      emit(CommentError("Couldn't fetch data. Is the device online?"));
    }
  }

  Future<void> loadData(int _id) async {
    Map<String, dynamic> params = {"idPost": _id};
    try {
      emit(PostLoading());
      Post _post = await _postRepository.fetchPostById(params);
      post = _post;
      await loadComment(_id);
      emit(ItemsPostLoaded(_post));
    } on NetworkException {
      emit(CommentError("Couldn't fetch data. Is the device online?"));
    }
  }

  Future<void> deleteComment(int id, int _idPost) async {
    Map<String, dynamic> params = {"idComment": id};
    try {
      emit(CommentLoading());
      if (await _postRepository.deleteComment(params)) {
        emit((ItemsCommentUploaded()));
        await loadComment(_idPost);
      } else {
        emit(CommentError("Submit failed"));
      }
    } on NetworkException {
      emit(CommentError("Error submitting data"));
    }
  }

  @override
  void onChange(Change<CommentState> change) {
    super.onChange(change);
    print(change.nextState);
  }
}
