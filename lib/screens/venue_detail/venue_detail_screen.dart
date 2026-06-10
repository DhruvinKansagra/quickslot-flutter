import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickslot_app/controllers/auth_controller.dart';
import 'package:quickslot_app/controllers/booking_controller.dart';
import 'package:quickslot_app/controllers/venue_controller.dart';
import 'package:quickslot_app/data/models/venue_model.dart';

class VenueDetailScreen extends StatelessWidget {
  final VenueModel venue;

  VenueDetailScreen({super.key, required this.venue});

  final VenueController controller = Get.find();

  final BookingController bookingController = Get.find();

  final AuthController authController = Get.find();
  Future<void> _bookSlot(String slotTime) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Confirm Booking"),
        content: Text("Do you want to book $slotTime?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Book"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await _submitBooking(slotTime);
  }

  Future<void> _submitBooking(String slotTime) async {
    final date = controller.selectedDate.value
        .toIso8601String()
        .split('T')
        .first;

    final success = await bookingController.createBooking(
      venueId: venue.id,
      date: date,
      slotTime: slotTime,
      userId: authController.userId.value,
    );

    if (success) {
      Get.snackbar("Success", "Slot booked successfully");
    } else {
      Get.snackbar("Failed", "Slot already booked");
    }

    // Refresh slots after booking
    await controller.getSlots(venue.id);
  }

  @override
  Widget build(BuildContext context) {
    controller.getSlots(venue.id);

    return Scaffold(
      appBar: AppBar(title: Text(venue.name)),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                initialDate: controller.selectedDate.value,
              );

              if (picked != null) {
                controller.selectedDate.value = picked;

                controller.getSlots(venue.id);
              }
            },
            child: const Text("Select Date"),
          ),

          Expanded(
            child: Obx(() {
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.slots.length,
                itemBuilder: (_, index) {
                  final slot = controller.slots[index];

                  return GestureDetector(
                    onTap: slot.booked
                        ? null
                        : () {
                            _bookSlot(slot.time);
                          },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: slot.booked ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        slot.time,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
