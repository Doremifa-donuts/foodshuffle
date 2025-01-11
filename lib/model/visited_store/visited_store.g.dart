// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visited_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitedStoreImpl _$$VisitedStoreImplFromJson(Map<String, dynamic> json) =>
    _$VisitedStoreImpl(
      RestaurantUuid: json['RestaurantUuid'] as String,
      RestaurantName: json['RestaurantName'] as String,
      Address: json['Address'] as String,
      Tell: json['Tell'] as String,
      Images:
          (json['Images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$VisitedStoreImplToJson(_$VisitedStoreImpl instance) =>
    <String, dynamic>{
      'RestaurantUuid': instance.RestaurantUuid,
      'RestaurantName': instance.RestaurantName,
      'Address': instance.Address,
      'Tell': instance.Tell,
      'Images': instance.Images,
    };
