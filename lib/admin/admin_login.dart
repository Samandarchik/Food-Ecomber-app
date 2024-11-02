import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/admin/home_admin.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height / 2),
            padding: EdgeInsets.only(top: 45, right: 20, left: 20),
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 53, 51, 51),
                  black,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(size.width, 110))),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 60),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text("Lest's start with\nAdmin!",
                        style: TextStyle(
                            color: black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: size.height / 2.2,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 20, top: 5, bottom: 5),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 160, 160, 147)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextFormField(
                                  controller: userNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter UserName";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "User Name",
                                      hintStyle: TextStyle(
                                          color: black.withOpacity(.5))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 20, top: 5, bottom: 5),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 160, 160, 147)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextFormField(
                                  controller: userPasswordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: black.withOpacity(.5))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: loginAdmin,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: black,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: textStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["id"] != userNameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Your id is not correct",
            style: textStyle18,
          )));
        } else if (result.data()["password"] !=
            userPasswordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Your Password is not correct")));
        } else {
          Route route = MaterialPageRoute(builder: (context) => HomeAdmin());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
