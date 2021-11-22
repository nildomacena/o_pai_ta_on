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
    /*   firestoreProvider.streamUsuarios().listen((u) {
      print('usuarios: $u');
      usuarios = u;
      /*   if (kDebugMode && usuarios != null) {
        usuarios = [
          ...usuarios!,
          ...usuarios!,
          ...usuarios!,
          ...usuarios!,
          ...usuarios!
        ];
      } */
      bannerAd.load();
      update();
    }); */
    super.onInit();
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
