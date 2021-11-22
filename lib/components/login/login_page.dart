import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:o_pai_ta_on/components/login/login_controller.dart';
import 'package:o_pai_ta_on/data/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.find();
  BannerAd? bannerAd;
  AdWidget? adWidget;
  LoginPage({Key? key}) : super(key: key) {
    bannerAd = BannerAd(
      adUnitId: kDebugMode
          ? BannerAd.testAdUnitId
          : 'ca-app-pub-8822334834267652/2104131655',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
  }

  Widget splashcreenContainer() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /* Image.asset(
            'assets/images/splashscreen.png',
            fit: BoxFit.cover,
          ), */
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 130),
            alignment: Alignment.center,
            height: Get.height,
            width: Get.width,
            color: Colors.black.withOpacity(.6),
            child: const Text(
              'Cansado de jogar com aleatório?\nCola com o pai aqui!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.red,
                  ),
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 1.0,
                    color: Colors.red,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
              bottom: 15,
              child: SizedBox(
                width: Get.width,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget loginContainer() {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoPlayer(controller.videoController),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 130),
            alignment: Alignment.center,
            height: Get.height,
            width: Get.width,
            color: Colors.black.withOpacity(.6),
            child: const Text(
              'Cansado de jogar com aleatório?\nCola com o pai aqui!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.red,
                  ),
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 1.0,
                    color: Colors.red,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 140,
            child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                width: Get.width,
                child: GoogleAuthButton(
                  text: 'Login com Google',
                  onPressed: () {
                    controller.loginWithGoogle();
                  },
                )),
          ),
          Positioned(
            bottom: -40,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              child: adWidget,
              width: Get.width,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      bannerAd!.load();
      adWidget = AdWidget(ad: bannerAd!);
    });
    return Scaffold(
      body: SafeArea(child: GetBuilder<LoginController>(
        builder: (_) {
          if (controller.autenticado == null) {
            return splashcreenContainer();
          }
          return loginContainer();
        },
      )),
    );
  }
}
