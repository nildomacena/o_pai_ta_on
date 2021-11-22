import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:o_pai_ta_on/model/modo_model.dart';
import 'package:o_pai_ta_on/model/usuario_model.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:stream_transform/stream_transform.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = Get.find();
  final FirebaseAuth _auth = Get.find();
  final Rxn<Usuario> usuario$ = Rxn<Usuario>(null);

  FirestoreProvider() {
    /* _auth.authStateChanges().listen((user) async {
      if (user != null) {
        usuario$.value = await getUsuario(uid: user.uid);
      } else {
        usuario$.value = null;
      }
    }); */

    usuario$.bindStream(_auth
        .authStateChanges()
        .concurrentAsyncExpand((user) => streamUsuarioByUser(user)));
  }

  Stream<List<Usuario>> streamUsuarios(
      [double? kdInicial,
      double? kdFinal,
      String? modo,
      String? forma,
      String? estado,
      String? plataforma]) {
    Query query = _firestore
        .collection('usuarios')
        .where('preencheuPerfil', isEqualTo: true);
    if (kdInicial != null) {
      query = query.where('kd', isGreaterThanOrEqualTo: kdInicial);
    }
    if (kdFinal != null) {
      query = query.where('kd', isLessThanOrEqualTo: kdFinal);
    }
    if (forma != null) {
      query = query.where('forma', isEqualTo: forma);
    }
    if (modo != null) {
      query = query.where('modo', isEqualTo: modo);
    }
    if (plataforma != null) {
      query = query.where('plataforma', isEqualTo: plataforma);
    }
    if (kdFinal == null && kdInicial == null) {
      query = query.orderBy('timestamp', descending: true);
    }
    print(plataforma);
    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((s) => Usuario.fromFirestore(s)).toList());
  }

  Future<List<Usuario>> getUsuarios() async {
    QuerySnapshot snapshot = await _firestore
        .collection('usuarios')
        .where('preencheuPerfil', isEqualTo: true)
        .get();
    return snapshot.docs.map((s) => Usuario.fromFirestore(s)).toList();
  }

  Stream<Usuario?> streamUsuarioByUser(User? user) {
    if (user == null) return Stream.value(null);
    return _firestore
        .doc('usuarios/${user.uid}')
        .snapshots()
        .map((snapshot) => Usuario.fromFirestore(snapshot));
  }

  Future<Usuario?> getUsuario({String? uid}) async {
    if (_auth.currentUser == null) return null;
    DocumentSnapshot snapshot = await _firestore
        .doc('usuarios/${uid != null ? uid : _auth.currentUser!.uid}')
        .get();
    return Usuario.fromFirestore(snapshot);
  }

  Future<dynamic> salvarDadosUsuario(
      String id, double kd, String plataforma, String forma, Modo modo,
      [String? estado]) async {
    if (_auth.currentUser == null) throw 'usuario-nulo';
    return _firestore.doc('usuarios/${_auth.currentUser!.uid}').update({
      'preencheuPerfil': true,
      'id': id,
      'kd': kd,
      'plataforma': plataforma,
      'forma': forma,
      'modoSigla': modo.sigla,
      'modo': modo.toJson,
      'estado': estado ?? ''
    });
  }
}
