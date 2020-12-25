import 'package:json_annotation/json_annotation.dart';

part 'list_member.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ListMember {
  List<Member> result;

  ListMember({this.result});

  factory ListMember.fromJson(Map<String, dynamic> json) => _$ListMemberFromJson(json);

  Map<String, dynamic> toJson() => _$ListMemberToJson(this);
}

@JsonSerializable(nullable: true)
class Member {
  int id;
  String name;
  String userName;
  Role role;
  bool gender;
  Department department;
  String born;
  String avatar;
  String phoneNumber;
  String GenCode;
  String email;
  bool isBlock;

  Member(
      {this.id,
      this.name,
      this.gender,
      this.userName,
      this.role,
      this.department,
      this.email,
      this.born,
      this.avatar,
      this.GenCode,
      this.phoneNumber,
      this.isBlock});

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable(nullable: true)
class Role {
  int id;
  String name;
  String Code;

  Role({this.id, this.name, this.Code});

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

@JsonSerializable(nullable: true)
class Department {
  int id;
  String name;
  String Code;

  Department({this.id, this.name, this.Code});

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
