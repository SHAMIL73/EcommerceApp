import 'package:flutter/material.dart';
import 'package:flutter_application_2/Login.dart';
import 'package:flutter_application_2/ProviderDemo.dart';
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
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderClass(),
      child: const MaterialApp(
        title: "QuizApp",
        home: Login(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}