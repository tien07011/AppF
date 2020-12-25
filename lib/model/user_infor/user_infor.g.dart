// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfor _$UserInforFromJson(Map<String, dynamic> json) {
  return UserInfor(
    id: json['id'] as int,
    name: json['name'] as String,
    born: json['born'] as String,
    role: json['role'] == null
        ? null
        : Role.fromJson(json['role'] as Map<String, dynamic>),
    department: json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>),
    avatar: json['avatar'] as String,
    GenCode: json['GenCode'] as String,
    gender: json['gender'] as bool,
    phoneNumber: json['phoneNumber'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserInforToJson(UserInfor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'born': instance.born,
      'role': instance.role?.toJson(),
      'department': instance.department?.toJson(),
      'avatar': instance.avatar,
      'GenCode': instance.GenCode,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
    };

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role(
    id: json['id'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
    isSendEmail: json['isSendEmail'] as bool,
    isCreateOrEditSheet: json['isCreateOrEditSheet'] as bool,
    isCreateOrEditBook: json['isCreateOrEditBook'] as bool,
    isCreateOrEditUser: json['isCreateOrEditUser'] as bool,
    isCreateOrEditStudent: json['isCreateOrEditStudent'] as bool,
    isCreatePost: json['isCreatePost'] as bool,
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'isSendEmail': instance.isSendEmail,
      'isCreateOrEditSheet': instance.isCreateOrEditSheet,
      'isCreateOrEditBook': instance.isCreateOrEditBook,
      'isCreateOrEditUser': instance.isCreateOrEditUser,
      'isCreateOrEditStudent': instance.isCreateOrEditStudent,
      'isCreatePost': instance.isCreatePost,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return Department(
    id: json['id'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
