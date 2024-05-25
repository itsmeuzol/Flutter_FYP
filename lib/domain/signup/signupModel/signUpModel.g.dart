// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signUpModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpModelImpl _$$SignUpModelImplFromJson(Map<String, dynamic> json) =>
    _$SignUpModelImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      houseno: json['houseno'] as int,
      wardno: json['wardno'] as int,
      location: json['location'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$SignUpModelImplToJson(_$SignUpModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'houseno': instance.houseno,
      'wardno': instance.wardno,
      'location': instance.location,
      'role': instance.role,
    };
