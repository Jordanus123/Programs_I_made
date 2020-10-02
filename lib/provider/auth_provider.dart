import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class AuthProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User _user = FirebaseAuth.instance.currentUser;
  bool logging = false;

  Status _status = Status.Uninitialized;
  final db = FirebaseAuth.instance;

  Status get status => _status;

  User get user => _user;

  Future<String> register(String email, String password, String name,
      String age, String usn, String contact, String course) async {
    logging = true;
    notifyListeners();
    try {
      print('asdads');
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((currentUser) {
        try {
          FirebaseFirestore.instance
              .collection("user")
              .doc(currentUser.user.uid)
              .set({
            "uid": currentUser.user.uid,
            "email": email,
            "password": password,
            "name": name,
            "status": 'active',
            "contact": contact,
            "age": age,
            "course": course,
            "usn": usn,
            'account': 'student'
          });
          _user = currentUser.user;
        } catch (e) {
          print(e);
        }
        return;
      });
      logging = false;
      notifyListeners();
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logging = false;
        notifyListeners();
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        logging = false;
        notifyListeners();
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print('catch');
      return (e.toString());
    }
    logging = false;
    notifyListeners();
    return "Please input proper email/password";
  }

  Future<String> logIn(email, password) async {
    logging = true;
    notifyListeners();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _user = value.user;
      });
      logging = false;
      notifyListeners();
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        logging = false;
        notifyListeners();
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        logging = false;
        notifyListeners();
        return ('Wrong password provided for that user.');
      }
    }
    logging = false;
    notifyListeners();
    return "Please input proper values";
  }

  Future<Null> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
