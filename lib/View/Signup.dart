import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/View%20Model/DarkModeProvider.dart';
import 'package:flutter_application_2/View/Eapp.dart';
import 'package:flutter_application_2/View/Login.dart';
import 'package:flutter_application_2/View%20Model/GoogleAuthenticationProvider.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Textfield Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Google Authentication

  // Light and Dark mode (From provider)

  Color _getTextColor(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return isDarkMode ? Colors.white : Colors.black;
  }

  Color _getTextColor2(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return isDarkMode ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<DarkModeProvider>(context).isDarkMode
          ? Colors.black
          : Colors.white,

      // App Bar

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: Text(
          'Eapp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getTextColor(context),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Consumer<DarkModeProvider>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    size: 30,
                    color: _getTextColor(context),
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Body

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: _getTextColor(context),
                  ),
                ),

                const SizedBox(height: 20.0),

                // Email Textfield

                TextField(
                  controller: emailController,
                  style: TextStyle(color: _getTextColor(context)),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10.0),

                // Password Textfield

                TextField(
                  controller: passwordController,
                  style: TextStyle(color: _getTextColor(context)),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20.0),

                // START OF ROW

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 64),

                      // Sign up Button

                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final credential =
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            if (credential != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Eapp()),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            } else {
                              print(e);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(170, 44)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              _getTextColor(context)),
                        ),
                        child: Text('SIGN UP',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: _getTextColor2(context),
                            )),
                      ),
                    ),

                    // Blue Color Login Button On Right Side of the Textfield

                    TextButton(
                      onPressed: () {
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

                // END OF ROW

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                      "-------------------------or sign in with-------------------------",
                      style: TextStyle(color: _getTextColor(context))),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Google Button

                    GestureDetector(
                      onTap: () async {
                        GoogleAuthenticationProvider provider =
                            Provider.of<GoogleAuthenticationProvider>(
                                context,
                                listen: false);
                        User? user = await provider.signInWithGoogle();

                        if (user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Eapp(),
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
