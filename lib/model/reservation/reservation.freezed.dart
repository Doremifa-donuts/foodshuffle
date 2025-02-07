// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return _Reservation.fromJson(json);
}

/// @nodoc
mixin _$Reservation {
  String get RestaurantUuid => throw _privateConstructorUsedError;
  String get RestaurantName => throw _privateConstructorUsedError;
  @GlobalDateTimeConverter()
  DateTime get ReservationDate => throw _privateConstructorUsedError;
  int get NumberOfPeople =>
      throw _privateConstructorUsedError; // CourseUuid        string
// CourseName        string
// CampaignUuid      string
// CampaignName      string
// Price             int
  bool get ReservationStatus => throw _privateConstructorUsedError;

  /// Serializes this Reservation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
          Reservation value, $Res Function(Reservation) then) =
      _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call(
      {String RestaurantUuid,
      String RestaurantName,
      @GlobalDateTimeConverter() DateTime ReservationDate,
      int NumberOfPeople,
      bool ReservationStatus});
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RestaurantUuid = null,
    Object? RestaurantName = null,
    Object? ReservationDate = null,
    Object? NumberOfPeople = null,
    Object? ReservationStatus = null,
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
      ReservationDate: null == ReservationDate
          ? _value.ReservationDate
          : ReservationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      NumberOfPeople: null == NumberOfPeople
          ? _value.NumberOfPeople
          : NumberOfPeople // ignore: cast_nullable_to_non_nullable
              as int,
      ReservationStatus: null == ReservationStatus
          ? _value.ReservationStatus
          : ReservationStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationImplCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$ReservationImplCopyWith(
          _$ReservationImpl value, $Res Function(_$ReservationImpl) then) =
      __$$ReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String RestaurantUuid,
      String RestaurantName,
      @GlobalDateTimeConverter() DateTime ReservationDate,
      int NumberOfPeople,
      bool ReservationStatus});
}

/// @nodoc
class __$$ReservationImplCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$ReservationImpl>
    implements _$$ReservationImplCopyWith<$Res> {
  __$$ReservationImplCopyWithImpl(
      _$ReservationImpl _value, $Res Function(_$ReservationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RestaurantUuid = null,
    Object? RestaurantName = null,
    Object? ReservationDate = null,
    Object? NumberOfPeople = null,
    Object? ReservationStatus = null,
  }) {
    return _then(_$ReservationImpl(
      RestaurantUuid: null == RestaurantUuid
          ? _value.RestaurantUuid
          : RestaurantUuid // ignore: cast_nullable_to_non_nullable
              as String,
      RestaurantName: null == RestaurantName
          ? _value.RestaurantName
          : RestaurantName // ignore: cast_nullable_to_non_nullable
              as String,
      ReservationDate: null == ReservationDate
          ? _value.ReservationDate
          : ReservationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      NumberOfPeople: null == NumberOfPeople
          ? _value.NumberOfPeople
          : NumberOfPeople // ignore: cast_nullable_to_non_nullable
              as int,
      ReservationStatus: null == ReservationStatus
          ? _value.ReservationStatus
          : ReservationStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationImpl implements _Reservation {
  const _$ReservationImpl(
      {required this.RestaurantUuid,
      required this.RestaurantName,
      @GlobalDateTimeConverter() required this.ReservationDate,
      required this.NumberOfPeople,
      required this.ReservationStatus});

  factory _$ReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationImplFromJson(json);

  @override
  final String RestaurantUuid;
  @override
  final String RestaurantName;
  @override
  @GlobalDateTimeConverter()
  final DateTime ReservationDate;
  @override
  final int NumberOfPeople;
// CourseUuid        string
// CourseName        string
// CampaignUuid      string
// CampaignName      string
// Price             int
  @override
  final bool ReservationStatus;

  @override
  String toString() {
    return 'Reservation(RestaurantUuid: $RestaurantUuid, RestaurantName: $RestaurantName, ReservationDate: $ReservationDate, NumberOfPeople: $NumberOfPeople, ReservationStatus: $ReservationStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationImpl &&
            (identical(other.RestaurantUuid, RestaurantUuid) ||
                other.RestaurantUuid == RestaurantUuid) &&
            (identical(other.RestaurantName, RestaurantName) ||
                other.RestaurantName == RestaurantName) &&
            (identical(other.ReservationDate, ReservationDate) ||
                other.ReservationDate == ReservationDate) &&
            (identical(other.NumberOfPeople, NumberOfPeople) ||
                other.NumberOfPeople == NumberOfPeople) &&
            (identical(other.ReservationStatus, ReservationStatus) ||
                other.ReservationStatus == ReservationStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, RestaurantUuid, RestaurantName,
      ReservationDate, NumberOfPeople, ReservationStatus);

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      __$$ReservationImplCopyWithImpl<_$ReservationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationImplToJson(
      this,
    );
  }
}

abstract class _Reservation implements Reservation {
  const factory _Reservation(
      {required final String RestaurantUuid,
      required final String RestaurantName,
      @GlobalDateTimeConverter() required final DateTime ReservationDate,
      required final int NumberOfPeople,
      required final bool ReservationStatus}) = _$ReservationImpl;

  factory _Reservation.fromJson(Map<String, dynamic> json) =
      _$ReservationImpl.fromJson;

  @override
  String get RestaurantUuid;
  @override
  String get RestaurantName;
  @override
  @GlobalDateTimeConverter()
  DateTime get ReservationDate;
  @override
  int get NumberOfPeople; // CourseUuid        string
// CourseName        string
// CampaignUuid      string
// CampaignName      string
// Price             int
  @override
  bool get ReservationStatus;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
