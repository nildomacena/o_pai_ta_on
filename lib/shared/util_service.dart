import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/model/modo_model.dart';

const ESTADOS = [
  {"nome": "Acre", "sigla": "AC"},
  {"nome": "Alagoas", "sigla": "AL"},
  {"nome": "Amapá", "sigla": "AP"},
  {"nome": "Amazonas", "sigla": "AM"},
  {"nome": "Bahia", "sigla": "BA"},
  {"nome": "Ceará", "sigla": "CE"},
  {"nome": "Distrito Federal", "sigla": "DF"},
  {"nome": "Espírito Santo", "sigla": "ES"},
  {"nome": "Goiás", "sigla": "GO"},
  {"nome": "Maranhão", "sigla": "MA"},
  {"nome": "Mato Grosso", "sigla": "MT"},
  {"nome": "Mato Grosso do Sul", "sigla": "MS"},
  {"nome": "Minas Gerais", "sigla": "MG"},
  {"nome": "Pará", "sigla": "PA"},
  {"nome": "Paraíba", "sigla": "PB"},
  {"nome": "Paraná", "sigla": "PR"},
  {"nome": "Pernambuco", "sigla": "PE"},
  {"nome": "Piauí", "sigla": "PI"},
  {"nome": "Rio de Janeiro", "sigla": "RJ"},
  {"nome": "Rio Grande do Norte", "sigla": "RN"},
  {"nome": "Rio Grande do Sul", "sigla": "RS"},
  {"nome": "Rondônia", "sigla": "RO"},
  {"nome": "Roraima", "sigla": "RR"},
  {"nome": "Santa Catarina", "sigla": "SC"},
  {"nome": "São Paulo", "sigla": "SP"},
  {"nome": "Sergipe", "sigla": "SE"},
  {"nome": "Tocantins", "sigla": "TO"}
];

class UtilService {
  List<Modo> MODOS = [
    Modo(sigla: "vdk_br", nome: "BR Verdansk"),
    Modo(sigla: "ress", nome: "Ressurgência"),
    Modo(sigla: "sq", nome: "Saque"),
  ];
  void snackBarErro({String? titulo, String? mensagem}) {
    Get.snackbar(
      titulo ?? 'Erro',
      mensagem ?? 'Erro durante a operação',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      duration: const Duration(seconds: 5),
    );
  }

  void snackBar(
      {required String titulo,
      required String mensagem,
      SnackPosition? snackPosition,
      Function? action}) {
    Get.snackbar(
      titulo,
      mensagem,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      backgroundColor: Colors.white,
      //colorText: Colors.white,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      duration: const Duration(seconds: 5),
    );
  }

  showToast(String mensagem) {
    Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showAlertCarregando([String? mensagem]) {
    Get.dialog(
        AlertDialog(
            content: SizedBox(
                height: 80,
                width: Get.width,
                child: Column(children: <Widget>[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      if (kDebugMode) fecharAlert();
                    },
                    child: AutoSizeText(
                      mensagem ?? 'Fazendo consulta...',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Get.theme.primaryColor),
                    ),
                  )
                ]))),
        barrierDismissible: false);
  }

  void fecharAlert() {
    if (Get.isDialogOpen ?? false) Get.back();
  }

  String estadoSiglaNome(String sigla) {
    var estado;
    try {
      estado = ESTADOS
          .firstWhere((e) => e['sigla']!.toUpperCase() == sigla.toUpperCase());
    } catch (e) {
      print(e);
      return '';
    }

    return estado['nome'] ?? '';
  }
}
