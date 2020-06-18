import 'package:flutter/material.dart';
import 'package:helpdesk/screens/FAQ/faq1.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';
import 'package:helpdesk/utils/hero_dialogue_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addtrivia.dart';

typedef OnClickExplore(int tabBarControllerIndex);

class AdminTrivia extends StatefulWidget {
  @override
  _AdminTriviaState createState() => _AdminTriviaState();
  final String uid;
  final String name;
  final String accountType;
  AdminTrivia({this.uid,this.name,this.accountType});
}
class _AdminTriviaState extends State<AdminTrivia>{
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
              widget.accountType=='admin' ? _addButton() : Container(),
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
                  onPressed: () {_addTrivia();},
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
                    child: Text("TRIVIA",style: TextStyle(
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

  BoxDecoration _logInButtonDecoration2() => BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.indigo[400],
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
        stream: Firestore.instance.collection("trivia").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              height: 50.0,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppThemeColors.primary),
              ),
            );
          }
          if (!snapshot.hasData) return Center(child: Text("No Trivias available at the moment"));
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
          //_logo(),
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
            ],
          ),
        ),
      );

  Widget _descContainer(snapshot,index) => Container(
        width: 300,
        height: 120.0,
        //color: Colors.white30,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 60.0, right: 50.0, bottom: 0),
        padding: EdgeInsets.only(top:5),
        child: Text(
          //'sample text lang to na para ma test yung app na to',
          (snapshot.data.documents[index]['desc']),
          style: TextStyle(
                    color: Colors.lightGreenAccent[400],
                    fontSize: 15.0,
                    fontFamily: 'fallout2',
                    
                    fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      );

  Widget _titleContainer(snapshot,index) => Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(color: Colors.lightGreenAccent[400], width: 4))),
        width: double.infinity,
        height: 45.0,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom:0,left: 20),
              height: 30,
              width: double.infinity,
              //color: Colors.white30,
              child: Text(
                'Did you know?',
                //(snapshot.data.documents[index]['title']),
                style: TextStyle(
                    color: Colors.lightGreenAccent[400],
                    fontSize: 25.0,
                    fontFamily: 'fallout',
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );

  Widget _boardBackground() => ClipRRect(
        
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage(
                'assets/monitor.png',
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
    Navigator.push(
      context,
      HeroDialogRoute(
        builder: (BuildContext context) {
            return Faq1(
              context: context,
              snapshot: snapshot,
            );
          }
        )
      );
    }

    void _addTrivia() {
      
    Navigator.push(
      context,
      HeroDialogRoute(
        builder: (BuildContext context) {
            return AddTrivia(
              uid: widget.uid,
              name: widget.name,
            );
          }
        )
      );
    }
    //pushh(context, Faq1(context: context, snapshot: snapshot,tab:widget.tab));
  
}
