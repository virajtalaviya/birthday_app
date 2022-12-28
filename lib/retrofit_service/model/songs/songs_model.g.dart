// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongsModel _$SongsModelFromJson(Map<String, dynamic> json) => SongsModel(
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SongsDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SongsModelToJson(SongsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

SongsDataModel _$SongsDataModelFromJson(Map<String, dynamic> json) =>
    SongsDataModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      songname: json['songname'] as String?,
      icon_url: json['icon_url'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SongsDataModelToJson(SongsDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'songname': instance.songname,
      'icon_url': instance.icon_url,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
