import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/data_bloc.dart';
import '../bloc/data_event.dart';



class DataSearchDelegate<T> extends SearchDelegate<T> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

    @override
Widget buildLeading(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      close(context, _getDefaultResult()); 
    },
  );
}

T _getDefaultResult() {
  throw UnimplementedError('Implement _getDefaultResult() to return a default value of type T');
}


    @override
    Widget buildResults(BuildContext context) {
      
    if (query.isNotEmpty) {
      context.read<DataBloc<T>>().add(SearchEvent(query));
    }
    return Container(); 
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); 
  }
}
