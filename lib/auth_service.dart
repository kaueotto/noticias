import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthExeption implements Exception {
  String Message;
  AuthExeption(this.Message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthExeption('A senha e muito Fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthExeption('Email ja esta sendo utilizado');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthExeption('Email nao encontrado, cadastre-se');
      } else if (e.code == 'wrong-password') {
        throw AuthExeption('Senha incorreta');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
