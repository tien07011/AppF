part of "book-info.cubit.dart";


@immutable
abstract class BookInfoState extends Equatable {
  const BookInfoState();
}

class BookInfoInitial extends BookInfoState {
  const BookInfoInitial();

  @override
  List<Object> get props => [];
}

class BookInfoLoading extends BookInfoState {
  const BookInfoLoading();

  @override
  List<Object> get props => [];
}

class BookInfoUploading extends BookInfoState {
  const BookInfoUploading();

  @override
  List<Object> get props => [];
}

class ChangeEdit extends BookInfoState {
  final bool edit;

  ChangeEdit(this.edit);

  @override
  List<Object> get props => [edit];
}

class ItemsBookInfoUploading extends BookInfoState {
  const ItemsBookInfoUploading();

  @override
  List<Object> get props => [];
}

class ItemsBookInfoUploaded extends BookInfoState {
  const ItemsBookInfoUploaded();

  @override
  List<Object> get props => [];
}

class BookInfoError extends BookInfoState {
  final String message;

  const BookInfoError(this.message);

  @override
  List<Object> get props => [message];
}
