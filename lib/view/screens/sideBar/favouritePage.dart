import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/constant/Style.dart';
import 'package:food/view/widgets/RestaurantCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../widgets/Cart/shoppingCart.dart';
import 'package:get/get.dart';
import 'package:food/controller/Store.dart';
import 'package:food/view/screens/maps.dart';
import 'package:food/view/screens/allRestaurants.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../widgets/foodCard.dart';
import '../../widgets/RestaurantCard.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/backGround.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
          child: Column(
            children: [
              Text(
                "Favorite",
                style: GoogleFonts.acme(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Food",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              GetX(
                  init: Get.put<StoreController>(StoreController()),
                  builder: (StoreController store) {
                    return SizedBox(
                      height: 205.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: store.getterFavoriteFood.favFood!.length,
                          itemBuilder: (BuildContext context, index) {
                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("restaurants")
                                    .doc(store.getterFavoriteFood
                                        .favFood![index]["restID"])
                                    .collection(store.getterFavoriteFood
                                        .favFood![index]["foodCategory"])
                                    .doc(store.getterFavoriteFood
                                        .favFood![index]["FoodID"])
                                    .snapshots(),
                                builder: (context, snapshotTwo) {
                                  if (snapshotTwo.hasData) {
                                    Map<String, dynamic>? data =
                                        snapshotTwo.data!.data();
                                    if (data != null) {
                                      return FoodCardWhite(
                                          foodName:
                                              snapshotTwo.data!["foodName"],
                                          foodPic: snapshotTwo.data!["img"],
                                          price: snapshotTwo.data!["price"],
                                          isFavorite: true,
                                          description: "description",
                                          rating: 5,
                                          restID: store.getterFavoriteFood
                                              .favFood![index]["restID"],
                                          category: store.getterFavoriteFood
                                              .favFood![index]["foodCategory"],
                                          foodID: store.getterFavoriteFood
                                              .favFood![index]["FoodID"]);
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(right: 15.w),
                                        height: 204.h,
                                        width: 150.w,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.5), // Shadow color
                                                spreadRadius:
                                                    3, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(2,
                                                    2), // Offset in the x and y directions
                                              ),
                                            ],
                                            color: Colors.red,
                                            borderRadius:
                                                MyRaduis().mainRadius),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "This element  have been deleted",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20.sp,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.put<StoreController>(
                                                    StoreController());
                                                StoreController.instance
                                                    .favFood(
                                                        store.getterFavoriteFood
                                                                .favFood![index]
                                                            ["restID"],
                                                        store.getterFavoriteFood
                                                                .favFood![index]
                                                            ["foodCategory"],
                                                        store.getterFavoriteFood
                                                                .favFood![index]
                                                            ["FoodID"]);
                                              },
                                              child: const Icon(
                                                Icons.highlight_remove_outlined,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  } else if (snapshotTwo.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: LoadingAnimationWidget.hexagonDots(
                                          color: MyColor().mainColor,
                                          size: 100),
                                    );
                                  } else {
                                    return Text(
                                      "This element is not available press to delete",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20.sp, color: Colors.black),
                                    );
                                  }
                                });
                          }),
                    );
                  }),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Restaurants",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              GetX(
                  init: Get.put<StoreController>(StoreController()),
                  builder: (StoreController store) {
                    return SizedBox(
                      height: 205.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              store.getterFavoriteRestaurants.favRest!.length,
                          itemBuilder: (BuildContext context, index) {
                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("restaurants")
                                    .doc(store.getterFavoriteRestaurants.favRest![index])
                                    .snapshots(),
                                builder: (context, snapshotTwo) {
                                  if (snapshotTwo.hasData) {
                                    Map<String, dynamic>? data =
                                        snapshotTwo.data!.data();
                                    if (data != null) {
                                      return RestaurantCardWhite(
                                          restaurantName:
                                              snapshotTwo.data!["restName"],
                                          restID: store.getterFavoriteRestaurants.favRest![index],
                                          restaurantPic: snapshotTwo.data!["img"],
                                          isFavorite: true,
                                          restWilaya: snapshotTwo.data!["restWilaya"],
                                          location: LocationObj(lat: snapshotTwo.data!["lat"], long: snapshotTwo.data!["long"]),
                                          systemRating: snapshotTwo.data!["rating"]);
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(right: 15.w),
                                        height: 204.h,
                                        width: 150.w,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.5), // Shadow color
                                                spreadRadius:
                                                    3, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(2,
                                                    2), // Offset in the x and y directions
                                              ),
                                            ],
                                            color: Colors.red,
                                            borderRadius:
                                                MyRaduis().mainRadius),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "This element  have been deleted",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20.sp,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.put<StoreController>(
                                                    StoreController());
                                                StoreController.instance
                                                    .favFood(
                                                        store.getterFavoriteFood
                                                                .favFood![index]
                                                            ["restID"],
                                                        store.getterFavoriteFood
                                                                .favFood![index]
                                                            ["foodCategory"],
                                                        store.getterFavoriteFood
                                                                .favFood![index]
                                                            ["FoodID"]);
                                              },
                                              child: const Icon(
                                                Icons.highlight_remove_outlined,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  } else if (snapshotTwo.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: LoadingAnimationWidget.hexagonDots(
                                          color: MyColor().mainColor,
                                          size: 100),
                                    );
                                  } else {
                                    return Text(
                                      "This element is not available press to delete",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20.sp, color: Colors.black),
                                    );
                                  }
                                });
                          }),
                    );
                  })

              // Add other widgets here
            ],
          ),
        ),
      ),
    ));
  }
}
