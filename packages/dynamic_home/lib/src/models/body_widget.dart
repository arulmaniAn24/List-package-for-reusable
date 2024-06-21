import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'body_widget.g.dart';

@immutable
@JsonSerializable()
class BodyWidget extends Equatable {
  final String? type;
  @JsonKey(name: 'field_type')
  final String? fieldType;
  @JsonKey(name: 'field_value')
  final String? fieldValue;
  @JsonKey(name: 'is_read_only')
  final bool? isReadOnly;
  @JsonKey(name: 'default_value')
  final dynamic defaultValue;
  @JsonKey(name: 'option_type')
  final String? optionType;
  final dynamic options;
  @JsonKey(name: 'place_holder')
  final List<PlaceHolder>? placeHolder;
  @JsonKey(name: 'keyboard_type')
  final String? keyboardType;
  @JsonKey(name: 'display_on')
  final dynamic displayOn;
  @JsonKey(name: 'value_restricted')
  final bool? valueRestricted;
  final List<Validation>? validations;
  @JsonKey(name: 'props')
  final BodyWidgetProps? bodyWidgetProps;
  @JsonKey(name: 'user_preference')
  final BodyWidgetUserPreference? userPreference;
  @JsonKey(name: 'fav_flex')
  final int? favFlex;
  final Favorite? favorite;
  @JsonKey(name: 'task_flex')
  final int? taskFlex;
  final Favorite? task;

  const BodyWidget({
    this.type,
    this.fieldType,
    this.fieldValue,
    this.isReadOnly,
    this.defaultValue,
    this.optionType,
    this.options,
    this.placeHolder,
    this.keyboardType,
    this.displayOn,
    this.valueRestricted,
    this.validations,
    this.bodyWidgetProps,
    this.userPreference,
    this.favFlex,
    this.favorite,
    this.taskFlex,
    this.task,
  });

  BodyWidget copyWith({
    String? type,
    String? fieldType,
    String? fieldValue,
    bool? isReadOnly,
    dynamic defaultValue,
    String? optionType,
    dynamic options,
    List<PlaceHolder>? placeHolder,
    String? keyboardType,
    dynamic displayOn,
    bool? valueRestricted,
    List<Validation>? validations,
    BodyWidgetProps? bodyWidgetProps,
    BodyWidgetUserPreference? userPreference,
    int? favFlex,
    Favorite? favorite,
    int? taskFlex,
    Favorite? task,
  }) =>
      BodyWidget(
        type: type ?? this.type,
        fieldType: fieldType ?? this.fieldType,
        fieldValue: fieldValue ?? this.fieldValue,
        isReadOnly: isReadOnly ?? this.isReadOnly,
        defaultValue: defaultValue ?? this.defaultValue,
        optionType: optionType ?? this.optionType,
        options: options ?? this.options,
        placeHolder: placeHolder ?? this.placeHolder,
        keyboardType: keyboardType ?? this.keyboardType,
        displayOn: displayOn ?? this.displayOn,
        valueRestricted: valueRestricted ?? this.valueRestricted,
        validations: validations ?? this.validations,
        bodyWidgetProps: bodyWidgetProps ?? this.bodyWidgetProps,
        userPreference: userPreference ?? this.userPreference,
        favFlex: favFlex ?? this.favFlex,
        favorite: favorite ?? this.favorite,
        taskFlex: taskFlex ?? this.taskFlex,
        task: task ?? this.task,
      );

  factory BodyWidget.fromJson(JsonMap json) =>
      _$BodyWidgetFromJson(json);
  JsonMap toJson() => _$BodyWidgetToJson(this);

  @override
  List<Object?> get props => [
        type,
        fieldType,
        fieldValue,
        isReadOnly,
        defaultValue,
        optionType,
        options,
        placeHolder,
        keyboardType,
        displayOn,
        valueRestricted,
        validations,
        bodyWidgetProps,
        userPreference,
        favFlex,
        favorite,
        taskFlex,
        task
      ];
}
