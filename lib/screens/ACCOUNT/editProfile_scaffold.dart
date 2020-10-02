import 'package:flutter/material.dart';
import 'package:helpdesk/screens/ACCOUNT/editprofile.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/utils/globals.dart';

class EditProfileScaffold extends StatefulWidget {
  @override
  _EditProfileScaffoldState createState() => _EditProfileScaffoldState();
  final String userId;
  final String aname;
  final String ausn;
  final String aage;
  final String acontact;
  final String acourse;
  final String uid;
  EditProfileScaffold(
      {this.userId,
      this.aname,
      this.aage,
      this.acontact,
      this.acourse,
      this.ausn,
      this.uid});
}

class _EditProfileScaffoldState extends State<EditProfileScaffold> {
  @override
  Widget build(BuildContext context) => SafeArea(
          child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: EditProfile(
            userId: widget.userId,
            aage: widget.aage,
            acontact: widget.acontact,
            acourse: widget.acourse,
            aname: widget.aname,
            ausn: widget.ausn,
            uid: widget.uid,
          ),
        ),
      ));

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
}
