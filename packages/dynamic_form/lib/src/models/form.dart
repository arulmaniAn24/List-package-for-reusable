// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dynamic_form/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'form.g.dart';

@immutable
@JsonSerializable()
class Form extends Equatable {
  @JsonKey(name: 'field_value')
  final String? fieldValue;
  final List<Label>? labels;
  @JsonKey(name: 'display_on')
  final List<dynamic>? displayOn;
  @JsonKey(name: 'next_form')
  final String? nextForm;
  final int? version;

  const Form({
    this.fieldValue,
    this.labels,
    this.displayOn,
    this.nextForm,
    this.version,
  });

  Form copyWith({
    String? fieldValue,
    List<Label>? labels,
    List<dynamic>? displayOn,
    String? nextForm,
    int? version,
  }) {
    return Form(
      fieldValue: fieldValue ?? this.fieldValue,
      labels: labels ?? this.labels,
      displayOn: displayOn ?? this.displayOn,
      nextForm: nextForm ?? this.nextForm,
      version: version ?? this.version,
    );
  }

  /// Deserializes the given [JsonMap] into a [Form].
  static Form fromJson(JsonMap json) => _$FormFromJson(json);

  /// Converts this [Form] into a [JsonMap].
  JsonMap toJson() => _$FormToJson(this);

  @override
  List<Object?> get props => [
        fieldValue,
        labels,
        displayOn,
        nextForm,
        version,
      ];
}
