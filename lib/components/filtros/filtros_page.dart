import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/filtros/filtros_controller.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class FiltrosPage extends StatelessWidget {
  FiltrosController controller = Get.put(FiltrosController());
  FiltrosPage({Key? key}) : super(key: key);
  final TextStyle styleLabel =
      const TextStyle(color: Colors.white, fontSize: 20);
  final TextStyle styleInput =
      const TextStyle(color: Colors.black, fontSize: 18);
  final EdgeInsetsGeometry marginLabel = const EdgeInsets.only(
    left: 10,
    right: 10,
    top: 10,
  );
  final EdgeInsetsGeometry marginInput = const EdgeInsets.only(
    left: 10,
    right: 10,
    top: 5,
  );
  final EdgeInsetsGeometry paddingInput = const EdgeInsets.only(
    left: 10,
    right: 10,
  );

  Widget selectPlataforma() {
    return Column(
      children: [
        Container(
          margin: marginLabel,
          alignment: Alignment.center,
          child: Text('Plataforma', style: styleLabel),
        ),
        Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
            width: Get.width,
            height: 60,
            child: GetBuilder<FiltrosController>(builder: (_) {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _.selecionaPlataforma('ps');
                      },
                      child: Container(
                          height: 60,
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                              color: _.plataformaSelecionada == 'ps'
                                  ? Colors.red[300]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset('assets/icons/ps.png')),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _.selecionaPlataforma('xbox');
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                              color: _.plataformaSelecionada == 'xbox'
                                  ? Colors.red[300]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset('assets/icons/xbox.png')),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _.selecionaPlataforma('battle');
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                              color: _.plataformaSelecionada == 'battle'
                                  ? Colors.red[300]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset('assets/icons/battle-net.png')),
                    ),
                  ),
                ],
              );
            })),
      ],
    );
  }

  Widget selectFormaJogo() {
    return Column(
      children: [
        Container(
          margin: marginLabel,
          alignment: Alignment.center,
          child: Text('Forma de jogo', style: styleLabel),
        ),
        Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
            width: Get.width,
            height: 60,
            child: GetBuilder<FiltrosController>(builder: (_) {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _.selecionaFormaJogo('rush');
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          height: 60,
                          decoration: BoxDecoration(
                              color: _.formaJogoSelecionada == 'rush'
                                  ? Colors.red[300]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/icons/rush.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: const AutoSizeText(
                                  'Rushando',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _.selecionaFormaJogo('mix');
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          height: 60,
                          decoration: BoxDecoration(
                              color: _.formaJogoSelecionada == 'mix'
                                  ? Colors.red[300]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/icons/mix.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: const AutoSizeText(
                                  'Mix',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _.selecionaFormaJogo('safe');
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          height: 60,
                          decoration: BoxDecoration(
                              color: _.formaJogoSelecionada == 'safe'
                                  ? Colors.red[300]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/icons/safe.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: const AutoSizeText(
                                  'Safe',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              );
            })),
      ],
    );
  }

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
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    controller: controller.kdInicial,
                    onSubmitted: (String str) {
                      controller.onKdSubmitted();
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.kdInicial.text = '';
                            },
                            icon: const Icon(Icons.clear)),
                        border: const OutlineInputBorder(),
                        hintText: 'Ex.: 9.99',
                        hintStyle:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                        labelText: 'KD INICIAL',
                        labelStyle:
                            const TextStyle(fontSize: 13, color: Colors.white)),
                  ),
                )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    controller: controller.kdFinal,
                    onSubmitted: (String str) {
                      controller.onKdSubmitted();
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.kdFinal.text = '';
                            },
                            icon: const Icon(Icons.clear)),
                        border: const OutlineInputBorder(),
                        hintText: 'Ex.: 9.99',
                        hintStyle:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                        labelText: 'KD FINAL',
                        labelStyle:
                            const TextStyle(fontSize: 13, color: Colors.white)),
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
          margin: const EdgeInsets.only(bottom: 5),
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
                            child: controller.isModoSelecionado(m)
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

    final Widget botaoFiltrar = GetBuilder<FiltrosController>(builder: (_) {
      if (!_.mostrarBotao) return Container();
      return Container(
        alignment: Alignment.center,
        width: Get.width,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ElevatedButton(
            onPressed: () {
              _.definirFiltros();
            },
            child: const Text('SELECIONAR FILTROS')),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtros'),
        actions: [
          GetBuilder<FiltrosController>(builder: (_) {
            if (_.mostrarBotao) {
              return TextButton(
                  onPressed: () {
                    _.limparFiltros();
                  },
                  child: const Text('LIMPAR FILTROS'));
            }
            return Container();
          })
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                kdWidget,
                const Divider(),
                modosWidget,
                const Divider(),
                selectPlataforma(),
                selectFormaJogo()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: botaoFiltrar,
          )
        ],
      ),
    );
  }
}
