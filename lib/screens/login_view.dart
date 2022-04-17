//login view
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/constants/app_constants.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),),
        elevation: 2,
        backgroundColor: mainHexColor,
      ),
      body: Column(
                      children: [
                        const SizedBox(
                          height: 20,
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
                                height: 20,
                              ),
    
                              //register call
                              SizedBox(
                                height: 30,
                                child: Text(
                                  'Login',
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
                          height: 50,
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
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
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
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
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
                                  .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
    
                              print(userCredential);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('user not found');
                              } else if (e.code == 'wrong-password') {
                                print('wrong password');
                              }
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
    
                        //spacing
                        const SizedBox(height: 15,),
    
                        //register here
                        TextButton(onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register/',
                           (route) => false,
                          );
                        },
                         child: const Text('Not registered yet? Register here!'),
                         ),
                      ],
                    ),
    );
                
  }
}
