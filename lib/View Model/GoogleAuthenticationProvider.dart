import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  User? get user => _user;

  Future<User?> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount;
    try {
      googleSignInAccount = await _googleSignIn.signIn().catchError((onError) => null);
      if (googleSignInAccount == null) {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        // Set the _user variable after successful authentication
        _user = user;

        // Notify listeners after updating the state
        notifyListeners();

        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ...
        } else if (e.code == 'invalid-credential') {
          // ...
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    return null;
  }
}
