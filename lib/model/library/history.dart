import 'package:app_tv/model/book_order/book_order.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history.g.dart';



@JsonSerializable(nullable: true, explicitToJson: true)
class ListHistory{
  List<History> result;
  ListHistory({this.result});

  factory ListHistory.fromJson(Map<String, dynamic> json) => _$ListHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ListHistoryToJson(this);

}
@JsonSerializable(nullable: true, explicitToJson: true)
class History {
  int id;
  Bookdetail bookdetail;
  Student student;
  String update_at;
  String payDate;
  String borrowDate;

  History(
      {this.id,
        this.bookdetail,
        this.student,
        this.update_at,
        this.payDate,
        this.borrowDate});

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);

}
@JsonSerializable(nullable: true, explicitToJson: true)
class Student {
  int id;
  String idStudent;
  String name;

  Student({this.id, this.idStudent, this.name});

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
