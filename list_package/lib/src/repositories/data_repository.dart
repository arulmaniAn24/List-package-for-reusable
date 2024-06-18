import '../models/data_item.dart';

class DataRepository {
  Future<List<DataItem<Map<String, dynamic>>>> fetchUserData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return List.generate(
      10,
      (index) => DataItem(data: {
        'name': 'User $index',
        'email': 'user$index@example.com',
      }),
    );
  }

  Future<List<DataItem<Map<String, dynamic>>>> fetchEmployeeData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return List.generate(
      10,
      (index) => DataItem(data: {
        'name': 'Employee $index',
        'position': 'Position $index',
      }),
    );
  }
}
