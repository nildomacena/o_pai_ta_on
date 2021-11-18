import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:o_pai_ta_on/components/filtros/filtros_page.dart';
import 'package:o_pai_ta_on/data/provider/firestore_provider.dart';
import 'package:o_pai_ta_on/model/usuario_model.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class ListaUsuariosController extends GetxController {
  List<Usuario>? usuarios;
  FirestoreProvider firestoreProvider = Get.find();
  BannerAd bannerAd = BannerAd(
    adUnitId: kDebugMode
        ? BannerAd.testAdUnitId
        : 'ca-app-pub-8822334834267652/4206862456',
    size: AdSize(height: 100, width: Get.width.toInt()),
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  @override
  void onInit() {
    firestoreProvider.streamUsuarios().listen((u) {
      print('usuarios: $u');
      usuarios = u;
      if (kDebugMode && usuarios != null) {
        usuarios = [
          ...usuarios!,
          ...usuarios!,
          ...usuarios!,
          ...usuarios!,
          ...usuarios!
        ];
      }
      bannerAd.load();
      update();
    });
    super.onInit();
  }

  updateUsuarios() async {
    usuarios = await firestoreProvider.getUsuarios();
    if (kDebugMode && usuarios != null) {
      usuarios = [
        ...usuarios!,
        ...usuarios!,
        ...usuarios!,
        ...usuarios!,
        ...usuarios!
      ];
    }
    print('usuarios: $usuarios');
    update();
  }

  copiar(String id) {
    FlutterClipboard.copy(id)
        .then((value) => UtilService().showToast('copiado'));
  }

  abrirFiltros() async {
    var result = await Get.to(() => FiltrosPage(), fullscreenDialog: true);
  }
}
