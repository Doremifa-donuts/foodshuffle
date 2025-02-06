import 'package:freezed_annotation/freezed_annotation.dart';

part 'urgent_campaign.freezed.dart';
part 'urgent_campaign.g.dart';

@freezed
class UrgentCampaign with _$UrgentCampaign {
  const factory UrgentCampaign({
    required String CampaignUuid,
    required String RestaurantUuid,
    required DateTime StartAt,
    required DateTime EndAt,
    required String Description,
    required String DiscountOffer,
    required DateTime CreatedAt,
  }) = _UrgentCampaign;

  factory UrgentCampaign.fromJson(Map<String, dynamic> json) =>
      _$UrgentCampaignFromJson(json);
}
