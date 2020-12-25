part of "infor.cubit.dart";

@immutable
abstract class InforState extends Equatable {
  const InforState();
}

class InforInitial extends InforState {
  const InforInitial();

  @override
  List<Object> get props => [];
}

class InforLoading extends InforState {
  const InforLoading();

  @override
  List<Object> get props => [];
}

class InforUploading extends InforState {
  const InforUploading();

  @override
  List<Object> get props => [];
}

class ItemsInforLoaded extends InforState {
  final int infor;

  ItemsInforLoaded(this.infor);

  @override
  List<Object> get props => [infor];
}
class ThongKeLoading extends InforState {
  const ThongKeLoading();

  @override
  List<Object> get props => [];
}

class InforLoaded extends InforState {
  final List<Post> listPost;
  InforLoaded(this.listPost);

  @override
  List<Object> get props => [listPost];
}

class ItemsInforUploading extends InforState {
  const ItemsInforUploading();

  @override
  List<Object> get props => [];
}

class ItemsInforUploaded extends InforState {
  const ItemsInforUploaded();

  @override
  List<Object> get props => [];
}

class InforError extends InforState {
  final String message;

  const InforError(this.message);

  @override
  List<Object> get props => [message];
}
