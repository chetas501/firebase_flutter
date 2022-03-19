import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/login.dart';
import 'package:flutter_firebase/pages/signup.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  final emailController = TextEditingController();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber,
          content: Text(
            'Password Reset Email has been sent ',
            style: TextStyle(fontSize: 18),
          )));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for this email');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              'No user found for this email',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Image.asset('assets/forget.jpg'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.black26, fontSize: 15),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else if (!value.contains('@')) {
                        return "Please enter valid email id";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                  // password = passwordController.text;
                                  // confirmPassword =
                                  //     confirmPasswordController.text;
                                });
                                resetPassword();
                              }
                            },
                            child: Text(
                              "Send Email",
                              style: TextStyle(fontSize: 15),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 13),
                            ))
                      ]),
                ),
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have a account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animayion2) =>
                                            SignUp(),
                                    transitionDuration: Duration(seconds: 0)));
                          },
                          child: Text('Sign Up'))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
