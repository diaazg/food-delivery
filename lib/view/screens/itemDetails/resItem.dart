import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/constant/Style.dart';
import 'package:food/view/widgets/curvePainter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food/view/screens/menu.dart';
import 'package:food/view/screens/maps.dart';
import 'package:food/view/widgets/RestaurantCard.dart';
import 'package:food/view/screens/mapNormal.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem(
      {
      required this.resName,
      required this.restID,
      required this.resImg,
      required this.resWilaya,
      required this.resLocation,
      required this.systemRating});
  final String resName;
  final String restID;
  final String resImg;
  final String resWilaya;
  final LocationObj resLocation;
  final Map<String, dynamic> systemRating;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomPaint(
            painter: CurvePainter(),
            child: Container(
              padding: EdgeInsets.only(
                  top: 40.h, bottom: 10.h, left: 30.w, right: 30.w),
              height: 300.h,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  resImg==""?Image.asset(
                    "images/restaurantLogo/2.png",
                    height: 200.h,
                    width: 200.w,
                  ):Image.network(
                    resImg,
                    height: 200.h,
                    width: 200.w,
                  ),
                  Text(
                    resName,
                    style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 130.h,
          ),
          GestureDetector(
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>mapNormal(restLocation: resLocation,)));

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
              height: 52.h,
              width: 296.w,
              decoration: BoxDecoration(
                  color: MyColor().mainColor,
                  borderRadius: MyRaduis().mainRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    resWilaya,
                    style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    size: 40,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Menu(
                            restID: restID,
                          )));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
              height: 52.h,
              width: 296.w,
              decoration: BoxDecoration(
                  color: MyColor().mainColor,
                  borderRadius: MyRaduis().mainRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu",
                    style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.menu_book_outlined,
                    size: 40,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.facebook,size: 45,),
            SizedBox(width: 40.w,),
            Icon(Icons.call_rounded,size: 45,)
          ],
          ),
          SizedBox(
            height: 30.h,
          ),
          RatingBar.builder(
            ignoreGestures: true,
            initialRating: systemRating["rating"],
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ],
      ),
    ));
  }
}
