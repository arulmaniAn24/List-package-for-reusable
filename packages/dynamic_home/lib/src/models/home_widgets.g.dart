// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widgets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeWidgets _$HomeWidgetsFromJson(Map<String, dynamic> json) => HomeWidgets(
      fieldValue: json['field_value'] as String?,
      appbarWidget: json['appbar_widget'] == null
          ? null
          : AppbarWidget.fromJson(
              json['appbar_widget'] as Map<String, dynamic>),
      bodyWidget: (json['body_widget'] as List<dynamic>?)
          ?.map((e) => BodyWidget.fromJson(e as Map<String, dynamic>))
          .toList(),
      bottomNavigation: json['bottom_navigation'] == null
          ? null
          : BottomNavigation.fromJson(
              json['bottom_navigation'] as Map<String, dynamic>),
      menu: json['menu'] == null
          ? null
          : Menu.fromJson(json['menu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeWidgetsToJson(HomeWidgets instance) =>
    <String, dynamic>{
      'field_value': instance.fieldValue,
      'appbar_widget': instance.appbarWidget,
      'body_widget': instance.bodyWidget,
      'bottom_navigation': instance.bottomNavigation,
      'menu': instance.menu,
    };
