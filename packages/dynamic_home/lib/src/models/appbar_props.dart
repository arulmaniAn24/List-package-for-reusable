import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'appbar_props.g.dart';

@immutable
@JsonSerializable()
class AppbarWidgetProps extends Equatable {
  final String? backgroundColor;
  final List<PlaceHolder>? title;
  final int? elevation;
  final bool? centerTitle;
  final int? titleSpacing;
  final StyleClass? titleTextStyle;
  final IconTheme? iconTheme;

  const AppbarWidgetProps({
    this.backgroundColor,
    this.title,
    this.elevation,
    this.centerTitle,
    this.titleSpacing,
    this.titleTextStyle,
    this.iconTheme,
  });

  AppbarWidgetProps copyWith({
    String? backgroundColor,
    List<PlaceHolder>? title,
    int? elevation,
    bool? centerTitle,
    int? titleSpacing,
    StyleClass? titleTextStyle,
    IconTheme? iconTheme,
  }) =>
      AppbarWidgetProps(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        title: title ?? this.title,
        elevation: elevation ?? this.elevation,
        centerTitle: centerTitle ?? this.centerTitle,
        titleSpacing: titleSpacing ?? this.titleSpacing,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        iconTheme: iconTheme ?? this.iconTheme,
      );

  factory AppbarWidgetProps.fromJson(JsonMap json) => _$AppbarWidgetPropsFromJson(json);
  JsonMap toJson() => _$AppbarWidgetPropsToJson(this);
  
  @override
  List<Object?> get props => [
        backgroundColor,
        title,
        elevation,
        centerTitle,
        titleSpacing,
        titleTextStyle,
        iconTheme
      ];
}
