import 'package:get/get.dart';
import 'package:quickslot_app/data/api_service.dart';
import 'package:quickslot_app/data/models/booking_model.dart';

class BookingController extends GetxController {
  final ApiService apiService = ApiService();
  RxList<BookingModel> bookings = <BookingModel>[].obs;
  RxBool isBooking = false.obs;
  Future<void> getBookings(String userId) async {
    isBooking.value = true;
    try {
      final response = await apiService.getBookings("6a298c8834db5fb9a94b444f");

      final List data = response.data['data'];

      bookings.value = data.map((e) => BookingModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      await apiService.cancelBooking(bookingId);

      Get.snackbar("Success", "Booking cancelled");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<bool> createBooking({
    required String venueId,
    required String date,
    required String slotTime,
    required String userId,
  }) async {
    try {
      print(
        "Creating booking with venueId: $venueId, date: $date, slotTime: $slotTime, userId: $userId",
      );
      final response = await apiService.createBooking(
        venueId: venueId,
        date: date,
        slotTime: slotTime,
        userId: "6a298c8834db5fb9a94b444f",
      );

      print(response.data);

      return true;
    } catch (e) {
      print("Booking Error => $e");
      return false;
    }
  }
}
