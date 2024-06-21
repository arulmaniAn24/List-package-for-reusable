// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageData _$HomePageDataFromJson(Map<String, dynamic> json) => HomePageData(
      home: json['home'] == null
          ? null
          : Home.fromJson(json['home'] as Map<String, dynamic>),
      homeWidgets: json['home_widgets'] == null
          ? null
          : HomeWidgets.fromJson(json['home_widgets'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomePageDataToJson(HomePageData instance) =>
    <String, dynamic>{
      'home': instance.home,
      'home_widgets': instance.homeWidgets,
    };
