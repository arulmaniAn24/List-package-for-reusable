// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_widget_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyWidgetProps _$BodyWidgetPropsFromJson(Map<String, dynamic> json) =>
    BodyWidgetProps(
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      padding: json['padding'] == null
          ? null
          : Margin.fromJson(json['padding'] as Map<String, dynamic>),
      position: json['position'] == null
          ? null
          : Margin.fromJson(json['position'] as Map<String, dynamic>),
      margin: json['margin'] == null
          ? null
          : Margin.fromJson(json['margin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BodyWidgetPropsToJson(BodyWidgetProps instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'padding': instance.padding,
      'position': instance.position,
      'margin': instance.margin,
    };
