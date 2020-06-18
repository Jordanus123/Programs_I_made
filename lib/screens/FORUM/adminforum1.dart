// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:helpdesk/utils/colors.dart';
// import 'package:helpdesk/utils/globals.dart';
// import 'package:helpdesk/utils/hero_dialogue_route.dart';
// import 'addforumanswer.dart';

// class AdminForum1 extends StatefulWidget {
//   @override
//   _AdminForum1State createState() => _AdminForum1State();
// final BuildContext context;
//  //  final AsyncSnapshot<QuerySnapshot> snapshot;
//   // final int index;
// final DocumentSnapshot snapshot1;
// final String title;
// final String indexNumber;
// final String accountType;
//   AdminForum1({
//     // @required this.index,
//    this.context,
//     this.snapshot1,
//     this.title,
//     this.indexNumber,
//     this.accountType
//   });
  
// }

// class _AdminForum1State extends State<AdminForum1> {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: <Widget>[
//           Column( 
//             children: <Widget>[
//               _streamAllUsers() 
//             ],
//           ),
//           widget.accountType=='admin' ? addButton() : Container(),
//         ],
//       ),
//     );
//   }

//   Widget addButton() => Container(
//                 padding: EdgeInsets.only(bottom: 20,right: 20),
//                 alignment: Alignment.bottomRight,
//                 child: FloatingActionButton(
//                   elevation: 20,
//                   backgroundColor: Colors.white,
//                   onPressed: () {_addForumAnswer();},
//                   tooltip: 'Increment',
//                   child: Icon(Icons.add,color: Colors.blue,),
//                 ),
//               );

// BoxDecoration _logInButtonDecoration() => BoxDecoration(

//     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//     gradient: LinearGradient(
//       begin: Alignment.bottomLeft,
//       end: Alignment.topRight,
//       stops: [0.1, 0.2, 0.6, 0.9],
//       colors: [
//         Colors.blue[300],
//         Colors.blue[400],
//         Colors.blue,
//         Colors.cyan[200],
//       ],
//     ),
//     border: Border.all(
//       color: Colors.white,
//       width: 0.2
//     )
//   );

//   Widget _streamAllUsers() => StreamBuilder<QuerySnapshot>(
//     stream: Firestore.instance.collection('forum').document(widget.indexNumber).collection('comments').snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//       if(snapshot.connectionState == ConnectionState.waiting){
//         return Container(
//           width: 50.0,
//           height: 50.0,
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppThemeColors.primary),
//           ),
//         );
//       }
//       if(snapshot.data.documents.length<1) return Center(child: Text("Answers for this question not yet available"));
//       if(snapshot.hasData) {
//         return _scrollableContainer(snapshot);
//       }
//       return Container();
//     },
//   );

//   Widget _scrollableContainer(
//     AsyncSnapshot<QuerySnapshot> snapshot
//   ) => Container(
    
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _filteredUsersContainer(snapshot)
//         ],
//       )
//   );


//  Widget _filteredUsersContainer(snapshot) => Container(
//     padding: EdgeInsets.only(top: 5.0),
//     height: Globals.tabBarWidgetsHeight(context) - 60,
//       child: ListView.builder(
//       physics: AlwaysScrollableScrollPhysics(),
//       addAutomaticKeepAlives: true,
//       addRepaintBoundaries: true,
//       shrinkWrap: true,
//       itemCount: snapshot.data.documents.length + 1,
//       itemBuilder: (BuildContext context, int index){
//         return index == snapshot.data.documents.length
//           ? Container(
//               width: Globals.screenWidth(context),
//               height: 50.0,
//               alignment: Alignment.center,
//               child: Text(
//                 "No more answers",
//                 style: TextStyle(
//                   color: AppThemeColors.disabledColor
//                 ),
//               ),
//             )
//             : _faqbutton1(context,index, snapshot);
//       }
//     ),
//   );
//   Widget _faqbutton1(context,int index, AsyncSnapshot<QuerySnapshot> snapshot) {
//     return GestureDetector(
//       onTap: null,
//       child: Container(
//         margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0,),
//           decoration: _logInButtonDecoration(),
//           child: Stack(
//             children: <Widget>[
//               Container(
//     child: InkWell(      
//       borderRadius: BorderRadius.all(Radius.circular(40.0)),
//       child: Column(
//         children: <Widget>[
//           Container(
//         width: 300.0,
//         height: 35.0,
//         alignment: Alignment.topLeft,
//         margin: EdgeInsets.only(left: 10.0, right: 10.0),
//         child:Text(
//               (snapshot.data.documents[index]['text']),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20.0,
//               ),
//               textAlign: TextAlign.left,
//           )
//       ),
//       Container(
//         width: 250.0,
//         height: 20.0,
//         alignment: Alignment.bottomRight,
//         margin: EdgeInsets.only(left: 10.0, right: 10.0),
//         child:Text(
//               (snapshot.data.documents[index]['text']),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12.0,
//               ),
//               textAlign: TextAlign.left,
//           )
//       ),
//         ],
//       )
//     )
//   )
//             ],
//           ),
//         )
//     );
//   }
// void _addForumAnswer() {
      
//     Navigator.push(
//       context,
//       HeroDialogRoute(
//         builder: (BuildContext context) {
//             return AddForumAnswer(
//               title: widget.title,
//               indexNumber: widget.indexNumber
//             );
//           }
//         )
//       );
//     }


// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpdesk/screens/FORUM/adminforum.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';
import 'package:helpdesk/utils/hero_dialogue_route.dart';

import 'addforumanswer.dart';

class AdminForum1 extends StatefulWidget {
  @override
  _AdminForum1State createState() => _AdminForum1State();
  final CollectionReference userCollection = Firestore.instance.collection('faq');
  final String indexNumber;
  final String accountType;
  final String title;
  final DocumentSnapshot snapshot;

  AdminForum1({
    this.indexNumber,
    this.accountType,
    this.title,
    this.snapshot
  });
  
}

class _AdminForum1State extends State<AdminForum1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: Navigator.canPop(context)
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 50,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : null,
            ),
            body: Stack(
              children: <Widget>[
                Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.2, 0.4, 0.4],
                  colors: [
                    Colors.blue[600],
                    Colors.blue[800],
                    Colors.blue[800],
                    Colors.white,
                  ],
                ),
              ),
              ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 70),
                      _questionContainer(),
                      SizedBox(height: 50),
                      _border(Colors.white),
                      SizedBox(height: 50),
                      _answerContainer(),
                      SizedBox(height: 30),
                      _border(Colors.blue[400]),
                      SizedBox(height: 30),
                      _adminContainer(),
                      _icon()
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.accountType=='admin' ? addButton() : Container(),
        ],
      ),
    );
  }


    Widget addButton() => Container(
                padding: EdgeInsets.only(bottom: 20,right: 20),
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  elevation: 20,
                  backgroundColor: Colors.white,
                  onPressed: () {_addForumAnswer();},
                  tooltip: 'Increment',
                  child: Icon(Icons.add,color: Colors.blue,),
                ),
              );

  void _addForumAnswer() {
      
    Navigator.push(
      context,
      HeroDialogRoute(
        builder: (BuildContext context) {
            return AddForumAnswer(
              title: widget.title,
              indexNumber: widget.indexNumber
            );
          }
        )
      );
    }


  Widget _questionContainer() => Container(
                //padding: EdgeInsets.only(right: 20, left: 60),
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                    ),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20)
                ),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(height:20),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${widget.snapshot.data['title']}",
                        //"widget.userCollection.document(widget.indexNumber)[asd],",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:10),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "${widget.snapshot.data['desc']}",
                        //"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaakoy napapaisip lang",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height:20),
                  ],
                ),
              );
  
  Widget _answerContainer() => Container(
                margin: EdgeInsets.only(right:20),
                alignment: Alignment.centerRight,
                child: Column(
                  children: <Widget>[
                    Text(
                      //"${widget.snapshot.data['desc']}",
                      "Answers",
                      style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 40,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              );

  Widget _border(color) => Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: color,
                      width: 5,
                    ),
                  ),
                ),
              );

  Widget _icon() => Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: 250.0,
        height: 350.0,
        child:
            Image(
          image: AssetImage('assets/LOGO3.png'),
          height: 150,
          width: 150,
        ),
      );

   Widget _adminContainer() => Container(
                //padding: EdgeInsets.only(right: 20, left: 60),
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 8,
                    color: Colors.blue
                    ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20)
                ),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: _streamAllUsers(),),
                    SizedBox(height:20),
                  ],
                ),
              );   

    Widget _streamAllUsers() => StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('forum').document(widget.indexNumber).collection('comments').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Container(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppThemeColors.primary),
          ),
        );
      }
      if(snapshot.data.documents.length<1) return Center(child: Text("Answers for this question not yet available"));
      if(snapshot.hasData) {
        return _scrollableContainer(snapshot);
      }
      return Container();
    },
  );    

  Widget _scrollableContainer(
    AsyncSnapshot<QuerySnapshot> snapshot
  ) => Container(
      child: Column(
        children: <Widget>[
          _filteredUsersContainer(snapshot)
        ],
      )
  );


 Widget _filteredUsersContainer(snapshot) => Container(
    //padding: EdgeInsets.only(top: 5.0),
    height: 300,
      child: ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      shrinkWrap: true,
      itemCount: snapshot.data.documents.length + 1,
      itemBuilder: (BuildContext context, int index){
        return index == snapshot.data.documents.length
          ? Container(
              width: Globals.screenWidth(context),
              height: 50.0,
              alignment: Alignment.center,
              child: Text(
                "No more answers",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
            )
            : _faqbutton2(context,index, snapshot);
      }
    ),
  );

  Widget _faqbutton2(context, int index, AsyncSnapshot<QuerySnapshot> snapshot){
    return Container(
                //padding: EdgeInsets.only(right: 20, left: 60),
                padding: EdgeInsets.symmetric(horizontal: 10,),
                margin: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 8,
                    color: Colors.white
                    ),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20)
                ),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(height:10),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        (snapshot.data.documents[index]['text']),
                        //"widget.userCollection.document(widget.indexNumber)[asd],",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height:10),
                  ],
                ),
              );
  }


}
