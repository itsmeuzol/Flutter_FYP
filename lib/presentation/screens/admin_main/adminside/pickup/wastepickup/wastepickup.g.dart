// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wastepickup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WastepickupImpl _$$WastepickupImplFromJson(Map<String, dynamic> json) =>
    _$WastepickupImpl(
      location: json['location'] as String,
      wardno: json['wardno'] as int,
      street: json['street'] as String,
      pickup_time: DateTime.parse(json['pickup_time'] as String),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$WastepickupImplToJson(_$WastepickupImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'wardno': instance.wardno,
      'street': instance.street,
      'pickup_time': instance.pickup_time.toIso8601String(),
      'message': instance.message,
    };
