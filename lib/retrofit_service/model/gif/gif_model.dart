import 'package:json_annotation/json_annotation.dart';

part 'gif_model.g.dart';

@JsonSerializable()
class GIFModel {
  int? code;
  List<String>? data;
  String? message;

  GIFModel({
    this.code,
    this.data,
    this.message,
  });

  factory GIFModel.fromJson(Map<String, dynamic> json) => _$GIFModelFromJson(json);

  Map<String, dynamic> toJson() => _$GIFModelToJson(this);
}
