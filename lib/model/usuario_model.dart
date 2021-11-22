import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:o_pai_ta_on/model/modo_model.dart';
import 'package:o_pai_ta_on/shared/util_service.dart';

class Usuario {
  final String uid;
  final String? nome;
  final String? id;
  final String? estado;
  final String? forma;
  final String? fotoUrl;
  final double? kd;
  final Modo? modo;
  final String? plataforma;
  final DateTime? ultimoLogin;

  Usuario(
      {required this.uid,
      this.nome,
      this.id,
      this.estado,
      this.forma,
      this.fotoUrl,
      this.kd,
      this.modo,
      this.plataforma,
      this.ultimoLogin});

  String get nomePlataforma => plataforma == 'battle'
      ? 'PC'
      : plataforma == 'ps'
          ? 'PlayStation'
          : 'XBOX';

  factory Usuario.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot.data() == null) throw 'usuario-nulo';
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    Modo? modo;
    if (data!['modoSigla'] != null) {
      modo =
          UtilService().MODOS.firstWhere((e) => e.sigla == data['modoSigla']);
    }

    return Usuario(
        uid: snapshot.id,
        nome: data['nome'] as String?,
        id: data['id'] ?? '',
        estado: data['estado'],
        forma: data['forma'],
        fotoUrl: data['fotoUrl'],
        kd: data['kd'],
        modo: modo,
        plataforma: data['plataforma'],
        ultimoLogin:
            data['timestamp'] != null ? data['timestamp'].toDate() : null);
  }
}
