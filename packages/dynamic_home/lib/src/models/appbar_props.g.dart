// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appbar_props.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppbarWidgetProps _$AppbarWidgetPropsFromJson(Map<String, dynamic> json) =>
    AppbarWidgetProps(
      backgroundColor: json['backgroundColor'] as String?,
      title: (json['title'] as List<dynamic>?)
          ?.map((e) => PlaceHolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      elevation: (json['elevation'] as num?)?.toInt(),
      centerTitle: json['centerTitle'] as bool?,
      titleSpacing: (json['titleSpacing'] as num?)?.toInt(),
      titleTextStyle: json['titleTextStyle'] == null
          ? null
          : StyleClass.fromJson(json['titleTextStyle'] as Map<String, dynamic>),
      iconTheme: json['iconTheme'] == null
          ? null
          : IconTheme.fromJson(json['iconTheme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppbarWidgetPropsToJson(AppbarWidgetProps instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'title': instance.title,
      'elevation': instance.elevation,
      'centerTitle': instance.centerTitle,
      'titleSpacing': instance.titleSpacing,
      'titleTextStyle': instance.titleTextStyle,
      'iconTheme': instance.iconTheme,
    };
