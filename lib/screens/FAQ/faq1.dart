import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Faq1 extends StatefulWidget {
  @override
  _Faq1State createState() => _Faq1State();
  final BuildContext context;
  final DocumentSnapshot snapshot;

  Faq1({
    @required this.snapshot,
    @required this.context,
  });
}

class _Faq1State extends State<Faq1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  SizedBox(height: 10),
                  _titleContainer(),
                  SizedBox(height: 50),
                  _descContainer(),
                  SizedBox(height: 20),
                  _border(Colors.white),
                  SizedBox( height: 50),
                  _textContainer(),
                  SizedBox(height: 50),
                  _border(Colors.blue[600]),
                  SizedBox(height: 30),
                  _icon()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleContainer() => Container(
                padding: EdgeInsets.only(right: 20, left: 60),
                alignment: Alignment.centerRight,
                child: Text(
                  "${widget.snapshot.data['title']}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              );
  
  Widget _descContainer() => Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      "${widget.snapshot.data['desc']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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

  Widget _textContainer() => Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 10,
                    color: Colors.white
                    ),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20)
                ),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(height:30),
                    Text(
                      "${widget.snapshot.data['text']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height:30),
                  ],
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
}
