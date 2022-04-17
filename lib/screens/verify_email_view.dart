import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/constants/app_constants.dart';
import 'package:flutter/material.dart';

//verify email view

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

Future<bool?> get userVerified async {
    await FirebaseAuth.instance.currentUser?.reload();
    return FirebaseAuth.instance.currentUser?.emailVerified;
  }

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Register',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),),
        elevation: 2,
        backgroundColor: mainHexColor,
      ),
      body: Center(
        child: Column(
          children: [
            //spacing
            const SizedBox(
              height: 50,
            ),
    
            //text
            const Text('Please Verify your Email Address'),
    
            //spacing
            const SizedBox(
              height: 50,
            ),
    
            //spacing
            const SizedBox(
              height: 50,
            ),
    
            //send button
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Send email verification'),
            )
          ],
        ),
      ),
    );
  }
}
