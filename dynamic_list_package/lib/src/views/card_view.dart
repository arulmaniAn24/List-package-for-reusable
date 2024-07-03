import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../models/list_item.dart';

class CardView extends StatelessWidget {
  final List<ListItem> items;
  final List<String> columnsToShow;

  CardView({required this.items, required this.columnsToShow});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(screenWidth),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 2,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final fields = items[index].fields;

            return GestureDetector(
              onTap: () {
                _viewItem(context, fields);
              },
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(
                    color: Color(0xFFDCDCDC),
                  ),
                ),
                color: const Color(0xFFE9EBF2),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: const Color(0xFF1F397A),
                            child: SvgPicture.asset(
                              'assets/images/user.svg',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fields['name'],
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  fields['email'],
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'View') {
                                _viewItem(context, fields);
                              } else if (value == 'Edit') {
                                _editItem(context, fields);
                              } else if (value == 'Delete') {
                                _deleteItem(context, fields);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'View',
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/visibility.svg',
                                      width: 13,
                                      height: 13,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('View'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Edit',
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/edit.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Edit'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Delete',
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/delete.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Delete'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${fields['mobile']}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              _buildStatusBadge(fields['status']),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${fields['location']}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _formatField(fields['createdAt'], 'date'),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                _formatField(fields['createdAt'], 'time'),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth >= 1200) {
      return 4;
    } else if (screenWidth >= 800) {
      return 2;
    } else {
      return 1;
    }
  }

  void _viewItem(BuildContext context, Map<String, dynamic> fields) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('View Item'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: fields.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${entry.key}: ${_formatField(entry.value, entry.key)}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _editItem(BuildContext context, Map<String, dynamic> fields) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: fields.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    initialValue: entry.value.toString(),
                    decoration: InputDecoration(
                      labelText: entry.key,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      fields[entry.key] = value;
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context, Map<String, dynamic> fields) {}

  String _formatField(dynamic value, String part) {
    if (part == 'date' || part == 'time') {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value);
      if (part == 'date') {
        return DateFormat('yyyy-MM-dd').format(dateTime);
      } else {
        return DateFormat('HH:mm').format(dateTime);
      }
    }
    return value.toString();
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Active':
        bgColor = Colors.green.withOpacity(0.2);
        textColor = Colors.green;
        break;
      case 'Inactive':
        bgColor = Colors.orange.withOpacity(0.2);
        textColor = Colors.orange;
        break;
      case 'Away':
        bgColor = Colors.red.withOpacity(0.2);
        textColor = Colors.red;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.2);
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
