import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/inserir_dados/inserir_dados_repository.dart';
import 'package:o_pai_ta_on/model/modo_model.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';
import 'package:o_pai_ta_on/widgets/selecionar_estado.dart';
import 'package:o_pai_ta_on/routes/app_routes.dart';

class InserirDadosController extends GetxController {
  final InserirDadosRepository repository;
  String plataformaSelecionada = '';
  String formaJogoSelecionada = '';
  Modo? modoPreferido;
  Map<String, String>? estadoSelecionado;
  InserirDadosController(this.repository);
  TextEditingController nomeController = TextEditingController();
  TextEditingController kdController = MaskedTextController(mask: '0.00');
  TextEditingController idController = TextEditingController();
  final Rx<bool> _preencheuPerfil = Rx<bool>(false);

  FocusNode idFocus = FocusNode();
  FocusNode kdFocus = FocusNode();

  ScrollController scrollController = ScrollController();

  set preencheuPerfil(bool value) => _preencheuPerfil.value = value;
  bool get preencheuPerfil => _preencheuPerfil.value;

  @override
  onInit() {
    _preencheuPerfil.bindStream(repository.preencheuPerfil());

    updateDadosUsuario();
    /*  if (kDebugMode) {
      kdController.text = '1.49';
      idController.text = 'TenMacena#1231231';
      plataformaSelecionada = 'battle';
      formaJogoSelecionada = 'rush';
      modoPreferido = UtilService().MODOS[0];
    } */
    super.onInit();
  }

  updateDadosUsuario() async {
    repository.getUsuario().then((usuario) {
      if (usuario != null) {
        kdController.text = usuario.kd?.toString() ?? '';
        idController.text = usuario.id ?? '';
        plataformaSelecionada = usuario.plataforma ?? '';
        formaJogoSelecionada = usuario.forma ?? '';
        modoPreferido = usuario.modo;
        if (usuario.estado != null && usuario.estado != '') {
          estadoSelecionado = ESTADOS.firstWhere((e) =>
              e['sigla']!.toUpperCase() == usuario.estado!.toUpperCase());
        }
        update();
      }
    });
  }

  bool get dadosValidos =>
      formaJogoSelecionada.isNotEmpty &&
      plataformaSelecionada.isNotEmpty &&
      kdController.text.isNotEmpty &&
      modoPreferido != null;
  selecionaPlataforma(String plataforma) {
    plataformaSelecionada = plataforma;
    update();
  }

  selecionaFormaJogo(String forma) {
    formaJogoSelecionada = forma;
    scrollController.animateTo(Get.height,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    update();
  }

  void selecionaModo(Modo modo) {
    modoPreferido = modo;
    kdFocus.unfocus();
    idFocus.unfocus();
    print('modo: $modo');
    update();
  }

  selecionaEstado() async {
    estadoSelecionado =
        await Get.to(() => const SelecionarEstado(), fullscreenDialog: true);
    update();
  }

  onIdSubmit() {
    kdFocus.requestFocus();
  }

  onKdSubmit() {
    try {
      print(double.parse(kdController.text.replaceAll(',', '.')));
    } catch (e) {
      print(e);
      if (e.runtimeType == FormatException) {
        UtilService()
            .snackBarErro(mensagem: 'Digite um KD válido no formato 9.99');
      }
    }
    kdFocus.unfocus();
  }

  submitCadastro() async {
    try {
      if (modoPreferido == null) {
        UtilService().showToast('Selecione seu modo de jogo preferido');
        return;
      }
      UtilService().showAlertCarregando('Salvando dados');
      await repository.salvarDadosUsuario(
          idController.text,
          double.parse(kdController.text.replaceAll(',', '.')),
          plataformaSelecionada,
          formaJogoSelecionada,
          modoPreferido!,
          estadoSelecionado?['sigla']);
      UtilService().showToast('Dados salvos');

      UtilService().fecharAlert();
    } catch (e) {
      UtilService().fecharAlert();
      UtilService().snackBarErro(
          mensagem:
              'Ocorreu um erro ao salvar os dados.\nTente novamente mais tarde');
    }
  }

  logout() {
    repository.logout();
    Get.offAllNamed(Routes.INITIAL);
  }
}
