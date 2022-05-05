import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/constants/app_constants.dart';
import 'package:firebase_tutorials/constants/routes.dart';
import 'package:firebase_tutorials/main.dart';
import 'package:firebase_tutorials/utilities/sign_out_dialog.dart';
import 'package:flutter/material.dart';

class BettaShoppa extends StatefulWidget {
  const BettaShoppa({ Key? key }) : super(key: key);

  @override
  State<BettaShoppa> createState() => _BettaShoppaState();
}

class _BettaShoppaState extends State<BettaShoppa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00d3d3d3),
      appBar: AppBar(
        title: Row(
          children: const <Widget> [
            Text('Betta',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontSize: 20.0,
        ),),
        SizedBox(width: 10.0,),

        Text(
          'Shoppa',
          style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  )
        )
        
          ],
        ),
        elevation: 0,
        backgroundColor: const Color(0x00d3d3d3),
        actions: [
          PopupMenuButton <MenuAction> (
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
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
            child: Text('Find recipes, Make a list, choose your ingredients.'),
          ),
          
        ],
      )
    );
  }
}

