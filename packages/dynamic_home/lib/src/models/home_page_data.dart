import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'models.dart';

part 'home_page_data.g.dart';

@immutable
@JsonSerializable()
class HomePageData extends Equatable {
  final Home? home;
  @JsonKey(name: 'home_widgets')
  final HomeWidgets? homeWidgets;

  const HomePageData({
    this.home,
    this.homeWidgets,
  });

  HomePageData copyWith({
    Home? home,
    HomeWidgets? homeWidgets,
  }) =>
      HomePageData(
        home: home ?? this.home,
        homeWidgets: homeWidgets ?? this.homeWidgets,
      );
  factory HomePageData.fromJson(JsonMap json) => _$HomePageDataFromJson(json);
  JsonMap toJson() => _$HomePageDataToJson(this);
  
  @override
  List<Object?> get props => [home, homeWidgets];
}
