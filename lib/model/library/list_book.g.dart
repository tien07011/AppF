// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBook _$ListBookFromJson(Map<String, dynamic> json) {
  return ListBook(
    result: (json['result'] as List)
        ?.map(
            (e) => e == null ? null : Book.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListBookToJson(ListBook instance) => <String, dynamic>{
      'result': instance.result?.map((e) => e?.toJson())?.toList(),
    };

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    id: json['id'] as int,
    idBook: json['idBook'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    amount: json['amount'] as int,
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'idBook': instance.idBook,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
    };
