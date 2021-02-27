// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseCoreModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCoreModel _$ResponseCoreModelFromJson(Map<String, dynamic> json) {
  return ResponseCoreModel(
    json['Status'] as int,
    json['Message'] as String,
    json['Data'],
  );
}

Map<String, dynamic> _$ResponseCoreModelToJson(ResponseCoreModel instance) =>
    <String, dynamic>{
      'Status': instance.Status,
      'Message': instance.Message,
      'Data': instance.Data,
    };
