
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorials/constants/app_constants.dart';
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
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/bettashoppa/' :(context) => const BettaShoppa(),
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

// main ui of app

class BettaShoppa extends StatefulWidget {
  const BettaShoppa({ Key? key }) : super(key: key);

  @override
  State<BettaShoppa> createState() => _BettaShoppaState();
}

class _BettaShoppaState extends State<BettaShoppa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Betta Shoppa',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),),
        elevation: 2,
        backgroundColor: mainHexColor,
        actions: [
          PopupMenuButton <MenuAction> (
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login/',
                     (_) => false,
                    );
              }
            }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem <MenuAction> (
                  value: MenuAction.logout,
                  child: Text('Log out'
                ))
              ];
            },
          ),
        ],
      ),


      body: Column(
        children: const [
          Center(
            child: Text('This is the main page'),
          ),
          
        ],
      )
    );
  }
}



//show dialog

Future <bool> showLogOutDialog(BuildContext context) {
  return showDialog <bool> (context: context,
  builder: (context) {
     return AlertDialog(
       title: const Text('sign out'),
       content: const Text('Are you sure you want to sign out?'),
       actions: [
         TextButton(onPressed: () {
           Navigator.of(context).pop(false);
         }, child: const Text('Cancel')),
         TextButton(onPressed: () {
           Navigator.of(context).pop(true);
         }, child: const Text('Yes')),
       ],
     );
   },
   ).then((value) => value??false);
}