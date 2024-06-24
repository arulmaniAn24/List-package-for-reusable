import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_event.dart';



class FilterIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {
        // Implement filter logic here
      },
    );
  }
}
