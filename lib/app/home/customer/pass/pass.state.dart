part of "pass.cubit.dart";

@immutable
abstract class PassState extends Equatable {
  const PassState();
}

class PassInitial extends PassState {
  const PassInitial();

  @override
  List<Object> get props => [];
}

class PassLoading extends PassState {
  const PassLoading();

  @override
  List<Object> get props => [];
}

class PassUploading extends PassState {
  const PassUploading();

  @override
  List<Object> get props => [];
}

class ItemsPassLoaded extends PassState {
  final int Pass;

  ItemsPassLoaded(this.Pass);

  @override
  List<Object> get props => [Pass];
}
class ThongKeLoading extends PassState {
  const ThongKeLoading();

  @override
  List<Object> get props => [];
}

class PassLoaded extends PassState {
  final List<int> listPost;
  PassLoaded(this.listPost);

  @override
  List<Object> get props => [listPost];
}

class ItemsPassUploading extends PassState {
  const ItemsPassUploading();

  @override
  List<Object> get props => [];
}

class ItemsPassUploaded extends PassState {
  const ItemsPassUploaded();

  @override
  List<Object> get props => [];
}

class PassError extends PassState {
  final String message;

  const PassError(this.message);

  @override
  List<Object> get props => [message];
}
