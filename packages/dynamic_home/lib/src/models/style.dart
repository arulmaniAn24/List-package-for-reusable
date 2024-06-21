import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'style.g.dart';

@immutable
@JsonSerializable()
class StyleClass extends Equatable {
  final int? fontSize;
  final String? fontWeight;
  final String? color;

  const StyleClass({
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  StyleClass copyWith({
    int? fontSize,
    String? fontWeight,
    String? color,
  }) =>
      StyleClass(
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        color: color ?? this.color,
      );

factory StyleClass.fromJson(JsonMap json) => _$StyleClassFromJson(json);
  JsonMap toJson() => _$StyleClassToJson(this);
  
  @override
  List<Object?> get props => [fontSize, fontWeight, color];
}
