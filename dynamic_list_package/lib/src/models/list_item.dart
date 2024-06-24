import 'package:equatable/equatable.dart';




class ListItem extends Equatable {
  final Map<String, dynamic> fields;

  ListItem({required this.fields});

  @override
  List<Object?> get props => [fields];

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(fields: json);
  }

  Map<String, dynamic> toJson() {
    return fields;
  }

  bool matchesQuery(String query) {
    final lowercaseQuery = query.toLowerCase();
    return fields.values.any((value) => value.toString().toLowerCase().contains(lowercaseQuery));
  }
}
