import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_event.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Search',
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    context.read<ListBloc>().add(SearchItems(query: ''));
                    setState(() {}); 
                  },
                ),
        ),
        onChanged: (query) {
          setState(() {}); 
          context.read<ListBloc>().add(SearchItems(query: query));
        },
      ),
    );
  }
}
