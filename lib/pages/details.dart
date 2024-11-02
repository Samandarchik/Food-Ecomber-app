import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int number = 1;
  int time = 30;
  int price = 28;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Image.asset(
              "assets/images/salad2.png",
              width: size.width,
              height: size.height / 2.5,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mediterranean",
                      style: AppWidget.semiBoldTextFeildSyle(),
                    ),
                    Text(
                      "Chickpea Salad",
                      style: AppWidget.boldTextFeildstyle(),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (number > 1) {
                        number--;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.remove,
                      color: white,
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      number.toString(),
                      style: AppWidget.semiBoldTextFeildSyle(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      number++;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.add,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              maxLines: 3,
              "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
              style: AppWidget.lighTextFeildSyle(),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Delivery Time    ",
                  style: AppWidget.semiBoldTextFeildSyle(),
                ),
                Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                Text(
                  " $time mint",
                  style: AppWidget.semiBoldTextFeildSyle(),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: AppWidget.semiBoldTextFeildSyle(),
                      ),
                      Text(
                        "\$${price * number}",
                        style: AppWidget.headlineTextFeildSyle(),
                      )
                    ],
                  ),
                  Container(
                    width: size.width / 2,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Add to Card",
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
