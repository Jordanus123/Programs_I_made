import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpdesk/screens/welcome4.dart';
import 'package:helpdesk/utils/colors.dart';

import 'REGISTRATION/login.dart';

class Authstreamed extends StatefulWidget {
  @override
  _AuthstreamedState createState() => _AuthstreamedState();
  
  
}

class _AuthstreamedState extends State<Authstreamed> {
  FirebaseUser user;
  @override
Widget build(BuildContext context) => StreamBuilder<FirebaseUser>(
		stream: FirebaseAuth.instance.onAuthStateChanged,
		builder: (context, snapshot){
			if(snapshot.hasError) {return Loginscreen();}
			if(snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold( 
          body: Container(
            height: 20.0,
            width: 20.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppThemeColors.primary.withOpacity(0.7)
              )
            ),
          ) 
        );
      }
			if(!snapshot.hasData) return Loginscreen();  
			return WelcomeScreen4(userid: snapshot.data.uid);
                      },
                    );
                  }