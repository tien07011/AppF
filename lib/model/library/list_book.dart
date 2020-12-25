import 'package:json_annotation/json_annotation.dart';

part 'list_book.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class ListBook {
  List<Book> result;

  ListBook({this.result});

  factory ListBook.fromJson(Map<String, dynamic> json) => _$ListBookFromJson(json);

  Map<String, dynamic> toJson() => _$ListBookToJson(this);
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
