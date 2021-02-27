import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'responseCoreModel.g.dart';

@JsonSerializable()
class ResponseCoreModel {
  ResponseCoreModel(this.Status, this.Message, this.Data) {
    DataString = jsonEncode(Data);
  }

  int Status;
  String Message;
  Object Data;

  @JsonKey(ignore: true)
  String DataString;

  factory ResponseCoreModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseCoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCoreModelToJson(this);
}
