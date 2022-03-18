import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/login.dart';

class Proflie extends StatefulWidget {
  const Proflie({Key? key}) : super(key: key);

  @override
  State<Proflie> createState() => _ProflieState();
}

class _ProflieState extends State<Proflie> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  User? user = FirebaseAuth.instance.currentUser;
  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verfication Email has been sent');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black26,
          content: Text(
            'Verfication Email has been sent',
            style: TextStyle(fontSize: 10, color: Colors.amber),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset('assets/profile.png'),
            ),
            SizedBox(height: 50),
            Column(
              children: [
                Text(
                  'User ID:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  uid,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                )
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email: $email',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                user!.emailVerified
                    ? Text(
                        'Verified',
                        style: TextStyle(fontSize: 22, color: Colors.lightBlue),
                      )
                    : TextButton(
                        onPressed: () {
                          verifyEmail();
                        },
                        child: Text(
                          'Verify Email',
                          style:
                              TextStyle(fontSize: 20, color: Colors.lightBlue),
                        ))
              ],
            ),
            SizedBox(height: 50),
            Column(
              children: [
                Text('Created',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  creationTime.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
