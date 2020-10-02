import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'REGISTRATION/login.dart';

class Inactive extends StatefulWidget {
  @override
  _InactiveState createState() => _InactiveState();
}

class _InactiveState extends State<Inactive> {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlatButton(
              onPressed: () async {
                signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Loginscreen()));
                ;
              },
              child: Text("ACCOUNT DEACTIVATED. PRESS TO LOGOUT"))),
    );
  }

  static Future<void> signOut() async {
    await _auth
        .signOut()
        .then((_) => print("sign out auth performed"))
        .catchError((err) => print("sign out auth error $err"));
  }

// Scaffold(
//           body:Container(
//           height: MediaQuery.of(context).size.height,
//           color: Colors.white,
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   Text("ACCOUNT HAS BEEN DEACTIVATED"),
//                   FlatButton(onPressed: ()async{signOut(); Navigator.push(context, MaterialPageRoute( builder: (BuildContext context) => Loginscreen()));;}, child: Text("LOGOUT"))
//                 ],
//               ),
//             ),

//         ),

//     );
}
