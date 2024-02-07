import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Controller/Providers/GoogleAuthenticationProvider.dart';
import 'package:flutter_application_2/View/UI/Order.dart';
import 'package:flutter_application_2/View/auth/Login.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authController = Get.put(GoogleAuthenticationProvider());

  final List<String> options = ['Logout'];

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 57,
              child: user?.photoURL != null
                  ? ClipOval(
                      child: Image.network(
                        user!.photoURL!,
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      size: 30,
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user?.email ?? 'Guest',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 120),
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black),
            child: TextButton(
              onPressed: () {
                if (options.contains('Logout')) {
                  Provider.of<GoogleAuthenticationProvider>(context, listen: false).logout(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
           const SizedBox(height: 76),
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black),
            child: TextButton(
              onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Orderpage(),
                    ),
                  );
              },
              child: const Text(
                'Order',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}