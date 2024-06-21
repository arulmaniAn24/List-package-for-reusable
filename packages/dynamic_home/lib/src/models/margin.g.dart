// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'margin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Margin _$MarginFromJson(Map<String, dynamic> json) => Margin(
      top: (json['top'] as num?)?.toInt(),
      bottom: (json['bottom'] as num?)?.toInt(),
      left: (json['left'] as num?)?.toInt(),
      right: (json['right'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MarginToJson(Margin instance) => <String, dynamic>{
      'top': instance.top,
      'bottom': instance.bottom,
      'left': instance.left,
      'right': instance.right,
    };
