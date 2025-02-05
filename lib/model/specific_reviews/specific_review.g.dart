// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specific_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpecificReviewImpl _$$SpecificReviewImplFromJson(Map<String, dynamic> json) =>
    _$SpecificReviewImpl(
      ReviewUuid: json['ReviewUuid'] as String,
      Comment: json['Comment'] as String,
      CreatedAt: DateTime.parse(json['CreatedAt'] as String),
      Images:
          (json['Images'] as List<dynamic>).map((e) => e as String).toList(),
      Icon: json['Icon'] as String,
      Good: (json['Good'] as num).toInt(),
      GoodFlag: json['GoodFlag'] as bool,
    );

Map<String, dynamic> _$$SpecificReviewImplToJson(
        _$SpecificReviewImpl instance) =>
    <String, dynamic>{
      'ReviewUuid': instance.ReviewUuid,
      'Comment': instance.Comment,
      'CreatedAt': instance.CreatedAt.toIso8601String(),
      'Images': instance.Images,
      'Icon': instance.Icon,
      'Good': instance.Good,
      'GoodFlag': instance.GoodFlag,
    };
