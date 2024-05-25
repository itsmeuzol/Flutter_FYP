// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wastepickup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Wastepickup _$WastepickupFromJson(Map<String, dynamic> json) {
  return _Wastepickup.fromJson(json);
}

/// @nodoc
mixin _$Wastepickup {
  String get location => throw _privateConstructorUsedError;
  int get wardno => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  DateTime get pickup_time => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WastepickupCopyWith<Wastepickup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WastepickupCopyWith<$Res> {
  factory $WastepickupCopyWith(
          Wastepickup value, $Res Function(Wastepickup) then) =
      _$WastepickupCopyWithImpl<$Res, Wastepickup>;
  @useResult
  $Res call(
      {String location,
      int wardno,
      String street,
      DateTime pickup_time,
      String message});
}

/// @nodoc
class _$WastepickupCopyWithImpl<$Res, $Val extends Wastepickup>
    implements $WastepickupCopyWith<$Res> {
  _$WastepickupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? wardno = null,
    Object? street = null,
    Object? pickup_time = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      wardno: null == wardno
          ? _value.wardno
          : wardno // ignore: cast_nullable_to_non_nullable
              as int,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      pickup_time: null == pickup_time
          ? _value.pickup_time
          : pickup_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WastepickupImplCopyWith<$Res>
    implements $WastepickupCopyWith<$Res> {
  factory _$$WastepickupImplCopyWith(
          _$WastepickupImpl value, $Res Function(_$WastepickupImpl) then) =
      __$$WastepickupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String location,
      int wardno,
      String street,
      DateTime pickup_time,
      String message});
}

/// @nodoc
class __$$WastepickupImplCopyWithImpl<$Res>
    extends _$WastepickupCopyWithImpl<$Res, _$WastepickupImpl>
    implements _$$WastepickupImplCopyWith<$Res> {
  __$$WastepickupImplCopyWithImpl(
      _$WastepickupImpl _value, $Res Function(_$WastepickupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? wardno = null,
    Object? street = null,
    Object? pickup_time = null,
    Object? message = null,
  }) {
    return _then(_$WastepickupImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      wardno: null == wardno
          ? _value.wardno
          : wardno // ignore: cast_nullable_to_non_nullable
              as int,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      pickup_time: null == pickup_time
          ? _value.pickup_time
          : pickup_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WastepickupImpl implements _Wastepickup {
  const _$WastepickupImpl(
      {required this.location,
      required this.wardno,
      required this.street,
      required this.pickup_time,
      required this.message});

  factory _$WastepickupImpl.fromJson(Map<String, dynamic> json) =>
      _$$WastepickupImplFromJson(json);

  @override
  final String location;
  @override
  final int wardno;
  @override
  final String street;
  @override
  final DateTime pickup_time;
  @override
  final String message;

  @override
  String toString() {
    return 'Wastepickup(location: $location, wardno: $wardno, street: $street, pickup_time: $pickup_time, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WastepickupImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.wardno, wardno) || other.wardno == wardno) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.pickup_time, pickup_time) ||
                other.pickup_time == pickup_time) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, location, wardno, street, pickup_time, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WastepickupImplCopyWith<_$WastepickupImpl> get copyWith =>
      __$$WastepickupImplCopyWithImpl<_$WastepickupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WastepickupImplToJson(
      this,
    );
  }
}

abstract class _Wastepickup implements Wastepickup {
  const factory _Wastepickup(
      {required final String location,
      required final int wardno,
      required final String street,
      required final DateTime pickup_time,
      required final String message}) = _$WastepickupImpl;

  factory _Wastepickup.fromJson(Map<String, dynamic> json) =
      _$WastepickupImpl.fromJson;

  @override
  String get location;
  @override
  int get wardno;
  @override
  String get street;
  @override
  DateTime get pickup_time;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$WastepickupImplCopyWith<_$WastepickupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
