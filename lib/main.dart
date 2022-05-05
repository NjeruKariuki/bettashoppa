
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorials/constants/app_constants.dart';
import 'package:firebase_tutorials/constants/routes.dart';
import 'package:firebase_tutorials/screens/bettashoppa.dart';
import 'package:firebase_tutorials/screens/login_view.dart';
import 'package:firebase_tutorials/screens/register_view.dart';
import 'package:firebase_tutorials/screens/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Betta Shoppa',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),

      //create named routes
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        bettashoppaRoute :(context) => const BettaShoppa(),
      },
    );
  }
}

//homepage builder
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            devtools.log(user.toString());
            if (user != null) {
              if (user.emailVerified) {
                return const BettaShoppa();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}


//menu button actions

enum MenuAction { logout }

