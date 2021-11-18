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
      bannerAd!.load();
      adWidget = AdWidget(ad: bannerAd!);
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
              children: [
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.usuarios != null
                          ? controller.usuarios!.length
                          : 1,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: CardUsuario(_.usuarios![index]))),
                        );
                      },
                    ),
                  ),
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
