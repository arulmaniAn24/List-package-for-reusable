import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'appbar_widget.g.dart';

@immutable
@JsonSerializable()
class AppbarWidget extends Equatable {
  final String? type;
  @JsonKey(name: 'props')
  final AppbarWidgetProps? actionProps;
  final ActionClass? leading;
  final List<ActionClass>? actions;

  const AppbarWidget({
    this.type,
    this.actionProps,
    this.leading,
    this.actions,
  });

  AppbarWidget copyWith({
    String? type,
    AppbarWidgetProps? actionProps,
    ActionClass? leading,
    List<ActionClass>? actions,
  }) =>
      AppbarWidget(
        type: type ?? this.type,
        actionProps: actionProps ?? this.actionProps,
        leading: leading ?? this.leading,
        actions: actions ?? this.actions,
      );
  factory AppbarWidget.fromJson(JsonMap json) =>
      _$AppbarWidgetFromJson(json);
  JsonMap toJson() => _$AppbarWidgetToJson(this);
  @override
  List<Object?> get props => [type, actionProps, leading, actions];
}
