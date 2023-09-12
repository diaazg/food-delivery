import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/constant/Style.dart';
import 'package:food/view/screens/itemDetails/foodItem.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:food/controller/Store.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    required this.foodName,
    required this.foodPic,
    required this.price,
    required this.isFavorite,
    required this.description,
    required this.rating,
  });
  final String foodName;
  final String foodPic;
  final int price;
  final bool isFavorite;
  final String description;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodItem(foodName: foodName, foodImg: foodPic, description: description, price: price, rating: rating,restID: restID,category: category,foodIndex: foodIndex,)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        height: 204.h,
        width: 150.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: MyColor().mainColor, borderRadius: MyRaduis().mainRadius),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {},
                    child: isFavorite
                        ? Image.asset(
                            "images/icons/favoritRed.png",
                            height: 18.h,
                            width: 20.w,
                          )
                        : Image.asset(
                            "images/icons/favorit.png",
                            height: 18.h,
                            width: 20.w,
                          )),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "images/foodUp/$foodPic.png",
                  height: 72.h,
                  width: 76.w,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  foodName,
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "$price DA",
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 20.sp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FoodCardWhite extends StatelessWidget {
  const FoodCardWhite(
      {required this.foodName,
      required this.foodPic,
      required this.price,
      required this.isFavorite,
      required this.description,
      required this.rating,
      required this.restID,
      required this.category,
      required this.foodID});
  final String foodName;
  final String foodPic;
  final int price;
  final bool isFavorite;
  final String description;
  final double rating;
  final String restID;
  final String category;
  final String foodID;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      height: 204.h,
      width: 150.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius:3, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(2, 5), // Offset in the x and y directions
            ),
          ],
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.put<StoreController>(StoreController());
                    StoreController.instance
                        .favFood(restID, category, foodID);
                  },
                  child: isFavorite
                      ? Image.asset(
                    "images/icons/favoritRed.png",
                    height: 18.h,
                    width: 20.w,
                  )
                      : Image.asset(
                    "images/icons/favorit.png",
                    height: 18.h,
                    width: 20.w,
                  )),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodItem(
                        show: false,
                        foodName: foodName,
                        foodImg: foodPic,
                        description: description,
                        price: price,
                        rating: rating,
                        restID: restID,
                        category: category,
                        foodID: foodID,
                      )));
            },
            child: Column(
              children: [
                Image.network(
                  foodPic,
                  height: 72.h,
                  width: 76.w,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  foodName,
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "$price DA",
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 20.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FoodCardAmber extends StatelessWidget {
  const FoodCardAmber(
      {required this.foodName,
        required this.foodPic,
        required this.price,
        required this.isFavorite,
        required this.description,
        required this.rating,
        required this.restID,
        required this.category,
        required this.foodID});
  final String foodName;
  final String foodPic;
  final int price;
  final bool isFavorite;
  final String description;
  final double rating;
  final String restID;
  final String category;
  final String foodID;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.w,bottom: 10,left: 5),
      height: 204.h,
      width: 150.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius:3, // Spread radius
              blurRadius: 2, // Blur radius
              offset: const Offset(2, 2), // Offset in the x and y directions
            ),
          ],
          color: MyColor().mainColor, borderRadius: MyRaduis().mainRadius),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.put<StoreController>(StoreController());
                    StoreController.instance
                        .favFood(restID, category, foodID);
                  },
                  child: isFavorite
                      ? Image.asset(
                    "images/icons/favoritRed.png",
                    height: 18.h,
                    width: 20.w,
                  )
                      : Image.asset(
                    "images/icons/favorit.png",
                    height: 18.h,
                    width: 20.w,
                  )),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodItem(
                        show: true,
                        foodName: foodName,
                        foodImg: foodPic,
                        description: description,
                        price: price,
                        rating: rating,
                        restID: restID,
                        category: category,
                        foodID: foodID,
                      )));
            },
            child: Column(
              children: [
                Image.network(
                  foodPic,
                  height: 72.h,
                  width: 76.w,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  foodName,
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "$price DA",
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 20.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

