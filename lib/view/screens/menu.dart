import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/view/widgets/foodCard.dart';
import 'package:food/constant/Style.dart';
import 'package:get/get.dart';
import 'package:food/controller/Store.dart';
import 'package:food/model/menu/category.dart';
import 'package:food/controller/Store.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Menu extends StatelessWidget {
  Menu({required this.restID});
  final String restID;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor().mainColor,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("restaurants")
              .doc(restID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> data = snapshot.data!['menuCategory'];
              return Container(
                height: 840.h,
                width: 395.w,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: StreamBuilder(builder: (context, snapshotTwo) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int categoryIndex) {
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("restaurants")
                                .doc(restID)
                                .collection(data[categoryIndex].toString()).snapshots(),
                            builder: (context, snapshotTwo) {
                              if(snapshotTwo.hasData){
                                final docs=snapshotTwo.data!.docs;
                                print(docs);
                                return Container(
                                  height: 270.h,
                                  width: 390,
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[categoryIndex].toString(),
                                        style: GoogleFonts.acme(
                                            color: Colors.black,
                                            fontSize: 40.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 20.h),
                                      Expanded(
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshotTwo.data!.docs.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return GetX(
                                                    init: Get.put<StoreController>(
                                                        StoreController()),
                                                    builder: (StoreController store) {
                                                      return FoodCardWhite(
                                                        foodName: docs[index]['foodName']
                                                            .toString(),
                                                        foodPic: docs[index]['img'],
                                                        price: docs[index]['price'],
                                                        isFavorite: store.getterFavoriteFood
                                                            .favFood ==
                                                            []
                                                            ? false
                                                            : store.getterFavoriteFood
                                                            .favFood!
                                                            .any((map) =>
                                                        map['restID'] ==
                                                            restID &&
                                                            map['foodCategory'] ==
                                                                data[categoryIndex]
                                                                    .toString() &&
                                                            map['FoodID'] ==
                                                                docs[index].id),
                                                        description: "description",
                                                        rating: 2,
                                                        restID: restID,
                                                        category: data[categoryIndex]
                                                            .toString(),
                                                        foodID: docs[index].id,
                                                      );
                                                    });
                                              }))
                                    ],
                                  ),
                                );
                              }else{
                                return Center(
                                  child: LoadingAnimationWidget.hexagonDots(
                                      color: Colors.white, size: 100),
                                );
                              }
                        });
                      });
                }),
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.hexagonDots(
                    color: Colors.white, size: 100),
              );
            }
          },
        ),
      ),
    );
  }
}
