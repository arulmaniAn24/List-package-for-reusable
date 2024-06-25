import 'package:flutter/material.dart';
import '../models/list_item.dart';

class CardView extends StatelessWidget {
  final List<ListItem> items;
  final List<String> columnsToShow;

  CardView({required this.items, required this.columnsToShow});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final fields = items[index].fields;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: columnsToShow.map((column) {
              return SizedBox(
                width: screenWidth < 600 ? (screenWidth / 2) - 16 : (screenWidth / 4) - 16, // Adjust width based on screen size
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          column,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth < 600 ? 14 : 16, // Adjust font size based on screen width
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${fields[column]}',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 12 : 14, // Adjust font size based on screen width
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
