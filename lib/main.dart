import 'package:flutter/material.dart';
import 'package:flutter_application_2/Controller/DarkModeProvider.dart';
import 'package:flutter_application_2/Controller/GmailProvider.dart';
import 'package:flutter_application_2/Controller/GoogleAuthenticationProvider.dart';
import 'package:flutter_application_2/Controller/ApiProvider.dart';
import 'package:flutter_application_2/View/SplashScreen.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

         //////////   PROVIDERS    //////////

      providers: [
        ChangeNotifierProvider(create: (context) => ApiProvider()),
        ChangeNotifierProvider(create: (context) => GoogleAuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => DarkModeProvider()),
        ChangeNotifierProvider(create: (context) => GmailProvider()),
      ],
      child: const MaterialApp(
        title: "QuizApp",
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}