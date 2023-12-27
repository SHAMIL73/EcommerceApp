import 'package:flutter/material.dart';
import 'package:flutter_application_2/View%20Model/DarkModeProvider.dart';
import 'package:flutter_application_2/View%20Model/GoogleAuthenticationProvider.dart';
import 'package:flutter_application_2/View/Login.dart';
import 'package:flutter_application_2/View%20Model/ProviderDemo.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderClass()),
        // Add more providers as needed
        ChangeNotifierProvider(create: (context) => GoogleAuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => DarkModeProvider()),
      ],
      child: const MaterialApp(
        title: "QuizApp",
        home: Login(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
