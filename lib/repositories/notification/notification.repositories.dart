import 'package:app_tv/model/notification/notification.dart';
import 'package:app_tv/services/notification/notification.service.dart';
import 'package:app_tv/utils/exception.dart';

class NotificationRepositories {
  Future<ListNotification> fetchListMember(Map<String, dynamic> params) async {
    final response = await NotificationService.getListNotification(params);
    return (response.statusCode == 200)
        ? ListNotification.fromJson(response.data['result'] as Map<String, dynamic>)
        : throw NetworkException;
  }

  Future<bool> seenNotification(Map<String, dynamic> params) async {
    final response = await NotificationService.seenNotification(params);
//    print(response.statusCode);
    return (response.statusCode == 200) ? true : false;
  }
  Future<int> newNotificationCount() async {
    final response = await NotificationService.getNews();
    print(response.data);
    return (response.statusCode == 200) ? response.data['result']['count'] as int : 0;
  }
}
