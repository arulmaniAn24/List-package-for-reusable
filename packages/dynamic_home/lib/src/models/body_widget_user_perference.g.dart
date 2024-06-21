// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_widget_user_perference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyWidgetUserPreference _$BodyWidgetUserPreferenceFromJson(
        Map<String, dynamic> json) =>
    BodyWidgetUserPreference(
      gridView: json['grid_view'] as bool?,
      filter: json['filter'] as List<dynamic>?,
      sortBy: json['sort_by'] as List<dynamic>?,
    );

Map<String, dynamic> _$BodyWidgetUserPreferenceToJson(
        BodyWidgetUserPreference instance) =>
    <String, dynamic>{
      'grid_view': instance.gridView,
      'filter': instance.filter,
      'sort_by': instance.sortBy,
    };
