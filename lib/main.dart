import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:o_pai_ta_on/initial_binding.dart';
import 'package:o_pai_ta_on/routes/app_pages.dart';
import 'package:o_pai_ta_on/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      initialRoute: Routes.INITIAL,
      getPages: AppPages.pages,
      title: 'O pai tá on!',
      theme: ThemeData.dark(),
    );
  }
}
