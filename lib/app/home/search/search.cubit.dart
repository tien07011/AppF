import 'package:app_tv/model/book_order/book_order.dart';
import 'package:app_tv/model/book_order/book_order_info.dart';
import 'package:app_tv/repositories/search/search.repository.dart';
import 'package:app_tv/services/search/search.service.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'search.state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchInitial()) {}

  BookOrder bookOrder;

  Future<void> loadData(int id) async {
    Map<String, dynamic> params = {"id": id};
    try {
      emit(SearchLoading());
      var response = await _searchRepository.fetchBookOrder(params);
      if (response != null) {
        bookOrder = BookOrder.fromJson(response.data['result'] as Map<String, dynamic>);
        emit(ItemsSearchLoaded(bookOrder));
      } else {
        emit(SearchError("Không tìm thấy !!!"));
      }
    } on NetworkException {
      emit(SearchError("Không tìm thấy !!!"));
    }
  }

  Future<void> newBook(String idBook, String id, int time) async {
    Map<String, dynamic> params = {
      "bookOrder": {"idBookdetail": idBook, "idStudent": id, "time": time}
    };
    try {
      emit(SearchLoading());
      if (await _searchRepository.createBookOrder(params)) {
        emit((ItemsSearchUploaded()));
      } else {
        emit(SearchError("Submit failed"));
      }
    } on NetworkException {
      emit(SearchError("Error submitting data"));
    }
    loadData(int.parse(id));
  }

  dynamic bookDetail;

  Future<void> getBookDetail(String id) async {
    try {
      emit(SearchLoading());
      final response = await SearchService.getBookDetail({"id": id});
      print(response);
      if (response.statusCode == 200 && response.data['status'] != 404) {
        bookDetail = response.data['result'];
        emit(ItemsBookDetailLoaded(bookDetail));
        emit(ItemsSearchLoaded(bookOrder));
      } else {
        Fluttertoast.showToast(
          msg: "Không tìm thấy",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on NetworkException {
      emit(SearchError("Couldn't fetch data. Is the device online?"));
    }
  }

  BookOrderInfo bookOrderInfo;

  Future<void> getBookOrderInfo(int id) async {
    try {
      emit(SearchLoading());
      final response = await SearchService.getBookOrderInfo({"id": id});
      print(response);
      if (response.statusCode == 200) {
        bookOrderInfo = BookOrderInfo.fromJson(response.data['result'] as Map<String, dynamic>);
        emit(ItemsBookOrderInfo(bookOrderInfo));
        emit(ItemsSearchLoaded(bookOrder));
      }
    } on NetworkException {
      emit(SearchError("Couldn't fetch data. Is the device online?"));
    }
  }

  Future<void> createBookPay(int idBook, String date) async {
    Map<String, dynamic> params = {
      "bookOrder": {"id": idBook, "payDate": date}
    };
    try {
      emit(SearchLoading());
      if (await _searchRepository.createBookOrderPay(params)) {
        emit((ItemsSearchUploaded()));
      } else {
        emit(SearchError("Submit failed"));
      }
    } on NetworkException {
      emit(SearchError("Error submitting data"));
    }
    loadData(int.parse(bookOrder.studentInfo.idStudent));
  }

  @override
  void onChange(Change<SearchState> change) {
    super.onChange(change);
    print(change.nextState);
  }
}
