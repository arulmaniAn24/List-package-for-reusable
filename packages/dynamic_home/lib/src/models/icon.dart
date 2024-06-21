import 'package:dynamic_home/dynamic_home.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'icon.g.dart';

@immutable
@JsonSerializable()
class IconClas extends Equatable {
  final String? package;
  @JsonKey(name: 'icon_name')
  final String? iconName;

  const IconClas({
    this.package,
    this.iconName,
  });

  IconClas copyWith({
    String? package,
    String? iconName,
  }) =>
      IconClas(
        package: package ?? this.package,
        iconName: iconName ?? this.iconName,
      );

  factory IconClas.fromJson(JsonMap json) => _$IconClasFromJson(json);
  JsonMap toJson() => _$IconClasToJson(this);

  @override
  List<Object?> get props => [package, iconName];
}
