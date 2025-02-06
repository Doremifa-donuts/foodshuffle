import 'package:freezed_annotation/freezed_annotation.dart';

class GlobalDateTimeConverter extends JsonConverter<DateTime, String> {
  const GlobalDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal();

  @override
  String toJson(DateTime object) => object.toIso8601String();
}
