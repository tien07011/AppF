// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListHistory _$ListHistoryFromJson(Map<String, dynamic> json) {
  return ListHistory(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : History.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListHistoryToJson(ListHistory instance) =>
    <String, dynamic>{
      'result': instance.result?.map((e) => e?.toJson())?.toList(),
    };

History _$HistoryFromJson(Map<String, dynamic> json) {
  return History(
    id: json['id'] as int,
    bookdetail: json['bookdetail'] == null
        ? null
        : Bookdetail.fromJson(json['bookdetail'] as Map<String, dynamic>),
    student: json['student'] == null
        ? null
        : Student.fromJson(json['student'] as Map<String, dynamic>),
    update_at: json['update_at'] as String,
    payDate: json['payDate'] as String,
    borrowDate: json['borrowDate'] as String,
  );
}

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'id': instance.id,
      'bookdetail': instance.bookdetail?.toJson(),
      'student': instance.student?.toJson(),
      'update_at': instance.update_at,
      'payDate': instance.payDate,
      'borrowDate': instance.borrowDate,
    };

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    id: json['id'] as int,
    idStudent: json['idStudent'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'idStudent': instance.idStudent,
      'name': instance.name,
    };
