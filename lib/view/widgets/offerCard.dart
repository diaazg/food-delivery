import 'package:flutter/material.dart';
import 'package:food/constant/Style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';






class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.start,
    required this.end,
    required this.img
  });
  final String title,subtitle,img,description,start,end;
  final int price;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      height: 140.h,
      width: 348.w,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius:3, // Spread radius
              blurRadius: 2, // Blur radius
              offset: const Offset(2, 2), // Offset in the x and y directions
            ),
          ],
          color: MyColor().mainColor,
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10.h, horizontal: 10.w),
            child: Container(
              width: 180.w,
              height: 100.h,
              child: Column(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.mochiyPopOne(
                        color: Colors.black, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(subtitle,
                      style: GoogleFonts.mochiyPopOne(
                          color: Colors.black, fontSize: 20)),
                ],
              ),
            ),
          ),
          Image.network(
            img,
            height: 150.h,
            width: 120.w,
          )
        ],
      ),
    );
  }
}
