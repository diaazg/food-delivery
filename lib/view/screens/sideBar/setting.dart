import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/constant/Style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/view/screens/authentication/interests.dart';


class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
          padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0),
                height: 52.h,
                width: 296.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: MyRaduis().mainRadius),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Change password",style: GoogleFonts.poppins(fontSize: 20.sp,color: Colors.black),),
                    Icon(
                      Icons.edit,
                      size: 20,
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0),
                height: 52.h,
                width: 296.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: MyRaduis().mainRadius),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Change language",style: GoogleFonts.poppins(fontSize: 20.sp,color: Colors.black),),
                    Icon(
                      Icons.language,
                      size: 20,
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.h,),
             GestureDetector(
               onTap: (){
                 //Navigator.push(context, MaterialPageRoute(builder: (context)=>const Interests()));
               },
               child:  Container(
                 padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0),
                 height: 52.h,
                 width: 296.w,
                 decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: MyRaduis().mainRadius),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Change interests",style: GoogleFonts.poppins(fontSize: 20.sp,color: Colors.black),),
                     Text("#",style: GoogleFonts.poppins(fontSize: 25.sp,color: Colors.black,fontWeight: FontWeight.w300),),

                   ],
                 ),
               ),
             )
            ],
          ),
        ),
      ),
    ));
  }
}
