import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'home.g.dart';

@immutable
@JsonSerializable()
class Home extends Equatable {
  @JsonKey(name: 'field_value')
  final String? fieldValue;
  final String? page;
  final String? path;
  final double? version;

  const Home({
    this.fieldValue,
    this.page,
    this.path,
    this.version,
  });

  Home copyWith({
    String? fieldValue,
    String? page,
    String? path,
    double? version,
  }) {
    return Home(
        fieldValue: fieldValue ?? this.fieldValue,
        page: page ?? this.page,
        path: page ?? this.path,
        version: version ?? this.version);
  }

  factory Home.fromJson(JsonMap json) => _$HomeFromJson(json);
  JsonMap toJson() => _$HomeToJson(this);

  @override
  List<Object?> get props => [fieldValue, page, path];
}
