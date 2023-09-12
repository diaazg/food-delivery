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


class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List prices = [];
  List amount = [];
  double total = 0;
  bool isFac = false;
  String time = "";
  String restID = "";
  String demand = "";
  List foods = [];
 Map<String,List<Map<String,dynamic>>>myOrders={};
 Map<String,dynamic>restNames={};

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
                "My Cart",
                style: GoogleFonts.acme(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50.h,
              ),
              GetX(
                init: Get.put<StoreController>(StoreController()),
                builder: (StoreController store) {
                  return Container(
                    height: 450.h,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          restNames={};
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("restaurants")
                                  .doc(store.getterMyCart.myCart![index]
                                      ['restID'])
                                  .snapshots(),
                              builder: (context, snp) {
                               if(snp.hasData){
                               restNames[snp.data!["id"]]=snp.data!["restName"];
                                 amount.clear();
                                 store.getterMyCart.myCart!
                                     .map((e) => amount.add(e['amount']))
                                     .toList();
                                 prices.clear();
                                 store.getterMyCart.myCart!
                                     .map((e) => prices.add(e['unitPrice']))
                                     .toList();
                                 foods.clear();
                                 store.getterMyCart.myCart!
                                     .map((e) => foods.add(e['foodName']))
                                     .toList();
                                 double total1 = 0;
                                 if (prices.isNotEmpty) {
                                   for (int i = 0; i < prices.length; i++) {
                                     total1 = total1 + prices[i] * amount[i];
                                   }
                                   total = total1;
                                   restID =
                                   store.getterMyCart.myCart![0]['restID'];
                                   myOrders={};
                                   store.getterMyCart.myCart!.toList().forEach((e) {
                                     if (myOrders.containsKey(e['restID'])) {
                                       // Append value to the list if key exists

                                       myOrders[e['restID']]!.add(e);

                                     } else {
                                       // Create a new list with the value if key doesn't exist

                                       myOrders[e['restID']] = [e];
                                     }
                                   });
                                 }
                                 return SwipeTo(
                                     iconOnLeftSwipe: Icons.remove_circle_outline,
                                     onLeftSwipe: (){
                                       Get.dialog(Dialog(
                                         child: SingleChildScrollView(
                                           child: Padding(
                                             padding:
                                             const EdgeInsets.all(8.0),
                                             child: Column(
                                               children: [
                                                 SizedBox(
                                                   height: 10.h,
                                                 ),
                                                 Text(
                                                   "Are you sure that you want to remove this food from your cart",
                                                   style: GoogleFonts.poppins(
                                                       fontSize: 20.sp,
                                                       color: Colors.black87),
                                                 ),
                                                 SizedBox(
                                                   height: 20.h,
                                                 ),
                                                 Row(
                                                   mainAxisAlignment:
                                                   MainAxisAlignment
                                                       .spaceEvenly,
                                                   children: [
                                                     ElevatedButton(
                                                         style: ButtonStyle(
                                                             backgroundColor:
                                                             MaterialStatePropertyAll(
                                                                 MyColor()
                                                                     .mainColor)),
                                                         onPressed: (){
                                                           store.deleteFromCart(
                                                             store.getterMyCart.myCart![index]
                                                             ['restID'],
                                                             store.getterMyCart.myCart![index]
                                                             ['category'],
                                                             store.getterMyCart.myCart![index]
                                                             ['foodID'],
                                                             store.getterMyCart.myCart![index]
                                                             ['unitPrice'],
                                                             store.getterMyCart.myCart![index]
                                                             ['amount'],
                                                             store.getterMyCart.myCart![index]
                                                             ['foodName'],
                                                           );
                                                           amount.clear();
                                                           store.getterMyCart.myCart!
                                                               .map((e) => amount.add(e['amount']))
                                                               .toList();
                                                           prices.clear();
                                                           store.getterMyCart.myCart!
                                                               .map(
                                                                   (e) => prices.add(e['unitPrice']))
                                                               .toList();
                                                           foods.clear();
                                                           store.getterMyCart.myCart!
                                                               .map((e) => foods.add(e['foodName']))
                                                               .toList();
                                                           String demand1 = "";
                                                           double total1 = 0;
                                                           if (prices.isNotEmpty) {
                                                             for (int i = 0;
                                                             i < prices.length;
                                                             i++) {
                                                               total1 =
                                                                   total1 + prices[i] * amount[i];
                                                             }
                                                             setState(() {
                                                               total = total1;
                                                               demand = demand1;
                                                               restID = store.getterMyCart.myCart![0]
                                                               ['restID'];
                                                             });
                                                           }
                                                             Navigator.of(
                                                                 context)
                                                                 .pop(true);
                                                           },
                                                         child: Center(
                                                           child: Text(
                                                             "Yes",
                                                             style: GoogleFonts
                                                                 .poppins(
                                                                 fontSize:
                                                                 20.sp,
                                                                 color: Colors
                                                                     .black87),
                                                           ),
                                                         )),
                                                     ElevatedButton(
                                                         style: ButtonStyle(
                                                             backgroundColor:
                                                             MaterialStatePropertyAll(
                                                                 MyColor()
                                                                     .mainColor)),
                                                         onPressed: () =>
                                                             Navigator.of(
                                                                 context)
                                                                 .pop(false),
                                                         child: Center(
                                                           child: Text(
                                                             "No",
                                                             style: GoogleFonts
                                                                 .poppins(
                                                                 fontSize:
                                                                 20.sp,
                                                                 color: Colors
                                                                     .black87),
                                                           ),
                                                         )),
                                                   ],
                                                 ),
                                                 SizedBox(
                                                   height: 20.h,
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ));
                                     },
                                     child: StreamBuilder(
                                   stream:
                                   FirebaseFirestore.instance.collection("restaurants").doc(store.getterMyCart.myCart![index]['restID']).collection(store
                                       .getterMyCart.myCart![index]['category']).doc(store.getterMyCart
                                       .myCart![index]['foodID']).snapshots() ,
                                   builder: (context,snapshotThree){
                                     if(snapshotThree.hasData){
                                       return ShoppingCart(
                                         foodName: snapshotThree.data!["foodName"],
                                         foodPic: "1",
                                         foodPrice: snapshotThree.data!["price"],
                                         amount: store.getterMyCart.myCart![index]
                                         ['amount'],
                                         increment: () {
                                           setState(() {
                                             store.increment(index);
                                           });
                                         },
                                         decrement: () {
                                           setState(() {
                                             store.decrement(index);
                                           });
                                         },
                                       );
                                     }else{
                                       return Center(
                                         child: LoadingAnimationWidget.hexagonDots(
                                             color: Colors.white, size: 100),
                                       );
                                     }
                                   },));
                               }else{
                                 return Center(
                                   child: LoadingAnimationWidget.hexagonDots(color: Colors.white, size: 100),
                                 );
                               }
                              });
                        },
                        separatorBuilder: (context, int) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: store.getterMyCart.myCart!.length),
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllRestaurants()));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "add Item",
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(Dialog(
                      child: Container(
                        height: 160.h,
                        width: 277.w,
                        decoration: BoxDecoration(
                            borderRadius: MyRaduis().mainRadius,
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total : $total DA",
                                style: GoogleFonts.poppins(
                                    fontSize: 25.sp, color: Colors.black),
                              ),
                              Center(
                                  child: GestureDetector(
                                onTap: () {
                                  if ( myOrders.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Maps(
                                              restNames: restNames,
                                              myOrders: myOrders,
                                                )));
                                  } else {
                                    Get.snackbar("About user", "User message",
                                        titleText:
                                            const Text("Check your connection"),
                                        messageText: const Text(
                                            "You lose internet connection"));
                                  }
                                },
                                child: Container(
                                  height: 46.h,
                                  width: 170.w,
                                  decoration: BoxDecoration(
                                      borderRadius: MyRaduis().mainRadius,
                                      color: MyColor().mainColor),
                                  child: Center(
                                    child: Text(
                                      "order location",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20.sp,
                                          color: Colors.black87),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ));
                  },
                  child: Container(
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: MyRaduis().mainRadius,
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        "see factor",
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              )

              // Add other widgets here
            ],
          ),
        ),
      ),
    ));
  }
}

