// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
mixin _$Course {
  String get CourseUuid => throw _privateConstructorUsedError;
  String get RestaurantUuid => throw _privateConstructorUsedError;
  String get CourseName => throw _privateConstructorUsedError;
  String get Description => throw _privateConstructorUsedError;
  List<String> get Images => throw _privateConstructorUsedError;
  int get Price => throw _privateConstructorUsedError;
  int get Minimum => throw _privateConstructorUsedError;

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call(
      {String CourseUuid,
      String RestaurantUuid,
      String CourseName,
      String Description,
      List<String> Images,
      int Price,
      int Minimum});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? CourseUuid = null,
    Object? RestaurantUuid = null,
    Object? CourseName = null,
    Object? Description = null,
    Object? Images = null,
    Object? Price = null,
    Object? Minimum = null,
  }) {
    return _then(_value.copyWith(
      CourseUuid: null == CourseUuid
          ? _value.CourseUuid
          : CourseUuid // ignore: cast_nullable_to_non_nullable
              as String,
      RestaurantUuid: null == RestaurantUuid
          ? _value.RestaurantUuid
          : RestaurantUuid // ignore: cast_nullable_to_non_nullable
              as String,
      CourseName: null == CourseName
          ? _value.CourseName
          : CourseName // ignore: cast_nullable_to_non_nullable
              as String,
      Description: null == Description
          ? _value.Description
          : Description // ignore: cast_nullable_to_non_nullable
              as String,
      Images: null == Images
          ? _value.Images
          : Images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      Price: null == Price
          ? _value.Price
          : Price // ignore: cast_nullable_to_non_nullable
              as int,
      Minimum: null == Minimum
          ? _value.Minimum
          : Minimum // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
          _$CourseImpl value, $Res Function(_$CourseImpl) then) =
      __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String CourseUuid,
      String RestaurantUuid,
      String CourseName,
      String Description,
      List<String> Images,
      int Price,
      int Minimum});
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
      _$CourseImpl _value, $Res Function(_$CourseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? CourseUuid = null,
    Object? RestaurantUuid = null,
    Object? CourseName = null,
    Object? Description = null,
    Object? Images = null,
    Object? Price = null,
    Object? Minimum = null,
  }) {
    return _then(_$CourseImpl(
      CourseUuid: null == CourseUuid
          ? _value.CourseUuid
          : CourseUuid // ignore: cast_nullable_to_non_nullable
              as String,
      RestaurantUuid: null == RestaurantUuid
          ? _value.RestaurantUuid
          : RestaurantUuid // ignore: cast_nullable_to_non_nullable
              as String,
      CourseName: null == CourseName
          ? _value.CourseName
          : CourseName // ignore: cast_nullable_to_non_nullable
              as String,
      Description: null == Description
          ? _value.Description
          : Description // ignore: cast_nullable_to_non_nullable
              as String,
      Images: null == Images
          ? _value._Images
          : Images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      Price: null == Price
          ? _value.Price
          : Price // ignore: cast_nullable_to_non_nullable
              as int,
      Minimum: null == Minimum
          ? _value.Minimum
          : Minimum // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseImpl implements _Course {
  const _$CourseImpl(
      {required this.CourseUuid,
      required this.RestaurantUuid,
      required this.CourseName,
      required this.Description,
      required final List<String> Images,
      required this.Price,
      required this.Minimum})
      : _Images = Images;

  factory _$CourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseImplFromJson(json);

  @override
  final String CourseUuid;
  @override
  final String RestaurantUuid;
  @override
  final String CourseName;
  @override
  final String Description;
  final List<String> _Images;
  @override
  List<String> get Images {
    if (_Images is EqualUnmodifiableListView) return _Images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_Images);
  }

  @override
  final int Price;
  @override
  final int Minimum;

  @override
  String toString() {
    return 'Course(CourseUuid: $CourseUuid, RestaurantUuid: $RestaurantUuid, CourseName: $CourseName, Description: $Description, Images: $Images, Price: $Price, Minimum: $Minimum)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseImpl &&
            (identical(other.CourseUuid, CourseUuid) ||
                other.CourseUuid == CourseUuid) &&
            (identical(other.RestaurantUuid, RestaurantUuid) ||
                other.RestaurantUuid == RestaurantUuid) &&
            (identical(other.CourseName, CourseName) ||
                other.CourseName == CourseName) &&
            (identical(other.Description, Description) ||
                other.Description == Description) &&
            const DeepCollectionEquality().equals(other._Images, _Images) &&
            (identical(other.Price, Price) || other.Price == Price) &&
            (identical(other.Minimum, Minimum) || other.Minimum == Minimum));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      CourseUuid,
      RestaurantUuid,
      CourseName,
      Description,
      const DeepCollectionEquality().hash(_Images),
      Price,
      Minimum);

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseImplToJson(
      this,
    );
  }
}

abstract class _Course implements Course {
  const factory _Course(
      {required final String CourseUuid,
      required final String RestaurantUuid,
      required final String CourseName,
      required final String Description,
      required final List<String> Images,
      required final int Price,
      required final int Minimum}) = _$CourseImpl;

  factory _Course.fromJson(Map<String, dynamic> json) = _$CourseImpl.fromJson;

  @override
  String get CourseUuid;
  @override
  String get RestaurantUuid;
  @override
  String get CourseName;
  @override
  String get Description;
  @override
  List<String> get Images;
  @override
  int get Price;
  @override
  int get Minimum;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
