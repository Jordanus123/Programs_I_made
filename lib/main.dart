import 'package:flutter/material.dart';
import 'package:helpdesk/provider/auth_provider.dart';
import 'package:helpdesk/provider/firebase_provider.dart';
import 'package:helpdesk/screens/initialize.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'AMACC Biñan Mobile Helpdesk and FAQ Application',
        theme: ThemeData(),
        home: Initialize(),
      ),
    );
  }
}
