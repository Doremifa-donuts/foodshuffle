// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewCardImpl _$$ReviewCardImplFromJson(Map<String, dynamic> json) =>
    _$ReviewCardImpl(
      RestaurantUuid: json['RestaurantUuid'] as String,
      RestaurantName: json['RestaurantName'] as String,
      ReviewUuid: json['ReviewUuid'] as String,
      Comment: json['Comment'] as String,
      CreatedAt: DateTime.parse(json['CreatedAt'] as String),
      Images:
          (json['Images'] as List<dynamic>).map((e) => e as String).toList(),
      Icon: json['Icon'] as String,
      Good: (json['Good'] as num).toInt(),
      Address: json['Address'] as String,
      Geolocation: (json['Geolocation'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$ReviewCardImplToJson(_$ReviewCardImpl instance) =>
    <String, dynamic>{
      'RestaurantUuid': instance.RestaurantUuid,
      'RestaurantName': instance.RestaurantName,
      'ReviewUuid': instance.ReviewUuid,
      'Comment': instance.Comment,
      'CreatedAt': instance.CreatedAt.toIso8601String(),
      'Images': instance.Images,
      'Icon': instance.Icon,
      'Good': instance.Good,
      'Address': instance.Address,
      'Geolocation': instance.Geolocation,
    };
