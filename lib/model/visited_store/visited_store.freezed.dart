// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visited_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisitedStore _$VisitedStoreFromJson(Map<String, dynamic> json) {
  return _VisitedStore.fromJson(json);
}

/// @nodoc
mixin _$VisitedStore {
  String get RestaurantUuid => throw _privateConstructorUsedError;
  String get RestaurantName => throw _privateConstructorUsedError;
  String get Address => throw _privateConstructorUsedError;
  String get Tell => throw _privateConstructorUsedError;
  List<String> get Images => throw _privateConstructorUsedError;

  /// Serializes this VisitedStore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VisitedStore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitedStoreCopyWith<VisitedStore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitedStoreCopyWith<$Res> {
  factory $VisitedStoreCopyWith(
          VisitedStore value, $Res Function(VisitedStore) then) =
      _$VisitedStoreCopyWithImpl<$Res, VisitedStore>;
  @useResult
  $Res call(
      {String RestaurantUuid,
      String RestaurantName,
      String Address,
      String Tell,
      List<String> Images});
}

/// @nodoc
class _$VisitedStoreCopyWithImpl<$Res, $Val extends VisitedStore>
    implements $VisitedStoreCopyWith<$Res> {
  _$VisitedStoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitedStore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RestaurantUuid = null,
    Object? RestaurantName = null,
    Object? Address = null,
    Object? Tell = null,
    Object? Images = null,
  }) {
    return _then(_value.copyWith(
      RestaurantUuid: null == RestaurantUuid
          ? _value.RestaurantUuid
          : RestaurantUuid // ignore: cast_nullable_to_non_nullable
              as String,
      RestaurantName: null == RestaurantName
          ? _value.RestaurantName
          : RestaurantName // ignore: cast_nullable_to_non_nullable
              as String,
      Address: null == Address
          ? _value.Address
          : Address // ignore: cast_nullable_to_non_nullable
              as String,
      Tell: null == Tell
          ? _value.Tell
          : Tell // ignore: cast_nullable_to_non_nullable
              as String,
      Images: null == Images
          ? _value.Images
          : Images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitedStoreImplCopyWith<$Res>
    implements $VisitedStoreCopyWith<$Res> {
  factory _$$VisitedStoreImplCopyWith(
          _$VisitedStoreImpl value, $Res Function(_$VisitedStoreImpl) then) =
      __$$VisitedStoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String RestaurantUuid,
      String RestaurantName,
      String Address,
      String Tell,
      List<String> Images});
}

/// @nodoc
class __$$VisitedStoreImplCopyWithImpl<$Res>
    extends _$VisitedStoreCopyWithImpl<$Res, _$VisitedStoreImpl>
    implements _$$VisitedStoreImplCopyWith<$Res> {
  __$$VisitedStoreImplCopyWithImpl(
      _$VisitedStoreImpl _value, $Res Function(_$VisitedStoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of VisitedStore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RestaurantUuid = null,
    Object? RestaurantName = null,
    Object? Address = null,
    Object? Tell = null,
    Object? Images = null,
  }) {
    return _then(_$VisitedStoreImpl(
      RestaurantUuid: null == RestaurantUuid
          ? _value.RestaurantUuid
          : RestaurantUuid // ignore: cast_nullable_to_non_nullable
              as String,
      RestaurantName: null == RestaurantName
          ? _value.RestaurantName
          : RestaurantName // ignore: cast_nullable_to_non_nullable
              as String,
      Address: null == Address
          ? _value.Address
          : Address // ignore: cast_nullable_to_non_nullable
              as String,
      Tell: null == Tell
          ? _value.Tell
          : Tell // ignore: cast_nullable_to_non_nullable
              as String,
      Images: null == Images
          ? _value._Images
          : Images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitedStoreImpl implements _VisitedStore {
  const _$VisitedStoreImpl(
      {required this.RestaurantUuid,
      required this.RestaurantName,
      required this.Address,
      required this.Tell,
      required final List<String> Images})
      : _Images = Images;

  factory _$VisitedStoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitedStoreImplFromJson(json);

  @override
  final String RestaurantUuid;
  @override
  final String RestaurantName;
  @override
  final String Address;
  @override
  final String Tell;
  final List<String> _Images;
  @override
  List<String> get Images {
    if (_Images is EqualUnmodifiableListView) return _Images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_Images);
  }

  @override
  String toString() {
    return 'VisitedStore(RestaurantUuid: $RestaurantUuid, RestaurantName: $RestaurantName, Address: $Address, Tell: $Tell, Images: $Images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitedStoreImpl &&
            (identical(other.RestaurantUuid, RestaurantUuid) ||
                other.RestaurantUuid == RestaurantUuid) &&
            (identical(other.RestaurantName, RestaurantName) ||
                other.RestaurantName == RestaurantName) &&
            (identical(other.Address, Address) || other.Address == Address) &&
            (identical(other.Tell, Tell) || other.Tell == Tell) &&
            const DeepCollectionEquality().equals(other._Images, _Images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, RestaurantUuid, RestaurantName,
      Address, Tell, const DeepCollectionEquality().hash(_Images));

  /// Create a copy of VisitedStore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitedStoreImplCopyWith<_$VisitedStoreImpl> get copyWith =>
      __$$VisitedStoreImplCopyWithImpl<_$VisitedStoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitedStoreImplToJson(
      this,
    );
  }
}

abstract class _VisitedStore implements VisitedStore {
  const factory _VisitedStore(
      {required final String RestaurantUuid,
      required final String RestaurantName,
      required final String Address,
      required final String Tell,
      required final List<String> Images}) = _$VisitedStoreImpl;

  factory _VisitedStore.fromJson(Map<String, dynamic> json) =
      _$VisitedStoreImpl.fromJson;

  @override
  String get RestaurantUuid;
  @override
  String get RestaurantName;
  @override
  String get Address;
  @override
  String get Tell;
  @override
  List<String> get Images;

  /// Create a copy of VisitedStore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitedStoreImplCopyWith<_$VisitedStoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
