import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:o_pai_ta_on/components/inserir_dados/inserir_dados_controller.dart';
import 'package:o_pai_ta_on/components/inserir_dados/inserir_dados_repository.dart';
import 'package:o_pai_ta_on/model/modo_model.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class InserirDadosPage extends StatelessWidget {
  BannerAd? bannerAd;
  AdWidget? adWidget;
  final InserirDadosController controller =
      Get.put(InserirDadosController(InserirDadosRepository()));
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

  InserirDadosPage({Key? key}) : super(key: key) {
    bannerAd = BannerAd(
      adUnitId: kDebugMode
          ? BannerAd.testAdUnitId
          : 'ca-app-pub-8822334834267652/4206862456',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
  }

  Widget cardAviso() {
    return GetX<InserirDadosController>(
      builder: (_) {
        if (_.preencheuPerfil) {
          return Container();
        }
        return Container(
            margin: const EdgeInsets.only(top: 20, right: 10),
            height: 70,
            width: Get.width,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
                child: Container(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: const Text(
                  'Preencha o seu perfil para que as pessoas possam te achar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            )));
      },
    );
  }

  Widget nomeIdCampo() {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Container(
                margin: marginLabel,
                alignment: Alignment.center,
                child: Text('Id', style: styleLabel),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: marginInput,
                padding: paddingInput,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.idController,
                  style: styleInput,
                  textAlign: TextAlign.center,
                  onFieldSubmitted: (str) {
                    controller.onIdSubmit();
                  },
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'seuid#99999999',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Container(
                margin: marginLabel,
                alignment: Alignment.center,
                child: Text('KD', style: styleLabel),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: marginInput,
                padding: paddingInput,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.kdController,
                  style: styleInput,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (str) {
                    controller.onKdSubmit();
                  },
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '9.99',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget selectPlataforma() {
    return Column(
      children: [
        Container(
          margin: marginLabel,
          alignment: Alignment.center,
          child: Text('Qual a sua plataforma?', style: styleLabel),
        ),
        Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
            width: Get.width,
            height: 60,
            child: GetBuilder<InserirDadosController>(builder: (_) {
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
          child: Text('Como tu gosta de jogar?', style: styleLabel),
        ),
        Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
            width: Get.width,
            height: 60,
            child: GetBuilder<InserirDadosController>(builder: (_) {
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

  Widget selectEstado() {
    return SizedBox(
      height: 100,
      width: Get.width,
      child: Column(
        children: [
          Container(
            margin: marginLabel,
            alignment: Alignment.center,
            child: Text('Quer falar de onde tu joga?', style: styleLabel),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            width: Get.width,
            child: GetBuilder<InserirDadosController>(
              builder: (_) {
                return OutlinedButton(
                  child: Text(
                    controller.estadoSelecionado != null
                        ? controller.estadoSelecionado!['nome']!.toUpperCase()
                        : 'SELECIONAR ESTADO',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: controller.selecionaEstado,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget botaoSalvar() {
    return GetBuilder<InserirDadosController>(
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.only(left: 30, right: 30),
          height: 50,
          width: Get.width,
          child: ElevatedButton(
            child: const Text('SALVAR CADASTRO'),
            onPressed: _.dadosValidos
                ? () {
                    _.submitCadastro();
                  }
                : null,
          ),
        );
      },
    );
  }

  Widget selectModo() {
    List<S2Choice<Modo?>> options = UtilService()
        .MODOS
        .map((m) => S2Choice<Modo?>(value: m, title: m.nome))
        .toList();

    return GetBuilder<InserirDadosController>(
      builder: (_) {
        return SmartSelect<Modo?>.single(
            title: 'MODO PREFERIDO',
            placeholder:
                _.modoPreferido != null ? _.modoPreferido!.nome : 'Selecione',
            selectedValue: _.modoPreferido,
            choiceItems: options,
            onChange: (state) => state.value == null
                ? () => print('state value: ${state.value}')
                : _.selecionaModo(state.value!));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      bannerAd!.load();
      adWidget = AdWidget(ad: bannerAd!);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seus dados'),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Stack(
        children: [
          ListView(
            controller: controller.scrollController,
            children: [
              cardAviso(),
              nomeIdCampo(),
              const Padding(padding: EdgeInsets.all(5)),
              const Divider(
                color: Colors.white,
              ),
              selectModo(),
              Divider(),
              selectPlataforma(),
              const Divider(
                color: Colors.white,
              ),
              selectFormaJogo(),
              const Divider(),
              selectEstado(),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: adWidget,
                width: Get.width,
                height: 100,
              ),
              botaoSalvar(),
              Container()
            ],
          ),
          //Positioned(bottom: 10, child: botaoSalvar())
        ],
      ),
    );
  }
}
