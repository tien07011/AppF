import 'package:json_annotation/json_annotation.dart';

part 'book_order.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class BookOrder {
  StudentInfo studentInfo;
  List<BookBorrowed> bookBorrowed;
  List<BookPaid> bookPaid;

  BookOrder({this.studentInfo, this.bookBorrowed, this.bookPaid});

  factory BookOrder.fromJson(Map<String, dynamic> json) => _$BookOrderFromJson(json);

  Map<String, dynamic> toJson() => _$BookOrderToJson(this);

}
@JsonSerializable(nullable: true)
class StudentInfo {
  int id;
  String idStudent;
  String name;
  String born;
  String grade;
  String note;

  StudentInfo({this.id, this.idStudent, this.name, this.born, this.grade, this.note});
  factory StudentInfo.fromJson(Map<String, dynamic> json) => _$StudentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StudentInfoToJson(this);

}
@JsonSerializable(nullable: true)
class BookBorrowed {
  int id;
  String borrowDate;
  String payDate;
  String deadline;
  Bookdetail bookdetail;

  BookBorrowed({this.id, this.borrowDate, this.payDate, this.deadline, this.bookdetail});
  factory BookBorrowed.fromJson(Map<String, dynamic> json) => _$BookBorrowedFromJson(json);

  Map<String, dynamic> toJson() => _$BookBorrowedToJson(this);

}
@JsonSerializable(nullable: true)
class Bookdetail {
  int id;
  String idBookDetails;
  Book book;

  Bookdetail({this.id, this.idBookDetails, this.book});
  factory Bookdetail.fromJson(Map<String, dynamic> json) => _$BookdetailFromJson(json);

  Map<String, dynamic> toJson() => _$BookdetailToJson(this);

}
@JsonSerializable(nullable: true)
class Book {
  int id;
  String idBook;
  String name;
  int price;
  int amount;

  Book({this.id, this.idBook, this.name, this.price, this.amount});
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);


}
@JsonSerializable(nullable: true)
class BookPaid {
  int id;
  String borrowDate;
  String payDate;
  String deadline;
  Bookdetail bookdetail;

  BookPaid({this.id, this.borrowDate, this.payDate, this.deadline, this.bookdetail});
  factory BookPaid.fromJson(Map<String, dynamic> json) => _$BookPaidFromJson(json);

  Map<String, dynamic> toJson() => _$BookPaidToJson(this);

}
