// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyWidget _$BodyWidgetFromJson(Map<String, dynamic> json) => BodyWidget(
      type: json['type'] as String?,
      fieldType: json['field_type'] as String?,
      fieldValue: json['field_value'] as String?,
      isReadOnly: json['is_read_only'] as bool?,
      defaultValue: json['default_value'],
      optionType: json['option_type'] as String?,
      options: json['options'],
      placeHolder: (json['place_holder'] as List<dynamic>?)
          ?.map((e) => PlaceHolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      keyboardType: json['keyboard_type'] as String?,
      displayOn: json['display_on'],
      valueRestricted: json['value_restricted'] as bool?,
      validations: (json['validations'] as List<dynamic>?)
          ?.map((e) => Validation.fromJson(e as Map<String, dynamic>))
          .toList(),
      bodyWidgetProps: json['props'] == null
          ? null
          : BodyWidgetProps.fromJson(json['props'] as Map<String, dynamic>),
      userPreference: json['user_preference'] == null
          ? null
          : BodyWidgetUserPreference.fromJson(
              json['user_preference'] as Map<String, dynamic>),
      favFlex: (json['fav_flex'] as num?)?.toInt(),
      favorite: json['favorite'] == null
          ? null
          : Favorite.fromJson(json['favorite'] as Map<String, dynamic>),
      taskFlex: (json['task_flex'] as num?)?.toInt(),
      task: json['task'] == null
          ? null
          : Favorite.fromJson(json['task'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BodyWidgetToJson(BodyWidget instance) =>
    <String, dynamic>{
      'type': instance.type,
      'field_type': instance.fieldType,
      'field_value': instance.fieldValue,
      'is_read_only': instance.isReadOnly,
      'default_value': instance.defaultValue,
      'option_type': instance.optionType,
      'options': instance.options,
      'place_holder': instance.placeHolder,
      'keyboard_type': instance.keyboardType,
      'display_on': instance.displayOn,
      'value_restricted': instance.valueRestricted,
      'validations': instance.validations,
      'props': instance.bodyWidgetProps,
      'user_preference': instance.userPreference,
      'fav_flex': instance.favFlex,
      'favorite': instance.favorite,
      'task_flex': instance.taskFlex,
      'task': instance.task,
    };
