import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString userId = ''.obs;
  RxString userName = ''.obs;

  void selectUser({required String id, required String name}) {
    userId.value = id;
    userName.value = name;
  }
}
