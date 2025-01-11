import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_card.freezed.dart';
part 'review_card.g.dart';

@freezed
class ReviewCard with _$ReviewCard {
  const factory ReviewCard({
    required String RestaurantUuid,
    required String RestaurantName,
    required String ReviewUuid,
    required String Comment,
    required DateTime CreatedAt,
    required List<String> Images,
    required String Icon,
    required int Good,
    required String Address,
    required Map<String, double> Geolocation,
  }) = _ReviewCard;

  factory ReviewCard.fromJson(Map<String, dynamic> json) =>
      _$ReviewCardFromJson(json);
}
