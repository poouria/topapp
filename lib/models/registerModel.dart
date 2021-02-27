import 'package:json_annotation/json_annotation.dart';
part 'registerModel.g.dart';

@JsonSerializable()
class RegisterModel {
  String RefMessage;
  String FlowToken;
  String ResponseCoreMessage;

  RegisterModel(this.RefMessage, this.FlowToken, this.ResponseCoreMessage);

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
