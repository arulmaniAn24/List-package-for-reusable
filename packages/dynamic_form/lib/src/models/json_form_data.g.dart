// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonFormData _$JsonFormDataFromJson(Map<String, dynamic> json) => JsonFormData(
      form: json['form'] == null
          ? null
          : Form.fromJson(json['form'] as Map<String, dynamic>),
      formData: (json['form_fields'] as List<dynamic>?)
          ?.map((e) => FormFields.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonFormDataToJson(JsonFormData instance) =>
    <String, dynamic>{
      'form': instance.form,
      'form_fields': instance.formData,
    };
