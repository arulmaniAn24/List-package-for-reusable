// lib/widgets/data_card_list.dart

import 'package:flutter/material.dart';

import '../models/data_item.dart';

class DataCardList<T> extends StatelessWidget {
  final List<DataItem<T>> data;
  final Widget Function(BuildContext, DataItem<T>) itemBuilder;

  DataCardList({
    Key? key,
    required this.data,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, data[index]);
      },
    );
  }
}
