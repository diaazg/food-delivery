import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/constant/Style.dart';
import 'package:timelines/timelines.dart';
import 'package:food/controller/Store.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderCardStatus extends StatelessWidget {
  const OrderCardStatus(
      {super.key,
      required this.foodName,
      required this.restName,
      required this.status,
        required this.orderID,
        required this.restID
      });
  final String foodName;
  final String restName;
  final String status;
  final String orderID;
  final String restID;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      color: Colors.white,
      height: 349.h,
      width: 330.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              foodName,
              style: GoogleFonts.poppins(fontSize: 20.sp, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Restaurant : ${restName.toUpperCase()}",
            style: GoogleFonts.poppins(fontSize: 20.sp, color: Colors.black),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Container(
              height: 160,
              width: 200,
              child: Row(
                children: [
                  FixedTimeline(
                    children: [
                      DotIndicator(
                        color: (status == "checked" ||
                                status == "inRoute" ||
                                status == "Done")
                            ? Color(0xFF1BEC49)
                            : Colors.black54,
                        size: (status == "checked" ||
                                status == "inRoute" ||
                                status == "Done")
                            ? 30
                            : 22,
                      ),
                      SizedBox(
                        height: 30.0,
                        child: SolidLineConnector(
                          color: (status == "inRoute" || status == "Done")
                              ? Color(0xFF1BEC49)
                              : Colors.black54,
                        ),
                      ),
                      DotIndicator(
                        color: (status == "inRoute" || status == "Done")
                            ? Color(0xFF1BEC49)
                            : Colors.black54,
                        size:
                            (status == "inRoute" || status == "Done") ? 30 : 22,
                      ),
                      SizedBox(
                        height: 30.0,
                        child: SolidLineConnector(
                          color: (status == "Done")
                              ? Color(0xFF1BEC49)
                              : Colors.black54,
                        ),
                      ),
                      DotIndicator(
                        color: (status == "Done")
                            ? Color(0xFF1BEC49)
                            : Colors.black54,
                        size: (status == "Done") ? 30 : 22,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    children: [
                      Text(
                        "Order checked",
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp, color: Colors.black),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "In route",
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp, color: Colors.black),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Done",
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp, color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Center(
            child: status == "No"
                ? GestureDetector(
              onTap: (){
                Get.put<StoreController>(StoreController());
                StoreController.instance.removeOrder(orderID);
              },
              child:Container(
                height: 46.h,
                width: 220.w,
                decoration: BoxDecoration(
                    borderRadius: MyRaduis().mainRadius,
                    color: Colors.red),
                child: Center(
                  child: Text("This order is not available",
                      style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          color: Colors.white),
                  textAlign: TextAlign.center,),
                ),
              ) ,
            )
                : status == "Done"? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                             Get.dialog(
                                 Dialog(
                               child:Container(
                                 height: 200.h,
                                 width: 300.w,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Text(
                                       "Rate restaurant",
                                       style: GoogleFonts.poppins(
                                           color: Colors.black,
                                           fontSize: 40.sp,
                                           fontWeight: FontWeight.bold),
                                     ),
                                     RatingBar.builder(
                                       ignoreGestures: false,
                                       initialRating: 0,
                                       direction: Axis.horizontal,
                                       allowHalfRating: true,
                                       itemCount: 5,
                                       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                       itemBuilder: (context, _) => Icon(
                                         Icons.star,
                                         color: Colors.amber,
                                       ),
                                       onRatingUpdate: (rating) {
                                         Get.put<StoreController>(StoreController());
                                         StoreController.instance.rating(restID, rating,context);
                                       },
                                     )
                                   ],
                                 ),
                               ),
                             ));
                        },
                        child: Container(
                          height: 46.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                              borderRadius: MyRaduis().mainRadius,
                              color: (status == "checked" ||
                                      status == "inRoute" ||
                                      status == "Done")
                                  ? MyColor().mainColor
                                  : Colors.grey),
                          child: Center(
                            child: Text("rate",
                                style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    color: (status == "checked" ||
                                            status == "inRoute" ||
                                            status == "Done")
                                        ? Colors.black
                                        : Colors.white)),
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: (){
                        Get.put<StoreController>(StoreController());
                        StoreController.instance.removeOrder(orderID);
                      },
                      child:const Icon(Icons.delete_forever,color: Colors.green,) ,
                    )
                  ],
                ):GestureDetector(
              onTap: () {
                Get.dialog(
                    Dialog(
                      child:Container(
                        height: 200.h,
                        width: 300.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Rate restaurant",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            RatingBar.builder(
                              ignoreGestures: false,
                              initialRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                Get.put<StoreController>(StoreController());
                                StoreController.instance.rating(restID, rating,context);
                              },
                            )
                          ],
                        ),
                      ),
                    ));
              },
              child: Container(
                height: 46.h,
                width: 170.w,
                decoration: BoxDecoration(
                    borderRadius: MyRaduis().mainRadius,
                    color: (status == "checked" ||
                        status == "inRoute" ||
                        status == "Done")
                        ? MyColor().mainColor
                        : Colors.grey),
                child: Center(
                  child: Text("rate",
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          color: (status == "checked" ||
                              status == "inRoute" ||
                              status == "Done")
                              ? Colors.black
                              : Colors.white)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
