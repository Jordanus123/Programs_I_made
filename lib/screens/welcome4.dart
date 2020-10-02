import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/provider/auth_provider.dart';
import 'package:helpdesk/screens/ACCOUNT/viewall.dart';
import 'package:helpdesk/screens/inactive.dart';
import 'package:provider/provider.dart';

import 'ACCOUNT/account.dart';
import 'FAQ/adminfaq.dart';
import 'FORUM/adminforum.dart';
import 'STAFF/staff.dart';
import 'TRIVIA/admintrivia.dart';
import 'MAP/map.dart';

class WelcomeScreen4 extends StatefulWidget {
  @override
  _Welcome4State createState() => _Welcome4State();
}

class _Welcome4State extends State<WelcomeScreen4> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(auth.user.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          print(auth.user.uid);

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          String _name = "${snapshot.data.data()['name']}";
          String _account = "${snapshot.data.data()['account']}";
          String _status = "${snapshot.data.data()['status']}";
          print(_name);
          print(_account);
          print(_status);
          return _status == "inactive"
              ? Inactive()
              : _tab2(_name, _account, auth);
        });
  }

  Widget _tab2(_name, _account, AuthProvider auth) => DefaultTabController(
        length: 6,
        child: SafeArea(
          child: Scaffold(
            appBar: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blue,
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.mood,
                  size: 25,
                )),
                Tab(
                  icon: Icon(
                    Icons.local_library,
                    size: 25,
                  ),
                ),
                Tab(
                    icon: Icon(
                  Icons.not_listed_location,
                  size: 25,
                )),
                Tab(
                    icon: Icon(
                  Icons.map,
                  size: 25,
                )),
                Tab(
                    icon: Icon(
                  Icons.supervised_user_circle,
                  size: 25,
                )),
                Tab(
                    icon: Icon(
                  Icons.chat,
                  size: 25,
                )),
              ],
            ),
            backgroundColor: Colors.white,
            body: TabBarView(
              children: [
                _account == "student"
                    ? Account(
                        userid: auth.user.uid,
                      )
                    : ViewAccount(
                        userid: auth.user.uid,
                      ),
                AdminFaq(
                    uid: auth.user.uid, name: _name, accountType: _account),
                AdminTrivia(
                  accountType: _account,
                ),
                Map(),
                Staff(),
                AdminForum(
                    uid: auth.user.uid, name: _name, accountType: _account),
              ],
            ),
          ),
        ),
      );
}
