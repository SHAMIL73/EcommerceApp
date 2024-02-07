import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/View/BottomNavigationBar.dart';

class GmailProvider extends ChangeNotifier {
  Future<void> gmailSigning(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Extract UID from the UserCredential
      String uid = credential.user!.uid;

      // Now you can use the UID as needed, for example, store it in a database
      // or perform any other operation.

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomBar(),
        ),
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }
}