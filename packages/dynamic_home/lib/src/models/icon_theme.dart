import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'icon_theme.g.dart';

@immutable
@JsonSerializable()
class IconTheme extends Equatable {
  final String? color;
  final int? size;

  const IconTheme({
    this.color,
    this.size,
  });

  IconTheme copyWith({
    String? color,
    int? size,
  }) =>
      IconTheme(
        color: color ?? this.color,
        size: size ?? this.size,
      );

  factory IconTheme.fromJson(JsonMap json) => _$IconThemeFromJson(json);
  JsonMap toJson() => _$IconThemeToJson(this);

  @override
  List<Object?> get props => [color, size];
}
