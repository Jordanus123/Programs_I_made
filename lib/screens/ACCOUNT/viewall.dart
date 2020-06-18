import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpdesk/screens/ACCOUNT/editprofile.dart';
import 'package:helpdesk/screens/REGISTRATION/login.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';
import 'package:helpdesk/utils/hero_dialogue_route.dart';
import 'editprofile.dart';


class ViewAccount extends StatefulWidget {
  @override
  _ViewAccountState createState() => _ViewAccountState();
  final String userid;
  ViewAccount({this.userid});
}

class _ViewAccountState extends State<ViewAccount> {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

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
    return  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("user").where("account", isEqualTo: "student").snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.connectionState==ConnectionState.waiting ? Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                    ) : Container(
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
                      margin: EdgeInsets.only(left:10),
                      alignment: Alignment.topRight,
                      child: Text(
                        "WELCOME TO: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: "fallout",
                          letterSpacing: 4
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(
                          color: Colors.white,
                          width: 8
                        ),
                        color: Colors.white
                      ),
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
                        "Admin",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.grey[500],
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: "fallout"
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
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
                    SizedBox(height: 20,),
                    _scrollableContainer(snapshot),
                    SizedBox(height: 20,),
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
                    _addButton(snapshot)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _addButton(snapshot) => 
      Container(
        margin: EdgeInsets.only(top: 50),
        decoration: _logInButtonDecoration(),
        child: InkWell(
          onTap: ()async{signOut(); Navigator.push(context, MaterialPageRoute( builder: (BuildContext context) => Loginscreen()));;},
          child: Container(
            
            height: 55.0,
            alignment: Alignment.center,
            //margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
                  "Logout",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0
                  ),
              )
          )
        )
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
    border: Border.all(
      color: AppThemeColors.primary,
      width: 0.2
    )
  );


  static Future<void> signOut() async {
    await _auth
        .signOut()
        .then((_) => print("sign out auth performed"))
        .catchError((err) => print("sign out auth error $err"));
  }

  // void _expandUserDialog(snapshot) {
  //   Navigator.push(
  //     context,
  //     HeroDialogRoute(
  //       builder: (BuildContext context) {
  //           return EditProfile(
  //             userId: widget.userid,
  //             aage: snapshot.data['age'],
  //             acontact: snapshot.data['contact'],
  //             acourse: snapshot.data['course'],
  //             aname: snapshot.data['name'],
  //             ausn: snapshot.data['usn'],
  //           );
  //         }
  //       )
  //     );
  //   }

  Widget _scrollableContainer(AsyncSnapshot<QuerySnapshot> snapshot) =>
      Container(
        margin: EdgeInsets.only(),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_filteredUsersContainer(snapshot)],
          ));

  Widget _filteredUsersContainer(snapshot) => Container(

        padding: EdgeInsets.only(top: 0.0),
        height: 300,
        width: double.infinity,
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length + 1,
            itemBuilder: (BuildContext context, int index) {
              
              return index == snapshot.data.documents.length
                  ? Container(
                    margin: EdgeInsets.only(top:50),
                      width: double.infinity,
                      height: 50.0,
                      alignment: Alignment.center,
                      child: Text(
                        "End of result",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  : _faqbutton1(context, index, snapshot);
            }),
      ); 
  Widget _faqbutton1(
      context, int index, AsyncSnapshot<QuerySnapshot> snapshot) {
    return GestureDetector(
      child: Container(
        child: _buttonWidgets(snapshot,index),
      ),
    );
  }

  Widget _buttonWidgets(snapshot,index) => Stack(
        children: <Widget>[
          _stackedBoard(snapshot,index),
          //_logo(),
        ],
      );


  Widget _stackedBoard(snapshot,index) => Stack(
        children: <Widget>[
          _boardBackground(snapshot,index),
        ],
      );


  Widget _boardBackground(snapshot,index) => Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,bottom: 5),
    height: 60,
    alignment: Alignment.centerRight,
        child: Stack(
          children: <Widget>[
            Text(snapshot.data.documents[index]['name'],style: TextStyle(color: Colors.white),),
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.1, 0.5, 0.7, 1.0],
                colors: [
                  Colors.grey[800],
                  Colors.grey[600],
                  Colors.grey[400],
                  Colors.white,
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      //color: Colors.red,
                      width: 250,
                      padding: EdgeInsets.only(left: 10,top: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Name: "+snapshot.data.documents[index]['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                          ),
                        ),
                    Container(
                      //color: Colors.red,
                      width: 250,
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Status: "+snapshot.data.documents[index]['status'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                          ),
                        ),
                  ],
                ),
                SizedBox(width: 0,),
                Container(
                  color: Colors.blue[400],
                    height: 60,
                    width: 100,
                  child: RaisedButton(
                    color: Colors.blue[800] ,
                    elevation: 0,
                    onPressed: () => _deactivate(snapshot,index),
                    child: Text(
                      "Activate/Deactivate",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
      
      void _deactivate(snapshot,index) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
        title: Text("Activate/Deactivate"),
        content: Text("Do you want to activate or deactivate "+ snapshot.data.documents[index]['name']+"'s account?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
            onPressed: ()=> _deactivateStudent(snapshot,index),
            child: Text("Deactivate"),
          ),
          RaisedButton(
            onPressed: ()=> _activateStudent(snapshot,index),
            child: Text("Activate"),
          ),
        ],
      );
      },
    );
  }
      // void _deactivate(snapshot,index) => AlertDialog(
      //   title: Text("Activate/Deactivate"),
      //   content: Text("Do you want to activate or deactivate "+ snapshot.data.documents[index]['name']+"'s account?"),
      //   actions: <Widget>[
      //     FlatButton(
      //       child: Text("Close"),
      //       onPressed: (){
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //     RaisedButton(
      //       onPressed: ()=> _deactivateStudent(snapshot,index),
      //       child: Text("Deactivate"),
      //     ),
      //     RaisedButton(
      //       onPressed: ()=> _activateStudent(snapshot,index),
      //       child: Text("Activate"),
      //     ),
      //   ],
      // );


      Future _deactivateStudent(snapshot,index) async {
    return await Firestore.instance.collection("user").document(snapshot.data.documents[index]['uid']).updateData({
      'status':'inactive'
      
    });
    Navigator.pop(context);
  }

  Future _activateStudent(snapshot,index) async {
    return await Firestore.instance.collection("user").document(snapshot.data.documents[index]['uid']).updateData({
      'status':'active'
    });
  }
}
