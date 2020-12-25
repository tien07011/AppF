import 'package:app_tv/model/library/list_book.dart';
import 'package:app_tv/model/member/list_member.dart';
import 'package:app_tv/services/library/library.service.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LibraryRepository {
  Future<ListBook> fetchListBook(Map<String, dynamic> params) async {
    final response = await LibraryService.getListBook(params);
    return (response.statusCode == 200)
        ? ListBook.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException;
  }
  Future<ListMember> fetchListMember(Map<String, dynamic> params) async {
    final response = await LibraryService.getListMember(params);
    return (response.statusCode == 200)
        ? ListMember.fromJson(response.data as Map<String, dynamic>)
        : throw NetworkException;
  }
  Future<bool> createBook(Map<String, dynamic> params) async {
    final response = await LibraryService.createBook(params);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.statusCode == 200 && response.data["message"] == "Thành công" ) ? true : throw NetworkException;
  }
  Future<Book> fetchBookInfo(Map<String, dynamic> params,int id) async {
    final response = await LibraryService.getBookInfo(params,id);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.statusCode == 200)
        ? Book.fromJson(response.data['result'] as Map<String, dynamic>)
        : throw NetworkException;
  }

  Future<bool> editBookInfo(Map<String, dynamic> params) async {
    final response = await LibraryService.editBookInfo(params);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.statusCode == 200 && response.data["message"] == "Thành công" ) ? true : throw NetworkException;
  }
  Future<bool> deleteBook(Map<String, dynamic> params) async {
    final response = await LibraryService.deleteBook(params);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.statusCode == 200 && response.data["message"] == "Thành công" ) ? true : throw NetworkException;
  }

  Future<bool> createUser(Map<String, dynamic> params) async {
    final response = await LibraryService.createUser(params);
    print(response);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.statusCode == 200 && response.data["message"] == "Thành công" ) ? true : throw NetworkException;
  }
  Future<bool> blockUser(Map<String, dynamic> params) async {
    final response = await LibraryService.blockUser(params);
    print(response);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.statusCode == 200 && response.data["message"] == "Thành công" ) ? true : throw NetworkException;
  }
  Future<bool> deleteUser(Map<String, dynamic> params) async {
    final response = await LibraryService.deleteUser(params);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.statusCode == 200 && response.data["message"] == "Thành công" ) ? true : throw NetworkException;
  }
}