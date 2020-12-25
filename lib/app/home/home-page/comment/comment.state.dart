part of "comment.cubit.dart";


@immutable
abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  const CommentInitial();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {
  const CommentLoading();

  @override
  List<Object> get props => [];
}

class PostLoading extends CommentState {
  const PostLoading();

  @override
  List<Object> get props => [];
}

class CommentUploading extends CommentState {
  const CommentUploading();

  @override
  List<Object> get props => [];
}

class ItemsCommentLoaded extends CommentState {
  final Comment comment;

  ItemsCommentLoaded(this.comment);

  @override
  List<Object> get props => [comment];
}

class ItemsPostLoaded extends CommentState {
  final Post post;

  ItemsPostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

class ItemsCommentUploading extends CommentState {
  const ItemsCommentUploading();

  @override
  List<Object> get props => [];
}

class ItemsCommentUploaded extends CommentState {
  const ItemsCommentUploaded();

  @override
  List<Object> get props => [];
}

class CommentError extends CommentState {
  final String message;

  const CommentError(this.message);

  @override
  List<Object> get props => [message];
}
