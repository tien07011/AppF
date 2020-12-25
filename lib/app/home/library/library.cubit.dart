import 'package:app_tv/model/library/history.dart';
import 'package:app_tv/repositories/library/library.repositories.dart';
import 'package:app_tv/services/library/library.service.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'library.state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryRepository _libraryRepository;

  LibraryCubit(this._libraryRepository) : super(LibraryInitial()) {
    loadData();
  }

  ListHistory listHistory = ListHistory(result: []);
  int borrow = 0;
  int paid = 0;
  int tak = 10;
  void pull() {
    tak += 10;
    loadData(take: tak);
  }

  void reset() {
    tak = 10;
  }
  Future<void> loadData({int take = 10}) async {
    Map<String, dynamic> params = {"skip": 0, "take": take};
    try {
      emit(LibraryLoading());
      final response = await LibraryService.getHistory(params);
      if (response.statusCode == 200) {
        listHistory = ListHistory.fromJson(response.data as Map<String, dynamic>);
        emit(ItemsLibraryLoaded(listHistory));
      }
    } on NetworkException {
      emit(LibraryError("Couldn't fetch data. Is the device online?"));
    }
    loadThongKe();
  }

  Future<void> loadThongKe() async {
    Map<String, dynamic> params = {
      "dayLeft": 30,
    };
    try {
      emit(ThongKeLoading());
      final response = await LibraryService.getThongKe(params);
      if (response.statusCode == 200) {
        borrow = int.parse(response.data['result']["borrow"].toString());
        paid = int.parse(response.data['result']["paid"].toString());
        emit(ThongKeLoaded(borrow, paid));
      }
    } on NetworkException {
      emit(LibraryError("Couldn't fetch data. Is the device online?"));
    }
  }
}
