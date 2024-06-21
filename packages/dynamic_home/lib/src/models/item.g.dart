// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      type: json['type'] as String?,
      icon: json['icon'] == null
          ? null
          : IconClas.fromJson(json['icon'] as Map<String, dynamic>),
      label: (json['label'] as List<dynamic>?)
          ?.map((e) => PlaceHolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      tooltip: (json['tooltip'] as List<dynamic>?)
          ?.map((e) => PlaceHolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeIcon: json['activeIcon'],
      backgroundColor: json['backgroundColor'],
      path: json['path'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'type': instance.type,
      'icon': instance.icon,
      'label': instance.label,
      'tooltip': instance.tooltip,
      'activeIcon': instance.activeIcon,
      'backgroundColor': instance.backgroundColor,
      'path': instance.path,
    };
