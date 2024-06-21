// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeClass _$SizeClassFromJson(Map<String, dynamic> json) => SizeClass(
      grid: json['grid'] == null
          ? null
          : Grid.fromJson(json['grid'] as Map<String, dynamic>),
      list: json['list'] == null
          ? null
          : Grid.fromJson(json['list'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SizeClassToJson(SizeClass instance) => <String, dynamic>{
      'grid': instance.grid,
      'list': instance.list,
    };
