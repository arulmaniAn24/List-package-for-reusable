import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'home_widgets.g.dart';

@immutable
@JsonSerializable()
class HomeWidgets extends Equatable {
  @JsonKey(name: 'field_value')
  final String? fieldValue;
  @JsonKey(name: 'appbar_widget')
  final AppbarWidget? appbarWidget;
  @JsonKey(name: 'body_widget')
  final List<BodyWidget>? bodyWidget;
  @JsonKey(name: 'bottom_navigation')
  final BottomNavigation? bottomNavigation;
  final Menu? menu;

  const HomeWidgets({
    this.fieldValue,
    this.appbarWidget,
    this.bodyWidget,
    this.bottomNavigation,
    this.menu,
  });

  HomeWidgets copyWith({
    String? fieldValue,
    AppbarWidget? appbarWidget,
    List<BodyWidget>? bodyWidget,
    BottomNavigation? bottomNavigation,
    Menu? menu,
  }) =>
      HomeWidgets(
        fieldValue: fieldValue ?? this.fieldValue,
        appbarWidget: appbarWidget ?? this.appbarWidget,
        bodyWidget: bodyWidget ?? this.bodyWidget,
        bottomNavigation: bottomNavigation ?? this.bottomNavigation,
        menu: menu ?? this.menu,
      );

  factory HomeWidgets.fromJson(JsonMap json) => _$HomeWidgetsFromJson(json);
  JsonMap toJson() => _$HomeWidgetsToJson(this);

  @override
  List<Object?> get props =>
      [fieldValue, appbarWidget, bodyWidget, bottomNavigation, menu];
}
