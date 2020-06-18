import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';

class AddFaq extends StatefulWidget {
  @override
  _AddFaqState createState() => _AddFaqState();
  final String uid;
  final String name;
  AddFaq({this.uid,this.name});
}

class _AddFaqState extends State<AddFaq> {

final _formKey = GlobalKey<FormState>();
String _title="";
String _desc="";
String error="";
String _text="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD FAQ"),
      ),
      body: _streamAllUsers(),
    );
  }

  Widget _body(AsyncSnapshot<QuerySnapshot> snapshot)=>Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _label("Title", context),
          _titleTextField(context),
          _label("Description", context),
          _descTextField(context),
          _label("Body", context),
          _bodyTextField(context),
          _addButton(snapshot)
          ],
        ),
      ),
    );

  Widget _label(String label, BuildContext context, {double width, Alignment alignment}) => Container(
    margin: EdgeInsets.only(top: 15.0, left: width==null?40.0:0.0),
    width: width == null ? Globals.screenWidth(context) : width,
    alignment: alignment==null?Alignment.centerLeft:alignment,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black45,
        fontWeight: FontWeight.bold
      )
    ),
  );

  Widget _titleTextField(BuildContext context) => Container(
    width: Globals.screenWidth(context) / 1.2,
    height: 60.0,
    margin: EdgeInsets.only(top: 5.0),
    alignment: Alignment.center,
    child: TextFormField(
      maxLength: 38,
      onChanged: (val) {
                setState(() {
                  _title=val;
                });
              },
      textCapitalization: TextCapitalization.words,
      decoration: inputDecoration("Enter Question Title"),
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black
      ),
      textAlign: TextAlign.left,
    ),
  );

  Widget _descTextField(BuildContext context) => Container(
    width: Globals.screenWidth(context) / 1.2,
    height: 60.0,
    margin: EdgeInsets.only(top: 5.0),
    alignment: Alignment.center,
    child: TextFormField(
      maxLength: 75,
      onChanged: (val) {
                setState(() {
                  _desc=val;
                });
              },
      textCapitalization: TextCapitalization.words,
      decoration: inputDecoration("Enter Question Description"),
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black
      ),
      textAlign: TextAlign.left,
    ),
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
                  _text=val;
                });
              },
      textCapitalization: TextCapitalization.words,
      decoration: inputDecoration("Enter Question Body"),
      style: TextStyle(

        fontSize: 14.0,
        color: Colors.black
      ),
      textAlign: TextAlign.left,
    ),
  );

InputDecoration inputDecoration(String hintText) => InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(width: 0.6, color: AppThemeColors.primary)
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: 14.0,
      color: Colors.black26
    ),
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(width: 1.0, color: Colors.grey[400])
    ),
  );

Widget _addButton(snapshot) => Container(
    margin: EdgeInsets.only(top: 50),
    decoration: _logInButtonDecoration(),
    child: InkWell(
      onTap: () async {
        updateUserData(_title, _desc, widget.uid,snapshot.data.documents.length+1);
        print(snapshot.data.documents.length+1);
        Navigator.pop(context);
        },
      child: Container(
        width: Globals.screenWidth(context),
        height: 55.0,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text(
              "ADD QUESTION",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0
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

  Widget _streamAllUsers() => StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("faq").snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      return _body(snapshot);
    });

final CollectionReference userCollection = Firestore.instance.collection('faq');

  Future updateUserData(String title,String desc,String uid,int snapshot) async {
    return await userCollection.document(snapshot.toString()).setData({
      "title":_title,
      "desc":_desc,
      "uid":widget.name,
      "text":_text
    });
  }



}