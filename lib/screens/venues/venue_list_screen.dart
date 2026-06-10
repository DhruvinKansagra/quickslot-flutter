import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickslot_app/controllers/venue_controller.dart';
import 'package:quickslot_app/screens/venue_detail/venue_detail_screen.dart';

class VenueListScreen extends StatelessWidget {
  VenueListScreen({super.key});

  final VenueController controller = Get.find<VenueController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Venues")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.venues.isEmpty) {
          return const Center(child: Text("No Venues Found"));
        }

        return ListView.builder(
          itemCount: controller.venues.length,

          itemBuilder: (_, index) {
            final venue = controller.venues[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => VenueDetailScreen(venue: venue));
              },
              child: Card(
                child: ListTile(
                  title: Text(venue.name),
                  subtitle: Text(venue.location),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
