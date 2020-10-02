import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpdesk/provider/auth_provider.dart';
import 'package:helpdesk/screens/ACCOUNT/editProfile_scaffold.dart';
import 'package:helpdesk/screens/ACCOUNT/editprofile.dart';
import 'package:helpdesk/screens/REGISTRATION/login.dart';
import 'package:helpdesk/services/auth_screen.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';
import 'package:helpdesk/utils/hero_dialogue_route.dart';
import 'package:helpdesk/utils/route_animation.dart';
import 'package:provider/provider.dart';
import 'editprofile.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
  final String userid;
  Account({this.userid});
}

class _AccountState extends State<Account> {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot> _getUserInfo;

  @override
  void initState() {
    _getUserInfo = FirebaseFirestore.instance
        .collection('user')
        .doc(widget.userid)
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: _getUserInfo,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                )
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.2, 0.3, 0.3],
                      colors: [
                        Colors.blue[600],
                        Colors.blue[800],
                        Colors.blue[800],
                        Colors.white,
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.topRight,
                            child: Text(
                              "WELCOME TO: ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontFamily: "fallout",
                                  letterSpacing: 4),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                border:
                                    Border.all(color: Colors.white, width: 8),
                                color: Colors.white),
                            child: Center(
                              child: Image(
                                image: AssetImage('assets/LOGO3.png'),
                                height: 200,
                                width: 200,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.data.data()["name"],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.grey[500],
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: "fallout"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.1, 0.4, 0.6, 0.8],
                                colors: [
                                  Colors.blue[500],
                                  Colors.blue[800],
                                  Colors.blue[800],
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _label("USN: "),
                          _basicInfo("-" + snapshot.data.data()["usn"]),
                          _label("Age: "),
                          _basicInfo("-" + snapshot.data.data()["age"]),
                          _label("Contact Number: "),
                          _basicInfo("-" + snapshot.data.data()["contact"]),
                          _label("Course: "),
                          _basicInfo("-" + snapshot.data.data()["course"]),
                          _label("Email: "),
                          _basicInfo("-" + snapshot.data.data()["email"]),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.1, 0.4, 0.6, 0.8],
                                colors: [
                                  Colors.blue[500],
                                  Colors.blue[800],
                                  Colors.blue[800],
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            height: 10,
                          ),
                          _addButton(snapshot, auth)
                        ],
                      ),
                    ),
                  ),
                );
        });
  }

  Widget _addButton(
          AsyncSnapshot<DocumentSnapshot> snapshot, AuthProvider auth) =>
      Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 50),
              decoration: _logInButtonDecoration(),
              child: InkWell(
                  onTap: () => _expandUserDialog(snapshot),
                  child: Container(
                      width: Globals.screenWidth(context) / 2,
                      height: 55.0,
                      alignment: Alignment.center,
                      //margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      )))),
          Container(
              margin: EdgeInsets.only(top: 50),
              decoration: _logInButtonDecoration(),
              child: InkWell(
                  onTap: () async {
                    auth.signOut().then((value) => Navigator.of(context)
                        .pushReplacement(Routes.createRoute(AuthScreen())));
                  },
                  child: Container(
                      width: Globals.screenWidth(context) / 2.01,
                      height: 55.0,
                      alignment: Alignment.center,
                      //margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        "Logout",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      )))),
        ],
      );
  BoxDecoration _logInButtonDecoration() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [0.1, 0.2, 0.6, 0.9],
        colors: [
          Colors.blue[300],
          Colors.blue[400],
          Colors.blue,
          Colors.cyan[200],
        ],
      ),
      border: Border.all(color: AppThemeColors.primary, width: 0.2));

  Widget _label(text) => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.announcement,
              size: 25,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.grey[500],
                  fontSize: 30,
                  fontFamily: "fallout"),
            ),
          ],
        ),
      );

  Widget _basicInfo(text) => Container(
        margin: EdgeInsets.only(left: 70),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            letterSpacing: 0,
            color: Colors.grey[500],
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _userdata(AsyncSnapshot<DocumentSnapshot> snapshot) => Container(
        child: Text("${snapshot.data.data()['name']}"),
      );

  void _expandUserDialog(AsyncSnapshot<DocumentSnapshot> snapshot) {
    Navigator.push(context, HeroDialogRoute(builder: (BuildContext context) {
      return EditProfileScaffold(
        userId: widget.userid,
        aage: snapshot.data.data()['age'],
        acontact: snapshot.data.data()['contact'],
        acourse: snapshot.data.data()['course'],
        aname: snapshot.data.data()['name'],
        ausn: snapshot.data.data()['usn'],
        uid: snapshot.data.data()['uid'],
      );
    }));
  }
}
