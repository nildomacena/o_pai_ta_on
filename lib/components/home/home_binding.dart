import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/home/home_controller.dart';
import 'package:o_pai_ta_on/components/home/home_repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(HomeRepository()));
  }
}
