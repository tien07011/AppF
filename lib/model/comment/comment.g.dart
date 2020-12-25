// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : Comments.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'result': instance.result?.map((e) => e?.toJson())?.toList(),
    };

UserCreate _$UserCreateFromJson(Map<String, dynamic> json) {
  return UserCreate(
    id: json['id'] as int,
    name: json['name'] as String,
    genCode: json['genCode'] as String,
    gender: json['gender'] as bool,
  )
    ..isBlock = json['isBlock'] as bool
    ..avatar = json['avatar'] as String;
}

Map<String, dynamic> _$UserCreateToJson(UserCreate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'genCode': instance.genCode,
      'gender': instance.gender,
      'isBlock': instance.isBlock,
      'avatar': instance.avatar,
    };

Comments _$CommentsFromJson(Map<String, dynamic> json) {
  return Comments(
    id: json['id'] as int,
    content: json['content'] as String,
    asset: json['asset'] as String,
    user: json['user'] == null
        ? null
        : UserCreate.fromJson(json['user'] as Map<String, dynamic>),
    createAt: json['createAt'] as String,
  );
}

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'asset': instance.asset,
      'user': instance.user,
      'createAt': instance.createAt,
    };
