// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:helpdesk/services/database.dart';
// //import 'package:get_in/utils/shared_components.dart';
// import 'dart:convert';

// import 'package:helpdesk/utils/shared_components.dart';

// class AuthService{

//   static final FirebaseAuth _auth = FirebaseAuth.instance;

// 	static Future<AuthResult> execEmailSignIn(String email, String password) async {
// 		return await _auth.signInWithEmailAndPassword(
// 			email: email, password: password);
// 	}

//   Future signInUser(String email, String password, BuildContext context) async {
//     try{
//       AuthResult result = await _auth.signInWithEmailAndPassword(
//         email: email, password: password
//       );
//       FirebaseUser user = result.user;
//       final IdTokenResult token = await user.getIdToken();
//       print(token.claims);
//       return user;
//     } catch (e) {
//         showFlushBar(
//           context: context,
//           message: e.message,
//           duration: 4
//         );
//        return null;
//     }
//   }

//   static Future<void> signOut() async {
// 		await _auth
// 			.signOut()
// 			.then((_) => print("sign out auth performed"))
// 			.catchError((err) => print("sign out auth error $err"));
// 	}

// Future registerWithEmailAndPassword(String email, String password, name, usn,age,contact,course,context) async{
//   try {
//     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     FirebaseUser user = result.user;

//     DatabaseService(uid: user.uid).updateUserData(name,usn,age,contact,course,email,password);
//     _auth.signInWithEmailAndPassword(
//         email: email, password: password
//       );
//     return user;

//   } catch(e){
//     showFlushBar(
//           context: context,
//           message: e.message,
//           duration: 4
//         );
//     return null;
//   }
// }

// }

// Map<String, dynamic> parseAuthToken(String token) {
// 	final parts = token.split('.');
// 	if (parts.length != 3) {
// 		throw Exception('invalid token');
// 	}

// 	final payload = decodeBase64(parts[1]);
// 	final payloadMap = json.decode(payload);
// 	if (payloadMap is! Map<String, dynamic>) {
// 		throw Exception('invalid payload');
// 	}

// 	return payloadMap;
// }

// String decodeBase64(String str) {
// 	String output = str.replaceAll('-', '+').replaceAll('_', '/');

// 	switch (output.length % 4) {
// 		case 0:
// 		break;
// 		case 2:
// 		output += '==';
// 		break;
// 		case 3:
// 		output += '=';
// 		break;
// 		default:
// 		throw Exception('Illegal base64url string!"');
// 	}

// 	return utf8.decode(base64Url.decode(output));
// }
