// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urgent_campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UrgentCampaignImpl _$$UrgentCampaignImplFromJson(Map<String, dynamic> json) =>
    _$UrgentCampaignImpl(
      CampaignUuid: json['CampaignUuid'] as String,
      RestaurantUuid: json['RestaurantUuid'] as String,
      StartAt:
          const GlobalDateTimeConverter().fromJson(json['StartAt'] as String),
      EndAt: const GlobalDateTimeConverter().fromJson(json['EndAt'] as String),
      Description: json['Description'] as String,
      DiscountOffer: json['DiscountOffer'] as String,
      CreatedAt:
          const GlobalDateTimeConverter().fromJson(json['CreatedAt'] as String),
    );

Map<String, dynamic> _$$UrgentCampaignImplToJson(
        _$UrgentCampaignImpl instance) =>
    <String, dynamic>{
      'CampaignUuid': instance.CampaignUuid,
      'RestaurantUuid': instance.RestaurantUuid,
      'StartAt': const GlobalDateTimeConverter().toJson(instance.StartAt),
      'EndAt': const GlobalDateTimeConverter().toJson(instance.EndAt),
      'Description': instance.Description,
      'DiscountOffer': instance.DiscountOffer,
      'CreatedAt': const GlobalDateTimeConverter().toJson(instance.CreatedAt),
    };
