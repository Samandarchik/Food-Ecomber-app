import 'package:flutter/material.dart';
import 'dart:async';

class YourWidget extends StatefulWidget {
  const YourWidget({super.key});

  @override
  State<YourWidget> createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  int a = 1;
  Timer? _timer;

  void _startAdding() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        a += 1; // Har bir sekundda a ga 1 qo'shadi
      });
    });
  }

  void _stopAdding() {
    if (_timer != null) {
      _timer!.cancel(); // Timer ni to'xtatadi
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapDown: (_) {
            _startAdding(); // Bosish bosilganda boshlaydi
          },
          onTapUp: (_) {
            _stopAdding(); // Bosish tugagach to'xtatadi
          },
          onTapCancel: () {
            _stopAdding(); // Agar bosish bekor qilinsa to'xtatadi
          },
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Text(
              'Value of a: $a',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopAdding(); // Widget o'chirilganda Timer ni to'xtatadi
    super.dispose();
  }
}
