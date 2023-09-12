import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/constant/Style.dart';


class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key, required this.foodName,required this.foodPic,required this.foodPrice,required this.amount,required this.decrement,required this.increment});
  final String foodName;
  final String foodPic;
  final int foodPrice;
  final int amount;
  final void Function() increment;
  final void Function() decrement;

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  String? foodName;
  String? foodPic;
  int? foodPrice;
  int? amount;
  @override
  void initState() {
    // TODO: implement initState
    foodName=widget.foodName;
    foodPic=widget.foodPic;
    foodPrice=widget.foodPrice;
    amount=widget.amount;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: 352.w,
      decoration: BoxDecoration(color: Colors.white,borderRadius: MyRaduis().mainRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("images/foodUp/$foodPic.png",height: 92.h,width: 95.w,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0,vertical: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(foodName!,style: GoogleFonts.poppins(fontSize: 20.sp,color: Colors.black),),
                Text(
                  "${foodPrice.toString()} DA",style: GoogleFonts.poppins(fontSize: 20.sp,color: Colors.black),),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){

                          widget.increment();


                      },
                      child:Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),color: MyColor().mainColor),
                        child: const Center(
                          child: Icon(Icons.add,color: Colors.black,size: 15,),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(widget.amount.toString(),style: GoogleFonts.poppins(fontSize: 20.sp,color: Colors.black),),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: (){

                         widget.decrement();


                      },
                      child:Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),color: MyColor().mainColor),
                        child: Center(
                          child: Image.asset("images/icons/minus.png",height: 1.5.h,width: 10.w,),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}