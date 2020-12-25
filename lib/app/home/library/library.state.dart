part of "library.cubit.dart";


@immutable
abstract class LibraryState extends Equatable {
  const LibraryState();
}

class LibraryInitial extends LibraryState {
  const LibraryInitial();

  @override
  List<Object> get props => [];
}

class LibraryLoading extends LibraryState {
  const LibraryLoading();

  @override
  List<Object> get props => [];
}

class LibraryUploading extends LibraryState {
  const LibraryUploading();

  @override
  List<Object> get props => [];
}

class ItemsLibraryLoaded extends LibraryState {
  final ListHistory library;

  ItemsLibraryLoaded(this.library);

  @override
  List<Object> get props => [library];
}
class ThongKeLoading extends LibraryState {
  const ThongKeLoading();

  @override
  List<Object> get props => [];
}

class ThongKeLoaded extends LibraryState {
  final int borrow;
  final int paid;
  ThongKeLoaded(this.borrow, this.paid);

  @override
  List<Object> get props => [borrow,paid];
}

class ItemsLibraryUploading extends LibraryState {
  const ItemsLibraryUploading();

  @override
  List<Object> get props => [];
}

class ItemsLibraryUploaded extends LibraryState {
  const ItemsLibraryUploaded();

  @override
  List<Object> get props => [];
}

class LibraryError extends LibraryState {
  final String message;

  const LibraryError(this.message);

  @override
  List<Object> get props => [message];
}
