import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:fooddeliveryapp/pages/bottom_nav.dart';
import 'package:fooddeliveryapp/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Food App",
      debugShowCheckedModeBanner: false,
      home: Ui(),
    );
  }
}
