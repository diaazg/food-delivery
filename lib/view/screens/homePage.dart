import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/constant/Style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/view/widgets/foodCard.dart';
import 'package:food/view/widgets/drawer.dart';
import 'package:food/view/screens/allRestaurants.dart';
import 'package:food/controller/Store.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../widgets/RestaurantCard.dart';
import '../widgets/offerCard.dart';

import '../../model/restaurantModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Animation<double>? textAnimation;
  AnimationController? textController;
  late Animation<double>? cursorAnimation;
  AnimationController? cursorController;

  Future<List<Map<String, dynamic>>> recomandedList() async {
    List<Map<String, dynamic>> result = [];
    Get.put(StoreController());
    String? wilaya = StoreController.instance.getterUserInfo.wilaya;
    List<RestaurantModel> wilayaRests = [];
    for (var element in StoreController.instance.getterRestaurants) {
      if (element.restWilaya == wilaya) {
        wilayaRests.add(element);
      }
    }
    List<RestaurantModel> mostRating = [];
    for (int i = 0; i < wilayaRests.length; i++) {
      if (mostRating.length < 2) {
        mostRating.add(wilayaRests[i]);
      } else {
        double minRating = mostRating[0].ratingSystem!["rating"];
        int minIndex = 0;
        for (int i = 1; i < mostRating.length; i++) {
          if (mostRating[i].ratingSystem!["rating"] < minRating) {
            minIndex = i;
          }
        }
        if (wilayaRests[i].ratingSystem!["rating"] > minRating) {
          mostRating.removeAt(minIndex);
          mostRating.add(wilayaRests[i]);
        }
      }
    }
    // use for loop instead of forEach in async operations
    for (var element1 in mostRating) {
      List? categories = [];
      categories = element1.categories;
      if (categories!.isNotEmpty) {
        for (var element2 in categories) {
          Get.put(StoreController());
          List? myInterest = StoreController.instance.getterUserInfo.interest;

          //convert to upper case
          for (int i = 0; i < myInterest!.length; i++) {
            String convertElement = myInterest[i].toString().toUpperCase();
            myInterest[i] = convertElement;
          }

          //add the same element with interest
          if (myInterest.contains(element2.toString().toUpperCase())) {
            QuerySnapshot snapshot = await FirebaseFirestore.instance
                .collection("restaurants")
                .doc(element1.id)
                .collection(element2)
                .get();
            final docs = snapshot.docs;
            if (docs.isNotEmpty) {
              //add one element
              for (int i = 0; i < 1; i++) {
                result.add({
                  "restID": element1.id,
                  "category": element2,
                  "foodID": docs[i].id
                });
              }
            }
          }
        }
      }
    }

    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 10), (timer) {
      recomandedList(); // Call the function to update data
    });
    textController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    textAnimation = Tween(begin: 0.0, end: 100.0.w).animate(
        CurvedAnimation(parent: textController!, curve: Curves.easeInSine));
    cursorController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    cursorAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: cursorController!, curve: Curves.easeInSine));
    cursorAnimation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        cursorController?.repeat();
      }
    });
    cursorController?.forward();
    textController?.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController?.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      endDrawer: NavDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Stack(
                      children: [
                        Container(
                          width: 250.w,
                          height: 100.h,
                          color: Colors.white,
                        ),
                        AnimatedBuilder(
                            animation: textAnimation!,
                            builder: (context, child) {
                              return Positioned(
                                  right: textAnimation!.value,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 20.h),
                                    child: GetX<StoreController>(
                                      init: Get.put<StoreController>(
                                          StoreController()),
                                      builder: (StoreController storeCont) {
                                        return Text(
                                          "Hello, ${storeCont.getterUserInfo.username}",
                                          style: GoogleFonts.jua(
                                              color: Colors.black,
                                              fontSize: 30.sp),
                                        );
                                      },
                                    ),
                                  ));
                            }),
                        AnimatedBuilder(
                            animation: cursorAnimation!,
                            builder: (context, child) {
                              return Positioned(
                                right: 0,
                                bottom: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          left: BorderSide(
                                              color: Colors.black87.withOpacity(
                                                  cursorAnimation!.value),
                                              width: 2))),
                                  width: 100.w,
                                  height: 40.h,
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.h, horizontal: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: MyColor().mainColor),
                        child: Center(
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("offers")
                      .snapshots(),
                  builder: (context, snp) {
                    if (snp.hasData) {
                      List data = snp.data!.docs;
                      List allOffers = [];
                      for (dynamic element in data) {
                        for (dynamic partialElement in element["offersList"]) {
                          allOffers.add(partialElement);
                        }
                      }
                      return SizedBox(
                        height: 160.h,
                        width: 348.w,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return OfferCard(
                                  title: allOffers[index]["title"],
                                  subtitle: allOffers[index]["subTitle"],
                                  description: allOffers[index]["description"],
                                  price: allOffers[index]["price"],
                                  start: allOffers[index]["start"],
                                  end: allOffers[index]["end"],
                                  img: allOffers[index]["img"]);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 20.w,
                              );
                            },
                            itemCount: allOffers.length),
                      );
                    } else if (snp.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.hexagonDots(
                            color: MyColor().mainColor, size: 100),
                      );
                    } else {
                      return Image.asset(
                        "images/noOffer.png",
                        height: 100,
                        width: 200,
                      );
                    }
                  }),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Recomanded",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              FutureBuilder(
                  future: recomandedList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.hexagonDots(
                            color: MyColor().mainColor, size: 100),
                      );
                    } else if (snapshot.hasError) {
                      return SizedBox(
                        height: 205.h,
                      );
                    } else {
                      return SizedBox(
                        height: 210.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, index) {
                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("restaurants")
                                      .doc(snapshot.data![index]["restID"])
                                      .collection(
                                          snapshot.data![index]["category"])
                                      .doc(snapshot.data![index]["foodID"])
                                      .snapshots(),
                                  builder: (context, snapshotTwo) {
                                    if (snapshotTwo.hasData) {
                                      return GetX(
                                          init: Get.put<StoreController>(
                                              StoreController()),
                                          builder: (StoreController store) {
                                            return FoodCardAmber(
                                                foodName: snapshotTwo
                                                    .data!["foodName"],
                                                foodPic:
                                                    snapshotTwo.data!["img"],
                                                price:
                                                    snapshotTwo.data!["price"],
                                                isFavorite: store.getterFavoriteFood
                                                            .favFood ==
                                                        []
                                                    ? false
                                                    : store.getterFavoriteFood.favFood!.any((map) =>
                                                        map['restID'] ==
                                                            snapshot.data![index]
                                                                ["restID"] &&
                                                        map['foodCategory'] ==
                                                            snapshot.data![index]
                                                                ["category"] &&
                                                        map['FoodID'] ==
                                                            snapshot.data![index]
                                                                ["foodID"]),
                                                description: "description",
                                                rating: 5,
                                                restID: snapshot.data![index]
                                                    ["restID"],
                                                category: snapshot.data![index]
                                                    ["category"],
                                                foodID: snapshot.data![index]["foodID"]);
                                          });
                                    } else {
                                      return Center(
                                        child:
                                            LoadingAnimationWidget.hexagonDots(
                                                color: MyColor().mainColor,
                                                size: 100),
                                      );
                                    }
                                  });
                            }),
                      );
                    }
                  }),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nearby to you",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllRestaurants()));
                    },
                    child: Row(
                      children: [
                        Text(
                          "View all",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, color: Colors.black),
                        ),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 150.h,
                child: GetX(
                  init: Get.put<StoreController>(StoreController()),
                  builder: (StoreController store) {
                    return store.getterRestaurants.isEmpty
                        ? Text("data")
                        : ListView.separated(
                      scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return RestaurantCard(
                                systemRating: store
                                    .getterRestaurants[index].ratingSystem!,
                                restID: store.getterRestaurants[index].id!,
                                restaurantName: store
                                    .getterRestaurants[index].restName!,
                                restaurantPic:
                                    store.getterRestaurants[index].img!,
                                isFavorite: store.getterFavoriteRestaurants
                                            .favRest ==
                                        []
                                    ? false
                                    : store
                                        .getterFavoriteRestaurants.favRest!
                                        .contains(store
                                            .getterRestaurants[index].id),
                                restWilaya: store
                                    .getterRestaurants[index].restWilaya!,
                                location: LocationObj(
                                    lat:
                                        store.getterRestaurants[index].lat!,
                                    long: store
                                        .getterRestaurants[index].long!),
                              );
                            },
                            separatorBuilder: (context, index) {
                             return SizedBox(
                                width: 20.w,
                              );
                            },
                            itemCount: store.getterRestaurants.length);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
