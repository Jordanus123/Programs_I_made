import 'package:flutter/material.dart';
import 'package:helpdesk/screens/welcome4.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:helpdesk/utils/shared_components.dart';
import 'package:helpdesk/services/auth.dart';

import 'sign.dart';

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final AuthService _auth = AuthService();
  bool _isLoggingIn = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: _main(),
      ),
    );
  }

  Widget _main() => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height+75,
          width: double.infinity,
          decoration: _maindeco(),
          child: Stack(
            children: <Widget>[
              Opacity(
                  opacity: .05,
                  child: Image(
                    image: AssetImage('assets/skin3.jpg'),
                    height: MediaQuery.of(context).size.height+75,
          width: double.infinity,
                  )),
              Column(
                children: <Widget>[
                  _icon(),
                  _form(),
                ],
              ),
            ],
          ),
        ),
      );

  BoxDecoration _maindeco() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.4, 0.6, 0.8],
          colors: [
            Colors.blue[700],
            Colors.blue[500],
            Colors.blue[500],
            Colors.blue[700],
          ],
        ),
      );

  Widget _icon() => Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: 250.0,
        height: 350.0,
        child:
            //Image.asset("assets/LOGO3.jpg"),
            Image(
          image: AssetImage('assets/LOGO3.png'),
          height: 150,
          width: 150,
        ),
      );

  Widget _form() => Container(
        child: Column(
          children: <Widget>[
            _loginTitle(),
            _emailTextField(),
            _passwordTextField(),
            SizedBox(height: 20.0),
            _loginButton(),
            SizedBox(height: 40.0),
            _signUpTitle(),
            _signUpLabel()
          ],
        ),
      );

  Widget _loginTitle() => Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
        child: Text(
          "Sign in with your email and password",
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      );

  Widget _emailTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            new BoxShadow(
              color: Colors.blue[700],
              spreadRadius: 1,
              offset: new Offset(
                0,
                4,
              ),
              blurRadius: 1.0,
            )
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40),
        alignment: Alignment.center,
        child: TextField(
          decoration: inputDecoration("Email Address"),
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
      );

  Widget _passwordTextField() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            new BoxShadow(
              color: Colors.blue[700],
              spreadRadius: 2,
              offset: new Offset(
                0,
                4,
              ),
              blurRadius: 2.0,
            )
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40),
        alignment: Alignment.center,
        child: TextField(
          decoration: inputDecoration("Password"),
          style: TextStyle(
            fontSize: 16.0,
          ),
          obscureText: true,
          textAlign: TextAlign.center,
          controller: _passwordController,
          keyboardType: TextInputType.emailAddress,
        ),
      );

  InputDecoration inputDecoration(String hintText) => InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                width: 1.0, color: AppThemeColors.primary.withOpacity(0.4))),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 2.0, color: Colors.grey)),
      );

  Widget _loginButton() => Container(
      decoration: _logInButtonDecoration(),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          onTap: () async {
            setState(() {
              _isLoggingIn = true;
            });
            await _auth
                .signInUser(
                    _emailController.text, _passwordController.text, context)
                .then((user) {
              print(user.uid);
              pushReplace(context, WelcomeScreen4(userid: user.uid));
            }).catchError((e) {
              setState(() {
                _isLoggingIn = false;
              });
            });
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
              width: 250.0,
              height: 45.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: _isLoggingIn
                  ? Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                    )
                  : Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ))));

  BoxDecoration _logInButtonDecoration() => BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black38,
              spreadRadius: 5,
              offset: new Offset(
                0,
                0,
              ),
              blurRadius: 5.0,
            )
          ],
          color: Colors.black,
          // gradient: LinearGradient(
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.topRight,
          //   stops: [0.1, 0.2, 0.6, 0.9],
          //   colors: [
          //     Colors.blue[300],
          //     Colors.blue[400],
          //     Colors.blue,
          //     Colors.cyan[200],
          //   ],
          // ),
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: AppThemeColors.primary, width: 0.2));

  Widget _signUpTitle() => Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 14.0,color: Colors.grey[400]),
        ),
      );

  Widget _signUpLabel() => GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignIn()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Click here to ",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[400]
                ),
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}
