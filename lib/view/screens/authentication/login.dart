import 'package:flutter/material.dart';
import 'package:food/constant/Style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/view/screens/authentication/registration.dart';
import 'package:food/controller/Authentification.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formkey=GlobalKey<FormState>();
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150.h,),
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
                    height: 100.h,
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          suffixIconColor: Colors.black54,
                          focusColor: Colors.black54,
                          fillColor: Colors.black54,
                          border: InputBorder.none,
                          hintText: 'email',
                          suffixIcon:const Icon(Icons.mail_outline),
                          enabledBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                    width: 370.w,
                    height: 100.h,
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          suffixIconColor: Colors.black54,
                          focusColor: Colors.black54,
                          fillColor: Colors.black54,
                          border: InputBorder.none,
                          hintText: 'password',
                          suffixIcon: const Icon(Icons.lock_outline),
                          enabledBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Text("Forget password? ",style: TextStyle(color: Colors.red,fontSize: 15.sp,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                  SizedBox(height:40.h ),
                  GestureDetector(
                    onTap: (){
                      if(_formkey.currentState!.validate()){
                        showDialog(context: context, builder: (BuildContext context){
                          return Center(
                            child: LoadingAnimationWidget.hexagonDots(
                                color: MyColor().mainColor, size: 100),
                          );
                        });
                        AuthController.instance.Login(email, password,context);
                      }
                    },
                    child: Container(
                      height: 50.h,
                      width: 200.w,
                      decoration: BoxDecoration(color: MyColor().mainColor,borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child:  Text("Sign in",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15.sp),),
                      ),
                    ),
                  ),
                  SizedBox(height:40.h ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
                    },
                    child: Center(
                      child:  Text("I don\'t have an account",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15.sp),),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
