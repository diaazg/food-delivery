import 'package:flutter/material.dart';
import 'package:food/constant/Style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/controller/Store.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class EditeInterest extends StatefulWidget {
  const EditeInterest({Key? key}) : super(key: key);

  @override
  State<EditeInterest> createState() => _EditeInterestState();
}

class _EditeInterestState extends State<EditeInterest> {
  Map<String, bool> interestsMap = {
    "pizza": false,
    "burger": false,
    "putin": false,
    "tacos": false,
    "sandwich": false,
    "oriental food": false,
    "spicy": false,
    "vegetarian": false,
    "traditional": false,
    "sea food": false
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put<StoreController>(StoreController());
    List myInterestList=StoreController.instance.getterUserInfo.interest!;
    print(myInterestList);
    for(int i=0;i<myInterestList.length;i++){
      myInterestList[i]=myInterestList[i].toString().toLowerCase();
      if(interestsMap.keys.contains(myInterestList[i])){
        print(myInterestList[i]);
        setState(() {
          interestsMap[myInterestList[i]]=true;
        });
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Interest",
                    style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["pizza"] = !interestsMap["pizza"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["pizza"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 119.w,
                        child: Center(
                          child: Text(
                            "#Pizza",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["pizza"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["burger"] = !interestsMap["burger"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["burger"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 125.w,
                        child: Center(
                          child: Text(
                            "#Burger",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["burger"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["putin"] = !interestsMap["putin"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["putin"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 101.w,
                        child: Center(
                          child: Text(
                            "#Putin",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["putin"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["tacos"] = !interestsMap["tacos"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["tacos"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 125.w,
                        child: Center(
                          child: Text(
                            "#Tacos",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["tacos"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["sandwich"] = !interestsMap["sandwich"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["sandwich"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 189.w,
                        child: Center(
                          child: Text(
                            "#Sandwich",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["sandwich"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["oriental food"] =
                          !interestsMap["oriental food"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["oriental food"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 234.w,
                        child: Center(
                          child: Text(
                            "#Oriental food",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["oriental food"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["spicy"] = !interestsMap["spicy"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["spicy"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 102.w,
                        child: Center(
                          child: Text(
                            "#Spicy",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["spicy"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["vegetarian"] = !interestsMap["vegetarian"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["vegetarian"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 171.w,
                        child: Center(
                          child: Text(
                            "#vegetarian",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["vegetarian"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["traditional"] =
                          !interestsMap["traditional"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["traditional"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 150.w,
                        child: Center(
                          child: Text(
                            "#Traditional",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["traditional"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          interestsMap["sea food"] = !interestsMap["sea food"]!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            border: Border.fromBorderSide(BorderSide(
                                color: interestsMap["sea food"] == true
                                    ? MyColor().mainColor
                                    : Colors.black))),
                        height: 47.h,
                        width: 189.w,
                        child: Center(
                          child: Text(
                            "#Sea food",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: interestsMap["sea food"] == true
                                    ? MyColor().mainColor
                                    : Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 140.h,
                ),
                GestureDetector(
                  onTap: (){
                    List<String> myListInterest = [];
                    for (String element in interestsMap.keys) {
                      if (interestsMap[element] == true) {
                        myListInterest.add(element);
                        print(element);
                      }
                    }
                    if (myListInterest.length > 4) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: LoadingAnimationWidget.hexagonDots(
                                  color: MyColor().mainColor, size: 100),
                            );
                          });
                     StoreController.instance.myInterest(myListInterest,context);
                    }

                  },
                  child: Container(
                    height: 50.h,
                    width: 200.w,
                    decoration: BoxDecoration(color: MyColor().mainColor,borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child:  Text("Edite",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15.sp),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}


class GridItem extends StatelessWidget {
  final String text;

  GridItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.black))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 47.h,
      width: 120.w,
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 18.sp),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
