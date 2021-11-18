import 'package:o_pai_ta_on/components/login/login_repository.dart';
import 'package:o_pai_ta_on/routes/app_routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final videoController =
      VideoPlayerController.asset('assets/videos/login.mp4');
  final LoginRepository repository = Get.put(LoginRepository());
  final RxBool _videoInitialized = false.obs;

  set videoInitialized(bool value) => _videoInitialized.value = value;
  bool get videoInitialized => _videoInitialized.value;
  bool? autenticado;

  @override
  void onInit() async {
    setSplashscreen();
    /* videoController.setVolume(0);
    videoController.setLooping(true);

    await videoController.initialize();
    videoInitialized = true;
    videoController.play(); */
    super.onInit();
  }

  Future<void> setSplashscreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    autenticado = repository.usuarioAutenticado();
    print('Autenticaod: $autenticado');
    if (autenticado == true) {
      Get.offAllNamed(Routes.HOME);
      return;
    }
    update();
  }

  loginWithGoogle() async {
    try {
      await repository.loginWithGoogle();
      videoController.dispose();
      Get.offAllNamed(Routes.HOME);
      Fluttertoast.showToast(msg: 'Você está logado');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erro ao fazer login. Tente novamente');
    }
  }
  /* final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value; */
}
