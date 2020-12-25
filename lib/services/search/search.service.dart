import 'package:app_tv/routers/application.dart';

class SearchService {
  static Future<dynamic> getBookOrder(Map<String, dynamic> params) {
    return Application.api.get('/student/search/book/${params['id']}');
  }

  static Future<dynamic> newBookOrder(Map<String, dynamic> params) {
    return Application.api.post('/book/bookOrder/create', params);
  }

  static Future<dynamic> getBookDetail(Map<String, dynamic> params) {
    return Application.api.get('/book/bookDetail/${params['id']}');
  }

  static Future<dynamic> getBookOrderInfo(Map<String, dynamic> params) {
    return Application.api.get('/book/bookOrder/${params['id']}');
  }

  static Future<dynamic> createBookPay(Map<String, dynamic> params) {
    return Application.api.post('/book/bookOrder/pay/', params);
  }
}
