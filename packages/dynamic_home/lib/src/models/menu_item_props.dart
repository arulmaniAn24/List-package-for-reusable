import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'menu_item_props.g.dart';

@immutable
@JsonSerializable()
class MenuItemPropsClass extends Equatable {
  final SizeClass? size;
  final Margin? margin;

  const MenuItemPropsClass({
    this.size,
    this.margin,
  });

  MenuItemPropsClass copyWith({
    SizeClass? size,
    Margin? margin,
  }) =>
      MenuItemPropsClass(
        size: size ?? this.size,
        margin: margin ?? this.margin,
      );

  factory MenuItemPropsClass.fromJson(JsonMap json) => _$MenuItemPropsClassFromJson(json);
  JsonMap toJson() => _$MenuItemPropsClassToJson(this);

  @override
  List<Object?> get props => [size, margin];
}
