import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                "images/logo.png",
                height: 200.h,
                width: 350.w,
              ),
            ),
            Image.asset("images/splash.gif",height: 200,width: 200,),
          ],
        ),
      ),
    ));
  }
}
