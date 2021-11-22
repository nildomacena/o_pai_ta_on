import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:o_pai_ta_on/components/filtros/filtros_page.dart';
import 'package:o_pai_ta_on/data/provider/auth_provider.dart';
import 'package:o_pai_ta_on/data/provider/firestore_provider.dart';
import 'package:o_pai_ta_on/model/usuario_model.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class ListaUsuariosController extends GetxController {
  Map<String, dynamic>? filtros = {};
  final RxList<Usuario> _usuarios = RxList<Usuario>();
  final RxBool _preencheuPerfil = RxBool(false);
  final FirestoreProvider firestoreProvider = Get.find();
  final AuthProvider authProvider = Get.find();
  static const _kAdIndex = 4;

  late NativeAd ad;
  bool isAdLoaded = false;

  bool possuiFiltros = false;
  final BannerAd bannerAd = BannerAd(
    adUnitId: kDebugMode
        ? BannerAd.testAdUnitId
        : 'ca-app-pub-8822334834267652/4206862456',
    size: AdSize(height: 100, width: Get.width.toInt()),
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  List<Usuario> get usuarios => _usuarios.toList();
  set usuarios(List<Usuario> value) => _usuarios.value = value;

  bool get preencheuPerfil => _preencheuPerfil.value;

  @override
  void onInit() {
    _preencheuPerfil.bindStream(authProvider.preencheuPerfil());
    updateStreamUsuarios();
    preparaAnuncio();
    super.onInit();
  }

  @override
  void onClose() {
    ad.dispose();
    bannerAd.dispose();
    super.onClose();
  }

  preparaAnuncio() async {
    ad = NativeAd(
      adUnitId: kDebugMode
          ? NativeAd.testAdUnitId
          : 'ca-app-pub-8822334834267652/2456513112',
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          isAdLoaded = true;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    await ad.load();
    update();
  }

  bool isIndexAd(int index) {
    return index == _kAdIndex;
  }

  int getIndexRealITem(int rawIndex) {
    if (rawIndex >= _kAdIndex && isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  updateStreamUsuarios(
      [double? kdInicial,
      double? kdFinal,
      String? modo,
      String? forma,
      String? plataforma,
      String? estado]) {
    _usuarios.bindStream(firestoreProvider.streamUsuarios(
        kdInicial, kdFinal, modo, forma, estado, plataforma));
    /* _usuarios.listen((u) {
      usuarios = u;
      print('uuuu: $u');
    }); */
  }

  updateUsuarios() async {
    usuarios = await firestoreProvider.getUsuarios();
    if (kDebugMode) {
      usuarios = [
        ...usuarios,
        ...usuarios,
        ...usuarios,
        ...usuarios,
        ...usuarios
      ];
    }
    print('usuarios: $usuarios');
    update();
  }

  copiar(String id) {
    FlutterClipboard.copy(id)
        .then((value) => UtilService().showToast('copiado'));
  }

  limparFiltros() {
    filtros = null;
    updateStreamUsuarios();
  }

  abrirFiltros() async {
    filtros = await Get.to(() => FiltrosPage(),
        fullscreenDialog: true, arguments: {'filtros': filtros});
    if (filtros != null) {
      updateStreamUsuarios(
        filtros!['kdInicial'],
        filtros!['kdFinal'],
        filtros!['modo'],
        filtros!['forma'],
        filtros!['plataforma'],
        filtros!['estado'],
      );
    } else {
      limparFiltros();
    }
    print('result: $filtros');
  }
}
