// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookOrder _$BookOrderFromJson(Map<String, dynamic> json) {
  return BookOrder(
    studentInfo: json['studentInfo'] == null
        ? null
        : StudentInfo.fromJson(json['studentInfo'] as Map<String, dynamic>),
    bookBorrowed: (json['bookBorrowed'] as List)
        ?.map((e) =>
            e == null ? null : BookBorrowed.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bookPaid: (json['bookPaid'] as List)
        ?.map((e) =>
            e == null ? null : BookPaid.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BookOrderToJson(BookOrder instance) => <String, dynamic>{
      'studentInfo': instance.studentInfo?.toJson(),
      'bookBorrowed': instance.bookBorrowed?.map((e) => e?.toJson())?.toList(),
      'bookPaid': instance.bookPaid?.map((e) => e?.toJson())?.toList(),
    };

StudentInfo _$StudentInfoFromJson(Map<String, dynamic> json) {
  return StudentInfo(
    id: json['id'] as int,
    idStudent: json['idStudent'] as String,
    name: json['name'] as String,
    born: json['born'] as String,
    grade: json['grade'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$StudentInfoToJson(StudentInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idStudent': instance.idStudent,
      'name': instance.name,
      'born': instance.born,
      'grade': instance.grade,
      'note': instance.note,
    };

BookBorrowed _$BookBorrowedFromJson(Map<String, dynamic> json) {
  return BookBorrowed(
    id: json['id'] as int,
    borrowDate: json['borrowDate'] as String,
    payDate: json['payDate'] as String,
    deadline: json['deadline'] as String,
    bookdetail: json['bookdetail'] == null
        ? null
        : Bookdetail.fromJson(json['bookdetail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookBorrowedToJson(BookBorrowed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'borrowDate': instance.borrowDate,
      'payDate': instance.payDate,
      'deadline': instance.deadline,
      'bookdetail': instance.bookdetail,
    };

Bookdetail _$BookdetailFromJson(Map<String, dynamic> json) {
  return Bookdetail(
    id: json['id'] as int,
    idBookDetails: json['idBookDetails'] as String,
    book: json['book'] == null
        ? null
        : Book.fromJson(json['book'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookdetailToJson(Bookdetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idBookDetails': instance.idBookDetails,
      'book': instance.book,
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

BookPaid _$BookPaidFromJson(Map<String, dynamic> json) {
  return BookPaid(
    id: json['id'] as int,
    borrowDate: json['borrowDate'] as String,
    payDate: json['payDate'] as String,
    deadline: json['deadline'] as String,
    bookdetail: json['bookdetail'] == null
        ? null
        : Bookdetail.fromJson(json['bookdetail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookPaidToJson(BookPaid instance) => <String, dynamic>{
      'id': instance.id,
      'borrowDate': instance.borrowDate,
      'payDate': instance.payDate,
      'deadline': instance.deadline,
      'bookdetail': instance.bookdetail,
    };
