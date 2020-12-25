// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMember _$ListMemberFromJson(Map<String, dynamic> json) {
  return ListMember(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : Member.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListMemberToJson(ListMember instance) =>
    <String, dynamic>{
      'result': instance.result?.map((e) => e?.toJson())?.toList(),
    };

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    id: json['id'] as int,
    name: json['name'] as String,
    gender: json['gender'] as bool,
    userName: json['userName'] as String,
    role: json['role'] == null
        ? null
        : Role.fromJson(json['role'] as Map<String, dynamic>),
    department: json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>),
    email: json['email'] as String,
    born: json['born'] as String,
    avatar: json['avatar'] as String,
    GenCode: json['GenCode'] as String,
    phoneNumber: json['phoneNumber'] as String,
    isBlock: json['isBlock'] as bool,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userName': instance.userName,
      'role': instance.role,
      'gender': instance.gender,
      'department': instance.department,
      'born': instance.born,
      'avatar': instance.avatar,
      'phoneNumber': instance.phoneNumber,
      'GenCode': instance.GenCode,
      'email': instance.email,
      'isBlock': instance.isBlock,
    };

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role(
    id: json['id'] as int,
    name: json['name'] as String,
    Code: json['Code'] as String,
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'Code': instance.Code,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return Department(
    id: json['id'] as int,
    name: json['name'] as String,
    Code: json['Code'] as String,
  );
}

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'Code': instance.Code,
    };
