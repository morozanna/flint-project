import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Authentication extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    User user;
    String error;
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
    } catch (e) {
      if (e.code == 'user-not-found') {
        error = 'Error: No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Error: Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        error = 'Error: Invalid e-mail';
      } else
        error = "Error: " + e.code.toString().replaceAll('-', ' ');
    }
    if (error != null) {
      return error;
    }
    notifyListeners();

    return user.uid;
  }

  Future<void> logout() async {
    var result = await _auth.signOut();
    notifyListeners();
    return result;
  }

  User getUser() {
    return _auth.currentUser;
  }
}
