import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/admin/admin_login.dart';
import 'package:fooddeliveryapp/pages/details.dart';
import 'package:fooddeliveryapp/servise/database.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool icecream = false, pizza = true, salad = false, burger = false;
  Stream? fooditemStream;
  ontheload() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItemsVertical() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      images: ds["Images"],
                                      name: ds["Name"],
                                      dedails: ds["Detail"],
                                      price: ds["Price"],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.only(right: 20, bottom: 20),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(ds["Images"],
                                    fit: BoxFit.cover, height: 120, width: 120),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["Name"],
                                      style: AppWidget.semiBoldTextFeildSyle(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Honey goot cheese",
                                      style: AppWidget.lighTextFeildSyle(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " ${ds["Price"]} 000 So'm",
                                    style: AppWidget.semiBoldTextFeildSyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator.adaptive();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          textAlign: TextAlign.center,
          "Shashlik Uz",
          style: AppWidget.boldTextFeildstyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminLogin()));
            },
            icon: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Delicious Food",
              style: AppWidget.headlineTextFeildSyle(),
            ),
            Text(
              "Discover and Get Great Food",
              style: AppWidget.lighTextFeildSyle(),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: showItem(),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: allItemsVertical(),
            )
          ],
        ),
      ),
    );
  }

  Row showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: icecream ? black : white),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "assets/images/ice-cream.png",
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                  color: icecream ? white : black,
                )),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = true;
            salad = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: pizza ? black : white),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "assets/images/pizza.png",
                  color: pizza ? white : black,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                )),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Salad");

            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: salad ? black : white),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "assets/images/salad.png",
                  color: salad ? white : black,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                )),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Burger");
            burger = true;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: burger ? black : white),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "assets/images/burger.png",
                  color: burger ? white : black,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                )),
          ),
        ),
      ],
    );
  }
}
