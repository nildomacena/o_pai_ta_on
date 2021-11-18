import 'package:get/get.dart';
import 'package:o_pai_ta_on/components/home/home_binding.dart';
import 'package:o_pai_ta_on/components/home/home_page.dart';
import 'package:o_pai_ta_on/components/inserir_dados/inserir_dados_binding.dart';
import 'package:o_pai_ta_on/components/inserir_dados/inserir_dados_page.dart';
import 'package:o_pai_ta_on/components/login/login_binding.dart';
import 'package:o_pai_ta_on/components/login/login_page.dart';
import 'package:o_pai_ta_on/components/login/login_repository.dart';
import 'package:o_pai_ta_on/routes/app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: Routes.HOME,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.INSERIR_DADOS,
        page: () => InserirDadosPage(),
        binding: InserirDadosBinding()),
  ];
}
