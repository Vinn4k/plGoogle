import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_google/controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2c2c2c),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/backgroud.jpg"),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              SizedBox(
                width: GetPlatform.isMobile
                    ? Get.width * 0.8
                    : Get.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: Get.height * 0.15,
                    ),
                    Center(
                      child: Text(
                        "Sincronizar Planilha",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: GetPlatform.isMobile
                                ? Get.width * 0.08
                                : Get.width * 0.03),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff23BDFC))),
                      onPressed: () async {
                        await controller.getFile();
                      },
                      child:  Text(
                        "Selecione a Planilha",
                        style: TextStyle(color: Colors.white,fontSize: Get.width*0.021),
                      ),
                    ),
                  ],
                ),
              ),
              _space(),
              Obx(() => Text(
                    "Arquivo: ${controller.localFile.value}",
                    style: const TextStyle(color: Colors.white),
                  )),
              _space(),
              Center(
                child: Obx(
                  () {
                    return controller.loading.value
                        ? const CircularProgressIndicator(
                            color: Color(0xff23BDFC))
                        : TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff23BDFC))),
                            onPressed: () async {
                              await controller.excelRead();
                            },
                            child:  Text(
                              "Sincronizar",
                              style: TextStyle(color: Colors.white,fontSize: Get.width*0.021),
                            ),
                          );
                  },
                ),
              ),Expanded(child: SizedBox(height: Get.height*0.55,)),

              Center(
                child: Obx(() {
                  return Text(
                    "Serial de sincronização: ${controller.id.value}",
                    style: const TextStyle(color: Colors.white),
                  );
                }),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    controller.singOut();
                  },
                  child: const Text(
                    "Trocar Serial",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _space() {
    return SizedBox(
      height: Get.height * 0.01,
    );
  }
}
