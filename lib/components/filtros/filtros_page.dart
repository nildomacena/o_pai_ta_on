import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/filtros/filtros_controller.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class FiltrosPage extends StatelessWidget {
  FiltrosController controller = Get.put(FiltrosController());
  FiltrosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget kdWidget = Container(
      height: 120,
      width: Get.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'Selecionar KD',
                style: TextStyle(fontSize: 20),
              )),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    controller: controller.kdInicial,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.kdInicial.text = '';
                            },
                            icon: const Icon(Icons.clear)),
                        border: const OutlineInputBorder(),
                        hintText: 'Ex.: 9.99',
                        hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        labelText: 'KD INICIAL',
                        labelStyle:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    controller: controller.kdFinal,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.kdFinal.text = '';
                            },
                            icon: const Icon(Icons.clear)),
                        border: const OutlineInputBorder(),
                        hintText: 'Ex.: 9.99',
                        hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        labelText: 'KD FINAL',
                        labelStyle:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
    final Widget modosWidget = GetBuilder<FiltrosController>(builder: (_) {
      print('build modos');
      return Container(
          height: 100,
          width: Get.width,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10, bottom: 20),
                  child: const Text(
                    'Modo de jogo',
                    style: TextStyle(fontSize: 20),
                  )),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: UtilService()
                      .MODOS
                      .map(
                        (m) => Container(
                            width: 150,
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: controller.modoSelecionado(m)
                                ? ElevatedButton(
                                    onPressed: () {
                                      controller.selecionarModo(m);
                                    },
                                    child: AutoSizeText(
                                      m.nome,
                                      maxLines: 1,
                                      maxFontSize: 18,
                                      style: const TextStyle(fontSize: 18),
                                    ))
                                : OutlinedButton(
                                    onPressed: () {
                                      controller.selecionarModo(m);
                                    },
                                    child: AutoSizeText(
                                      m.nome,
                                      maxLines: 1,
                                      maxFontSize: 18,
                                      style: const TextStyle(fontSize: 18),
                                    ))),
                      )
                      .toList(),
                ),
              ),
            ],
          ));
    });
    /* final Widget formaWidget = GetBuilder<FiltrosController>(builder: (_) {
      print('build modos');
      return SizedBox(
          height: 100,
          width: Get.width,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10, bottom: 20),
                  child: const Text(
                    'Forma de jogo',
                    style: TextStyle(fontSize: 20),
                  )),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: controller.formasDeJogo
                      .map(
                        (m) => Container(
                            width: 150,
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: controller.modoSelecionado(m)
                                ? ElevatedButton(
                                    onPressed: () {
                                      controller.selecionarModo(m);
                                    },
                                    child: AutoSizeText(
                                      m.nome,
                                      maxLines: 1,
                                      maxFontSize: 18,
                                      style: const TextStyle(fontSize: 18),
                                    ))
                                : OutlinedButton(
                                    onPressed: () {
                                      controller.selecionarModo(m);
                                    },
                                    child: AutoSizeText(
                                      m.nome,
                                      maxLines: 1,
                                      maxFontSize: 18,
                                      style: const TextStyle(fontSize: 18),
                                    ))),
                      )
                      .toList(),
                ),
              ),
            ],
          ));
    }); */

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtros'),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: ListView(
          shrinkWrap: true,
          children: [kdWidget, Divider(), modosWidget],
        ),
      ),
    );
  }
}
