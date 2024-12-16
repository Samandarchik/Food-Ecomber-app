import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final _questionController = TextEditingController();
  final _answerAController = TextEditingController();
  final _answerBController = TextEditingController();
  final _answerCController = TextEditingController();
  final _answerDController = TextEditingController();
  final _correctAnswerController = TextEditingController();
  final _categoryController = TextEditingController(); // Kategoriya nomi

  final _firestore = FirebaseFirestore.instance;

  // Savol yuborish funksiyasi
  void _submitQuestion() async {
    if (_questionController.text.isEmpty ||
        _answerAController.text.isEmpty ||
        _answerBController.text.isEmpty ||
        _answerCController.text.isEmpty ||
        _answerDController.text.isEmpty ||
        _correctAnswerController.text.isEmpty ||
        _categoryController.text.isEmpty) {
      return; // Validatsiya
    }

    String category =
        _categoryController.text.trim(); // Kategoriya nomini olish

    // Firestore'da kategoriya mavjudligini tekshirish
    var categoryRef = _firestore.collection('chats').doc(category);

    categoryRef.get().then((doc) {
      if (!doc.exists) {
        // Agar kategoriya mavjud bo'lmasa, uni yaratish
        categoryRef.set({'createdAt': FieldValue.serverTimestamp()});
      }

      // Savol va javob variantlarini qo'shish
      categoryRef.collection('questions').add({
        'question': _questionController.text,
        'answers': {
          'a': _answerAController.text,
          'b': _answerBController.text,
          'c': _answerCController.text,
          'd': _answerDController.text,
        },
        'correctAnswer': _correctAnswerController.text,
      }).then((_) {
        // Formani tozalash
        _questionController.clear();
        _answerAController.clear();
        _answerBController.clear();
        _answerCController.clear();
        _answerDController.clear();
        _correctAnswerController.clear();
        _categoryController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Savol muvaffaqiyatli qo\'shildi!')));
      }).catchError((e) {
        print('Error: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Xatolik yuz berdi.')));
      });
    }).catchError((e) {
      print('Error checking category: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kategoriya tekshirishda xato yuz berdi.')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                  labelText: 'Kategoriya nomi (masalan: questions1)'),
            ),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Savol'),
            ),
            TextField(
              controller: _answerAController,
              decoration: InputDecoration(labelText: 'Javob A'),
            ),
            TextField(
              controller: _answerBController,
              decoration: InputDecoration(labelText: 'Javob B'),
            ),
            TextField(
              controller: _answerCController,
              decoration: InputDecoration(labelText: 'Javob C'),
            ),
            TextField(
              controller: _answerDController,
              decoration: InputDecoration(labelText: 'Javob D'),
            ),
            TextField(
              controller: _correctAnswerController,
              decoration:
                  InputDecoration(labelText: 'To\'g\'ri javob (a/b/c/d)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitQuestion,
              child: Text('Savolni yuborish'),
            ),
          ],
        ),
      ),
    );
  }
}
