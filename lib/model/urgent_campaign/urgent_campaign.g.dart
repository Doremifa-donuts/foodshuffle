// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urgent_campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UrgentCampaignImpl _$$UrgentCampaignImplFromJson(Map<String, dynamic> json) =>
    _$UrgentCampaignImpl(
      CampaignUuid: json['CampaignUuid'] as String,
      RestaurantUuid: json['RestaurantUuid'] as String,
      StartAt: DateTime.parse(json['StartAt'] as String),
      EndAt: DateTime.parse(json['EndAt'] as String),
      Description: json['Description'] as String,
      DiscountOffer: json['DiscountOffer'] as String,
      CreatedAt: DateTime.parse(json['CreatedAt'] as String),
    );

Map<String, dynamic> _$$UrgentCampaignImplToJson(
        _$UrgentCampaignImpl instance) =>
    <String, dynamic>{
      'CampaignUuid': instance.CampaignUuid,
      'RestaurantUuid': instance.RestaurantUuid,
      'StartAt': instance.StartAt.toIso8601String(),
      'EndAt': instance.EndAt.toIso8601String(),
      'Description': instance.Description,
      'DiscountOffer': instance.DiscountOffer,
      'CreatedAt': instance.CreatedAt.toIso8601String(),
    };
