import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food/constant/Style.dart';
import 'package:food/view/screens/authentication/login.dart';

class firstPages extends StatefulWidget {
  const firstPages({Key? key}) : super(key: key);

  @override
  State<firstPages> createState() => _firstPagesState();
}

class _firstPagesState extends State<firstPages> {
  final controller = PageController();
  bool isLastPage = false;
  int? ind;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: MyColor().mainColor,
      body: Column(
        children: [
          Container(
            height: 600.h,
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                  index == 0 ? ind = index + 2 : ind = index - 1;
                });
              },
              controller: controller,
              children: const [
                Page(
                  img: 1,
                  title: 'Delevery service to your home',

                ),
                Page(
                    img: 2,
                    title: 'order food that you want ',
                   ),
                Page(
                  img: 3,
                  title: 'find the restaurant location',

                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: ExpandingDotsEffect(
                dotColor: Colors.white, activeDotColor: Colors.white),
            onDotClicked: (index) {
              controller.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
          ),
          SizedBox(height: 40.h),
          ElevatedButton(
            onPressed: () {
              isLastPage
                  ? Navigator.push(context, MaterialPageRoute(builder: (context)=>login()))
                  : controller.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease);
            },
            child: isLastPage?Text(
              "Get started",
              style: GoogleFonts.jua(color: Colors.white, fontSize: 30.sp),
            ):Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 20.w,),
                Text(
                  "Next",
                  style: GoogleFonts.jua(color: Colors.white, fontSize: 30.sp),
                ),
                Icon(Icons.navigate_next,color: Colors.white,)
              ],
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(300.w, 70.h),
                maximumSize:Size(300.w, 70.h) ,
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
          )


        ],
      ),
    ));
  }
}

class Page extends StatelessWidget {
  const Page(
      {super.key,

        required this.img,
        required this.title,
       });
  final int img;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "images/firstPages/$img.png",
              height: 500.h,
              width: 350.w,
            ),
            Text(
              title,
              style: GoogleFonts.josefinSans(color: Colors.black, fontSize: 24.sp),
            ),
          ],
        ),
      ),
    );
  }
}

