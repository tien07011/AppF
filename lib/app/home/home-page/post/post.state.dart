part of "post.cubit.dart";


@immutable
abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  const PostLoading();

  @override
  List<Object> get props => [];
}

class PostUploading extends PostState {
  const PostUploading();

  @override
  List<Object> get props => [];
}

class ItemsPostLoaded extends PostState {
  final List<Post> listPost;

  ItemsPostLoaded(this.listPost);

  @override
  List<Object> get props => [listPost];
}

class ItemsPostUploading extends PostState {
  const ItemsPostUploading();

  @override
  List<Object> get props => [];
}

class ItemsPostUploaded extends PostState {
  const ItemsPostUploaded();

  @override
  List<Object> get props => [];
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}
