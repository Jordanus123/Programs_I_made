import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';
import 'package:helpdesk/utils/hero_dialogue_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addforum.dart';
import 'adminforum1.dart';

typedef OnClickExplore(int tabBarControllerIndex);

class AdminForum extends StatefulWidget {
  @override
  _AdminForumState createState() => _AdminForumState();
  final String uid;
  final String name;
  final String accountType;
  AdminForum({this.uid,this.name,this.accountType});
}
class _AdminForumState extends State<AdminForum>{
String _title="";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.grey[300],
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              _streamAllUsers(),
              _labelContainer(),
              widget.accountType=="admin" ? Container() : _addButton(),
            ],
          )),
    );
  }

   Widget _addButton() => Container(
                padding: EdgeInsets.only(bottom: 20,right: 20),
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  elevation: 20,
                  backgroundColor: Colors.white,
                  onPressed: () {_addForum();},
                  tooltip: 'Increment',
                  child: Icon(Icons.add,color: Colors.blue,),
                ),
              );


  Widget _labelContainer()=>Container(
                color: Colors.transparent,
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
                  ),
                  child: Center(
                    child: Text("FORUM",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4
                    ),),
                  ),
                ),
              );

  BoxDecoration _logInButtonDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.black,
            offset: new Offset(
              10.0,
              10.0,
            ),
            blurRadius: 30.0,
          )
        ],
      );

  Widget _streamAllUsers() => StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("forum").snapshots(),
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
          if (snapshot.data.documents.length<1) return Center(child: Text("No questions available at the moment"));
          if (snapshot.hasData) {
            return _scrollableContainer(snapshot);
          }
          return Container();
        },
      );

  Widget _scrollableContainer(AsyncSnapshot<QuerySnapshot> snapshot) =>
      Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.2, 0.3, 0.3],
              colors: [
                Colors.blue[600],
                Colors.blue[800],
                Colors.blue[800],
                Colors.white,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_filteredUsersContainer(snapshot)],
          ));

  Widget _filteredUsersContainer(snapshot) => Container(
        padding: EdgeInsets.only(top: 0.0),
        height: Globals.tabBarWidgetsHeight(context) + 21.5,
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
      onTap: () {
        _expandUserDialog(
          snapshot.data.documents[index],
        );
      },
      child: Container(
        margin: EdgeInsets.only(top:40),
        child: _buttonWidgets(snapshot,index),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Widget _buttonWidgets(snapshot,index) => Stack(
        children: <Widget>[
          _boardDesign(snapshot,index),
          _logo(),
        ],
      );

  Widget _boardDesign(snapshot,index) => Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(
          50.0,
          20,
          30.0,
          20,
        ),
        decoration: _logInButtonDecoration(),
        child: _stackedBoard(snapshot,index),
      );

  Widget _stackedBoard(snapshot,index) => Stack(
        children: <Widget>[
          _boardBackground(),
          _boardText(snapshot,index),
        ],
      );

  Widget _boardText(snapshot,index) => Container(
        child: InkWell(
          child: Column(
            children: <Widget>[
              _titleContainer(snapshot,index),
              _descContainer(snapshot,index),
              _askedContainer(snapshot, index)
            ],
          ),
        ),
      );

  Widget _askedContainer(snapshot,index) => Container(
        width: double.infinity,
        height: 50.0,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(left: 20.0, right: 15.0,),
        child: 
            Container(
              alignment: Alignment.topRight,
              height: 50,
              width: double.infinity,
              //color: Colors.white30,
              child: Text(
                // 'Sample Title',
                ("Asked by: "+ snapshot.data.documents[index]['uid']),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    ),
                textAlign: TextAlign.left,
              ),
        ),
      );    

  Widget _descContainer(snapshot,index) => Container(
        width: 300,
        height: 70.0,
        //color: Colors.white30,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 60.0, right: 15.0, bottom: 0),
        padding: EdgeInsets.only(top:5),
        child: Text(
          // 'sample text lang to na para ma test yung app na to',
          (snapshot.data.documents[index]['desc']),
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
          ),
          textAlign: TextAlign.left,
        ),
      );

  Widget _titleContainer(snapshot,index) => Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(color: Colors.white, width: 1))),
        width: double.infinity,
        height: 70.0,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 20.0, right: 15.0, top: 20),
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: double.infinity,
              //color: Colors.white30,
              child: Text(
                // 'Sample Title',
                (snapshot.data.documents[index]['title']),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );

  Widget _boardBackground() => ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage(
                'assets/board4.jpg',
              ),
              fit: BoxFit.fill,
              height: 210,
            ),
            Container(
              height: 210,
              color: Colors.black26,
            ),
          ],
        ),
      );

  Widget _logo() => Container(
        child: Image(
          image: AssetImage(
            'assets/LOGO5.png',
          ),
          height: 110,
          width: 110,
        ),
        margin: EdgeInsets.only(top: 100, bottom: 50, left: 0),
      );

    void _expandUserDialog(snapshot) {
      var title=snapshot['title'];
      var indexNumber=snapshot['indexNumber'];
    Navigator.push(
      context,
      HeroDialogRoute(
        builder: (BuildContext context) {
            return AdminForum1(
              indexNumber: indexNumber,
              accountType: widget.accountType,
              title: title,
              snapshot: snapshot,
            );
          }
        )
      );
    }

    void _addForum() {
    Navigator.push(
      context,
      HeroDialogRoute(
        builder: (BuildContext context) {
            return AddForum(
              uid: widget.uid,
              name: widget.name,

              
            );
          }
        )
      );
    }
    //pushh(context, Faq1(context: context, snapshot: snapshot,tab:widget.tab));
  
}

//   void _expandUserDialog(snapshot,index) {
//     var title=snapshot['title'];
//     pushh(context, Forum1(context: context, snapshot1: snapshot,title: title));
//     }