import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_google/controller/login_controller.dart';

import '../widget/form_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xff2c2c2c),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgroud.jpg"),
                fit: BoxFit.cover,
              )),
          child: Center(
            child: SizedBox(
              width: GetPlatform.isMobile ? Get.width * 0.8 : Get.width * 0.5,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    SizedBox(
                      height: Get.height*0.3,
                    ),
                    Center(
                      child: Text(
                        "Insira a Serial",
                        style: TextStyle(
                            color:  Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: GetPlatform.isMobile
                                ? Get.width * 0.08
                                : Get.width * 0.03),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    FormWidget().form(controller: idController, label: "ID Planilha"),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(
                      () {
                        return controller.loading.value
                            ? const CircularProgressIndicator(color: Color(0xff23BDFC))
                            : TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff23BDFC))),
                                onPressed: () async {
                                  _formKey.currentState!.validate()?
                                  await controller.saveId(idController.text):null;

                                },
                                child:  Text(
                                  "Acessar",
                                  style: TextStyle(color: Colors.white,fontSize: Get.width*0.021),
                                ),
                              );
                      },
                    ),
                    SizedBox(
                      height: Get.height*0.2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
