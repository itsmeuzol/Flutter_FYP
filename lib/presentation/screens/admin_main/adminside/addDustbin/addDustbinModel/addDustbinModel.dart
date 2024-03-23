import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'addDustbinModel.freezed.dart';
part 'addDustbinModel.g.dart';

@freezed
class AddDustbinModel with _$AddDustbinModel {
  const factory AddDustbinModel({
    required String location,
    required int wardno,
    int? assigned_staff,
    String? dustbin_type,
    int? fill_percentage,
  }) = _AddDustbinModel;

  factory AddDustbinModel.fromJson(Map<String, dynamic> json) =>
      _$AddDustbinModelFromJson(json);
}
