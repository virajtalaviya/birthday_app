// // ignore_for_file: non_constant_identifier_names
//
// import 'package:json_annotation/json_annotation.dart';
//
// part 'songs_model.g.dart';
//
// @JsonSerializable()
// class SongsModel {
//   int? code;
//   List<SongsDataModel>? data;
//   String? message;
//
//   SongsModel({
//     this.code,
//     this.data,
//     this.message,
//   });
//
//   factory SongsModel.fromJson(Map<String, dynamic> json) =>
//       _$SongsModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SongsModelToJson(this);
// }
//
// @JsonSerializable()
// class SongsDataModel {
//   int? id;
//   String? name;
//   String? songname;
//   String? icon_url;
//   String? created_at;
//   String? updated_at;
//
//   SongsDataModel({
//     this.id,
//     this.name,
//     this.songname,
//     this.icon_url,
//     this.created_at,
//     this.updated_at,
//   });
//
//   factory SongsDataModel.fromJson(Map<String, dynamic> json) =>
//       _$SongsDataModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SongsDataModelToJson(this);
// }
