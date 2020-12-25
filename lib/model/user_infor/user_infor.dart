import 'package:json_annotation/json_annotation.dart';

part 'user_infor.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class UserInfor {
  int id;
  String name;
  String born;
  Role role;
  Department department;
  String avatar;
  String GenCode;
  String email;
  String phoneNumber;
  bool gender;

  UserInfor(
      {this.id,
      this.name,
      this.born,
      this.role,
      this.department,
      this.avatar,
      this.GenCode,
      this.gender,
      this.phoneNumber,
      this.email});

  factory UserInfor.fromJson(Map<String, dynamic> json) => _$UserInforFromJson(json);

  Map<String, dynamic> toJson() => _$UserInforToJson(this);
}

@JsonSerializable(nullable: true)
class Role {
  int id;
  String name;
  String code;
  bool isSendEmail;
  bool isCreateOrEditSheet;
  bool isCreateOrEditBook;
  bool isCreateOrEditUser;
  bool isCreateOrEditStudent;
  bool isCreatePost;

  Role(
      {this.id,
      this.name,
      this.code,
      this.isSendEmail,
      this.isCreateOrEditSheet,
      this.isCreateOrEditBook,
      this.isCreateOrEditUser,
      this.isCreateOrEditStudent,
      this.isCreatePost});

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

@JsonSerializable(nullable: true)
class Department {
  int id;
  String name;
  String code;

  Department({this.id, this.name, this.code});

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
