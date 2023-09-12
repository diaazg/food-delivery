import 'package:flutter/material.dart';
import 'package:food/constant/Style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/view/screens/sideBar/profile/profile.dart';
import 'package:food/view/screens/sideBar/setting.dart';
import 'package:food/controller/Authentification.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:food/view/screens/sideBar/favouritePage.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200.w,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
      ),
      backgroundColor: MyColor().mainColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: MyColor().mainColor),
            child: const Center(
              child: Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: SizedBox(
              width: 50.w,
            ),
            trailing: Image.asset(
              "images/icons/person.png",
              height: 18.h,
              width: 20.w,
            ),
            title: Text('Profile'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Profile()))
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.w,
            ),
            trailing: Image.asset(
              "images/icons/Heart.png",
              height: 18.h,
              width: 20.w,
            ),
            title: const Text('Favorite'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const FavouritePage()))
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.w,
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
            title: const Text('Log out'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: LoadingAnimationWidget.hexagonDots(
                          color: MyColor().mainColor, size: 100),
                    );
                  });
              AuthController.instance.logOut();
            },
          ),
        ],
      ),
    );
  }
}
