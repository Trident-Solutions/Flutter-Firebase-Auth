// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MemoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoModel _$MemoModelFromJson(Map<dynamic, dynamic> json) {
  return MemoModel(
    json['title'] as String,
    json['notes'] as String,
  );
}

Map<String, dynamic> _$MemoModelToJson(MemoModel instance) => <String, dynamic>{
      'title': instance.title,
      'notes': instance.notes,
    };
