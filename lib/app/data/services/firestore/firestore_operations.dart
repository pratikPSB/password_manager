import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_manager/app/data/services/auth/authentication.dart';
import 'package:password_manager/main.dart';

class FireStoreOperations {
  static createDefaultVaultForUser() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = await Authentication.getCurrentUser();
    if(user != null) {
      //todo: add fire store logic
      // firestore.collection("users").doc(user.uid).set();
    }
  }
}