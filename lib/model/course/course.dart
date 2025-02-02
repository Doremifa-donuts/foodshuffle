import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const factory Course({
    required String CourseUuid,
    required String RestaurantUuid,
    required String CourseName,
    required String Discription,
    required List<String> Images,
    required int Price,
    required int Minimum,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
