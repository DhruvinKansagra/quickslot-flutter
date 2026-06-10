import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickslot_app/controllers/auth_controller.dart';
import 'package:quickslot_app/controllers/booking_controller.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final BookingController bookingController = Get.find<BookingController>();

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadBookings();
    });
  }

  Future<void> loadBookings() async {
    await bookingController.getBookings(authController.userId.value);
  }

  Future<void> onCancelBooking(String bookingId) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Cancel Booking"),
        content: const Text("Are you sure you want to cancel this booking?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    if (result != true) return;

    await bookingController.cancelBooking(bookingId);

    await loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: Obx(() {
        if (bookingController.isBooking.value &&
            bookingController.bookings.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (bookingController.bookings.isEmpty) {
          return RefreshIndicator(
            onRefresh: loadBookings,
            child: ListView(
              children: const [
                SizedBox(height: 250),
                Center(child: Text("No Bookings Found")),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: loadBookings,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: bookingController.bookings.length,
            itemBuilder: (context, index) {
              final booking = bookingController.bookings[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    booking.venueName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date: ${booking.date}"),
                        const SizedBox(height: 4),
                        Text("Time: ${booking.slotTime}"),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      onCancelBooking(booking.id);
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
