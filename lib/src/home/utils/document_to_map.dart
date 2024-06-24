import 'package:nitrite/nitrite.dart';


// Recursive function to convert Document to Map<String, dynamic>
Map<String, dynamic> convertDocumentToMap(Document document) {
  Map<String, dynamic> resultMap = {};

  document.toMap().forEach((key, value) {
    resultMap[key] = _convertValue(value);
  });

  return resultMap;
}

dynamic _convertValue(dynamic value) {
  if (value is Document) {
    return convertDocumentToMap(value);
  } else if (value is List) {
    return value.map((item) => _convertValue(item)).toList();
  } else if (value is Map) {
    return value.map((k, v) {
      if (k is! String) {
        throw Exception(
            "Unexpected key type in map. Expected String, found ${k.runtimeType}");
      }
      return MapEntry(k, _convertValue(v));
    });
  } else {
    return value;
  }
}
