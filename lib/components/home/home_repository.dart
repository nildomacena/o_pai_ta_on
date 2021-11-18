import 'package:get/get.dart';
import 'package:o_pai_ta_on/data/provider/auth_provider.dart';
import 'package:o_pai_ta_on/data/provider/firestore_provider.dart';
import 'package:o_pai_ta_on/model/usuario_model.dart';

class HomeRepository {
  FirestoreProvider firestoreProvider = Get.find();
  AuthProvider authProvider = Get.find();

  Stream<Usuario?> streamUsuario() {
    return firestoreProvider.usuario$.stream;
  }

  Future<Usuario?> atualUsuario() {
    return firestoreProvider.getUsuario();
  }

  logout() {
    authProvider.logout();
  }
}
