// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Form _$FormFromJson(Map<String, dynamic> json) => Form(
      fieldValue: json['field_value'] as String?,
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
          .toList(),
      displayOn: json['display_on'] as List<dynamic>?,
      nextForm: json['next_form'] as String?,
      version: (json['version'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FormToJson(Form instance) => <String, dynamic>{
      'field_value': instance.fieldValue,
      'labels': instance.labels,
      'display_on': instance.displayOn,
      'next_form': instance.nextForm,
      'version': instance.version,
    };
