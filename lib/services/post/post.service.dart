import 'package:app_tv/routers/application.dart';

class PostService {
  static Future<dynamic> getListPost(Map<String, dynamic> params) {
    return Application.api.get('/poster/skip=${params['skip']}&&take=${params['take']}');
  }
  static Future<dynamic> getComment(Map<String, dynamic> params) {
    return Application.api.get('/poster/comment/${params['idPost']}');
  }
  static Future<dynamic> getPostById(Map<String, dynamic> params) {
    return Application.api.get('/poster/${params['idPost']}');
  }
  static Future<dynamic> deletePost(Map<String, dynamic> params) {
    return Application.api.delete('/poster/${params['idPost']}');
  }
  static Future<dynamic> deleteComment(Map<String, dynamic> params) {
    return Application.api.delete('/poster/comment/${params['idComment']}');
  }
}