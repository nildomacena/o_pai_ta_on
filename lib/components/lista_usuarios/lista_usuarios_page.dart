import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:o_pai_ta_on/components/lista_usuarios/card_usuario.dart';
import 'package:o_pai_ta_on/components/lista_usuarios/lista_usuarios_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListaUsuarios extends StatelessWidget {
  ListaUsuariosController controller = Get.put(ListaUsuariosController());
  BannerAd? bannerAd;
  AdWidget? adWidget;

  ListaUsuarios({Key? key}) : super(key: key) {
    bannerAd = BannerAd(
      adUnitId: kDebugMode
          ? BannerAd.testAdUnitId
          : 'ca-app-pub-8822334834267652/4206862456',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      try {
        bannerAd!.load();
        adWidget = AdWidget(ad: bannerAd!);
      } catch (e) {
        print('Erro ao carregar banner: $e');
      }
    });
    Widget futureBuilderPlaceholder = FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return SizedBox(
                height: Get.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    const Text(
                      'Não foram encontrados usuários para os filtros selecionados',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        child: const Text('LIMPAR FILTROS'),
                        onPressed: () {
                          controller.limparFiltros();
                        },
                      ),
                    )
                  ],
                ),
              );
          }
        });

    return GetBuilder<ListaUsuariosController>(
      builder: (_) {
        if (_.usuarios == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GetX<ListaUsuariosController>(builder: (_) {
                    if (!_.preencheuPerfil) {
                      return Container(
                          margin: const EdgeInsets.only(
                              top: 20, right: 10, bottom: 400),
                          height: 70,
                          width: Get.width,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                              child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: const Text(
                                'Preencha o seu perfil para que as pessoas possam te achar\nClique no menu no canto inferior direito e coloque seus dados',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          )));
                    }
                    return AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _.usuarios.isNotEmpty
                            ? _.usuarios.length + (_.isAdLoaded ? 1 : 0)
                            : 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (_.usuarios.isEmpty) {
                            return futureBuilderPlaceholder;
                          }
                          if (_.isAdLoaded && _.isIndexAd(index)) {
                            return Container(
                                color: Colors.white,
                                width: Get.width,
                                height: 70,
                                child: AdWidget(ad: _.ad));
                          }
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                    child: CardUsuario(_
                                        .usuarios[_.getIndexRealITem(index)]))),
                          );
                        },
                      ),
                    );
                  }),
                ),
                Container(
                  //margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: adWidget,
                  width: Get.width,
                  height: AdSize.fullBanner.height.toDouble(),
                )
              ],
            ),
            Positioned(
              bottom: 70,
              right: 30,
              child: FloatingActionButton(
                child: const Icon(FontAwesomeIcons.filter),
                onPressed: () {
                  controller.abrirFiltros();
                },
              ),
            )
          ],
        );
      },
    );
  }
}
