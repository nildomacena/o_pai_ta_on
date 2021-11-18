import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/model/modo_model.dart';

class FiltrosController extends GetxController {
  TextEditingController kdInicial = TextEditingController();
  TextEditingController kdFinal = TextEditingController();

  List<Modo> modosSelecionados = [];
  List<Map<String, String>> formasDeJogo = [
    {'sigla': 'rush', 'nome': 'Rushando'},
    {'sigla': 'mix', 'rush': 'Mix'},
    {'sigla': 'safe', 'rush': 'Safe'},
  ];

  Map<String, String>? formaSelecionada;
  bool modoSelecionado(Modo modo) {
    bool contem = false;
    for (var m in modosSelecionados) {
      if (modo.sigla.contains(m.sigla)) contem = true;
    }
    return contem;
  }

  selecionarModo(Modo modo) {
    if (modosSelecionados.isEmpty) {
      modosSelecionados.add(modo);
    } else if (modoSelecionado(modo)) {
      modosSelecionados.removeAt(
          modosSelecionados.indexWhere((m) => m.sigla.contains(modo.sigla)));
    } else {
      modosSelecionados.add(modo);
    }
    print('Modos: $modosSelecionados');
    update();
  }

  /* selecionarForma(Map<String, String> modo) {
    if (modosSelecionados.isEmpty) {
      modosSelecionados.add(modo);
    } else if (modoSelecionado(modo)) {
      modosSelecionados.removeAt(
          modosSelecionados.indexWhere((m) => m.sigla.contains(modo.sigla)));
    } else {
      modosSelecionados.add(modo);
    }
    print('Modos: $modosSelecionados');
    update();
  } */
}
