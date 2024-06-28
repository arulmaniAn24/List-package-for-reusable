import 'list_item.dart';
import 'table_setting.dart';

class ResponseModel {
  final TableSetting tableSetting;
  final List<ListItem> data;

  ResponseModel({required this.tableSetting, required this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json');
    try {
      final tableSetting = TableSetting.fromJson(json['table_setting']);
      final data = List<ListItem>.from(
          json['data'].map((item) => ListItem.fromJson(item)));
      print('Parsed successfully: tableSetting=$tableSetting, data=$data');
      return ResponseModel(
        tableSetting: tableSetting,
        data: data,
      );
    } catch (e) {
      print('Error parsing JSON: $e');
      throw e;
    }
  }
}
