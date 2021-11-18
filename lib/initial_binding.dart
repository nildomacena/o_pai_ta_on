import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:o_pai_ta_on/data/provider/auth_provider.dart';
import 'package:o_pai_ta_on/data/provider/firestore_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseAuth.instance, permanent: true);
    Get.put(FirebaseFirestore.instance, permanent: true);
    Get.put(AuthProvider(), permanent: true);
    Get.put(FirestoreProvider(), permanent: true);
  }
}
