import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'validation.g.dart';

@immutable
@JsonSerializable()
class Validation extends Equatable {
  final bool? mandatory;

  const Validation({
    this.mandatory,
  });

  Validation copyWith({
    bool? mandatory,
  }) =>
      Validation(
        mandatory: mandatory ?? this.mandatory,
      );

  factory Validation.fromJson(JsonMap json) => _$ValidationFromJson(json);
  JsonMap toJson() => _$ValidationToJson(this);

  @override
  List<Object?> get props => [mandatory];
}
