// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmLoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmLoginModel _$ConfirmLoginModelFromJson(Map<String, dynamic> json) {
  return ConfirmLoginModel(
    json['UserId'] as String,
    json['Token'] as String,
    json['DestinationCardNoList'] as List,
    json['SourceCardNoList'] as List,
    json['Info'] as String,
    json['PublicKey'] as String,
    json['HasWallet'] as bool,
    json['ResponseCoreMessage'] as String,
  );
}

Map<String, dynamic> _$ConfirmLoginModelToJson(ConfirmLoginModel instance) =>
    <String, dynamic>{
      'UserId': instance.UserId,
      'Token': instance.Token,
      'DestinationCardNoList': instance.DestinationCardNoList,
      'SourceCardNoList': instance.SourceCardNoList,
      'Info': instance.Info,
      'PublicKey': instance.PublicKey,
      'HasWallet': instance.HasWallet,
      'ResponseCoreMessage': instance.ResponseCoreMessage,
    };
