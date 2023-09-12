import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food/constant/Style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/view/screens/navBar.dart';
import 'package:food/controller/Authentification.dart';
import 'package:food/constant/lists.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:food/view/screens/authentication/interests.dart';

class RegistrationPage extends StatefulWidget {
   const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formkey=GlobalKey<FormState>();
  String email='';
  String password='';
  String userName='';
  String phoneNbr='';
  String? newWilaya;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                "images/logo.png",
                height: 200.h,
                width: 350.w,
              ),
            ),
            Form(
              key: _formkey,
              child:Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    width: 370.w,
                    height: 80.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                    child: Center(
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            email=val;
                          });
                        },
                        validator: (val)=>val!.isEmpty?'Enter an email':null,

                        cursorColor: Colors.black,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          suffixIconColor: Colors.black54,
                          focusColor: Colors.black54,
                          fillColor: Colors.black54,
                          border: InputBorder.none,
                          hintText: 'email',
                          suffixIcon: Icon(Icons.mail_outline),
                          enabledBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(20)
                          ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:  const BorderSide(
                            width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(20)
                    ),


                        ),

                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    width: 370.w,
                    height: 80.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                    child: Center(
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            userName=val;
                          });
                        },
                        validator: (val)=>val!.isEmpty?'Enter user name':null,

                        cursorColor: Colors.black,
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          suffixIconColor: Colors.black54,
                          focusColor: Colors.black54,
                          fillColor: Colors.black54,
                          border: InputBorder.none,
                          hintText: 'user name',
                          suffixIcon: Icon(Icons.person_2_outlined),
                          enabledBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(20)
                          ),
focusedErrorBorder: OutlineInputBorder(
    borderSide:  const BorderSide(
        width: 1, color: Colors.red),
    borderRadius: BorderRadius.circular(20)
),

                        ),

                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    width: 370.w,
                    height: 80.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                    child: Center(
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            password=val;
                          });
                        },
                        validator: (val)=>val!.isEmpty?'Enter your password':null,

                        cursorColor: Colors.black,
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          suffixIconColor: Colors.black54,
                          focusColor: Colors.black54,
                          fillColor: Colors.black54,
                          border: InputBorder.none,
                          hintText: 'password',
                          suffixIcon: Icon(Icons.lock_outline),
                          enabledBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
                                  width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(20)
                          ),

                        ),

                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    width: 370.w,
                    height: 80.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                    child: Center(
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            phoneNbr=val;
                          });
                        },
                        validator: (val)=>val!.isEmpty?'Enter your phone number':null,

                        cursorColor: Colors.black,
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          suffixIconColor: Colors.black54,
                          focusColor: Colors.black54,
                          fillColor: Colors.black54,
                          border: InputBorder.none,
                          hintText: 'phone number',
                          suffixIcon: const Icon(Icons.call_outlined),
                          enabledBorder: OutlineInputBorder(
                              borderSide:   const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
                                  width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
                                  width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(20)
                          ),


                        ),

                      ),
                    ),
                  ),



                ],
              ),
            ),
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
            SizedBox(height:40.h ),
            GestureDetector(
              onTap: (){
                if (_formkey.currentState!.validate() && newWilaya!=null) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Interests(email: email, password: password, userName: userName, phoneNbr: phoneNbr, newWilaya: newWilaya!)));
                }
              },
              child: Container(
                height: 50.h,
                width: 200.w,
                decoration: BoxDecoration(color: MyColor().mainColor,borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child:  Text("Sign up",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15.sp),),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
