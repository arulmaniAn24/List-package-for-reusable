import 'dart:convert';
import 'dart:io';
import 'package:first_app/tabledata/usersdata_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/table_bloc/table_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;


class TableDataUi extends StatefulWidget {
  const TableDataUi({super.key});

  @override
  State<TableDataUi> createState() => _TableDataUiState();
}

class _TableDataUiState extends State<TableDataUi> {
   // List<User> users = [];
   int _currentPage = 1;
   int _pageSize =5;
   final List<int> _pageSizeOptions = [5, 10, 20, 50];

   @override
   void initState(){
     super.initState();
     context.read<UsersDataBloc>().add(LoadUserData());
   }

   void exportToCsv(List<dynamic> users) async{
     // print(users);
     List<List<dynamic>> rows =[];
     rows.add(["Id", "Name", "Username", "Email"]);

     users.forEach((user) {
       // print(user.id);
       rows.add([
         user.id,
         user.name,
         user.username,
         user.email,
       ]);
     });
     // print(rows);
     String csv = const ListToCsvConverter().convert(rows);
     // print(csv);
     final bytes = utf8.encode(csv);
     final blob = html.Blob([bytes]);
     final url = html.Url.createObjectUrlFromBlob(blob);
     final anchor = html.AnchorElement(href: url)
       ..setAttribute("download", "users_data.csv")
       ..click();
     html.Url.revokeObjectUrl(url);

     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('CSV exported '),
         ));
   }

   Future<void> exportToPdf(BuildContext context, List<dynamic> users) async {
     final pdf = pw.Document();

     pdf.addPage(
       pw.Page(
         build: (pw.Context context) {
           return pw.Table.fromTextArray(
             context: context,
             data: <List<String>>[
               <String>['Id', 'Name', 'Username', 'Email'],
               ...users.map((user) =>
               [
                 user.id.toString(),
                 user.name,
                 user.username,
                 user.email
               ]),
             ],
           );
         },
       ),
     );
     final Uint8List pdfBytes = await pdf.save();
     final blob = html.Blob([pdfBytes], 'application/pdf');
     final url = html.Url.createObjectUrlFromBlob(blob);
     final anchor = html.AnchorElement(href: url)
       ..setAttribute('download', 'users_data.pdf')
       ..click();
     html.Url.revokeObjectUrl(url);

     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('PDF exported '),
         ));
   }


     @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersDataBloc, UserState>(
          builder: (context, state) {
            if (state.users.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              final paginatedUsers = state.users.skip((_currentPage - 1) * _pageSize).take(_pageSize).toList();
              final numOfPages = (state.users.length / _pageSize).ceil();
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              exportToCsv(state.users);
                              },
                            child: Text("Export as CSV")
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                            onPressed: (){
                              exportToPdf(context,state.users);
                            },
                            child: Text("Export as PDF")
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),
                    SingleChildScrollView(
                      child: DataTable(
                          columns: [
                            DataColumn(label: Text("Id")),
                            DataColumn(label: Text("Name")),
                            DataColumn(label: Text("UserName")),
                            DataColumn(label: Text("Email Id")),
                            DataColumn(label: Text("Action")),
                          ],
                          rows: paginatedUsers.map((user) {
                            return DataRow(
                                cells: [
                                  DataCell(Text(user.id.toString())),
                                  DataCell(Text(user.name)),
                                  DataCell(Text(user.username)),
                                  DataCell(Text(user.email)),
                                  DataCell(
                                      Row(
                                        children: [
                                          Tooltip(
                                              message: "Edit",
                                              child: IconButton(
                                                icon: Icon(Icons.edit),
                                                  iconSize: 18,
                                                onPressed: (){
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Edit Clicked '),
                                                      ));
                                                },
                                              ),
                                            ),
                                          SizedBox(width: 15,),
                                          Tooltip(
                                            child: IconButton(
                                              icon: Icon(Icons.delete),
                                              iconSize: 18,
                                              onPressed: (){
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Delete Clicked '),
                                                    ));
                                              },
                                            ),
                                            message: "Delete",
                                          ),
                                        ],
                                      )
                                  ),
                                ]);
                          }).toList(),
                      ),
                    ),
                    // SizedBox(height: 50,),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 400.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DropdownButton<int>(
                                value: _pageSize,
                                items: _pageSizeOptions.map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _pageSize = value!;
                                    _currentPage = 1; // Reset to the first page
                                  });
                                },
                              ),
                              Pagination(
                                numOfPages: numOfPages,
                                selectedPage: _currentPage,
                                pagesVisible: 5,
                                onPageChanged: (page) {
                                  setState(() {
                                    _currentPage = page;
                                  });
                                  },
                                nextIcon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.blue[200],
                                  size: 12,
                                ),
                                previousIcon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.blue[200],
                                  size: 12,
                                ),
                                activeTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                                activeBtnStyle: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue[200]),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(38),
                                    ),
                                  ),
                                ),
                                inactiveBtnStyle: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(38),
                                    ),
                                  ),
                                ),
                                inactiveTextStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }
}
// class _DataSource extends DataTableSource{
//   List<User> users = [];
//   _DataSource({required this.users});
//
//   @override
//   DataRow? getRow(int index){
//     if(index >= users.length){
//       return null;
//     }
//     final user = users[index];
//     return DataRow(
//         cells: [
//           DataCell(Text(user.id.toString())),
//           DataCell(Text(user.name)),
//           DataCell(Text(user.username)),
//           DataCell(Text(user.email)),
//           DataCell(Tooltip(child: Icon(Icons.edit), message: "Edit",)),
//         ]);
//   }
//   @override
//   int get rowCount => users.length;
//
//   @override
//   int get selectedRowCount => 0;
//
//   @override
//   bool get isRowCountApproximate => false;
// }






