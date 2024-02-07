import 'package:flutter/material.dart';
import 'package:flutter_application_2/Controller/Providers/CartProvider.dart';
import 'package:flutter_application_2/Controller/Providers/GmailProvider.dart';
import 'package:flutter_application_2/Controller/Providers/GoogleAuthenticationProvider.dart';
import 'package:flutter_application_2/Controller/Providers/ApiProvider.dart';
import 'package:flutter_application_2/Controller/Providers/WishProvider.dart';
import 'package:flutter_application_2/View/SplashScreen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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
        ChangeNotifierProvider(create: (context) => GmailProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishProvider()),
      ],
      child:  const GetMaterialApp(
        title: "QuizApp",
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}