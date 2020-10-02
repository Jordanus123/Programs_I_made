import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/screens/REGISTRATION/login.dart';
import 'package:helpdesk/screens/REGISTRATION/login_scaffold.dart';
import 'package:helpdesk/screens/welcome4.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      setState(() {});
      firebaseUser = user;
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  User firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // return LoginScreen();

    if (firebaseUser == null) {
      return LoginScaffold();
    } else {
      return WelcomeScreen4();
    }
  }
}
