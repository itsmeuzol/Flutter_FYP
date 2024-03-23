// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'addDustbinModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddDustbinModel _$AddDustbinModelFromJson(Map<String, dynamic> json) {
  return _AddDustbinModel.fromJson(json);
}

/// @nodoc
mixin _$AddDustbinModel {
  String get location => throw _privateConstructorUsedError;
  int get wardno => throw _privateConstructorUsedError;
  int? get assigned_staff => throw _privateConstructorUsedError;
  String? get dustbin_type => throw _privateConstructorUsedError;
  int? get fill_percentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddDustbinModelCopyWith<AddDustbinModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddDustbinModelCopyWith<$Res> {
  factory $AddDustbinModelCopyWith(
          AddDustbinModel value, $Res Function(AddDustbinModel) then) =
      _$AddDustbinModelCopyWithImpl<$Res, AddDustbinModel>;
  @useResult
  $Res call(
      {String location,
      int wardno,
      int? assigned_staff,
      String? dustbin_type,
      int? fill_percentage});
}

/// @nodoc
class _$AddDustbinModelCopyWithImpl<$Res, $Val extends AddDustbinModel>
    implements $AddDustbinModelCopyWith<$Res> {
  _$AddDustbinModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? wardno = null,
    Object? assigned_staff = freezed,
    Object? dustbin_type = freezed,
    Object? fill_percentage = freezed,
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
      assigned_staff: freezed == assigned_staff
          ? _value.assigned_staff
          : assigned_staff // ignore: cast_nullable_to_non_nullable
              as int?,
      dustbin_type: freezed == dustbin_type
          ? _value.dustbin_type
          : dustbin_type // ignore: cast_nullable_to_non_nullable
              as String?,
      fill_percentage: freezed == fill_percentage
          ? _value.fill_percentage
          : fill_percentage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddDustbinModelImplCopyWith<$Res>
    implements $AddDustbinModelCopyWith<$Res> {
  factory _$$AddDustbinModelImplCopyWith(_$AddDustbinModelImpl value,
          $Res Function(_$AddDustbinModelImpl) then) =
      __$$AddDustbinModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String location,
      int wardno,
      int? assigned_staff,
      String? dustbin_type,
      int? fill_percentage});
}

/// @nodoc
class __$$AddDustbinModelImplCopyWithImpl<$Res>
    extends _$AddDustbinModelCopyWithImpl<$Res, _$AddDustbinModelImpl>
    implements _$$AddDustbinModelImplCopyWith<$Res> {
  __$$AddDustbinModelImplCopyWithImpl(
      _$AddDustbinModelImpl _value, $Res Function(_$AddDustbinModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? wardno = null,
    Object? assigned_staff = freezed,
    Object? dustbin_type = freezed,
    Object? fill_percentage = freezed,
  }) {
    return _then(_$AddDustbinModelImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      wardno: null == wardno
          ? _value.wardno
          : wardno // ignore: cast_nullable_to_non_nullable
              as int,
      assigned_staff: freezed == assigned_staff
          ? _value.assigned_staff
          : assigned_staff // ignore: cast_nullable_to_non_nullable
              as int?,
      dustbin_type: freezed == dustbin_type
          ? _value.dustbin_type
          : dustbin_type // ignore: cast_nullable_to_non_nullable
              as String?,
      fill_percentage: freezed == fill_percentage
          ? _value.fill_percentage
          : fill_percentage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddDustbinModelImpl implements _AddDustbinModel {
  const _$AddDustbinModelImpl(
      {required this.location,
      required this.wardno,
      this.assigned_staff,
      this.dustbin_type,
      this.fill_percentage});

  factory _$AddDustbinModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddDustbinModelImplFromJson(json);

  @override
  final String location;
  @override
  final int wardno;
  @override
  final int? assigned_staff;
  @override
  final String? dustbin_type;
  @override
  final int? fill_percentage;

  @override
  String toString() {
    return 'AddDustbinModel(location: $location, wardno: $wardno, assigned_staff: $assigned_staff, dustbin_type: $dustbin_type, fill_percentage: $fill_percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddDustbinModelImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.wardno, wardno) || other.wardno == wardno) &&
            (identical(other.assigned_staff, assigned_staff) ||
                other.assigned_staff == assigned_staff) &&
            (identical(other.dustbin_type, dustbin_type) ||
                other.dustbin_type == dustbin_type) &&
            (identical(other.fill_percentage, fill_percentage) ||
                other.fill_percentage == fill_percentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, location, wardno, assigned_staff,
      dustbin_type, fill_percentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddDustbinModelImplCopyWith<_$AddDustbinModelImpl> get copyWith =>
      __$$AddDustbinModelImplCopyWithImpl<_$AddDustbinModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddDustbinModelImplToJson(
      this,
    );
  }
}

abstract class _AddDustbinModel implements AddDustbinModel {
  const factory _AddDustbinModel(
      {required final String location,
      required final int wardno,
      final int? assigned_staff,
      final String? dustbin_type,
      final int? fill_percentage}) = _$AddDustbinModelImpl;

  factory _AddDustbinModel.fromJson(Map<String, dynamic> json) =
      _$AddDustbinModelImpl.fromJson;

  @override
  String get location;
  @override
  int get wardno;
  @override
  int? get assigned_staff;
  @override
  String? get dustbin_type;
  @override
  int? get fill_percentage;
  @override
  @JsonKey(ignore: true)
  _$$AddDustbinModelImplCopyWith<_$AddDustbinModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
