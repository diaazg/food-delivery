import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/constant/Style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/controller/Store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:food/controller/Authentification.dart';
import 'edite/editeInterest.dart';
import 'package:food/constant/lists.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? img;
  void pickImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 400,
        maxWidth: 400,
        imageQuality: 75);
    Reference ref = FirebaseStorage.instance
        .ref('users/')
        .child(AuthController.instance.uid);
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {


        if (value.isNotEmpty) {
          setState(() {
            img = value;
          });
          Get.put<StoreController>(StoreController());
          StoreController.instance.updateImg(value.toString());
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/backGround.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          child: GetX(
            init: Get.put<StoreController>(StoreController()),
            builder: (StoreController store) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: (store.getterUserInfo.img == "")
                        ? Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 100,
                              child: Center(
                                child: Icon(
                                  Icons.person_outline_rounded,
                                  color: MyColor().mainColor,
                                  size: 40,
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 100,
                              backgroundImage:
                                  NetworkImage("${store.getterUserInfo.img}"),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "user name ",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.black))),
                    height: 52.h,
                    width: 332.w,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            store.getterUserInfo.username!,
                            style: GoogleFonts.poppins(
                                fontSize: 20.sp, color: Colors.black),
                          ),
                          const Icon(Icons.edit),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "phone number",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration:const  BoxDecoration(

                        color: Colors.white,
                        border:Border.fromBorderSide(
                            BorderSide(color: Colors.black))),
                    height: 52.h,
                    width: 332.w,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            store.getterUserInfo.phoneNbr!,
                            style: GoogleFonts.poppins(
                                fontSize: 20.sp, color: Colors.black),
                          ),
                          const Icon(Icons.edit),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "wilaya",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration:const  BoxDecoration(

                        color: Colors.white,
                        border:Border.fromBorderSide(
                            BorderSide(color: Colors.black))),
                    height: 52.h,
                    width: 332.w,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            store.getterUserInfo.wilaya!,
                            style: GoogleFonts.poppins(
                                fontSize: 20.sp, color: Colors.black),
                          ),
                          GestureDetector(
                              onTap: () {
                                final formKey = GlobalKey<FormState>();
                                String? newWilaya =
                                store.getterUserInfo.wilaya!;
                                Get.dialog(Dialog(
                                  child: SizedBox(
                                    height: 300.h,
                                    width: 400.w,
                                    child: Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 10.h),
                                              width: 370.w,
                                              height: 100.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: DropdownButtonFormField(
                                                  validator: (val) =>
                                                  val!.isEmpty
                                                      ? 'Enter wilaya'
                                                      : null,
                                                  value: newWilaya,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      newWilaya = newValue;
                                                    });
                                                  },
                                                  items: wilayatList.map<
                                                      DropdownMenuItem<
                                                          String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  store.changeRestWilaya(
                                                      newWilaya!);
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Container(
                                                height: 46.h,
                                                width: 170.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    MyRaduis().mainRadius,
                                                    color: MyColor().mainColor),
                                                child: Center(
                                                  child: Text(
                                                    "Update",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 20.sp,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ));
                              },
                              child: const Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Interest",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration:const  BoxDecoration(

                        color: Colors.white,
                        border:Border.fromBorderSide(
                            BorderSide(color: Colors.black))),
                    height: 52.h,
                    width: 332.w,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Edite",
                            style: GoogleFonts.poppins(
                                fontSize: 20.sp, color: Colors.black),
                          ),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditeInterest()));
                              },
                              child: const Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  ),

                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}
