import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/sign_up.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController mailcontroller = TextEditingController();
  String email = "";
  final _formkey = GlobalKey<FormState>();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: textStyle18,
      )));
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for that email.",
          style: textStyle18,
        )));
      } else if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "invalid-email",
          style: textStyle18,
        )));
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "Password Recovery",
              style: TextStyle(
                  fontSize: 30, color: white, fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            "Enter your mail",
            style: TextStyle(
                color: white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Form(
              key: _formkey,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white70, width: 2),
                    ),
                    child: TextFormField(
                      controller: mailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Email";
                        }
                        return null;
                      },
                      style: TextStyle(color: white),
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: white,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: 30,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = mailcontroller.text;
                        });
                        resetPassword();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 140,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Send Email",
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: white.withOpacity(.8)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "  Creat",
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
