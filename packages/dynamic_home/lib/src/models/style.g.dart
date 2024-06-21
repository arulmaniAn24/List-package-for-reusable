// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleClass _$StyleClassFromJson(Map<String, dynamic> json) => StyleClass(
      fontSize: (json['fontSize'] as num?)?.toInt(),
      fontWeight: json['fontWeight'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$StyleClassToJson(StyleClass instance) =>
    <String, dynamic>{
      'fontSize': instance.fontSize,
      'fontWeight': instance.fontWeight,
      'color': instance.color,
    };
