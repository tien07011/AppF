// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_order_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookOrderInfo _$BookOrderInfoFromJson(Map<String, dynamic> json) {
  return BookOrderInfo(
    id: json['id'] as int,
    borrowDate: json['borrowDate'] as String,
    payDate: json['payDate'] as String,
    deadline: json['deadline'] as String,
    bookdetail: json['bookdetail'] == null
        ? null
        : Bookdetail.fromJson(json['bookdetail'] as Map<String, dynamic>),
    userCheckIn: json['userCheckIn'] == null
        ? null
        : UserCheckIn.fromJson(json['userCheckIn'] as Map<String, dynamic>),
    userCheckOut: json['userCheckOut'] == null
        ? null
        : UserCheckOut.fromJson(json['userCheckOut'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookOrderInfoToJson(BookOrderInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'borrowDate': instance.borrowDate,
      'payDate': instance.payDate,
      'deadline': instance.deadline,
      'bookdetail': instance.bookdetail?.toJson(),
      'userCheckIn': instance.userCheckIn?.toJson(),
      'userCheckOut': instance.userCheckOut?.toJson(),
    };

UserCheckIn _$UserCheckInFromJson(Map<String, dynamic> json) {
  return UserCheckIn(
    id: json['id'] as int,
    name: json['name'] as String,
    GenCode: json['GenCode'] as String,
    gender: json['gender'] as bool,
  );
}

Map<String, dynamic> _$UserCheckInToJson(UserCheckIn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'GenCode': instance.GenCode,
      'gender': instance.gender,
    };

UserCheckOut _$UserCheckOutFromJson(Map<String, dynamic> json) {
  return UserCheckOut(
    id: json['id'] as int,
    name: json['name'] as String,
    GenCode: json['GenCode'] as String,
    gender: json['gender'] as bool,
  );
}

Map<String, dynamic> _$UserCheckOutToJson(UserCheckOut instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'GenCode': instance.GenCode,
      'gender': instance.gender,
    };
