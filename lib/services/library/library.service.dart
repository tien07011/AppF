import 'package:app_tv/routers/application.dart';

class LibraryService {
  static Future<dynamic> getListBook(Map<String, dynamic> params) {
    return Application.api.get('/book/skip=${params['skip']}&take=${params['take']}?search=${params['search']}');
  }

  static Future<dynamic> getListMember(Map<String, dynamic> params) {
    return Application.api.get('/user/skip=${params['skip']}&take=${params['take']}?search=${params['search']}');
  }

  static Future<dynamic> getBookCount(Map<String, dynamic> params) {
    return Application.api.get('/book/count');
  }

  static Future<dynamic> createBook(Map<String, dynamic> params) {
    return Application.api.post('/book/create', params);
  }

  static Future<dynamic> getBookInfo(Map<String, dynamic> params, int id) {
    return Application.api.get('/book/$id', params);
  }

  static Future<dynamic> editBookInfo(Map<String, dynamic> params) {
    return Application.api.put('/book/', params);
  }

  static Future<dynamic> getRole(Map<String, dynamic> params) {
    return Application.api.get('/user/role');
  }

  static Future<dynamic> getDepartment(Map<String, dynamic> params) {
    return Application.api.get('/user/department');
  }

  static Future<dynamic> getHistory(Map<String, dynamic> params) {
    return Application.api.get('/book/bookOrder/history/take=${params['take']}&skip=${params['skip']}');
  }

  static Future<dynamic> getThongKe(Map<String, dynamic> params) {
    return Application.api.get('/book/bookOrder/historyCount/dayLeft=${params["dayLeft"]}');
  }

  static Future<dynamic> deleteBook(Map<String, dynamic> params) {
    return Application.api.delete('/book/RemoveById/idBook=${params['idBook']}');
  }

  static Future<dynamic> createUser(Map<String, dynamic> params) {
    return Application.api.post('/user/create', params);
  }

  static Future<dynamic> blockUser(Map<String, dynamic> params) {
    return Application.api.put('/user/block', params);
  }
  static Future<dynamic> deleteUser(Map<String, dynamic> params) {
    return Application.api.delete('/user/${params['id']}');
  }

  static Future<dynamic> updateUser(Map<String, dynamic> params) {
    return Application.api.put('/user/updateRole', params);
  }
}
