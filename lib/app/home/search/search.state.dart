part of "search.cubit.dart";


@immutable
abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  const SearchLoading();

  @override
  List<Object> get props => [];
}

class SearchUploading extends SearchState {
  const SearchUploading();

  @override
  List<Object> get props => [];
}

class ItemsSearchLoaded extends SearchState {
  final BookOrder bookOrder;

  ItemsSearchLoaded(this.bookOrder);

  @override
  List<Object> get props => [bookOrder];
}
class ItemsBookOrderInfo extends SearchState {
  final BookOrderInfo bookOrder;

  ItemsBookOrderInfo(this.bookOrder);

  @override
  List<Object> get props => [bookOrder];
}
class ItemsBookDetailLoaded extends SearchState {
  final dynamic bookOrder;

  ItemsBookDetailLoaded(this.bookOrder);

  @override
  List<Object> get props => [bookOrder];
}

class ItemsSearchUploading extends SearchState {
  const ItemsSearchUploading();

  @override
  List<Object> get props => [];
}

class ItemsSearchUploaded extends SearchState {
  const ItemsSearchUploaded();

  @override
  List<Object> get props => [];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
