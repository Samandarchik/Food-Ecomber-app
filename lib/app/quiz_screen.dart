import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool thisExerciseIsDone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chats').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {}
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Chats mavjud emas.'));
          }

          // Chatlarni olish
          var chatDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              thisExerciseIsDone;
              var chatData = chatDocs[index];
              String chatId = chatData.id; 
              
              return ListTile(
                trailing: thisExerciseIsDone ? SizedBox() : Icon(Icons.lock),
                title: Text('Chat: $chatId'),
                onTap: () {
                  _showQuestions(chatId);
                },
              );
            },
          );
        },
      ),
    );
  }

  // Savollarni ko'rsatish uchun yangi sahifa
  void _showQuestions(String chatId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QuizPage(chatId: chatId, thisExerciseIsDone: thisExerciseIsDone),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  bool thisExerciseIsDone;
  final String chatId;

  QuizPage({super.key, required this.chatId, required this.thisExerciseIsDone});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isFinished = false;
  String _selectedAnswer = '';
  late double _percentage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz: ${widget.chatId}')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('chats')
            .doc(widget.chatId) // chatId dan savollarni olish
            .collection('questions')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {}
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Savollar mavjud emas.'));
          }

          // Savollar ro'yxatini olish
          var questionDocs = snapshot.data!.docs;

          // Savollar tugagandan so'ng, natijani ko'rsatish
          if (_currentQuestionIndex >= questionDocs.length) {
            // Ball foizini hisoblash
            _percentage = (_score / questionDocs.length) * 100;

            // Agar ball 80% dan kam bo'lsa, exercise tugallanmagan deb belgilaymiz
            if (_percentage < 80) {
              // Update the exercise status in the parent (QuizScreen) widget
              setState(() {
                widget.thisExerciseIsDone = false;
              });
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _isFinished = true;
              });
            });

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Test yakunlandi. Sizning natijangiz: $_score / ${questionDocs.length} (${_percentage.toStringAsFixed(2)}%)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                _percentage < 80
                    ? Text(
                        'Savollarni 80% dan kam to\'pladingiz! Iltimos, qayta urinib ko\'ring.',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      )
                    : SizedBox(),
              ],
            );
          }

          // Hozirgi savolni olish
          var questionData = questionDocs[_currentQuestionIndex];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(questionData['question'],
                    style: TextStyle(fontSize: 20)),
              ),
              ...['a', 'b', 'c', 'd'].map((answerKey) {
                return RadioListTile<String>(
                  title: Text(questionData['answers'][answerKey]),
                  value: answerKey,
                  groupValue: _selectedAnswer,
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswer = value!;
                    });
                  },
                );
              }).toList(),
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text(
                  _currentQuestionIndex == questionDocs.length - 1
                      ? 'Natijalarni ko\'rish'
                      : 'Keyingi savol',
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _nextQuestion() {
    if (_selectedAnswer.isEmpty) return;

    // Savolni tekshirib, natijani hisoblash
    _firestore
        .collection('chats')
        .doc(widget.chatId) // chatId dan savollarni olish
        .collection('questions')
        .doc((_currentQuestionIndex + 1).toString()) // Savol ID
        .get()
        .then((question) {
      if (question.exists) {
        var correctAnswer = question['correctAnswer'];
        if (correctAnswer == _selectedAnswer) {
          setState(() {
            _score++;
          });
        }
      }

      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = '';
      });

      // Savollar tugagach, natijani ko'rsatish
      _firestore
          .collection('chats')
          .doc(widget.chatId)
          .collection('questions')
          .get()
          .then((snapshot) {
        if (_currentQuestionIndex >= snapshot.docs.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _isFinished = true;
            });
          });
        }
      }).catchError((e) {
        print('Error: $e');
      });
    }).catchError((e) {
      print('Error: $e');
    });
  }
}
