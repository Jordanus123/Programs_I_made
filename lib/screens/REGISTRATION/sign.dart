import 'package:flutter/material.dart';
import 'package:helpdesk/services/auth.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';
import 'package:helpdesk/utils/shared_components.dart';

import '../welcome4.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService _auth= AuthService();
final _formKey = GlobalKey<FormState>();

//text field state
String email="";
String password="";
String error="";
String name="";
String usn="";
String age='';
String contact='';
String course="";
bool _logging=false;


  Future<bool> _onWillPop() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: _discardChangesContainer(),
          ),
        )) ??
        false;
  }

  Widget _discardChangesContainer() => Container(
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
          _dialogButton()
        ],
      ));

  Widget _dialogButton() => Container(
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

  @override
  Widget build(BuildContext context) => SafeArea(
          child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _body(),
        ),
      ));

  Widget _body() {
    return Container(
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
            _customAppBar(),
            _titleAndSub(),
            _basicInfo(),
            _addButton()
          ],
        ),
      ],
    )));
  }

  Widget _customAppBar() => Container(
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
                    content: _discardChangesContainer(),
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

  Widget _titleAndSub() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[_title(), _subtitle()],
      );

  Widget _title() => Container(
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
              "Sign Up",
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
          "Provide your information.",
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

  Widget _basicInfo() => Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            _label("Name"),
            _nameTextField(),
            SizedBox(height: 20),
            _label("USN"),
            _usnTextField(),
            SizedBox(height: 20),
            _label("Age and Contact"),
            Container(
              width: 500,
              child: Row(
                children: <Widget>[
                  Container(width: MediaQuery.of(context).size.width/6,child: _ageTextField()),
                  SizedBox(width: 10,),
                  Container(width: MediaQuery.of(context).size.width/1.7,child: _contactTextField())
                ],
              ),
            ),
            SizedBox(height: 20),
            _label("Course"),
            _courseTextField(),
            SizedBox(height: 20),
            _label("Email"),
            _emailTextField(),
            SizedBox(height: 20),
            _label("Password"),
            _passwordTextField(),
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

    Widget _nameTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          decoration: inputDecoration("Enter your Name",),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          validator: (val)=> val.isEmpty ? 'Cannot be empty': null,
              onChanged: (val) {
                setState(() {
                  name=val;
                });
              },
        ),
      );

    Widget _usnTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          maxLength: 11,
          decoration: inputDecoration("Enter your USN",),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          validator: (val)=> val.length < 11 ? 'Enter a valid USN': null,
              onChanged: (val) {
                setState(() {
                  usn=val;
                });
              },
        ),
      );

    Widget _ageTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          maxLength: 2,
          decoration: inputDecoration("Age",),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          validator: (val)=> val.length > 3 || val.length < 1 || double.parse(val)<14 ? 'Enter a valid Age': null,
              onChanged: (val) {
                setState(() {
                  age=val;
                });
              },
        ),
      );

    Widget _contactTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          maxLength: 11,
          decoration: inputDecoration("Enter your Contact Number",),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          validator: (val)=> val.length != 11 ? 'Enter a valid Contact Number': null,
              onChanged: (val) {
                setState(() {
                  contact=val;
                });
              },
        ),
      );

    Widget _courseTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          decoration: inputDecoration("Enter your Course",),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.emailAddress,
          validator: (val)=> val.isEmpty ? 'Cannot be empty': null,
              onChanged: (val) {
                setState(() {
                  course=val;
                });
              },
        ),
      );

    Widget _passwordTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          decoration: inputDecoration("Enter your Password",),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.emailAddress,
          validator: (val)=> val.length <6 ? 'Enter a Password 6+ Chars Long': null,
              obscureText: true,
              onChanged: (val) {
                setState(() {
                  password=val;
                });
              },
        ),
      );

    Widget _emailTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: .5)
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        alignment: Alignment.centerLeft,
        child: TextFormField(
          decoration: inputDecoration("Enter your Email Address",),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
              onChanged: (val) {
                setState(() {
                  email=val;
                });
              },
        ),
      );

      String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Widget _addButton() => Container(
    margin: EdgeInsets.only(top: 50),
    decoration: _logInButtonDecoration(),
    child: InkWell(
      onTap: () async{
              
                if (_formKey.currentState.validate()){
                  setState(() {
                _logging = true;
              });
                print(email);
                print(password);
                dynamic result = await _auth.registerWithEmailAndPassword(email, password,name,usn,age,contact,course,context).then((user){
                  print(user.uid);
                  pushReplace(context, WelcomeScreen4(userid: user.uid));
                }).catchError((e){
                  setState(() {
                _logging = false;
              });
                });
                 FocusScope.of(context).requestFocus(new FocusNode()); 
                }
              },
      child: Container(
        width: Globals.screenWidth(context),
        height: 55.0,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: _logging==false ? Text(
              "Register",
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
