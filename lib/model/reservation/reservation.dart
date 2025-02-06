import 'package:foodshuffle/utils/datetime_convater.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

@freezed
class Reservation with _$Reservation {
  const factory Reservation(
      {required String RestaurantUuid,
      required String RestaurantName,
      @GlobalDateTimeConverter() required DateTime ReservationDate,
      required int NumberOfPeople,
      // CourseUuid        string
      // CourseName        string
      // CampaignUuid      string
      // CampaignName      string
      // Price             int
      required bool ReservationStatus}) = _Reservation;

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);
}
