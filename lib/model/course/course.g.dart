// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      CourseUuid: json['CourseUuid'] as String,
      RestaurantUuid: json['RestaurantUuid'] as String,
      CourseName: json['CourseName'] as String,
      Discription: json['Discription'] as String,
      Images:
          (json['Images'] as List<dynamic>).map((e) => e as String).toList(),
      Price: (json['Price'] as num).toInt(),
      Minimum: (json['Minimum'] as num).toInt(),
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'CourseUuid': instance.CourseUuid,
      'RestaurantUuid': instance.RestaurantUuid,
      'CourseName': instance.CourseName,
      'Discription': instance.Discription,
      'Images': instance.Images,
      'Price': instance.Price,
      'Minimum': instance.Minimum,
    };
