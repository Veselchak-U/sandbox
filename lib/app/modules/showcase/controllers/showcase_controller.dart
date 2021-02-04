import 'package:get/get.dart';
import 'package:sandbox/app/data/stub_data.dart';

class ShowcaseController extends GetxController {
  //TODO: Implement ShowcaseController

  final count = 0.obs;
  final items = StubData.items;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
