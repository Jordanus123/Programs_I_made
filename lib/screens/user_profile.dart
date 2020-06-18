import 'package:flutter/material.dart';

typedef OnClickExplore(int tabBarControllerIndex);
// class UserProfile extends StatefulWidget{

//   final OnClickExplore onClickExplore;
  

//   const UserProfile({
//     @required this.onClickExplore,
    
//   });

//   _UserProfile createState() => _UserProfile();

// }
// class _UserProfile extends State<UserProfile>{
  
// }

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("imo mama"),
    );
  }
}