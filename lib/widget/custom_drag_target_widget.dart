import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:teste_google/controller/home_controller.dart';

class CustomDragTargetWidget extends StatelessWidget {
  const CustomDragTargetWidget(
      {Key? key,
      required this.status,
      required this.textoConfigurado,
      required this.titulo,
      required this.controller})
      : super(key: key);
  final RxBool status;
  final HomeController controller;
  final String textoConfigurado;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (BuildContext context, List<Object?> candidateData,
          List<dynamic> rejectedData) {
        return Obx(
          () {
            return status.value
                ? GestureDetector(
                    onTap: () {
                      setColumDefault(titulo);
                      status.value = false;
                    },
                    child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(20),
                        child: Text(textoConfigurado,
                            style: const TextStyle(color: Colors.white))))
                : Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.all(20),
                    child: Text(titulo,
                        style: const TextStyle(color: Colors.white)));
          },
        );
      },
      onWillAccept: (data) {

        return true;
      },
      onAccept: (int data) {
        setColum(titulo,data);
        status.value = true;
      },
    );
  }

  setColum(String titulo, int index) {

    switch (titulo) {
      case "Código de Barras":
        controller.rowCodBarras.value = index;
        break;
      case "Produto":
        controller.rowProduto.value = index;
        break;
      case "Grupo":
        controller.rowGrupo.value = index;
        break;
      case "Quantidade":
        controller.rowquantidade.value = index;
        break;
    }
  }
  setColumDefault(String titulo) {
    switch (titulo) {
      case "Código de Barras":
        controller.rowCodBarras.value = 0;
        break;
      case "Produto":
        controller.rowProduto.value = 1;
        break;
      case "Grupo":
        controller.rowGrupo.value = 2;
        break;
      case "Quantidade":
        controller.rowProduto.value = 3;
        break;
    }
  }
}
