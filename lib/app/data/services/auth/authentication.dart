import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/app/data/utils/extensions.dart';

import '../../utils/widgets.dart';

class Authentication {
  //get current logged-in user
  static Future<User?> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
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
          Get.showSnackbar(getSnackBar(message: e.message!));
      }
    }
    return user;
  }

  //login with google & return logged-in user
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await getCurrentUser();

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
          UserCredential userCredential;
          if (user != null) {
            userCredential = await user.linkWithCredential(credential);
          } else {
            userCredential = await auth.signInWithCredential(credential);
          }
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            Get.showSnackbar(
                getSnackBar(message: "The account already exists with a different credential"));
          } else if (e.code == 'invalid-credential') {
            Get.showSnackbar(
                getSnackBar(message: "Error occurred while accessing credentials. Try again."));
          } else {
            Get.showSnackbar(getSnackBar(message: e.message!));
          }
        } catch (e) {
          Get.showSnackbar(getSnackBar(message: "Error occurred using Google Sign In. Try again."));
        }
      }
    }
    return user;
  }

  //create user with email & password
  static Future<User?> createUserWithCredentials({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await getCurrentUser();
    try {
      if (kIsWeb) {
        await auth.setPersistence(Persistence.INDEXED_DB);
      }
      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      UserCredential userCredential;
      if (user != null) {
        userCredential = await user.linkWithCredential(credential);
      } else {
        userCredential =
            await auth.createUserWithEmailAndPassword(email: email, password: password);
      }
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          printDebug("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          Get.showSnackbar(getSnackBar(message: e.message!));
      }
    }
    return user;
  }

  //logging in to existing account with email & password
  static Future<User?> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await getCurrentUser();
    try {
      if (kIsWeb) {
        await auth.setPersistence(Persistence.INDEXED_DB);
      }
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          printDebug("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          Get.showSnackbar(getSnackBar(message: e.message!));
      }
    }
    return user;
  }

  static updateUserFields({String name = "", String email = "", String password = ""}) async {
    User? user = await getCurrentUser();
    if (user != null) {
      if (name != "") {
        user.updateDisplayName(name);
      }
      if (email != "") {
        user.verifyBeforeUpdateEmail(email);
      }
      if (password != "") {
        user.updatePassword(password);
      }
    }
  }

  static initiateEmailVerificationFlow() async {
    User? user = await getCurrentUser();
    if (user != null) {
      await user.reload();
      if (user.email != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          Get.showSnackbar(getSnackBar(
              title: "Verify E-mail", message: "please verify your email as it is mandatory."));
        }
      }
    }
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
      Get.showSnackbar(getSnackBar(message: "Error signing out. Try again."));
    }
  }
}
