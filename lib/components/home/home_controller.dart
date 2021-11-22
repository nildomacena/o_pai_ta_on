import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:o_pai_ta_on/components/home/home_repository.dart';
import 'package:o_pai_ta_on/components/inserir_dados/inserir_dados_page.dart';
import 'package:o_pai_ta_on/components/lista_usuarios/lista_usuarios_page.dart';
import 'package:o_pai_ta_on/model/usuario_model.dart';
import 'package:o_pai_ta_on/routes/app_routes.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  final Rxn<Usuario> _usuario = Rxn<Usuario>(null);
  final Rx<bool> _preencheuPerfil = Rx<bool>(false);
  int indexBottomNavigation = 0;
  List<Widget> pages = [
    ListaUsuarios(),
    InserirDadosPage(),
  ];

  HomeController(this.repository) {
    _usuario.bindStream(repository.streamUsuario());
    _preencheuPerfil.bindStream(repository.preencheuPerfil());
    repository.streamUsuario().first.then((value) => usuario = value);
  }

  set usuario(Usuario? value) => _usuario.value = value;
  Usuario? get usuario => _usuario.value;

  set preencheuPerfil(bool value) => _preencheuPerfil.value = value;
  bool get preencheuPerfil => _preencheuPerfil.value;

  Widget get paginaAtual => pages[indexBottomNavigation];

  @override
  void onInit() async {
    mostrarAlertaConcordancia();
    usuario = await repository.atualUsuario();
    super.onInit();
  }

  goToLogin() {
    Get.offAllNamed(Routes.INITIAL);
  }

  mostrarAlertaConcordancia() async {
    await Future.delayed(const Duration(seconds: 1));
    if (GetStorage().read('aceita_termos') == null ||
        !GetStorage().read('aceita_termos')) {
      var result = await AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Termos de concordância',
        desc:
            'Ao clicar no botão abaixo, você concorda com os termos do aplicativo O Pai Tá On, incluindo o fato de que as informações fornecidas serão divulgadas com os usuários do app, visto que esse é o intituito do aplicativo',
        btnCancelText: 'Sair do app',
        btnOkText: 'Aceito os termos',
        btnCancelOnPress: () {
          SystemNavigator.pop();
        },
        btnOkOnPress: () {
          GetStorage().write('aceita_termos', true);
        },
      ).show();
      print('result alert $result');
    }
  }

  inserirDados() {
    Get.to(InserirDadosPage(), fullscreenDialog: true);
  }

  setIndex(int index) {
    indexBottomNavigation = index;
    update();
  }

  logout() {
    repository.logout();
    //Get.offAllNamed(Routes.INITIAL);
  }
  /* final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value; */
}
