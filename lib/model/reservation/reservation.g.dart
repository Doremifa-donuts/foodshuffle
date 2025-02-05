// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationImpl _$$ReservationImplFromJson(Map<String, dynamic> json) =>
    _$ReservationImpl(
      RestaurantUuid: json['RestaurantUuid'] as String,
      RestaurantName: json['RestaurantName'] as String,
      ReservationDate: DateTime.parse(json['ReservationDate'] as String),
      NumberOfPeople: (json['NumberOfPeople'] as num).toInt(),
      ReservationStatus: json['ReservationStatus'] as bool,
    );

Map<String, dynamic> _$$ReservationImplToJson(_$ReservationImpl instance) =>
    <String, dynamic>{
      'RestaurantUuid': instance.RestaurantUuid,
      'RestaurantName': instance.RestaurantName,
      'ReservationDate': instance.ReservationDate.toIso8601String(),
      'NumberOfPeople': instance.NumberOfPeople,
      'ReservationStatus': instance.ReservationStatus,
    };
