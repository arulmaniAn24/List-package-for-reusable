// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dynamic_form/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'json_form_data.g.dart';

@immutable
@JsonSerializable()
class JsonFormData extends Equatable {
  final Form? form;
  @JsonKey(name: 'form_fields')
  final List<FormFields>? formData;

  const JsonFormData({
    this.form,
    this.formData,
  });

  JsonFormData copyWith({
    Form? form,
    List<FormFields>? formData,
  }) {
    return JsonFormData(
      form: form ?? this.form,
      formData: formData ?? this.formData,
    );
  }

  /// Deserializes the given [JsonMap] into a [JsonFormData].
  static JsonFormData fromJson(JsonMap json) => _$JsonFormDataFromJson(json);

  /// Converts this [JsonFormData] into a [JsonMap].
  JsonMap toJson() => _$JsonFormDataToJson(this);

  @override
  List<Object?> get props => [form, formData];
}
