// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addDustbinModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddDustbinModelImpl _$$AddDustbinModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AddDustbinModelImpl(
      location: json['location'] as String,
      wardno: json['wardno'] as int,
      assigned_staff: json['assigned_staff'] as int?,
      dustbin_type: json['dustbin_type'] as String?,
      fill_percentage: json['fill_percentage'] as int?,
    );

Map<String, dynamic> _$$AddDustbinModelImplToJson(
        _$AddDustbinModelImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'wardno': instance.wardno,
      'assigned_staff': instance.assigned_staff,
      'dustbin_type': instance.dustbin_type,
      'fill_percentage': instance.fill_percentage,
    };
