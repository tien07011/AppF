import 'package:app_tv/model/book_order/book_order.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book_order_info.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class BookOrderInfo {
  int id;
  String borrowDate;
  String payDate;
  String deadline;
  Bookdetail bookdetail;
  UserCheckIn userCheckIn;
  UserCheckOut userCheckOut;

  BookOrderInfo(
      {this.id,
        this.borrowDate,
        this.payDate,
        this.deadline,
        this.bookdetail,
        this.userCheckIn,
        this.userCheckOut});
  factory BookOrderInfo.fromJson(Map<String, dynamic> json) => _$BookOrderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BookOrderInfoToJson(this);

}

@JsonSerializable(nullable: true)
class UserCheckIn {
  int id;
  String name;
  String  GenCode;
  bool gender;

  UserCheckIn({this.id, this.name, this.GenCode, this.gender});
  factory UserCheckIn.fromJson(Map<String, dynamic> json) => _$UserCheckInFromJson(json);

  Map<String, dynamic> toJson() => _$UserCheckInToJson(this);

}
@JsonSerializable(nullable: true)
class UserCheckOut {
  int id;
  String name;
  String GenCode;
  bool gender;

  UserCheckOut({this.id, this.name, this.GenCode, this.gender});
  factory UserCheckOut.fromJson(Map<String, dynamic> json) => _$UserCheckOutFromJson(json);

  Map<String, dynamic> toJson() => _$UserCheckOutToJson(this);

}
