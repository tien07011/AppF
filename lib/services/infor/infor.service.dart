import 'package:app_tv/routers/application.dart';

class InforService {
  static Future<dynamic> getPost(Map<String, dynamic> params) {
    return Application.api.get('/poster/profile?take=${params['take']}&skip=${params['skip']}');
  }
  static Future<dynamic> resetPass(Map<String, dynamic> params) {
    return Application.api.put('/admin/changePassword',params);
  }
  static Future<dynamic> userUpdate(Map<String, dynamic> params) {
    return Application.api.put('/user/update',params);
  }
  static Future<dynamic> getUserInfo(Map<String, dynamic> params) {
    return Application.api.get('/user/${params['id']}',params);
  }
}