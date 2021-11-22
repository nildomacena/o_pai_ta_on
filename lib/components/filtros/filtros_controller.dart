import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/model/modo_model.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class FiltrosController extends GetxController {
  TextEditingController kdInicial = TextEditingController();
  TextEditingController kdFinal = TextEditingController();
  String plataformaSelecionada = '';
  String formaJogoSelecionada = '';
  Modo? modoSelecionado;
  bool possuiFiltros = false;
  List<Map<String, String>> formasDeJogo = [
    {'sigla': 'rush', 'nome': 'Rushando'},
    {'sigla': 'mix', 'rush': 'Mix'},
    {'sigla': 'safe', 'rush': 'Safe'},
  ];

  FiltrosController() {
    if (Get.arguments != null && Get.arguments['filtros'] != null) {
      var filtros = Get.arguments['filtros'];
      if (filtros['kdInicial'] != null) {
        kdInicial.text = filtros['kdInicial'].toString();
      }
      if (filtros['kdFinal'] != null) {
        kdFinal.text = Get.arguments['filtros']['kdFinal'].toString();
      }
      if (filtros['plataformaSelecionada'] != null) {
        plataformaSelecionada = filtros['plataformaSelecionada'];
      }
      if (filtros['modo'] != null) {
        modoSelecionado =
            UtilService().MODOS.firstWhere((m) => m.sigla == filtros['modo']);
      }
      if (filtros['forma'] != null) {
        formaJogoSelecionada = filtros['forma'];
      }
      if (filtros['plataforma'] != null) {
        plataformaSelecionada = filtros['plataforma'];
      }
    }
    update();
  }

  bool isModoSelecionado(Modo m) =>
      modoSelecionado == null ? false : m.sigla == modoSelecionado!.sigla;
  bool get mostrarBotao =>
      kdInicial.text != '' ||
      kdFinal.text != '' ||
      plataformaSelecionada != '' ||
      formaJogoSelecionada != '' ||
      modoSelecionado != null;

  selecionarModo(Modo modo) {
    if (modoSelecionado != null && modo.sigla == modoSelecionado!.sigla) {
      modoSelecionado = null;
    } else {
      modoSelecionado = modo;
    }
    update();
  }

  onKdSubmitted() {
    update();
  }

  selecionaPlataforma(String plataforma) {
    if (plataformaSelecionada == plataforma) {
      plataformaSelecionada = '';
    } else {
      plataformaSelecionada = plataforma;
    }
    update();
  }

  selecionaFormaJogo(String forma) {
    if (formaJogoSelecionada == forma) {
      formaJogoSelecionada = '';
    } else {
      formaJogoSelecionada = forma;
    }
    update();
  }

  definirFiltros() {
    Map<String, dynamic> filtros = {};
    if (kdInicial.text != '') {
      filtros['kdInicial'] = double.parse(kdInicial.text);
    }
    if (kdFinal.text != '') {
      filtros['kdFinal'] = double.parse(kdFinal.text);
    }
    if (plataformaSelecionada != '') {
      filtros['plataformaSelecionada'] = plataformaSelecionada;
    }
    if (modoSelecionado != null) {
      filtros['modo'] = modoSelecionado!.sigla;
    }
    if (formaJogoSelecionada != '') {
      filtros['forma'] = formaJogoSelecionada;
    }
    if (plataformaSelecionada != '') {
      filtros['plataforma'] = plataformaSelecionada;
    }

    Get.back(result: filtros);
  }

  limparFiltros() {
    kdInicial.text = '';
    kdFinal.text = '';
    plataformaSelecionada = '';
    modoSelecionado = null;
    formaJogoSelecionada = '';
    update();
  }
}
