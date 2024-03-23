import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'addStaffModel.freezed.dart';
part 'addStaffModel.g.dart';

@freezed
class AddStaffModel with _$AddStaffModel {
  const factory AddStaffModel({
    required String name,
    required String email,
    required String password,
    required String location,
    int? houseno,
    int? wardno,
    String? role,
    int? isAdmin,
    int? isStaff,
    required String phone,
  }) = _AddStaffModel;

  factory AddStaffModel.fromJson(Map<String, dynamic> json) =>
      _$AddStaffModelFromJson(json);
}
