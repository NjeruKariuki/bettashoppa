//login view
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/constants/routes.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:glassmorphism/glassmorphism.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/ingredients.jpg'))),
          child: Center(
            child: SizedBox(
              height: 410,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GlassmorphicContainer(
                      width: 350,
                      height: 370,
                      borderRadius: 20,
                      blur: 5,
                      alignment: Alignment.bottomCenter,
                      border: 2,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.01),
                          const Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        colors: [
                          const Color(0xFFffffff).withOpacity(0),
                          const Color((0xFFFFFFFF)).withOpacity(0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15).copyWith(top: 70),
                        child: Column(
                          children: [
                            TextField(
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: _email,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontSize: 14),
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white.withOpacity(.8),
                                    size: 20,
                                  ),
                                  prefixIconConstraints:
                                      const BoxConstraints(minWidth: 35),
                                  hintText: 'Enter your email',
                                  hintStyle: const TextStyle(
                                      color: Colors.white60, fontSize: 14)),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: _password,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontSize: 14),
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white.withOpacity(.8),
                                    size: 20,
                                  ),
                                  prefixIconConstraints:
                                      const BoxConstraints(minWidth: 35),
                                  suffixIcon: Icon(
                                    Icons.visibility_off,
                                    color: Colors.white.withOpacity(.8),
                                    size: 20,
                                  ),
                                  suffixIconConstraints:
                                      const BoxConstraints(minWidth: 35),
                                  hintText: 'Enter your password',
                                  hintStyle: const TextStyle(
                                      color: Colors.white60, fontSize: 14)),
                            ),
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(.8),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final email = _email.text;
                                final password = _password.text;

                                try {
                                  final userCredential = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );

                                  devtools.log(userCredential.toString());
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    bettashoppaRoute,
                                    (route) => false,
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    await showErrorDialog(
                                      context,
                                      'User not found!',
                                    );
                                    devtools.log('user not found');
                                  } else if (e.code == 'wrong-password') {
                                    await showErrorDialog(
                                      context,
                                      'Wrong password!',
                                    );
                                    devtools.log('wrong password');
                                  } else {
                                    await showErrorDialog(
                                      context,
                                      e.code.toString(),
                                    );
                                  }
                                } catch (e) {
                                  await showErrorDialog(
                                    context,
                                    e.toString(),
                                  );
                                }
                              },
                              child: Container(
                                height: 45,
                                width: 320,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    border: Border.all(color: Colors.white70)),
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(.8),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      registerRoute,
                                      (route) => false,
                                    );
                                  },
                                  child: const Text(
                                    'New here? Sign Up',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/meal.jpg'))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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
