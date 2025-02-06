import 'package:foodshuffle/utils/datetime_convater.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'specific_review.freezed.dart';
part 'specific_review.g.dart';

@freezed
class SpecificReview with _$SpecificReview {
  const factory SpecificReview(
      {required String ReviewUuid,
      required String Comment,
      @GlobalDateTimeConverter() required DateTime CreatedAt,
      required List<String> Images,
      required String Icon,
      required int Good,
      required bool GoodFlag}) = _SpecificReview;

  factory SpecificReview.fromJson(Map<String, dynamic> json) =>
      _$SpecificReviewFromJson(json);
}
