import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'menu_user_preference.g.dart';

@immutable
@JsonSerializable()
class MenuUserPreference extends Equatable {
  final bool? gridView;

  const MenuUserPreference({
    this.gridView,
  });

  MenuUserPreference copyWith({
    bool? gridView,
  }) =>
      MenuUserPreference(
        gridView: gridView ?? this.gridView,
      );

  factory MenuUserPreference.fromJson(JsonMap json) => _$MenuUserPreferenceFromJson(json);
  JsonMap toJson() => _$MenuUserPreferenceToJson(this);

  @override
  List<Object?> get props => [gridView];
}
