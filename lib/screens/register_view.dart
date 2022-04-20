import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/constants/app_constants.dart';
import 'package:firebase_tutorials/constants/routes.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

//dispose fields

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevation: 2,
        backgroundColor: mainHexColor,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          //text
          Center(
            child: Column(
              children: const [
                //welcome message
                SizedBox(
                  height: 40,
                  child: Text(
                    'Welcome to BettaShoppa',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                //spacing
                SizedBox(
                  height: 30,
                ),

                //register call
                SizedBox(
                  height: 40,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),

          //email field
          SizedBox(
            width: 380,
            child: TextField(
              enableSuggestions: false,
              autocorrect: false,
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                labelText: "enter your email",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          //password field
          SizedBox(
            width: 380,
            child: TextField(
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              controller: _password,
              decoration: InputDecoration(
                labelText: "enter your password",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),

          //spacing
          const SizedBox(
            height: 50,
          ),

          //registerbutton
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(380, 70),
              maximumSize: const Size(380, 70),
              shadowColor: mainHexColor,
              elevation: 6,
              primary: mainHexColor,
            ),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                await showErrorDialog(
                  context,
                  'user registered successfully!',
                );
                devtools.log('user registered successfully');
                devtools.log(userCredential.toString());
                Navigator.of(context).pushNamedAndRemoveUntil(
                  bettashoppaRoute,
                  (route) => false,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'invalid-email') {
                  await showErrorDialog(
                    context,
                    'Invalid email!',
                  );
                  devtools.log('invalid email');
                } else if (e.code == 'weak-password') {
                  await showErrorDialog(
                    context,
                    'Weak password!',
                  );
                  devtools.log('weak password');
                } else if (e.code == 'email-already-in-use') {
                  await showErrorDialog(
                    context,
                    'Email already in use!',
                  );
                  devtools.log('email already in use');
                } else {
                  await showErrorDialog(
                    context,
                    'Something bad happened!, try again',
                  );
                  devtools.log('sth bad happened');
                }
              } catch (e) {
                await showErrorDialog(
                  context,
                  e.toString(),
                );
              }
            },
            child: const Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          //spacing
          const SizedBox(
            height: 15,
          ),

          //register here
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already have an account. Login here!'),
          ),
        ],
      ),
    );
  }
}

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('an error occured'),
        content: Text(text),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'))
        ],
      );
    },
  );
}
