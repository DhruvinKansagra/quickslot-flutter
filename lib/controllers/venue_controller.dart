import 'package:get/get.dart';

import '../data/api_service.dart';
import '../data/models/venue_model.dart';

class VenueController extends GetxController {
  final ApiService apiService = ApiService();

  RxBool isLoading = false.obs;

  RxList<VenueModel> venues = <VenueModel>[].obs;

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
}
