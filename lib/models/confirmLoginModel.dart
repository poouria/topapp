import 'package:json_annotation/json_annotation.dart';
part 'confirmLoginModel.g.dart';

@JsonSerializable()
class ConfirmLoginModel {
  String UserId;
  String Token;
  List DestinationCardNoList;
  List SourceCardNoList;
  String Info;
  String PublicKey;
  bool HasWallet;
  String ResponseCoreMessage;

  ConfirmLoginModel(
      this.UserId,
      this.Token,
      this.DestinationCardNoList,
      this.SourceCardNoList,
      this.Info,
      this.PublicKey,
      this.HasWallet,
      this.ResponseCoreMessage);

  factory ConfirmLoginModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmLoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmLoginModelToJson(this);
}
