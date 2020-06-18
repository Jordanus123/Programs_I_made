import 'package:flutter/material.dart';
import 'package:helpdesk/screens/auth_streamed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'AMACC Biñan Mobile Helpdesk and FAQ Application',
      theme: ThemeData(
       
      ),
      home: Authstreamed(),
    );
  }
}
