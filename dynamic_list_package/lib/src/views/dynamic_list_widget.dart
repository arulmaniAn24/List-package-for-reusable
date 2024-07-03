import 'package:dynamic_list_package/src/widgets/download_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_bloc.dart';
import '../bloc/list_state.dart';
import '../bloc/list_event.dart';
import '../models/list_item.dart';
import '../models/response_model.dart';
import '../services/api_service.dart';
import 'card_view.dart';
import 'table_view.dart';
import '../widgets/search_widget.dart';
import '../widgets/filter_icon_widget.dart';
import '../widgets/sort_icon_widget.dart';
import '../widgets/column_selection_widget.dart';
import '../widgets/view_toggle_button.dart';

class DynamicListWidget extends StatefulWidget {
  final ResponseModel response;

  DynamicListWidget({required this.response});

  @override
  _DynamicListWidgetState createState() => _DynamicListWidgetState();
}

class _DynamicListWidgetState extends State<DynamicListWidget> {
  late bool isTableView;
  List<String> selectedColumns = [];

  @override
  void initState() {
    super.initState();
    isTableView = widget.response.tableSetting.defaultView == 'table';
    selectedColumns = widget.response.tableSetting.columnsToShow;
    context.read<ListBloc>().add(FetchItems(widget.response));
    print('DynamicListWidget initState: isTableView=$isTableView');
  }

  void toggleView() {
    setState(() {
      isTableView = !isTableView;
    });
  }

  void updateColumns(List<String> columns) {
    setState(() {
      selectedColumns = columns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state is ListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListLoaded) {
          if (selectedColumns.isEmpty) {
            selectedColumns = state.columns;
          }
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Dynamic List',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F397A),
                      ),
                    ),
                    const Spacer(),
                    // Expanded(child: SearchWidget()),
                    ColumnSelectionWidget(
                      allColumns: state.columns,
                      onColumnsChanged: updateColumns,
                      initiallySelectedColumns: selectedColumns,
                    ),
                    SortIconWidget(
                      columns: state.columns,
                    ),

                    FilterIconWidget(
                      columns: state.columns,
                    ),
                    const DownloadWidget(),
                    ViewToggleButton(
                      onViewChanged: toggleView,
                      isTableView: isTableView,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: isTableView
                      ? TableView(items: state.items, columns: selectedColumns)
                      : CardView(
                          items: state.items, columnsToShow: selectedColumns),
                ),
              ],
            ),
          );
        } else if (state is ListError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
