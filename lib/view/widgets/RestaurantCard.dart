import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/constant/Style.dart';
import 'package:food/view/screens/itemDetails/resItem.dart';
import 'package:food/controller/Store.dart';
import 'package:get/get.dart';


class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key,
    required this.restaurantName,
    required this.restID,
    required this.restaurantPic,
    required this.isFavorite,
    required this.restWilaya,
    required this.location,
    required this.systemRating

  });
  final bool isFavorite;
  final String restaurantName;
  final String restID;
  final String restaurantPic;
  final String restWilaya;
  final LocationObj location;
  final Map<String,dynamic> systemRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      height: 145.h,
      width: 150.w,
      decoration: BoxDecoration(color: MyColor().mainColor,borderRadius: MyRaduis().mainRadius),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap:(){
                    Get.put<StoreController>(StoreController());
                    StoreController.instance.favorite(restID);
                  },
                  child: isFavorite?Image.asset("images/icons/favoritRed.png",height: 18.h,width: 20.w,):Image.asset("images/icons/favorit.png",height: 18.h,width: 20.w,)),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantItem(resName: restaurantName,restID: restID, resImg: restaurantPic, resWilaya: restWilaya, resLocation: location, systemRating: systemRating)));
            },
            child: Column(
              children: [
                restaurantPic==""?Image.asset("images/restaurantLogo/2.png",height: 80.h,width: 100.w,):Image.network(restaurantPic,height: 80.h,width: 100.w,),
                SizedBox(height:10.h),
                Text(restaurantName,style: GoogleFonts.acme(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class RestaurantCardWhite extends StatelessWidget {
  const RestaurantCardWhite ({super.key,
    required this.restaurantName,
    required this.restID,
    required this.restaurantPic,
    required this.isFavorite,
    required this.restWilaya,
    required this.location,
    required this.systemRating

  });
  final bool isFavorite;
  final String restaurantName;
  final String restID;
  final String restaurantPic;
  final String restWilaya;
  final LocationObj location;
  final Map<String,dynamic> systemRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      height: 145.h,
      width: 150.w,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius:3, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(2, 2), // Offset in the x and y directions
            ),
          ],
          color: Colors.white,borderRadius: MyRaduis().mainRadius),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap:(){
                    Get.put<StoreController>(StoreController());
                    StoreController.instance.favorite(restID);
                  },
                  child: isFavorite?Image.asset("images/icons/favoritRed.png",height: 18.h,width: 20.w,):Image.asset("images/icons/favorit.png",height: 18.h,width: 20.w,)),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantItem(resName: restaurantName,restID: restID, resImg: restaurantPic, resWilaya: restWilaya, resLocation: location, systemRating: systemRating)));
            },
            child: Column(
              children: [
                restaurantPic==""?Image.asset("images/restaurantLogo/2.png",height: 80.h,width: 100.w,):Image.network(restaurantPic,height: 80.h,width: 100.w,),
                SizedBox(height:10.h),
                Text(restaurantName,style: GoogleFonts.acme(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LocationObj{
  double? lat,long;
  LocationObj({required this.lat,required this.long});
}