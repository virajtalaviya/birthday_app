// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuotesModel _$QuotesModelFromJson(Map<String, dynamic> json) => QuotesModel(
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuotesModelToJson(QuotesModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
