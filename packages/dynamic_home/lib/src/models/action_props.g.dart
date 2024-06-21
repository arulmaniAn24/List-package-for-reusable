// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionProps _$ActionPropsFromJson(Map<String, dynamic> json) => ActionProps(
      alignment: json['alignment'] as String?,
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

Map<String, dynamic> _$ActionPropsToJson(ActionProps instance) =>
    <String, dynamic>{
      'alignment': instance.alignment,
      'padding': instance.padding,
      'position': instance.position,
      'margin': instance.margin,
    };
