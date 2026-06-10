import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:5000/api/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<Response> getVenues() async {
    return await dio.get('/venues');
  }

  Future<Response> getSlots(String venueId, String date) async {
    return await dio.get(
      '/venues/$venueId/slots',
      queryParameters: {'date': date},
    );
  }
}
