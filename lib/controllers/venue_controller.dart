import 'package:get/get.dart';
import 'package:quickslot_app/data/models/slot_model.dart';

import '../data/api_service.dart';
import '../data/models/venue_model.dart';

class VenueController extends GetxController {
  final ApiService apiService = ApiService();

  RxBool isLoading = false.obs;

  RxList<VenueModel> venues = <VenueModel>[].obs;
  RxList<SlotModel> slots = <SlotModel>[].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    getVenues();
    super.onInit();
  }

  Future<void> getVenues() async {
    try {
      isLoading.value = true;

      final response = await apiService.getVenues();

      final List data = response.data['data'];

      venues.value = data.map((e) => VenueModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSlots(String venueId) async {
    try {
      isLoading.value = true;

      final date = selectedDate.value.toIso8601String().split('T').first;

      final response = await apiService.getSlots(venueId, date);

      final List data = response.data['slots'];

      print("aaaaaaaaa $data");

      slots.value = data.map((e) => SlotModel.fromJson(e)).toList();
    } finally {
      isLoading.value = false;
    }
  }
}
