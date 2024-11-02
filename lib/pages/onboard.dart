import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/sign_up.dart';
import 'package:fooddeliveryapp/widget/content_model.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contens.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          contens[i].images,
                          height: 450,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          contens[i].title,
                          textAlign: TextAlign.center,
                          style: AppWidget.semiBoldTextFeildSyle(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          contens[i].description,
                          textAlign: TextAlign.center,
                          style: AppWidget.lighTextFeildSyle(),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contens.length,
              (index) => buildDot(index, context),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex == contens.length - 1) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              }
              _controller.nextPage(
                  duration: Duration(milliseconds: 250), curve: Curves.ease);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              height: 60,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              child: Center(
                child: Text(
                    currentIndex == contens.length - 1 ? "Start" : "Next",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 18 : 7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.black38),
    );
  }
}
