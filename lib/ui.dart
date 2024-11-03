import 'package:flutter/material.dart';

class Ui extends StatelessWidget {
  const Ui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(
                  title: Text("data"),
                )));
  }
}

class Ui1 extends StatelessWidget {
  const Ui1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
