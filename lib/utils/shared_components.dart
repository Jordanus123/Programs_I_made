// //import 'package:cached_network_image/cached_network_image.dart';
// //import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// //import 'package:helpdesk/screens/user_profile/expanded_user.dart';
// import 'package:helpdesk/utils/colors.dart';
// //import 'package:helpdesk/utils/globals.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// //import 'package:shimmer/shimmer.dart';

// void showFlushBar({
//   @required BuildContext context,
//   @required String message,
//   int duration
// }) {
//   Flushbar(
//     flushbarPosition: FlushbarPosition.TOP,
//     flushbarStyle: FlushbarStyle.GROUNDED,
//     backgroundColor: Colors.white,
//     backgroundGradient: LinearGradient(colors: [Colors.white, Colors.red[100]]),
//     isDismissible: false,
//     duration: Duration(seconds: duration!=null?duration:3),
//     leftBarIndicatorColor: Colors.red,
//     icon: Icon(
//       Icons.warning,
//       color: Colors.red,
//     ),
//     messageText: Container(
//       alignment: Alignment.centerLeft,
//       height: 40.0,
//       child: Text(
//         message,
//         style: TextStyle(fontSize: 14.0, color: Colors.black54, fontFamily: "ShadowsIntoLightTwo"),
//       ),
//     )
//   )..show(context);
// }

// void pushReplace(BuildContext context,Widget dest){

// 	// Navigator.of(context).push(
//   Navigator.of(context).pushReplacement(
// 		MaterialPageRoute( builder: (BuildContext context) => dest )
// 	);
// }
// void pushh(BuildContext context,Widget dest){

// 	// Navigator.of(context).push(
//     Navigator.push(context, MaterialPageRoute( builder: (BuildContext context) => dest));
//     //Navigator.pushReplacement(context, MaterialPageRoute( builder: (BuildContext context) => dest ));
//   // Navigator.of(context).push(
// 	// 	MaterialPageRoute( builder: (BuildContext context) => dest )
// 	// );
// }

// // Future<void> userInfoModalBottomSheet({
// //   @required BuildContext context,
// //   @required String userId,
// //   @required String userAccountID
// // }) async {
// //   final DocumentSnapshot userDetails = await Firestore.instance.collection(Globals.COL_USERS).document(userId).get();
// //   showModalBottomSheet(
// //     context: context,
// //     builder: (BuildContext bContext){
// //       return userDetails.data!=null
// //         ? _userInfoContainer(bContext, userDetails, userAccountID)
// //         : Container();
// //     }
// //   );
// // }

// // Widget _userInfoContainer(
// //   BuildContext context,
// //   DocumentSnapshot userDetails,
// //   String userId
// // ) => Container(
// //   height: 404.0,
// //   child: Column(
// //     children: <Widget>[
// //       Container(
// //         width: Globals.screenWidth(context),
// //         height: 3.0,
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.centerRight,
// //             end: Alignment.centerLeft,
// //             stops: [0.1, 0.2, 0.3, 0.8],
// //             colors: [
// //               Colors.red[400],
// //               Colors.pink[200],
// //               Colors.orange[100],
// //               Colors.white,
// //             ],
// //           ),
// //         ),
// //       ),
// //       GestureDetector(
// //         onTap: (){
// //           _expandUserDialog(context, userDetails, userId);
// //         },
// //         child: Stack(
// //           children: <Widget>[
// //             _userImage(context, userDetails),
// //             Positioned(
// //               bottom: 0.0,
// //               child: Container(
// //                 width: Globals.screenWidth(context),
// //                 color: Colors.white70,
// //                 child: _userInfo(context, userDetails),
// //               ),
// //             )
// //           ],
// //         )
// //       ),
// //     ],
// //   ),
// // );

// // Widget _userImage(BuildContext context, DocumentSnapshot snapshot) => Hero(
// //   tag: snapshot.data['userId'],
// //   child: Container(
// //     child: ClipRRect(
// //       child: CachedNetworkImage(
// //         width: Globals.screenWidth(context),
// //         height: 400.0,
// //         fit: BoxFit.cover,
// //         imageUrl: snapshot.data['userImage']['imageUrl'],
// //         placeholder: (BuildContext context, String placeHolder){
// //           return _avatarShimmer(height: 400.0, width: Globals.screenWidth(context));
// //         },
// //         errorWidget: (BuildContext context, String placeHolder, Object object){
// //           return Icon(Icons.error);
// //         },
// //       ),
// //     )
// //   ),
// // );

// // Widget _avatarShimmer({double height, double width}) => Shimmer.fromColors(
// //   baseColor: Color.fromRGBO(225, 225, 225, 1.0),
// //   highlightColor: Color.fromRGBO(245, 245, 245, 1.0),
// //   child: Container(
// //     decoration: BoxDecoration(
// //       borderRadius: BorderRadius.circular(10.0),
// //       color: Color.fromRGBO(225, 225, 225, 1.0),
// //     ),
// //     child: SizedBox(
// //       height: height??40.0,
// //       width: width??40.0,
// //     ),
// //   )
// // );

// // Widget _userInfo(BuildContext context, DocumentSnapshot snapshot) => Container(
// //     padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
// //     width: Globals.screenWidth(context),
// //     child: Column(
// //       mainAxisAlignment: MainAxisAlignment.start,
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: <Widget>[
// //         Text(
// //           "${snapshot.data['name']}",
// //           style: TextStyle(
// //             color: Colors.black.withOpacity(0.7),
// //             fontSize: 24.0,
// //             fontWeight: FontWeight.bold
// //           ),
// //         ),
// //         SizedBox(height: 5.0),
// //         Text(
// //           "${snapshot.data['age']}",
// //           style: TextStyle(
// //             color: Colors.black.withOpacity(0.7),
// //             fontSize: 20.0,
// //           ),
// //         ),
// //         SizedBox(height: 10.0),
// //         Container(
// //           child: Row(
// //             children: <Widget>[
// //               Icon(
// //                 MdiIcons.mapMarkerRadius,
// //                 size: 17.0,
// //                 color: AppThemeColors.primary,
// //               ),
// //               SizedBox(width: 5.0),
// //               Container(
// //                 width: Globals.screenWidth(context) - 60.0,
// //                 child: Text(
// //                   "${snapshot.data['userAddress']}",
// //                   maxLines: 5,
// //                   overflow: TextOverflow.ellipsis,
// //                   style: TextStyle(
// //                     color: Colors.black.withOpacity(0.7),
// //                     fontSize: 14.0,
// //                   ),
// //                 ),
// //               )
// //             ],
// //           ),
// //         )
// //       ],
// //     ),
// //   );

//   // Future<void> _expandUserDialog(BuildContext context, snapshot, String userId) async {
//   //   await showGeneralDialog(
//   //     barrierColor: Colors.black.withOpacity(0.5),
//   //     transitionBuilder: (context, a1, a2, widget) {
//   //       return Transform.scale(
//   //         scale: a1.value,
//   //         child: Opacity(
//   //           opacity: a1.value,
//   //           child: ExpandedUser(
//   //             userId: userId,
//   //             isAccountOwner: false,
//   //             heroTag: snapshot.data['userId'],
//   //             imageUrl: snapshot.data['userImage']['imageUrl'],
//   //             snapshot: snapshot,
//   //           )
//   //         ),
//   //       );
//   //     },
//   //     transitionDuration: Duration(milliseconds: 200),
//   //     barrierDismissible: true,
//   //     barrierLabel: '',
//   //     context: context,
//   //     pageBuilder: (context, animation1, animation2) {
//   //       return Container();
//   //     }
//   //   );
//   // }

//   void showToast(String message){
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIos: 1,
//         backgroundColor: Colors.black38,
//         textColor: Colors.white,
//         fontSize: 12.0
//     );
//   }
