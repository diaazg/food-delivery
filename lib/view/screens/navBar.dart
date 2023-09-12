import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:food/constant/Style.dart';
import'package:unicons/unicons.dart';
import 'homePage.dart';
import 'package:food/view/screens/myCart/MyCart.dart';
import 'package:food/view/screens/MyOrders/MyOrders.dart';




class NavBar extends StatefulWidget {
 const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<TabItem> items =const [
    TabItem(
      icon: UniconsLine.shopping_cart,
      title: '',
    ),
    TabItem(
      icon: Icons.home_outlined,
      title: '',
    ),
    TabItem(
      icon: Icons.library_books_sharp,
      title: '',
    ),

  ];
  List<Widget> screens=[const MyCart(),const HomePage(),const MyOrders()];
  int visit = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar:BottomBarDefault(
            items: items,
            backgroundColor: Colors.white,
            color: Colors.black,
            colorSelected: MyColor().mainColor,
            indexSelected: visit,
            onTap: (int index) => setState(() {
              visit = index;
            }),
            animated: true,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
          ) ,
          backgroundColor: Colors.white,
          body: screens[visit],
          ),
        );
  }
}
