import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  load() {
    loading = !loading;
    notifyListeners();
  }

  Future<bool> saveChanges(context, AsyncSnapshot<DocumentSnapshot> snapshot,
      name, usn, age, contact, course) async {
    loading = true;
    notifyListeners();
    try {
      userCollection.doc(snapshot.data.data()['uid']).update({
        "name": name,
        "usn": usn,
        "age": age,
        "contact": contact,
        "course": contact,
      });
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Saved Changes")));
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
