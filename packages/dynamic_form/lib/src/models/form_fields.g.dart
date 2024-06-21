// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFields _$FormFieldsFromJson(Map<String, dynamic> json) => FormFields(
      fieldValue: json['field_value'] as String?,
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      isReadOnly: json['is_read_only'] as bool?,
      defaultValue: (json['default_value'] as List<dynamic>?)
          ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
          .toList(),
      optionType: json['option_type'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeHolder: (json['place_holder'] as List<dynamic>?)
          ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
          .toList(),
      keyboardType: json['keyboard_type'] as String?,
      displayOn: json['display_on'] as List<dynamic>?,
      valueRestricted: json['value_restricted'] as bool?,
      validations: json['validations'] as List<dynamic>?,
    );

Map<String, dynamic> _$FormFieldsToJson(FormFields instance) =>
    <String, dynamic>{
      'field_value': instance.fieldValue,
      'labels': instance.labels,
      'type': instance.type,
      'is_read_only': instance.isReadOnly,
      'default_value': instance.defaultValue,
      'option_type': instance.optionType,
      'options': instance.options,
      'place_holder': instance.placeHolder,
      'keyboard_type': instance.keyboardType,
      'display_on': instance.displayOn,
      'value_restricted': instance.valueRestricted,
      'validations': instance.validations,
    };
