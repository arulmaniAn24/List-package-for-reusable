import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'item.g.dart';

@immutable
@JsonSerializable()
class Item extends Equatable {
  final String? type;
  final IconClas? icon;
  final String? label;
  final String? tooltip;
  final dynamic activeIcon;
  final dynamic backgroundColor;
  final String? path;

  const Item({
    this.type,
    this.icon,
    this.label,
    this.tooltip,
    this.activeIcon,
    this.backgroundColor,
    this.path,
  });

  Item copyWith({
    String? type,
    IconClas? icon,
    String? label,
    String? tooltip,
    dynamic activeIcon,
    dynamic backgroundColor,
    String? path,
  }) =>
      Item(
        type: type ?? this.type,
        icon: icon ?? this.icon,
        label: label ?? this.label,
        tooltip: tooltip ?? this.tooltip,
        activeIcon: activeIcon ?? this.activeIcon,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        path: path ?? this.path,
      );

  factory Item.fromJson(JsonMap json) => _$ItemFromJson(json);
  JsonMap toJson() => _$ItemToJson(this);

  @override
  List<Object?> get props =>
      [type, icon, label, tooltip, activeIcon, backgroundColor, path];
}
