import 'package:first_app/table_bloc/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TableUi extends StatefulWidget {

  const TableUi({super.key});

  @override
  State<TableUi> createState() => _TableUiState();
}

class _TableUiState extends State<TableUi> {
  // final List<String> data = ["cell1","cell2","cell3"];
  @override
  void initState(){
    super.initState();
    context.read<TableBloc>().add(TableData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<TableBloc, TableState>(
          listener: (context,state){},
          builder: (context, state){
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
                // border: TableBorder.all(color: Colors.grey),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  ...List.generate(
                      state.data.length, (index) => TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    state.data[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                  )
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
