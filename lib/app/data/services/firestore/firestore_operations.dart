import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_manager/app/data/model/vault_model.dart';
import 'package:password_manager/app/data/services/auth/authentication.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../../model/credentials_model.dart';

class FireStoreOperations {
  static const String _cnUser = "users";
  static const String _cnVault = "vaults";
  static const String _cnCredentials = "credentials";
  static const String _userNotPresent = "user not logged in!!!";

  static Future<DocumentReference<Map<String, dynamic>>?> addVault(VaultModel vault,
      {String? fbVaultId = ""}) async {
    User? user = await Authentication.getCurrentUser();
    if (user != null) {
      CollectionReference<Map<String, dynamic>> ref =
          FirebaseFirestore.instance.collection(_cnUser).doc(user.uid).collection(_cnVault);
      if (fbVaultId != "") {
        await ref.doc(fbVaultId).set(vault.toJson(), SetOptions(merge: true));
        return ref.doc(fbVaultId);
      } else {
        return ref.add(vault.toJson());
      }
    } else {
      printDebug(_userNotPresent);
      return null;
    }
  }

  static Future<DocumentReference<Map<String, dynamic>>?> addCredentialToVault(
      String fsVaultID, CredentialsModel credModel,
      {String? fsCredId = ""}) async {
    User? user = await Authentication.getCurrentUser();
    if (user != null) {
      CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance
          .collection(_cnUser)
          .doc(user.uid)
          .collection(_cnVault)
          .doc(fsVaultID)
          .collection(_cnCredentials);
      if (fsCredId != "") {
        await ref.doc(fsCredId).set(credModel.toJson(), SetOptions(merge: true));
        return ref.doc(fsCredId);
      } else {
        return ref.add(credModel.toJson());
      }
    } else {
      printDebug(_userNotPresent);
      return null;
    }
  }

  static Future<void> deleteCredentialFromVault(
    String fsVaultID,
    String fsCredId,
  ) async {
    User? user = await Authentication.getCurrentUser();
    if (user != null) {
      return FirebaseFirestore.instance
          .collection(_cnUser)
          .doc(user.uid)
          .collection(_cnVault)
          .doc(fsVaultID)
          .collection(_cnCredentials)
          .doc(fsCredId)
          .delete();
    } else {
      printDebug(_userNotPresent);
    }
  }

  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> getVaultList() async {
    User? user = await Authentication.getCurrentUser();
    if (user != null) {
      return await FirebaseFirestore.instance
          .collection(_cnUser)
          .doc(user.uid)
          .collection(_cnVault)
          .snapshots();
    } else {
      printDebug(_userNotPresent);
      return null;
    }
  }

  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> getCredentialListByVault(
    String fsVaultID, {
    String orderBy = "",
  }) async {
    User? user = await Authentication.getCurrentUser();
    if (user != null) {
      CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance
          .collection(_cnUser)
          .doc(user.uid)
          .collection(_cnVault)
          .doc(fsVaultID)
          .collection(_cnCredentials);

      if (orderBy != "") {
        ref.orderBy(orderBy);
      }
      return ref.snapshots();
    } else {
      printDebug(_userNotPresent);
      return null;
    }
  }
}
