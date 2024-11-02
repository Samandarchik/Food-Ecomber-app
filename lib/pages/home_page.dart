import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/details.dart';
import 'package:fooddeliveryapp/servise/database.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool icecream = false, pizza = false, salad = false, burger = false;
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

  Widget allItems() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Center(child: Text("No items found"));
        }
        final items = snapshot.data.docs;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return ListTile(
              leading: Image.network(
                item['Images'],
                width: 30,
                height: 30,
              ),
              title: Text(item['Name']),
              subtitle: Text('\$${item['Price']}'),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Hello Samandar",
                  style: AppWidget.boldTextFeildstyle(),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
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
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            Text("Delicious Food", style: AppWidget.headlineTextFeildSyle()),
            Text("Discover and Get Great Food",
                style: AppWidget.lighTextFeildSyle()),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.only(right: 20), child: showItem()),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildFoodCard("assets/images/salad2.png", "Veggie Taco Hash",
                      "Fresh and Healthy", "\$25"),
                  const SizedBox(width: 15),
                  buildFoodCard("assets/images/salad4.png", "Mix Veg Salad",
                      "Spicy with Onion", "\$28"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            buildFeaturedFoodCard("assets/images/salad3.png",
                "Mediterranean Chickpea Salad", "Honey goat cheese", "\$28"),
            Expanded(child: allItems()), // ListView ni joylashtirish uchun
          ],
        ),
      ),
    );
  }

  Widget buildFoodCard(
      String imagePath, String title, String subtitle, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Details()));
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(imagePath,
                    height: 150, width: 150, fit: BoxFit.cover),
                Text(title, style: AppWidget.semiBoldTextFeildSyle()),
                const SizedBox(height: 5),
                Text(subtitle, style: AppWidget.lighTextFeildSyle()),
                const SizedBox(height: 5),
                Text(price, style: AppWidget.semiBoldTextFeildSyle()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFeaturedFoodCard(
      String imagePath, String title, String subtitle, String price) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(imagePath, height: 120, width: 120),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child:
                        Text(title, style: AppWidget.semiBoldTextFeildSyle()),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(subtitle, style: AppWidget.lighTextFeildSyle()),
                  ),
                  const SizedBox(height: 5),
                  Text(price, style: AppWidget.semiBoldTextFeildSyle()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildFilterItem("assets/images/ice-cream.png", () {
          setState(() {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
          });
        }, icecream),
        buildFilterItem("assets/images/pizza.png", () {
          setState(() {
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
          });
        }, pizza),
        buildFilterItem("assets/images/salad.png", () {
          setState(() {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
          });
        }, salad),
        buildFilterItem("assets/images/burger.png", () {
          setState(() {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
          });
        }, burger),
      ],
    );
  }

  Widget buildFilterItem(
      String imagePath, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.black : Colors.white,
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: 40,
            width: 40,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
