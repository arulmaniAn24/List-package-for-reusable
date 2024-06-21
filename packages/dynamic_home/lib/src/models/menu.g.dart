// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      type: json['type'] as String?,
      fieldType: json['field_type'] as String?,
      fieldValue: json['field_value'] as String?,
      bodyWidgetProps: json['props'] == null
          ? null
          : BodyWidgetProps.fromJson(json['props'] as Map<String, dynamic>),
      userPreference: json['user_preference'] == null
          ? null
          : MenuUserPreference.fromJson(
              json['user_preference'] as Map<String, dynamic>),
      menuItemProps: json['menu_item_props'] == null
          ? null
          : MenuItemPropsClass.fromJson(
              json['menu_item_props'] as Map<String, dynamic>),
      menuList: (json['menu_list'] as List<dynamic>?)
          ?.map((e) => MenuList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'type': instance.type,
      'field_type': instance.fieldType,
      'field_value': instance.fieldValue,
      'props': instance.bodyWidgetProps,
      'user_preference': instance.userPreference,
      'menu_item_props': instance.menuItemProps,
      'menu_list': instance.menuList,
    };
