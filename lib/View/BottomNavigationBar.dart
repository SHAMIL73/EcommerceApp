// async {
//                           try {
//                             final credential = await FirebaseAuth.instance
//                                 .createUserWithEmailAndPassword(
//                               email: emailController.text,
//                               password: passwordController.text,
//                             );
//                             if (credential == true) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const Dashboard()),
//                               );
//                             }
//                           } on FirebaseAuthException catch (e) {
//                             if (e.code == 'weak-password') {
//                               print('The password provided is too weak.');
//                             } else if (e.code == 'email-already-in-use') {
//                               print(
//                                   'The account already exists for that email.');
//                             } else {
//                               print(e);
//                             }
//                           } catch (e) {
//                             print(e);
//                           }
//                         },