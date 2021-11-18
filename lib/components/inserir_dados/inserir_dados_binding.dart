import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/inserir_dados/inserir_dados_controller.dart';
import 'package:o_pai_ta_on/components/inserir_dados/inserir_dados_repository.dart';

class InserirDadosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InserirDadosController>(
        () => InserirDadosController(InserirDadosRepository()));
  }
}
