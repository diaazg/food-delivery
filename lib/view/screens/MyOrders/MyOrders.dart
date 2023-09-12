import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/view/widgets/OrdersCardState.dart';
import 'package:food/controller/Store.dart';
import 'package:food/controller/Authentification.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String? uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put<AuthController>(AuthController());
    uid = AuthController.instance.uid;
  }

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
                "My orders",
                style: GoogleFonts.acme(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50.h,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(uid)
                    .collection("orders")
                    .snapshots(),
                builder: (context, snp) {
                  if (snp.hasData) {
                    return Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return OrderCardStatus(
                              foodName: snp.data!.docs[index]["demand"],
                              restName: snp.data!.docs[index]["restName"],
                              status: snp.data!.docs[index]["state"],
                              orderID:snp.data!.docs[index].id.toString() ,
                              restID:snp.data!.docs[index]["restID"] ,
                            );
                          },
                          separatorBuilder: (context, int) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                          itemCount: snp.data!.docs.length),
                    );
                  } else {
                    return Center(
                      child: LoadingAnimationWidget.hexagonDots(
                          color: Colors.white, size: 100),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
