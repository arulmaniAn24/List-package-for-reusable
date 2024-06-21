import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'action.g.dart';

@immutable
@JsonSerializable()
class ActionClass extends Equatable {
  final String? type;
  @JsonKey(name: 'field_type')
  final String? fieldType;
  @JsonKey(name: 'props')
  final ActionProps? actionProps;
  final List<PlaceHolder>? name;
  final IconClas? icon;
  final String? path;

  const ActionClass({
    this.type,
    this.fieldType,
    this.actionProps,
    this.name,
    this.icon,
    this.path,
  });

  ActionClass copyWith({
    String? type,
    String? fieldType,
    ActionProps? actionProps,
    List<PlaceHolder>? name,
    IconClas? icon,
    String? path,
  }) {
    return ActionClass(
        fieldType: fieldType ?? this.fieldType,
        icon: icon ?? this.icon,
        name: name ?? this.name,
        path: path ?? this.path,
        actionProps: actionProps ?? this.actionProps);
  }

  factory ActionClass.fromJson(JsonMap json) => _$ActionClassFromJson(json);
  JsonMap toJson() => _$ActionClassToJson(this);

  @override
  List<Object?> get props => [type, fieldType, actionProps, name, icon, path];
}
