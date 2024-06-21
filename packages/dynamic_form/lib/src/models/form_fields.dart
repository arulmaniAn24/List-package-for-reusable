// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dynamic_form/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'form_fields.g.dart';

@immutable
@JsonSerializable()
class FormFields extends Equatable {
  @JsonKey(name: 'field_value')
  final String? fieldValue;
  final List<Label>? labels;
  final String? type;
  @JsonKey(name: 'is_read_only')
  final bool? isReadOnly;
  @JsonKey(name: 'default_value')
  final List<Label>? defaultValue;
  @JsonKey(name: 'option_type')
  final String? optionType;
  final List<Label>? options;
  @JsonKey(name: 'place_holder')
  final List<Label>? placeHolder;
  @JsonKey(name: 'keyboard_type')
  final String? keyboardType;
  @JsonKey(name: 'display_on')
  final List<dynamic>? displayOn;
  @JsonKey(name: 'value_restricted')
  final bool? valueRestricted;
  final List<dynamic>? validations;

  const FormFields({
    this.fieldValue,
    this.labels,
    this.type,
    this.isReadOnly,
    this.defaultValue,
    this.optionType,
    this.options,
    this.placeHolder,
    this.keyboardType,
    this.displayOn,
    this.valueRestricted,
    this.validations,
  });

  FormFields copyWith({
    String? fieldValue,
    List<Label>? labels,
    String? type,
    bool? isReadOnly,
    List<Label>? defaultValue,
    String? optionType,
    List<Label>? options,
    List<Label>? placeHolder,
    String? keyboardType,
    List<dynamic>? displayOn,
    bool? valueRestricted,
    List<dynamic>? validations,
  }) {
    return FormFields(
      fieldValue: fieldValue ?? this.fieldValue,
      labels: labels ?? this.labels,
      type: type ?? this.type,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      defaultValue: defaultValue ?? this.defaultValue,
      optionType: optionType ?? this.optionType,
      options: options ?? this.options,
      placeHolder: placeHolder ?? this.placeHolder,
      keyboardType: keyboardType ?? this.keyboardType,
      displayOn: displayOn ?? this.displayOn,
      valueRestricted: valueRestricted ?? this.valueRestricted,
      validations: validations ?? this.validations,
    );
  }

  /// Deserializes the given [JsonMap] into a [FormFields].
  static FormFields fromJson(JsonMap json) => _$FormFieldsFromJson(json);

  /// Converts this [FormFields] into a [JsonMap].
  JsonMap toJson() => _$FormFieldsToJson(this);

  @override
  List<Object?> get props {
    return [
      fieldValue,
      labels,
      type,
      isReadOnly,
      defaultValue,
      optionType,
      options,
      placeHolder,
      keyboardType,
      displayOn,
      valueRestricted,
      validations,
    ];
  }
}
