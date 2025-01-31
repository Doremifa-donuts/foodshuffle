// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'specific_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpecificReview _$SpecificReviewFromJson(Map<String, dynamic> json) {
  return _SpecificReview.fromJson(json);
}

/// @nodoc
mixin _$SpecificReview {
  String get ReviewUuid => throw _privateConstructorUsedError;
  String get Comment => throw _privateConstructorUsedError;
  DateTime get CreatedAt => throw _privateConstructorUsedError;
  List<String> get Images => throw _privateConstructorUsedError;
  String get Icon => throw _privateConstructorUsedError;
  int get Good => throw _privateConstructorUsedError;
  bool get GoodFlag => throw _privateConstructorUsedError;

  /// Serializes this SpecificReview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpecificReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpecificReviewCopyWith<SpecificReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecificReviewCopyWith<$Res> {
  factory $SpecificReviewCopyWith(
          SpecificReview value, $Res Function(SpecificReview) then) =
      _$SpecificReviewCopyWithImpl<$Res, SpecificReview>;
  @useResult
  $Res call(
      {String ReviewUuid,
      String Comment,
      DateTime CreatedAt,
      List<String> Images,
      String Icon,
      int Good,
      bool GoodFlag});
}

/// @nodoc
class _$SpecificReviewCopyWithImpl<$Res, $Val extends SpecificReview>
    implements $SpecificReviewCopyWith<$Res> {
  _$SpecificReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpecificReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ReviewUuid = null,
    Object? Comment = null,
    Object? CreatedAt = null,
    Object? Images = null,
    Object? Icon = null,
    Object? Good = null,
    Object? GoodFlag = null,
  }) {
    return _then(_value.copyWith(
      ReviewUuid: null == ReviewUuid
          ? _value.ReviewUuid
          : ReviewUuid // ignore: cast_nullable_to_non_nullable
              as String,
      Comment: null == Comment
          ? _value.Comment
          : Comment // ignore: cast_nullable_to_non_nullable
              as String,
      CreatedAt: null == CreatedAt
          ? _value.CreatedAt
          : CreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      Images: null == Images
          ? _value.Images
          : Images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      Icon: null == Icon
          ? _value.Icon
          : Icon // ignore: cast_nullable_to_non_nullable
              as String,
      Good: null == Good
          ? _value.Good
          : Good // ignore: cast_nullable_to_non_nullable
              as int,
      GoodFlag: null == GoodFlag
          ? _value.GoodFlag
          : GoodFlag // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpecificReviewImplCopyWith<$Res>
    implements $SpecificReviewCopyWith<$Res> {
  factory _$$SpecificReviewImplCopyWith(_$SpecificReviewImpl value,
          $Res Function(_$SpecificReviewImpl) then) =
      __$$SpecificReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ReviewUuid,
      String Comment,
      DateTime CreatedAt,
      List<String> Images,
      String Icon,
      int Good,
      bool GoodFlag});
}

/// @nodoc
class __$$SpecificReviewImplCopyWithImpl<$Res>
    extends _$SpecificReviewCopyWithImpl<$Res, _$SpecificReviewImpl>
    implements _$$SpecificReviewImplCopyWith<$Res> {
  __$$SpecificReviewImplCopyWithImpl(
      _$SpecificReviewImpl _value, $Res Function(_$SpecificReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpecificReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ReviewUuid = null,
    Object? Comment = null,
    Object? CreatedAt = null,
    Object? Images = null,
    Object? Icon = null,
    Object? Good = null,
    Object? GoodFlag = null,
  }) {
    return _then(_$SpecificReviewImpl(
      ReviewUuid: null == ReviewUuid
          ? _value.ReviewUuid
          : ReviewUuid // ignore: cast_nullable_to_non_nullable
              as String,
      Comment: null == Comment
          ? _value.Comment
          : Comment // ignore: cast_nullable_to_non_nullable
              as String,
      CreatedAt: null == CreatedAt
          ? _value.CreatedAt
          : CreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      Images: null == Images
          ? _value._Images
          : Images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      Icon: null == Icon
          ? _value.Icon
          : Icon // ignore: cast_nullable_to_non_nullable
              as String,
      Good: null == Good
          ? _value.Good
          : Good // ignore: cast_nullable_to_non_nullable
              as int,
      GoodFlag: null == GoodFlag
          ? _value.GoodFlag
          : GoodFlag // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpecificReviewImpl implements _SpecificReview {
  const _$SpecificReviewImpl(
      {required this.ReviewUuid,
      required this.Comment,
      required this.CreatedAt,
      required final List<String> Images,
      required this.Icon,
      required this.Good,
      required this.GoodFlag})
      : _Images = Images;

  factory _$SpecificReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecificReviewImplFromJson(json);

  @override
  final String ReviewUuid;
  @override
  final String Comment;
  @override
  final DateTime CreatedAt;
  final List<String> _Images;
  @override
  List<String> get Images {
    if (_Images is EqualUnmodifiableListView) return _Images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_Images);
  }

  @override
  final String Icon;
  @override
  final int Good;
  @override
  final bool GoodFlag;

  @override
  String toString() {
    return 'SpecificReview(ReviewUuid: $ReviewUuid, Comment: $Comment, CreatedAt: $CreatedAt, Images: $Images, Icon: $Icon, Good: $Good, GoodFlag: $GoodFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecificReviewImpl &&
            (identical(other.ReviewUuid, ReviewUuid) ||
                other.ReviewUuid == ReviewUuid) &&
            (identical(other.Comment, Comment) || other.Comment == Comment) &&
            (identical(other.CreatedAt, CreatedAt) ||
                other.CreatedAt == CreatedAt) &&
            const DeepCollectionEquality().equals(other._Images, _Images) &&
            (identical(other.Icon, Icon) || other.Icon == Icon) &&
            (identical(other.Good, Good) || other.Good == Good) &&
            (identical(other.GoodFlag, GoodFlag) ||
                other.GoodFlag == GoodFlag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ReviewUuid, Comment, CreatedAt,
      const DeepCollectionEquality().hash(_Images), Icon, Good, GoodFlag);

  /// Create a copy of SpecificReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecificReviewImplCopyWith<_$SpecificReviewImpl> get copyWith =>
      __$$SpecificReviewImplCopyWithImpl<_$SpecificReviewImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpecificReviewImplToJson(
      this,
    );
  }
}

abstract class _SpecificReview implements SpecificReview {
  const factory _SpecificReview(
      {required final String ReviewUuid,
      required final String Comment,
      required final DateTime CreatedAt,
      required final List<String> Images,
      required final String Icon,
      required final int Good,
      required final bool GoodFlag}) = _$SpecificReviewImpl;

  factory _SpecificReview.fromJson(Map<String, dynamic> json) =
      _$SpecificReviewImpl.fromJson;

  @override
  String get ReviewUuid;
  @override
  String get Comment;
  @override
  DateTime get CreatedAt;
  @override
  List<String> get Images;
  @override
  String get Icon;
  @override
  int get Good;
  @override
  bool get GoodFlag;

  /// Create a copy of SpecificReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpecificReviewImplCopyWith<_$SpecificReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
