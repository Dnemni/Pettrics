import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

/// Firestore REST API client to avoid gRPC dependency
/// Uses Firebase REST API v1 for Firestore operations
class FirestoreRestClient {
  static const String projectId = 'pettrics-23f5b';
  static const String baseUrl =
      'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents';

  /// Get the current user's ID token for authentication
  static Future<String?> _getIdToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return await user.getIdToken();
  }

  /// Create a document in a collection
  static Future<Map<String, dynamic>?> createDocument(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    final token = await _getIdToken();
    if (token == null) throw Exception('User not authenticated');

    final url = '$baseUrl/$collection/$documentId';
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'fields': _convertToFirestoreFields(data),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create document: ${response.body}');
    }
  }

  /// Get a document from a collection
  static Future<Map<String, dynamic>?> getDocument(
    String collection,
    String documentId,
  ) async {
    final token = await _getIdToken();
    if (token == null) throw Exception('User not authenticated');

    final url = '$baseUrl/$collection/$documentId';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return _convertFromFirestoreFields(data['fields']);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to get document: ${response.body}');
    }
  }

  /// Update a document in a collection
  static Future<Map<String, dynamic>?> updateDocument(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    final token = await _getIdToken();
    if (token == null) throw Exception('User not authenticated');

    final url = '$baseUrl/$collection/$documentId';
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'fields': _convertToFirestoreFields(data),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update document: ${response.body}');
    }
  }

  /// Delete a document from a collection
  static Future<void> deleteDocument(
    String collection,
    String documentId,
  ) async {
    final token = await _getIdToken();
    if (token == null) throw Exception('User not authenticated');

    final url = '$baseUrl/$collection/$documentId';
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete document: ${response.body}');
    }
  }

  /// Query documents in a collection with filters
  static Future<List<Map<String, dynamic>>> queryDocuments(
    String collection, {
    String? orderBy,
    int? limit,
    Map<String, dynamic>? where,
  }) async {
    final token = await _getIdToken();
    if (token == null) throw Exception('User not authenticated');

    final url = '$baseUrl:runQuery';

    final structuredQuery = <String, dynamic>{
      'from': [
        {'collectionId': collection}
      ],
    };

    if (where != null) {
      structuredQuery['where'] = _buildWhereClause(where);
    }

    if (orderBy != null) {
      structuredQuery['orderBy'] = [
        {
          'field': {'fieldPath': orderBy},
          'direction': 'DESCENDING',
        }
      ];
    }

    if (limit != null) {
      structuredQuery['limit'] = limit;
    }

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'structuredQuery': structuredQuery,
      }),
    );

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body) as List;
      return results
          .where((item) => item['document'] != null)
          .map((item) => _convertFromFirestoreFields(item['document']['fields'])
              as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Failed to query documents: ${response.body}');
    }
  }

  /// Convert Dart map to Firestore field format
  static Map<String, dynamic> _convertToFirestoreFields(
      Map<String, dynamic> data) {
    final fields = <String, dynamic>{};
    data.forEach((key, value) {
      if (value is String) {
        fields[key] = {'stringValue': value};
      } else if (value is int) {
        fields[key] = {'integerValue': value.toString()};
      } else if (value is double) {
        fields[key] = {'doubleValue': value};
      } else if (value is bool) {
        fields[key] = {'booleanValue': value};
      } else if (value is DateTime) {
        fields[key] = {'timestampValue': value.toUtc().toIso8601String()};
      } else if (value is List) {
        fields[key] = {
          'arrayValue': {
            'values': value.map((item) {
              if (item is String) return {'stringValue': item};
              if (item is int) return {'integerValue': item.toString()};
              if (item is double) return {'doubleValue': item};
              if (item is bool) return {'booleanValue': item};
              return {'stringValue': item.toString()};
            }).toList()
          }
        };
      } else if (value == null) {
        fields[key] = {'nullValue': null};
      } else {
        fields[key] = {'stringValue': value.toString()};
      }
    });
    return fields;
  }

  /// Convert Firestore field format to Dart map
  static Map<String, dynamic> _convertFromFirestoreFields(
      Map<String, dynamic>? fields) {
    if (fields == null) return {};
    final data = <String, dynamic>{};
    fields.forEach((key, value) {
      if (value['stringValue'] != null) {
        data[key] = value['stringValue'];
      } else if (value['integerValue'] != null) {
        data[key] = int.parse(value['integerValue']);
      } else if (value['doubleValue'] != null) {
        data[key] = value['doubleValue'];
      } else if (value['booleanValue'] != null) {
        data[key] = value['booleanValue'];
      } else if (value['timestampValue'] != null) {
        data[key] = DateTime.parse(value['timestampValue']);
      } else if (value['arrayValue'] != null) {
        data[key] = (value['arrayValue']['values'] as List?)
                ?.map((item) {
                  if (item['stringValue'] != null) return item['stringValue'];
                  if (item['integerValue'] != null)
                    return int.parse(item['integerValue']);
                  if (item['doubleValue'] != null) return item['doubleValue'];
                  if (item['booleanValue'] != null) return item['booleanValue'];
                  return null;
                })
                .where((item) => item != null)
                .toList() ??
            [];
      } else if (value['nullValue'] != null) {
        data[key] = null;
      }
    });
    return data;
  }

  /// Build WHERE clause for queries
  static Map<String, dynamic> _buildWhereClause(Map<String, dynamic> where) {
    final filters = <Map<String, dynamic>>[];

    where.forEach((field, value) {
      filters.add({
        'fieldFilter': {
          'field': {'fieldPath': field},
          'op': 'EQUAL',
          'value': _convertToFirestoreFields({field: value})[field],
        }
      });
    });

    if (filters.length == 1) {
      return filters[0];
    } else {
      return {
        'compositeFilter': {
          'op': 'AND',
          'filters': filters,
        }
      };
    }
  }
}
