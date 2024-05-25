import 'package:freezed_annotation/freezed_annotation.dart';

part 'wastepickup.freezed.dart';
part 'wastepickup.g.dart';

@freezed
class Wastepickup with _$Wastepickup {
  const factory Wastepickup({
    required String location,
    required int wardno,
    required String street,
    required DateTime pickup_time,
    required String message,
  }) = _Wastepickup;

  factory Wastepickup.fromJson(Map<String, dynamic> json) =>
      _$WastepickupFromJson(json);
}
