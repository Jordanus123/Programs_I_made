import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/services/auth.dart';
import 'package:helpdesk/services/database.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
  final String userId;
  final String aname;
  final String ausn;
  final String aage;
  final String acontact;
  final String acourse; 
  EditProfile({
    this.userId,
    this.aname,
    this.aage,
    this.acontact,
    this.acourse,
    this.ausn
  });
}

class _EditProfileState extends State<EditProfile> {

  Stream<DocumentSnapshot> _getUserInfo;

  @override
  void initState() {
    _getUserInfo = Firestore.instance
        .collection('user')
        .document(widget.userId)
        .snapshots();
String name= widget.aname;
    super.initState();
  }

final AuthService _auth= AuthService();
final _formKey = GlobalKey<FormState>();

//text field state
String name;
String error="";
String usn;
String age;
String contact;
String course;
bool _logging=false;


  Future<bool> _onWillPop() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: _discardChangesContainer(context),
          ),
        )) ??
        false;
  }
  @override
  Widget build(BuildContext context) => SafeArea(
          child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _body(context),
        ),
      ));

  Widget _body(context) {
    return  StreamBuilder<DocumentSnapshot>(
        stream: _getUserInfo,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return snapshot.connectionState==ConnectionState.waiting ? Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                    ) : Container(
        child: SingleChildScrollView(
            child: Stack(
      children: <Widget>[
        Container(
          decoration: _mainContainerBG(),
          height: Globals.screenHeight(context),
          width: Globals.screenWidth(context),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _customAppBar(context),
            _titleAndSub(context),
            _basicInfo(snapshot),
            _addButton()
          ],
        ),
      ],
    )));});}
  

  Widget _customAppBar(context) => Container(
        color: Colors.transparent,
        width: Globals.screenWidth(context),
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10.0),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.blue[300],
              ),
              onPressed: () async {
                hideKeyboard();
                FocusScope.of(context).requestFocus(new FocusNode());
                await showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: _discardChangesContainer(context),
                  ),
                );
              },
            ),
            SizedBox(
              width: Globals.screenWidth(context) / 4,
            ),
            
          ],
        ),
      );

  Widget _discardChangesContainer(context) => Container(
      width: 200.0,
      height: 99.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Discard changes?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            "Are you sure you want to discard all changes?",
            style: TextStyle(fontSize: 14.0),
          ),
          _dialogButton(context)
        ],
      ));

  Widget _dialogButton(context) => Container(
        margin: EdgeInsets.only(top: 15.0),
        width: 230.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                hideKeyboard();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 15.0),
                child: Text(
                  "Discard",
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: Container(
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(color: AppThemeColors.primary, fontSize: 14.0),
                ),
              ),
            )
          ],
        ),
      );

  BoxDecoration _mainContainerBG() => BoxDecoration(
        gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.2, 0.25, 0.25],
                  colors: [
                    Colors.blue[600],
                    Colors.blue[800],
                    Colors.blue[800],
                    Colors.white,
                  ],
                ),
      );

  Widget _titleAndSub(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[_title(context), _subtitle()],
      );

  Widget _title(context) => Container(
        margin: EdgeInsets.all(15.0),
        width: Globals.screenWidth(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.person_pin,
              color: Colors.blue[300],
              size: 25.0,
            ),
            SizedBox(width: 10.0),
            Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.blue[300],
                fontSize: 21.0,
              ),
            ),
          ],
        ),
      );

  Widget _subtitle() => Container(
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 15.0),
        child: Text(
          "Always update your information.",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      );

  InputDecoration inputDecoration(String hintText) => InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 0.6, color: AppThemeColors.primary)),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.0, color: Colors.black45,),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 1.0, color: Colors.grey[400])),
      );

  Widget _basicInfo(snapshot) => Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            _label("Name"),
            _nameTextField(snapshot),
            SizedBox(height: 20),
            _label("USN"),
            _usnTextField(snapshot),
            SizedBox(height: 20),
            _label("Age and Contact"),
            Container(
              width: 500,
              child: Row(
                children: <Widget>[
                  Container(width: MediaQuery.of(context).size.width/7,child: _ageTextField(snapshot)),
                  SizedBox(width: 20,),
                  Container(width: MediaQuery.of(context).size.width/1.5,child: _contactTextField(snapshot))
                ],
              ),
            ),
            SizedBox(height: 20),
            _label("Course"),
            _courseTextField(snapshot),
            SizedBox(height: 20),
          ],
        ),
      ),
    );

    Widget _label(data) => Container(
      alignment: Alignment.centerRight,
      child: Text(
        data,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 25,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold
        ),),
    );

    Widget _nameTextField(snapshot) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          decoration: inputDecoration(snapshot.data["name"],),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
              onChanged: (val) {
                if (val!=null){
                  setState(() {
                  name=val;
                });
                }
                
                print(name);
              },
        ),
      );

    Widget _usnTextField(snapshot) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          maxLength: 11,
          decoration: inputDecoration(snapshot.data["usn"],),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          validator: (val)=> val.length!=0 && val.length != 11 ? 'Enter a valid USN': null,
              onChanged: (val) {
                if (val!=null){
                  setState(() {
                  usn=val;
                });
                }
                
                print(usn);
              },
        ),
      );

    Widget _ageTextField(snapshot) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          maxLength: 2,
          decoration: inputDecoration(snapshot.data["age"],),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          validator: (val)=> val.length!=0 && double.parse(val)<14 ? 'Enter a valid Age': null,
              onChanged: (val) {
                if (val!=null){
                  setState(() {
                  age=val;
                });
                }
                
                print(age);
              },
        ),
      );

    Widget _contactTextField(snapshot) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          maxLength: 11,
          decoration: inputDecoration(snapshot.data["contact"],),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          validator: (val)=> val.length!=0 && val.length != 11 ? 'Enter a valid Contact Number': null,
              onChanged: (val) {
                if (val!=null){
                  setState(() {
                  contact=val;
                });
                }
                
                print(contact);
              },
        ),
      );

    Widget _courseTextField(snapshot) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          decoration: inputDecoration(snapshot.data["course"],),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
              onChanged: (val) {
                if (val!=null){
                  setState(() {
                  course=val;
                });
                }
                
                print(course);
              },
        ),
      );

  Widget _addButton() => Container(
    margin: EdgeInsets.only(top: 50),
    decoration: _logInButtonDecoration(),
    child: InkWell(
      onTap: () async{
                if (name==null){
                  setState(() {
                  name=widget.aname;
                });
                }
                if (usn==null){
                  setState(() {
                  usn=widget.ausn;
                });
                }
                if (age==null){
                  setState(() {
                  age=widget.aage;
                });
                }
                if (contact==null){
                  setState(() {
                  contact=widget.acontact;
                });
                }
                if (course==null){
                  setState(() {
                  course=widget.acourse;
                });
                }
                if (_formKey.currentState.validate()){
                  setState(() {
                _logging = true;
              });
                print(name);
                print(usn);
                dynamic result = await await DatabaseService(uid: widget.userId).updateUserData3(name,usn,age,contact,course);
                Navigator.pop(context);
                  if (result==null){
                    setState(() {
                      error="enter valid email";
                    });
                    setState(() {
                _logging = false;
              });
                  }
                  else{
                    print("error");
                    Navigator.pop(context);
                  }
                }
                setState(() {
                _logging = false;
              });
               //Navigator.pop(context);
              },
      child: Container(
        width: Globals.screenWidth(context),
        height: 55.0,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: _logging==false ? Text(
              "Update Info",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold
              ),
          ):Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
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
}
