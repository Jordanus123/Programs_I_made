// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService {

//   final String uid;
//   DatabaseService({ this.uid });

//   final CollectionReference userCollection = Firestore.instance.collection('user');

//   Future updateUserData(String name, usn,age,contact,course,email,password) async {
//     return await userCollection.document(uid).setData({
//       "name":name,
//       "usn":usn,
//       "age":age,
//       "contact":contact,
//       "course":course,
//       "email":email,
//       "password":password,
//       "account":"student",
//       'uid':uid,
//       'status':'active'
//     });
//   }

//   Future updateUserData2(String name, usn,age,contact,course) async {
//     if (name!=""){
//       return await userCollection.document(uid).updateData({
//       "name":name,
//     });
//     }
//     if (usn!=""){
//       return await userCollection.document(uid).updateData({
//       "usn":usn,
//     });
//     }
//     if (age!=""){
//       return await userCollection.document(uid).updateData({
//       "age":age,
//     });
//     }
//     if (contact!=""){
//       return await userCollection.document(uid).updateData({
//       "contact":contact,
//     });
//     }
//     if (course!=""){
//       return await userCollection.document(uid).updateData({
//       "course":course,
//     });
//     }

//   }

//   Future updateUserData3(String name, usn,age,contact,course) async {

//       return await userCollection.document(uid).updateData({
//       "name":name,
//       "usn":usn,
//       "age":age,
//       "contact":contact,
//       "course":course,
//     });

//   }

// Stream<QuerySnapshot> get user {
//   return userCollection.snapshots();
// }

// }
