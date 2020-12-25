import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ListPost {
  List<Post> result;

  ListPost({this.result});

  factory ListPost.fromJson(Map<String, dynamic> json) => _$ListPostFromJson(json);

  Map<String, dynamic> toJson() => _$ListPostToJson(this);
}

@JsonSerializable(nullable: true)
class Post {
  int id;
  String urlAssets;
  UserCreate userCreate;
  String content;
  String create_at;
  int likes;
  int comments;
  bool isLike;

  Post({this.id, this.urlAssets, this.userCreate, this.content, this.create_at, this.likes, this.comments, this.isLike});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable(nullable: true)
class UserCreate {
  int id;
  String name;
  Department department;
  String avatar;
  String genCode;
  bool gender;

  UserCreate({this.id, this.name, this.department, this.avatar, this.genCode, this.gender});

  factory UserCreate.fromJson(Map<String, dynamic> json) => _$UserCreateFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateToJson(this);
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
