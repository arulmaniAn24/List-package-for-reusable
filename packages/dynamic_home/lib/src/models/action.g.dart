// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionClass _$ActionClassFromJson(Map<String, dynamic> json) => ActionClass(
      type: json['type'] as String?,
      fieldType: json['field_type'] as String?,
      actionProps: json['props'] == null
          ? null
          : ActionProps.fromJson(json['props'] as Map<String, dynamic>),
      name: json['name'] as String?,
      icon: json['icon'] == null
          ? null
          : IconClas.fromJson(json['icon'] as Map<String, dynamic>),
      path: json['path'] as String?,
    );

Map<String, dynamic> _$ActionClassToJson(ActionClass instance) =>
    <String, dynamic>{
      'type': instance.type,
      'field_type': instance.fieldType,
      'props': instance.actionProps,
      'name': instance.name,
      'icon': instance.icon,
      'path': instance.path,
    };
