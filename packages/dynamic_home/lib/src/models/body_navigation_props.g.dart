// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_navigation_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BottomNavigationProps _$BottomNavigationPropsFromJson(
        Map<String, dynamic> json) =>
    BottomNavigationProps(
      backgroundColor: json['backgroundColor'] as String?,
      currentIndex: (json['currentIndex'] as num?)?.toInt(),
      elevation: (json['elevation'] as num?)?.toInt(),
      iconSize: (json['iconSize'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedFontSize: (json['selectedFontSize'] as num?)?.toInt(),
      selectedIconTheme: json['selectedIconTheme'] == null
          ? null
          : IconTheme.fromJson(
              json['selectedIconTheme'] as Map<String, dynamic>),
      selectedItemColor: json['selectedItemColor'] as String?,
      selectedLabelStyle: json['selectedLabelStyle'] == null
          ? null
          : StyleClass.fromJson(
              json['selectedLabelStyle'] as Map<String, dynamic>),
      showSelectedLabels: json['showSelectedLabels'] as bool?,
      showUnselectedLabels: json['showUnselectedLabels'] as bool?,
      unselectedFontSize: (json['unselectedFontSize'] as num?)?.toInt(),
      unselectedIconTheme: json['unselectedIconTheme'] == null
          ? null
          : IconTheme.fromJson(
              json['unselectedIconTheme'] as Map<String, dynamic>),
      unselectedItemColor: json['unselectedItemColor'] as String?,
      unselectedLabelStyle: json['unselectedLabelStyle'] == null
          ? null
          : StyleClass.fromJson(
              json['unselectedLabelStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BottomNavigationPropsToJson(
        BottomNavigationProps instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'currentIndex': instance.currentIndex,
      'elevation': instance.elevation,
      'iconSize': instance.iconSize,
      'items': instance.items,
      'selectedFontSize': instance.selectedFontSize,
      'selectedIconTheme': instance.selectedIconTheme,
      'selectedItemColor': instance.selectedItemColor,
      'selectedLabelStyle': instance.selectedLabelStyle,
      'showSelectedLabels': instance.showSelectedLabels,
      'showUnselectedLabels': instance.showUnselectedLabels,
      'unselectedFontSize': instance.unselectedFontSize,
      'unselectedIconTheme': instance.unselectedIconTheme,
      'unselectedItemColor': instance.unselectedItemColor,
      'unselectedLabelStyle': instance.unselectedLabelStyle,
    };
