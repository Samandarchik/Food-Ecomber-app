import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/coor.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class Ui extends StatelessWidget {
  const Ui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyBottom(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          MyBottom(
              icon: Icon(
            Icons.remove,
            color: white,
          ))
        ],
      ),
    );
  }
}

class MyBottom extends StatelessWidget {
  final Icon icon;
  const MyBottom({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 60,
        color: Colors.red,
        child: Center(child: icon),
      ),
    );
  }
}
