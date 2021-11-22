import 'package:get/get.dart';
import 'package:o_pai_ta_on/data/provider/auth_provider.dart';
import 'package:o_pai_ta_on/data/provider/firestore_provider.dart';
import 'package:o_pai_ta_on/model/modo_model.dart';
import 'package:o_pai_ta_on/model/usuario_model.dart';

class InserirDadosRepository {
  FirestoreProvider firestoreProvider = Get.find();
  AuthProvider authProvider = Get.find();
  Future<Usuario?> getUsuario() {
    return firestoreProvider.getUsuario();
  }

  Future<dynamic> salvarDadosUsuario(
      String id, double kd, String plataforma, String forma, Modo modo,
      [String? estado]) async {
    return firestoreProvider.salvarDadosUsuario(
        id, kd, plataforma, forma, modo, estado);
  }

  Stream<bool> preencheuPerfil() {
    return authProvider.preencheuPerfil();
  }

  logout() {
    authProvider.logout();
  }
}
