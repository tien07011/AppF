
import 'package:app_tv/model/library/list_book.dart';
import 'package:app_tv/repositories/library/library.repositories.dart';
import 'package:app_tv/services/library/library.service.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'list-book.state.dart';

class ListBookCubit extends Cubit<ListBookState> {
  final LibraryRepository _libraryRepository;
  ListBookCubit(this._libraryRepository) : super(ListBookInitial()) {
    loadData();
    getBookCount();
  }

  List<Book> listBook = [];
  List<Book> listBookView = [];
  int bookCount = 0;
  int tak = 10;
  String search = "";

  Future<void> getBookCount() async {
    Map<String, dynamic> params = {};
    try {
      emit(BookCountLoading());
      final response = await LibraryService.getBookCount(params);
      if (response.statusCode == 200) {
        print(response);
        bookCount = int.parse(response.data['result']['count'].toString());
        emit(BookCountLoaded(bookCount));
      }
    } on NetworkException {
      emit(ListBookError("Couldn't fetch data. Is the device online?"));
    }
  }

  void pull() {
    tak += 10;
    loadData(search: search,take: tak);
  }

  void reset() {
    tak = 10;
  }


  Future<void> loadData({String search = "",int take = 10}) async {
    this.search = search;
    Map<String, dynamic> params = {
      "skip" : 0,
      "take" : take,
      "search" : search
    };
    try {
      emit(ListBookLoading());
      ListBook _listBook = await _libraryRepository.fetchListBook(params);
      listBook = _listBook.result;
      emit(ItemsListBookLoaded(listBook));
    } on NetworkException {
      emit(ListBookError("Couldn't fetch data. Is the device online?"));
    }
  }

  Future<bool> newBook(String name,int price,String id,int amount) async {
    Map<String, dynamic> params = {
      "book" : {
        "name" : name,
        "price" : price,
        "idBook" : id,
        "amount" : amount
      }
    };
    try {
      emit(ListBookLoading());
      if (await _libraryRepository.createBook(params)) {
        loadData();
        return true;
        emit((ItemsListBookUploaded()));
      } else {
        emit(ListBookError("Submit failed"));
        return false;
      }
    } on NetworkException {
      emit(ListBookError("Error submitting data"));
      return false;
    }
  }

  Future<bool> deleteBook(String id) async {
    Map<String, dynamic> params = {
      "idBook" : id
    };
    try {
      emit(ListBookLoading());
      if (await _libraryRepository.deleteBook(params)) {
        emit((ItemsListBookUploaded()));
        loadData();
        return true;
      } else {
        emit(ListBookError("Submit failed"));
        return false;

      }
    } on NetworkException {
      emit(ListBookError("Error submitting data"));
      return false;

    }
  }

  @override
  void onChange(Change<ListBookState> change) {
    super.onChange(change);
    print(change.nextState);
  }
}