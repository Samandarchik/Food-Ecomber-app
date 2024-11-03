import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  final String images;
  final String name;
  final String price;
  final String dedails;
  const Details(
      {super.key,
      required this.images,
      required this.name,
      required this.dedails,
      required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String formatNumber(int number) {
    final NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  int number = 1, time = 30, total = 0;
  String? id;

  @override
  void initState() {
    super.initState();
    total = int.parse(widget.price);
  }

  void _updateTotal() {
    total = int.parse(widget.price) * number; // Total qiymatini yangilang
  }

  Timer? _timer;

  void _startAdding() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        number++;
        _updateTotal();
      });
    });
  }

  void _startRemov() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        if (number > 1) {
          number--;
          _updateTotal();
        }
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shashlik Uz",
          style: AppWidget.boldTextFeildstyle(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.images,
              width: size.width,
              height: size.height / 2.5,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
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
                    onTapDown: (_) {
                      _startRemov(); // Bosish bosilganda boshlaydi
                    },
                    onTapUp: (_) {
                      _stopAdding(); // Bosish tugagach to'xtatadi
                    },
                    onTapCancel: () {
                      _stopAdding(); // Agar bosish bekor qilinsa to'xtatadi
                    },
                    onTap: () {
                      setState(() {
                        if (number > 1) {
                          number--;
                          total = total - int.parse(widget.price);
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
                    onTapDown: (_) {
                      _startAdding(); // Bosish bosilganda boshlaydi
                    },
                    onTapUp: (_) {
                      _stopAdding(); // Bosish tugagach to'xtatadi
                    },
                    onTapCancel: () {
                      _stopAdding(); // Agar bosish bekor qilinsa to'xtatadi
                    },
                    onTap: () {
                      setState(() {
                        total = total + int.parse(widget.price);
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
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: size.height * .15,
                child: Text(
                  maxLines: 6,
                  widget.dedails,
                  style: AppWidget.lighTextFeildSyle(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
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
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            " ${formatNumber(total)} 000",
                            style: AppWidget.headlineTextFeildSyle(),
                          ),
                        ],
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
                        GestureDetector(
                          onTap: () async {
                            Map<String, dynamic> addFoodtoCart = {
                              "Name": widget.name,
                              "Quantity": number.toString(),
                              "Total": total.toString(),
                              "Image": widget.images
                            };
                          },
                          child: Text(
                            "Add to Card",
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
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

  @override
  void dispose() {
    _stopAdding(); // Widget o'chirilganda Timer ni to'xtatadi
    super.dispose();
  }
}
