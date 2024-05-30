import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

class Authentication {
  //get current logged-in user
  static Future<User?> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  //login with google & return logged-in user
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        await auth.setPersistence(Persistence.INDEXED_DB);
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        user = userCredential.user;
      } catch (e) {
        printDebug(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            Get.showSnackbar(
                const GetSnackBar(title: "The account already exists with a different credential"));
          } else if (e.code == 'invalid-credential') {
            Get.showSnackbar(
                const GetSnackBar(title: "Error occurred while accessing credentials. Try again."));
          }
        } catch (e) {
          Get.showSnackbar(
              const GetSnackBar(title: "Error occurred using Google Sign In. Try again."));
        }
      }
    }
    return user;
  }

  //logout user from firebase
  static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(title: "Error signing out. Try again."));
    }
  }

  //login anonymously and return the user
  static Future<User?> signInAnonymous() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      if (kIsWeb) {
        await auth.setPersistence(Persistence.INDEXED_DB);
      }
      final userCredential = await auth.signInAnonymously();
      printDebug("Signed in with temporary account.");
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          printDebug("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          printDebug("Unknown error.");
      }
    }
    return user;
  }
}
