import 'dart:io';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_google/data/model/data_model.dart';
import 'package:teste_google/routes/app_routes.dart';
import 'package:teste_google/service/file_pick_service.dart';
import 'package:teste_google/widget/collum_order_widget.dart';

import '../credential.dart';

class HomeController extends GetxController{
  late final SharedPreferences prefs;
  final CollumOrderWidget _orderWidget=CollumOrderWidget();
  @override
  void onInit() async{
    prefs = await SharedPreferences.getInstance();
    String? ids= prefs.getString("id");
    if(ids==null){
      Get.offNamed(Routes.LOGIN);
    }else{
      id.value= ids;
      await init();
    }
    super.onInit();

  }
 late final _gsheets;
  late final Worksheet? _wkSheet;
  RxBool loading=false.obs;
  RxString localFile="nda".obs;
  RxString id="".obs;
  RxInt rowCodBarras=0.obs;
  RxInt rowProduto=1.obs;
  RxInt rowGrupo=2.obs;
  RxInt rowquantidade=3.obs;
  RxBool aceptedCdBarras=false.obs;
  RxBool aceptedProduto=false.obs;
  RxBool aceptedGrupo=false.obs;
  RxBool aceptedQuanti=false.obs;






Future<File?> getFile()async{
  final FilePickService service=FilePickService();
  File? file=await service.getFile();
  if(file !=null){
    localFile.value=file.path;
    _orderWidget.showWidget();
   await getHead();

    return file;
  }else{
    Get.showSnackbar(const GetSnackBar(title: "Erro",message: "Selecione o Arquivo",duration: Duration(seconds: 3),));
    return null;
  }



}



  excelRead(){
    readExcel(path: localFile.value);
  }


  Future init() async {
    try {
      _gsheets = GSheets(CredentialSs.credentials);
      final sheet = await _gsheets.spreadsheet(id.value);
      _wkSheet = await _getSheet("Página1", sheet);
      final firstsRow = DataModel.getData();
      _wkSheet!.values.insertRow(1, firstsRow);
    }
    catch (e) {
      Get.defaultDialog(title: "Erro",
      middleText: "Erro ao Connectar com a planilha",
      onConfirm: ()async{
        await prefs.remove("id");
        Get.offAllNamed(Routes.LOGIN);
      },
      );
    }
  }


  Future<void> insertNewData(List<Map<String, dynamic>> data) async {
    loading.value=true;
    data.removeAt(0);
    await _wkSheet!.clear();
    final firstsRow = DataModel.getData();
    _wkSheet!.values.insertRow(1, firstsRow);
    await _wkSheet!.values.map.appendRows(data);
    loading.value=false;
  }
  static Future<Worksheet?> _getSheet(
      String title, Spreadsheet spreadsheet) async {


    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {

      return spreadsheet.worksheetByTitle(title);
    }
  }
  Future<List<Map<String,dynamic>>> getHead()async{
    String file = localFile.value;
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
   List< Map<String,dynamic>> data=[];
    for (var row in excel.tables[excel.tables.keys.first]!.rows.first) {
      Map<String,dynamic> dados={"titulo":row?.value,"index":row?.colIndex} ;
      data.add(dados);

    }
    return data;
    }

 Future<void> readExcel ({required String path})async{
    String file = path;
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> dados=[];

    for (var table in excel.tables.keys) {

      int total=excel.tables[table]!.maxRows -1;
      for (var row in excel.tables[excel.tables.keys.first]!.rows) {

        if(row[0]!.value!="produtos"){
          var quantidade=row[rowquantidade.value]?.value??0;
          String quantidadeFix=quantidade.toString();
          String quantidadeNormalizada="";
          if(quantidadeFix.contains(".") ){
            quantidadeNormalizada= quantidadeFix.substring(0,quantidadeFix.indexOf('.'));
          }else if(quantidadeFix.contains(',')){
            quantidadeNormalizada= quantidadeFix.substring(0,quantidadeFix.indexOf(','));
          }else{
            quantidadeNormalizada=quantidadeFix;
          }

          final Map<String, dynamic> data = {
            DataModel.cdBarras:row[rowCodBarras.value]?.value,
            DataModel.produto:row[rowProduto.value]?.value,
            DataModel.grupo:row[rowGrupo.value]?.value,
            DataModel.quantidade:quantidadeNormalizada
          };

            dados.add(data);

        }


      }break;

    }

   await insertNewData(dados);
  }
Future<void> singOut()async{
  await prefs.remove("id");
  Get.offNamed(Routes.LOGIN);

}
}
