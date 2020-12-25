import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ListNotification {
  List<Notifications> notifications;

  ListNotification({this.notifications});

  factory ListNotification.fromJson(Map<String, dynamic> json) => _$ListNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ListNotificationToJson(this);
}

@JsonSerializable(nullable: true, explicitToJson: true)
class Notifications {
  int notification_id;
  String notification_context;
  DateTime notification_creat_at;
  int notification_posterId;
  int notification_userCreateId;
  String userCreate_name;
  String userCreate_avatar;
  int isSeen;

  Notifications(
      {this.notification_id,
      this.notification_context,
      this.notification_creat_at,
      this.notification_posterId,
      this.notification_userCreateId,
      this.userCreate_name,
      this.userCreate_avatar,
      this.isSeen});

  factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}
