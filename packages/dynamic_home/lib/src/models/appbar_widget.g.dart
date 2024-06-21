// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appbar_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppbarWidget _$AppbarWidgetFromJson(Map<String, dynamic> json) => AppbarWidget(
      type: json['type'] as String?,
      actionProps: json['props'] == null
          ? null
          : AppbarWidgetProps.fromJson(json['props'] as Map<String, dynamic>),
      leading: (json['leading'] as List<dynamic>?)
          ?.map((e) => ActionClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => ActionClass.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppbarWidgetToJson(AppbarWidget instance) =>
    <String, dynamic>{
      'type': instance.type,
      'props': instance.actionProps,
      'leading': instance.leading,
      'actions': instance.actions,
    };
