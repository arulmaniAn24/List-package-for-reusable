import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'favorite.g.dart';

@immutable
@JsonSerializable()
class Favorite extends Equatable {
  @JsonKey(name: 'field_type')
  final String? fieldType;
  @JsonKey(name: 'field_value')
  final String? fieldValue;
  @JsonKey(name: 'props')
  final MenuItemPropsClass? menuItemProps;

  const Favorite({
    this.fieldType,
    this.fieldValue,
    this.menuItemProps,
  });

  Favorite copyWith({
    String? fieldType,
    String? fieldValue,
    MenuItemPropsClass? menuItemProps,
  }) =>
      Favorite(
        fieldType: fieldType ?? this.fieldType,
        fieldValue: fieldValue ?? this.fieldValue,
        menuItemProps: menuItemProps ?? this.menuItemProps,
      );
      
  factory Favorite.fromJson(JsonMap json) =>
      _$FavoriteFromJson(json);
  JsonMap toJson() => _$FavoriteToJson(this);

  @override
  List<Object?> get props => [fieldType, fieldValue, menuItemProps];
}
