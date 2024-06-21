// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
      fieldType: json['field_type'] as String?,
      fieldValue: json['field_value'] as String?,
      menuItemProps: json['props'] == null
          ? null
          : MenuItemPropsClass.fromJson(json['props'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'field_type': instance.fieldType,
      'field_value': instance.fieldValue,
      'props': instance.menuItemProps,
    };
