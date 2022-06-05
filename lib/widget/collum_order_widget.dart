import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_google/controller/home_controller.dart';
import 'package:teste_google/utils/theme/app_colors.dart';
import 'package:teste_google/widget/custom_drag_target_widget.dart';

class CollumOrderWidget {
  showWidget() {
    HomeController _controller = Get.find<HomeController>();
    return Get.defaultDialog(
        title: "Arraste os Items para os Locais ",
        content: SizedBox(
          width: Get.width * 0.70,
          height: Get.height * 0.40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 0,
                    child: CustomDragTargetWidget(
                      status: _controller.aceptedCdBarras,
                      textoConfigurado: "Código De barras Sincronizado",
                      titulo: "Código de Barras",
                      controller: _controller,
                    ),
                  ),
                  Expanded(
                    child: CustomDragTargetWidget(
                      status: _controller.aceptedProduto,
                      textoConfigurado: "Produto Sincronizado",
                      titulo: "Produto",
                      controller: _controller,
                    ),
                  ),
                  Expanded(
                    child: CustomDragTargetWidget(
                      status: _controller.aceptedGrupo,
                      textoConfigurado: "Grupo Sincronizado",
                      titulo: "Grupo",
                      controller: _controller,
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: CustomDragTargetWidget(
                      status: _controller.aceptedQuanti,
                      textoConfigurado: "Quantidade Sincronizado",
                      titulo: "Quantidade",
                      controller: _controller,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: Get.width * 0.70,
                height: Get.height * 0.08,
                child: FutureBuilder(
                    future: _controller.getHead(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color: AppColors.primary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Draggable(
                                      data: snapshot.data![index]["index"],
                                      child: Center(
                                          child: Text(
                                        "${snapshot.data![index]["titulo"]}",
                                      )),
                                      childWhenDragging: SizedBox(
                                          height: Get.height * 0.08,
                                          child: Text(
                                              "${snapshot.data![index]["titulo"]}")),
                                      feedback: SizedBox(
                                          height: Get.height * 0.08,
                                          child: Text(
                                            "${snapshot.data![index]["titulo"]}",
                                            style: TextStyle(fontSize: 38),
                                          )),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container();
                    }),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.primary)
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
