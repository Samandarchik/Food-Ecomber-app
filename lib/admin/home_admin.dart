import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/admin/add_food.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Home Admin",
                style: AppWidget.headlineTextFeildSyle(),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFood()));
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Image.asset(
                            "assets/images/food.jpg",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: size.width * .1,
                        ),
                        Text(
                          "Add Food Items",
                          style: textStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
