import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/home_page.dart';
import 'package:fooddeliveryapp/pages/order.dart';
import 'package:fooddeliveryapp/pages/profile.dart';
import 'package:fooddeliveryapp/pages/wallet.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePage homePage;
  late Profile profile;
  late Order order;
  late Wallet wallet;
  @override
  void initState() {
    homePage = const HomePage();
    order = const Order();
    profile = const Profile();
    wallet = const Wallet();
    pages = [homePage, order, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          height: 65,
          color: black,
          backgroundColor: white,
          items: const [
            Icon(
              Icons.home,
              color: white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: white,
            ),
            Icon(
              Icons.wallet_outlined,
              color: white,
            ),
            Icon(
              Icons.person_outline,
              color: white,
            ),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
