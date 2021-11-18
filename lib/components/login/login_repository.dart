import 'package:get/get.dart';
import 'package:o_pai_ta_on/data/provider/auth_provider.dart';

class LoginRepository {
  final AuthProvider authProvider = Get.find();

  LoginRepository();

  Future<dynamic> loginWithGoogle() {
    return authProvider.loginWithGoogle();
  }

  bool usuarioAutenticado() {
    return authProvider.getUser() != null;
  }
}
