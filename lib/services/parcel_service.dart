import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taabo/model/package.dart';
import 'package:taabo/services/secure_storage_service.dart';

class ParcelService {
  final SecureStorageService _secureStorage = SecureStorageService();
  final String baseUrl = "https://tajmexapp.onrender.com";

  Future<List<Parcel>> getAllParcels() async {
    List<Parcel> parcels = [];
    try {
      final String? jwtToken = await _secureStorage.read('auth_token');

      if (jwtToken == null) {
        print('JWT token is not available');
        return parcels;
      }

      final response = await http.get(
        Uri.parse("$baseUrl/parcels"),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var parcelData in data["data"]) {
          Parcel parcel = Parcel.fromJson(parcelData);
          parcels.add(parcel);
        }
        return parcels;
      } else {
        return parcels;
      }
    } catch (e) {
      print("error happened $e");
      return parcels;
    }
  }

  Future<void> addNewParcel(Parcel parcel) async {
    final String? jwtToken = await _secureStorage.read('auth_token');

    if (jwtToken == null) {
      throw Exception('JWT token is not available');
    }

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/parcels"),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json', // Optional, depending on the API
        },
        body: jsonEncode(parcel.toJson()),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Parcel added successfully: ${response.body}");
      } else {
        throw Exception(
            'Failed to add parcel. Status code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      // Catch any network-related issues or other exceptions
      print("Error while making HTTP request: $e");
      rethrow; // Re-throw the exception to be handled by the calling function
    }
  }
}
