import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/view/widgets/RestaurantCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/constant/Style.dart';
import 'package:food/view/widgets/curvePainter.dart';
import 'package:food/controller/Store.dart';
import 'package:get/get.dart';
import '../itemDetails/resItem.dart';

class FoodItem extends StatelessWidget {
  const FoodItem(
      {super.key,
        required this.show,
      required this.foodName,
      required this.foodImg,
      required this.description,
      required this.price,
      required this.rating,
      required this.restID,
      required this.category,
      required this.foodID});
  final bool show;
  final String foodName;
  final String foodImg;
  final String description;
  final int price;
  final double rating;
  final String restID;
  final String category;
  final String foodID;

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
                  Image.network(
                    foodImg,
                    height: 200.h,
                    width: 300.w,
                  ),
                  Text(
                    foodName,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description :",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                        fontSize: 15.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Price : $price DA",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                ],
              ),
            ),
          ),
          show?StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("restaurants")
                  .doc(restID)
                  .snapshots(),
              builder: (context, snp) {
                if (snp.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantItem(
                                  resName: snp.data!["restName"],
                                  restID: restID,
                                  resImg: snp.data!["img"],
                                  resWilaya: snp.data!["restWilaya"],
                                  resLocation: LocationObj(lat: snp.data!["lat"], long: snp.data!["long"]),
                                  systemRating: snp.data!["rating"])));
                    },
                    child: Container(
                      height: 63.h,
                      width: 296.w,
                      decoration: BoxDecoration(
                          color: MyColor().mainColor,
                          borderRadius: MyRaduis().mainRadius),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Restaurant",
                            style: GoogleFonts.poppins(
                                fontSize: 25.sp, color: Colors.black),
                          ),
                          Icon(
                            Icons.maps_home_work_outlined,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 63.h,
                    width: 296.w,
                    decoration: BoxDecoration(
                        color: MyColor().mainColor,
                        borderRadius: MyRaduis().mainRadius),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Restaurant",
                          style: GoogleFonts.poppins(
                              fontSize: 25.sp, color: Colors.black),
                        ),
                        Icon(
                          Icons.maps_home_work_outlined,
                          size: 40,
                        )
                      ],
                    ),
                  );
                }
              }):SizedBox(height: 20.h,),
          SizedBox(
            height: 50.h,
          ),
          GestureDetector(
            onTap: () {
              Get.put<StoreController>(StoreController());
              StoreController.instance
                  .addToCart(restID, category, foodID, price, foodName);
            },
            child: Container(
              height: 63.h,
              width: 296.w,
              decoration: BoxDecoration(
                  color: MyColor().mainColor,
                  borderRadius: MyRaduis().mainRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Add to cart",
                    style: GoogleFonts.poppins(
                        fontSize: 25.sp, color: Colors.black),
                  ),
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 40,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
