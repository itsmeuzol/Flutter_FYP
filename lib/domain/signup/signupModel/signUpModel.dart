// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'signUpModel.freezed.dart';
part 'signUpModel.g.dart';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

@freezed
class SignUpModel with _$SignUpModel {
  const factory SignUpModel({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int houseno,
    required int wardno,
    required String location,
    required String role,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);
}
