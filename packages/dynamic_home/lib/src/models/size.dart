import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'size.g.dart';

@immutable
@JsonSerializable()
class SizeClass extends Equatable {
  final Grid? grid;
  final Grid? list;

  const SizeClass({
    this.grid,
    this.list,
  });

  SizeClass copyWith({
    Grid? grid,
    Grid? list,
  }) =>
      SizeClass(
        grid: grid ?? this.grid,
        list: list ?? this.list,
      );

  factory SizeClass.fromJson(JsonMap json) => _$SizeClassFromJson(json);
  JsonMap toJson() => _$SizeClassToJson(this);

  @override
  List<Object?> get props => [grid, list];
}
