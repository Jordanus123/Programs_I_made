import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';

class AddForumAnswer extends StatefulWidget {
  @override
  _AddForumAnswerState createState() => _AddForumAnswerState();
  final String uid;
  final String name;
  final String title;
  final String indexNumber;
  AddForumAnswer({this.uid, this.name, this.title, this.indexNumber});
}

class _AddForumAnswerState extends State<AddForumAnswer> {
  final _formKey = GlobalKey<FormState>();
  String error = "";
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD  ANSWER"),
      ),
      body: _streamAllUsers(),
    );
  }

  Widget _body(AsyncSnapshot<QuerySnapshot> snapshot) => Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _label("Answer", context),
              _bodyTextField(context),
              _addButton(snapshot)
            ],
          ),
        ),
      );

  Widget _label(String label, BuildContext context,
          {double width, Alignment alignment}) =>
      Container(
        margin: EdgeInsets.only(top: 15.0, left: width == null ? 40.0 : 0.0),
        width: width == null ? Globals.screenWidth(context) : width,
        alignment: alignment == null ? Alignment.centerLeft : alignment,
        child: Text(label,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black45,
                fontWeight: FontWeight.bold)),
      );

  Widget _bodyTextField(BuildContext context) => Container(
        width: Globals.screenWidth(context) / 1.2,
        height: 150.0,
        margin: EdgeInsets.only(top: 5.0),
        alignment: Alignment.topLeft,
        child: TextFormField(
          expands: true,
          keyboardType: TextInputType.multiline,
          maxLength: null,
          maxLines: null,
          minLines: null,
          onChanged: (val) {
            setState(() {
              _text = val;
            });
          },
          textCapitalization: TextCapitalization.words,
          decoration: inputDecoration("Enter Answer Body"),
          style: TextStyle(fontSize: 14.0, color: Colors.black),
          textAlign: TextAlign.left,
        ),
      );

  InputDecoration inputDecoration(String hintText) => InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 0.6, color: AppThemeColors.primary)),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.0, color: Colors.black26),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 1.0, color: Colors.grey[400])),
      );

  Widget _addButton(snapshot) => Container(
      margin: EdgeInsets.only(top: 50),
      decoration: _logInButtonDecoration(),
      child: InkWell(
          onTap: () async {
            updateUserData(widget.uid, snapshot.data.documents.length + 1);
            print(snapshot.data.documents.length + 1);
            Navigator.pop(context);
          },
          child: Container(
              width: Globals.screenWidth(context),
              height: 55.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "ADD ANSWER",
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ))));

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

  Widget _streamAllUsers() => StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('forum')
          .doc(widget.indexNumber)
          .collection('comments')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return _body(snapshot);
      });

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('forum');

  Future updateUserData(String uid, int snapshot) async {
    return await userCollection
        .doc(widget.indexNumber)
        .collection('comments')
        .doc(snapshot.toString())
        .set({"uid": widget.name, "text": _text});
  }
}
