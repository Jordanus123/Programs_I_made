import 'package:flutter/material.dart';
import 'package:helpdesk/screens/REGISTRATION/login.dart';

class LoginScaffold extends StatefulWidget {
  @override
  _LoginScaffoldState createState() => _LoginScaffoldState();
}

class _LoginScaffoldState extends State<LoginScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Loginscreen(),
      ),
    );
  }
}
