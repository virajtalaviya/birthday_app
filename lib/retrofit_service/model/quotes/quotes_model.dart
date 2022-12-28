import 'package:json_annotation/json_annotation.dart';

part 'quotes_model.g.dart';

@JsonSerializable()
class QuotesModel {
  int? code;
  List<String>? data;
  String? message;

  QuotesModel({
    this.code,
    this.data,
    this.message,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) =>
      _$QuotesModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuotesModelToJson(this);
}
