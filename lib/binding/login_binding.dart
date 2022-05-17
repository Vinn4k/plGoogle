
import 'package:get/get.dart';
import 'package:teste_google/controller/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>LoginController());

  }
}