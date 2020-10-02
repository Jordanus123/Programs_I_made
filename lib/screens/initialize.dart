import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/services/auth_screen.dart';

class Initialize extends StatefulWidget {
  @override
  _InitializeState createState() => _InitializeState();
}

class _InitializeState extends State<Initialize> {
  bool initializing = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  Future<Null> initialize() async {
    var result = await Firebase.initializeApp().then((value) {
      initializing = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (initializing) {
      return Center(child: CircularProgressIndicator());
    } else {
      return AuthScreen();
    }
  }
}
