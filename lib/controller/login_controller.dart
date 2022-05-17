
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_google/routes/app_routes.dart';

class LoginController extends GetxController{
  RxBool loading=false.obs;



  Future<void> saveId(String id)async{
    final prefs=await SharedPreferences.getInstance();
    prefs.setString("id", id);
    Get.offNamed(Routes.INITIAL);


  }

}