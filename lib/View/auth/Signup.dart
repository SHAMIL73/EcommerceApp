import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Const/Color.dart';
import 'package:flutter_application_2/Controller/GmailProvider.dart';
import 'package:flutter_application_2/View/BottomNavigationBar.dart';
import 'package:flutter_application_2/View/auth/Login.dart';
import 'package:flutter_application_2/Controller/GoogleAuthenticationProvider.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
//                       // Textfield Controller //                        //

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//                       // Google Authentication //                      //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//                      // App Bar //                                    //

      appBar: AppBar(
        title: const Text(
          'Eapp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

//                     // Body //                                      //

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20.0),

                //                     // Email Textfield //                         //

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10.0),

                //                      // Password Textfield //                   //

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20.0),

//                       // START OF ROW //                        //

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 64),

//                      // Sign up Button //                      //

                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<GmailProvider>(context, listen: false)
                              .gmailSigning(
                                  context, emailController, passwordController);
                        },

//                      // Button Style //                       //

                        style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(170, 44)),
                            backgroundColor:
                                MaterialStateProperty.all(blackcolor)),
                        child: Text('SIGN UP',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: whitecolor,
                            )),
                      ),
                    ),

//                    // Blue Color Login Button On Right Side of the Textfield//             //

                    TextButton(
                      onPressed: () {//

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        "log in",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ],
                ),

//                // END OF ROW//                  //

                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "-------------------------or sign in with-------------------------",
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
//                    // Google Button//                  //

                    GestureDetector(
                      onTap: () async {
                        GoogleAuthenticationProvider provider =
                            Provider.of<GoogleAuthenticationProvider>(context,
                                listen: false);
                        User? user = await provider.signInWithGoogle();

                        if (user != null) {
//                       //Navigation//                       //

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const BottomBar(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/google-removebg-preview.png',
                            height: 33,
                            width: 33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}