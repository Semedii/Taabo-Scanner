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
    try {
      final String? jwtToken = await _secureStorage.read('auth_token');

      if (jwtToken == null) {
        print('JWT token is not available');
        return;
      }

      final response = await http.post(Uri.parse("$baseUrl/parcels"),
          headers: {
            'Authorization': 'Bearer $jwtToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(parcel.toJson()));

      if (response.statusCode == 200) {
        print("waryaa success ${response.body}");
      }
    } catch (e) {
      print("error happened : $e");
    }
  }
}
