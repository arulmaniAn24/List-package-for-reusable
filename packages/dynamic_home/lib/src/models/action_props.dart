import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'action_props.g.dart';

@immutable
@JsonSerializable()
class ActionProps extends Equatable {
  final String? alignment;
  final Margin? padding;
  final Margin? position;
  final Margin? margin;

  const ActionProps({
    this.alignment,
    this.padding,
    this.position,
    this.margin,
  });

  ActionProps copyWith({
    String? alignment,
    Margin? padding,
    Margin? position,
    Margin? margin,
  }) {
    return ActionProps(
        alignment: alignment ?? this.alignment, margin: margin ?? this.margin);
  }

  factory ActionProps.fromJson(JsonMap json) => _$ActionPropsFromJson(json);
  JsonMap toJson() => _$ActionPropsToJson(this);

  @override
  List<Object?> get props => [alignment, padding, position, margin];
}
