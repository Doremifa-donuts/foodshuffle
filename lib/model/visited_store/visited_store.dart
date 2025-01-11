import 'package:freezed_annotation/freezed_annotation.dart';

part 'visited_store.freezed.dart';
part 'visited_store.g.dart';


@freezed
class VisitedStore with _$VisitedStore {
  const factory VisitedStore({
    required String RestaurantUuid,
    required String RestaurantName,
    required String Address,
    required String Tell,
    required List<String> Images,
  }) = _VisitedStore;
  factory VisitedStore.fromJson(Map<String, dynamic> json) =>
      _$VisitedStoreFromJson(json);
}
