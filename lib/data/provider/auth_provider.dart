import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_transform/stream_transform.dart';

class AuthProvider {
  final FirebaseAuth _auth = Get.find();
  final FirebaseFirestore _firestore = Get.find();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthProvider() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        updateUltimoLogin(user);
        print('AuthProvider user: $user ');
      }
    });
  }
  User? getUser() {
    return _auth.currentUser;
  }

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signIn().catchError((onError) {
        print('Erro ao fazer login: $onError');
      });
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return checkUserInfo(userCredential.user!);
      } else {
        throw 'usuario-cancelou';
      }
    } catch (e) {
      throw 'usuario-cancelou';
    }
  }

  Future<bool> checkUserInfo(User user) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.doc('usuarios/${user.uid}').get();
    //Verifica se o usuário existe no firestore

    if (!documentSnapshot.exists) {
      await _firestore.doc('usuarios/${user.uid}').set({
        'nome': user.displayName,
        'email': user.email,
        'fotoUrl': user.photoURL,
        'preencheuPerfil': false,
        'timestamp': FieldValue.serverTimestamp()
      });
      return true;
    }
    return true;
  }

  Stream<bool> preencheuPerfil() {
    if (_auth.currentUser == null) return Stream.value(false);
    return _firestore
        .doc('usuarios/${_auth.currentUser!.uid}')
        .snapshots()
        .map((snapshot) {
      if (snapshot.data()!['preencheuPerfil'] != null) {
        return snapshot.data()!['preencheuPerfil'] as bool;
      } else {
        return false;
      }
    });

    /* .map((user) {
      if (user == null) {
        return false;
      } else {
        return _firestore
            .doc('usuarios/${user.uid}')
            .snapshots()
            .map((snapshot) {
          if (snapshot.data()!['preencheuPerfil'] != null) {
            return snapshot.data()!['preencheuPerfil'] as bool;
          } else {
            return false;
          }
        });
      }
    }); */
  }

  updateUltimoLogin(User user) async {
    DocumentSnapshot snapshot =
        await _firestore.doc('usuarios/${user.uid}').get();
    if (snapshot.exists) {
      _firestore
          .doc('usuarios/${user.uid}')
          .update({'timestamp': FieldValue.serverTimestamp()});
    }
  }

  logout() {
    _auth.signOut();
  }
}
