import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/forgot_password.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                        height: size.height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Login",
                              style: AppWidget.headlineTextFeildSyle(),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: AppWidget.semiBoldTextFeildSyle(),
                                  prefixIcon: Icon(Icons.email_outlined)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: AppWidget.semiBoldTextFeildSyle(),
                                  prefixIcon: Icon(Icons.password_outlined)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword()));
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Forgot Password?",
                                  style: AppWidget.semiBoldTextFeildSyle(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Color(0xffff5722),
                                    borderRadius: BorderRadius.circular(20)),
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Don't have an account? Sign up",
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
