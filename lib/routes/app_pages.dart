import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../binding/home_binding.dart';
import '../binding/login_binding.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import 'app_routes.dart';

class AppPages  {

static final routes = [
    GetPage(
        name: Routes.INITIAL,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),


  ];


}
