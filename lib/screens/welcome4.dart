import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/screens/ACCOUNT/viewall.dart';
import 'package:helpdesk/screens/inactive.dart';

import 'ACCOUNT/account.dart';
import 'FAQ/adminfaq.dart';
import 'FORUM/adminforum.dart';
import 'STAFF/staff.dart';
import 'TRIVIA/admintrivia.dart';
import 'MAP/map.dart';

class WelcomeScreen4 extends StatefulWidget{
  @override
  _Welcome4State createState() => _Welcome4State();
final String userid;
  WelcomeScreen4({this.userid});
}

class _Welcome4State extends State<WelcomeScreen4>{

  Stream<DocumentSnapshot> _getUserInfo;

  @override
  void initState() {


    _getUserInfo = Firestore.instance
				.collection('user')
				.document(widget.userid)
				.snapshots();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    print(widget.userid);
    return StreamBuilder<DocumentSnapshot>(
          stream: _getUserInfo,
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
            String _name="${snapshot.data['name']}";
            String _account="${snapshot.data['account']}";
            String _status="${snapshot.data['status']}";
            return _status=="inactive" ? Inactive() : _tab2(_name,_account) ;
          }
    );
  }

    Widget _tab2(_name,_account) => DefaultTabController(
      length: 6,
      child: SafeArea(
        child: Scaffold(
          appBar: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blue,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(icon: Icon(Icons.mood,size: 25,)),
              Tab(icon: Icon(Icons.local_library,size: 25,),),
              Tab(icon: Icon(Icons.not_listed_location,size: 25,)),
              Tab(icon: Icon(Icons.map,size: 25,)),
              Tab(icon: Icon(Icons.supervised_user_circle,size: 25,)),
              Tab(icon: Icon(Icons.chat,size: 25,)),
              
            ],
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            
            children: [
              _account=="student" ? Account(userid: widget.userid,):ViewAccount(userid: widget.userid,),
              AdminFaq(uid: widget.userid,name: _name,accountType: _account),
              AdminTrivia(accountType: _account,),
              Map(),
              Staff(),
              AdminForum(uid: widget.userid,name: _name,accountType: _account),
              
            ],
          ),
        ),
      ),
    );
}