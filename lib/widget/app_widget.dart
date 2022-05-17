
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_google/binding/home_binding.dart';
import 'package:teste_google/pages/home_page.dart';
import 'package:teste_google/routes/app_pages.dart';
import 'package:teste_google/routes/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      title: "Teste Google sheets",
      initialRoute: Routes.INITIAL,

      getPages:AppPages.routes);
  }
}
