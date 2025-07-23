import 'package:cloud_firestore/cloud_firestore.dart';

class ModelHelper {
  /// Returns true if the map contains the key and its value is non-null.
  static bool containsKey(Map<String, dynamic> map, String key) {
    return map.containsKey(key) && map[key] != null;
  }

  /// Returns true if the map contains the key and the value is a non-empty string, list, or map.
  static bool containsKeyAndNotEmpty(Map<String, dynamic> map, String key) {
    if (!map.containsKey(key) || map[key] == null) return false;
    final value = map[key];
    if (value is String || value is Iterable || value is Map) {
      return value.isNotEmpty;
    }
    return true; // for int, double, bool etc. that are not null
  }

  /// Safely retrieves a string if it exists and is not empty.
  static String? stringOrNull(Map<String, dynamic> map, String key) {
    final value = map[key];
    if (value is String && value.isNotEmpty) return value;
    return null;
  }

  /// Safely retrieves a boolean.
  static bool? boolOrNull(Map<String, dynamic> map, String key) {
    final value = map[key];
    if (value is bool) return value;
    return null;
  }

  /// Safely retrieves an int.
  static int? intOrNull(Map<String, dynamic> map, String key) {
    final value = map[key];
    if (value is int) return value;
    return null;
  }

  /// Safely retrieves a double.
  static double? doubleOrNull(Map<String, dynamic> map, String key) {
    final value = map[key];
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return null;
  }

  /// Converts a Firestore Timestamp or DateTime to a DateTime.
  static DateTime? timestampToDate(Map<String, dynamic> map, String key) {
    final value = map[key];
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  static DateTime? parseDate(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.tryParse(value);
    } else {
      return null;
    }
  }
}
