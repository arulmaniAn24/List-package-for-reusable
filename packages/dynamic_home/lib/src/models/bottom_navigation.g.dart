// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_navigation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BottomNavigation _$BottomNavigationFromJson(Map<String, dynamic> json) =>
    BottomNavigation(
      type: json['type'] as String?,
      bottomNavigationProps: json['props'] == null
          ? null
          : BottomNavigationProps.fromJson(
              json['props'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BottomNavigationToJson(BottomNavigation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'props': instance.bottomNavigationProps,
    };
