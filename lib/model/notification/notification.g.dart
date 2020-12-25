// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListNotification _$ListNotificationFromJson(Map<String, dynamic> json) {
  return ListNotification(
    notifications: (json['notifications'] as List)
        ?.map((e) => e == null
            ? null
            : Notifications.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListNotificationToJson(ListNotification instance) =>
    <String, dynamic>{
      'notifications':
          instance.notifications?.map((e) => e?.toJson())?.toList(),
    };

Notifications _$NotificationsFromJson(Map<String, dynamic> json) {
  return Notifications(
    notification_id: json['notification_id'] as int,
    notification_context: json['notification_context'] as String,
    notification_creat_at: json['notification_creat_at'] == null
        ? null
        : DateTime.parse(json['notification_creat_at'] as String),
    notification_posterId: json['notification_posterId'] as int,
    notification_userCreateId: json['notification_userCreateId'] as int,
    userCreate_name: json['userCreate_name'] as String,
    userCreate_avatar: json['userCreate_avatar'] as String,
    isSeen: json['isSeen'] as int,
  );
}

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'notification_id': instance.notification_id,
      'notification_context': instance.notification_context,
      'notification_creat_at':
          instance.notification_creat_at?.toIso8601String(),
      'notification_posterId': instance.notification_posterId,
      'notification_userCreateId': instance.notification_userCreateId,
      'userCreate_name': instance.userCreate_name,
      'userCreate_avatar': instance.userCreate_avatar,
      'isSeen': instance.isSeen,
    };
