import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService() {
    print("New AuthService");
  }

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  Future logout() {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }

  Future createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {}

  Future<FirebaseUser> loginUser({String email, String password})async{
    try{
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
      notifyListeners();
      return result.user;
    }
    catch(e){
      throw new AuthException(e.code, e.message);
    }
  }
}
