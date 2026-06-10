import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://quickslot-hackathon-production.up.railway.app/api/v1',
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

  Future<Response> getBookings(String userId) async {
    return await dio.get('/users/$userId/bookings');
  }

  Future<Response> cancelBooking(String bookingId) async {
    return await dio.delete('/bookings/$bookingId');
  }

  Future<Response> createBooking({
    required String venueId,
    required String date,
    required String slotTime,
    required String userId,
  }) async {
    return dio.post(
      '/bookings',
      data: {"venueId": venueId, "date": date, "slotTime": slotTime},
      options: Options(headers: {"X-User-Id": userId}),
    );
  }
}
