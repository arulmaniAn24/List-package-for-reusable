// import 'package:flutter/material.dart';
// import '../models/list_item.dart';

// class CardView extends StatelessWidget {
//   final List<ListItem> items;
//   final List<String> columnsToShow;

//   CardView({required this.items, required this.columnsToShow});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: _getCrossAxisCount(screenWidth),
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//           ),
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final fields = items[index].fields;
//             return Card(
//               elevation: 3,
//               child: InkWell(
//                 onTap: () {
//                   _viewItem(context, fields);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Item ${index + 1}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: _getFontSize(screenWidth),
//                             ),
//                           ),
//                           PopupMenuButton<String>(
//                             onSelected: (value) {
//                               if (value == 'View') {
//                                 _viewItem(context, fields);
//                               } else if (value == 'Edit') {
//                                 _editItem(context, fields);
//                               } else if (value == 'Delete') {
//                                 _deleteItem(context, fields);
//                               }
//                             },
//                             itemBuilder: (context) => [
//                               PopupMenuItem(
//                                 value: 'View',
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.visibility),
//                                     SizedBox(width: 8),
//                                     Text('View'),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 value: 'Edit',
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.edit),
//                                     SizedBox(width: 8),
//                                     Text('Edit'),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 value: 'Delete',
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.delete),
//                                     SizedBox(width: 8),
//                                     Text('Delete'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: columnsToShow.map((column) {
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     '$column:',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: _getFontSize(screenWidth),
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     '${fields[column]}',
//                                     style: TextStyle(
//                                       fontSize: _getFontSize(screenWidth) - 2,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   int _getCrossAxisCount(double screenWidth) {
//     if (screenWidth >= 1200) {
//       return 4; // Web
//     } else if (screenWidth >= 800) {
//       return 2; // Tablet
//     } else {
//       return 1; // Mobile
//     }
//   }

//   double _getFontSize(double screenWidth) {
//     if (screenWidth >= 1200) {
//       return 18; // Web
//     } else if (screenWidth >= 800) {
//       return 16; // Tablet
//     } else {
//       return 14; // Mobile
//     }
//   }

//   void _viewItem(BuildContext context, Map<String, dynamic> fields) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('View Item'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: fields.entries.map((entry) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         '${entry.key}: ',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text('${entry.value}'),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _editItem(BuildContext context, Map<String, dynamic> fields) {
//     final TextEditingController _controller = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Item'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: fields.entries.map((entry) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                   child: TextFormField(
//                     initialValue: entry.value.toString(),
//                     decoration: InputDecoration(
//                       labelText: entry.key,
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) {
//                       fields[entry.key] = value;
//                     },
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement save functionality
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteItem(BuildContext context, Map<String, dynamic> fields) {
//     // Implement delete item functionality
//     // e.g., call a function to delete the item and refresh the list
//   }
// }

// import 'package:flutter/material.dart';
// import '../models/list_item.dart';

// class CardView extends StatelessWidget {
//   final List<ListItem> items;
//   final List<String> columnsToShow;

//   CardView({required this.items, required this.columnsToShow});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return ListView.builder(
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final fields = items[index].fields;
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: columnsToShow.map((column) {
//               return SizedBox(
//                 width: screenWidth < 600
//                     ? (screenWidth / 2) - 16
//                     : (screenWidth / 4) - 16,
//                 child: Card(
//                   elevation: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           column,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: screenWidth < 600 ? 14 : 16,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           '${fields[column]}',
//                           style: TextStyle(
//                             fontSize: screenWidth < 600 ? 12 : 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }




