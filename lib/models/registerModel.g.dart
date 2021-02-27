// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) {
  return RegisterModel(
    json['RefMessage'] as String,
    json['FlowToken'] as String,
    json['ResponseCoreMessage'] as String,
  );
}

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'RefMessage': instance.RefMessage,
      'FlowToken': instance.FlowToken,
      'ResponseCoreMessage': instance.ResponseCoreMessage,
    };
