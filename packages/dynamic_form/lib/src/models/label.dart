// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dynamic_form/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'label.g.dart';

@immutable
@JsonSerializable()
class Label extends Equatable {
  final String? language;
  final String? key;
  final String? value;

  const Label({
    this.language,
    this.key,
    this.value,
  });

  Label copyWith({
    String? language,
    String? key,
    String? value,
  }) {
    return Label(
      language: language ?? this.language,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  /// Deserializes the given [JsonMap] into a [Label].
  static Label fromJson(JsonMap json) => _$LabelFromJson(json);

  /// Converts this [Label] into a [JsonMap].
  JsonMap toJson() => _$LabelToJson(this);

  @override
  List<Object?> get props => [language, key, value];
}
