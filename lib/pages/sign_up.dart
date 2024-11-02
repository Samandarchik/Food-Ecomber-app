import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/bottom_nav.dart';
import 'package:fooddeliveryapp/pages/log_in.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: red,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
      } on FirebaseException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: orange,
              content: Text(
                "Password Provided is too Weak",
                style: textStyle18,
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: orange,
              content: Text(
                "Account Already exsists",
                style: textStyle18,
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: size.width,
                height: size.height / 2.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffff5c30), Color(0xffe74b1a)])),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height / 3),
                width: size.width,
                height: size.height / 2,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Text(""),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, right: 20, left: 20),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: size.width / 1.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: size.width,
                        height: size.height / 1.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Sign Up",
                                style: AppWidget.headlineTextFeildSyle(),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: namecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle:
                                        AppWidget.semiBoldTextFeildSyle(),
                                    prefixIcon: Icon(Icons.person_outlined)),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: mailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter E-mail';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle:
                                        AppWidget.semiBoldTextFeildSyle(),
                                    prefixIcon: Icon(Icons.email_outlined)),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: passwordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle:
                                        AppWidget.semiBoldTextFeildSyle(),
                                    prefixIcon: Icon(Icons.password_outlined)),
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = mailcontroller.text;
                                        name = namecontroller.text;
                                        password = passwordcontroller.text;
                                      });
                                    }
                                    registration();
                                  });
                                },
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Color(0xffff5722),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LogIn()));
                      },
                      child: Text(
                        "Already have an account? Login",
                        style: AppWidget.semiBoldTextFeildSyle(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
