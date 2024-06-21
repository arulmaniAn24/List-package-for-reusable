import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'menu.g.dart';

@immutable
@JsonSerializable()
class Menu extends Equatable {
  final String? type;
  @JsonKey(name: 'field_type')
  final String? fieldType;
  @JsonKey(name: 'field_value')
  final String? fieldValue;
  @JsonKey(name: 'props')
  final BodyWidgetProps? bodyWidgetProps;
  @JsonKey(name: 'user_preference')
  final MenuUserPreference? userPreference;
  @JsonKey(name: 'menu_item_props')
  final MenuItemPropsClass? menuItemProps;
  @JsonKey(name: 'menu_list')
  final List<MenuList>? menuList;

  const Menu({
    this.type,
    this.fieldType,
    this.fieldValue,
    this.bodyWidgetProps,
    this.userPreference,
    this.menuItemProps,
    this.menuList,
  });

  Menu copyWith({
    String? type,
    String? fieldType,
    String? fieldValue,
    BodyWidgetProps? bodyWidgetProps,
    MenuUserPreference? userPreference,
    MenuItemPropsClass? menuItemProps,
    List<MenuList>? menuList,
  }) =>
      Menu(
        type: type ?? this.type,
        fieldType: fieldType ?? this.fieldType,
        fieldValue: fieldValue ?? this.fieldValue,
        bodyWidgetProps: bodyWidgetProps ?? this.bodyWidgetProps,
        userPreference: userPreference ?? this.userPreference,
        menuItemProps: menuItemProps ?? this.menuItemProps,
        menuList: menuList ?? this.menuList,
      );

  factory Menu.fromJson(JsonMap json) => _$MenuFromJson(json);
  JsonMap toJson() => _$MenuToJson(this);

  @override
  List<Object?> get props => [
        type,
        fieldType,
        fieldValue,
        bodyWidgetProps,
        userPreference,
        menuItemProps,
        menuList
      ];
}
