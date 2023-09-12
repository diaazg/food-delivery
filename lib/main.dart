import 'package:flutter/material.dart';
import 'package:food/view/screens/firstPages/firstPages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/view/screens/homePage.dart';
import 'view/screens/menu.dart';
import 'package:flutter_config/flutter_config.dart';
import 'view/screens/maps.dart';
import 'package:get/get.dart';
import 'controller/Authentification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/screens/authentication/interests.dart';
import 'view/screens/splashScreen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
      designSize: const Size(392.72727272727275,850.9090909090909),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return GetMaterialApp(
         debugShowCheckedModeBanner: false,
          home:child ,
        );
      },
      child:Splash(),
    );
  }
}

