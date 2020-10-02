import 'package:flutter/material.dart';
import 'package:helpdesk/screens/REGISTRATION/sign.dart';

class SignScaffold extends StatefulWidget {
  @override
  _SignScaffoldState createState() => _SignScaffoldState();
}

class _SignScaffoldState extends State<SignScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SignIn(),
    ));
  }
}
