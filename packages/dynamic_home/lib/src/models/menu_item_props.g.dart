// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemPropsClass _$MenuItemPropsClassFromJson(Map<String, dynamic> json) =>
    MenuItemPropsClass(
      size: json['size'] == null
          ? null
          : SizeClass.fromJson(json['size'] as Map<String, dynamic>),
      margin: json['margin'] == null
          ? null
          : Margin.fromJson(json['margin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MenuItemPropsClassToJson(MenuItemPropsClass instance) =>
    <String, dynamic>{
      'size': instance.size,
      'margin': instance.margin,
    };
