import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constant/Style.dart';
import 'package:food/view/widgets/RestaurantCard.dart';
import 'package:food/controller/Store.dart';
import 'package:get/get.dart';

class Maps extends StatefulWidget {
  Maps(
      {required this.myOrders,
      required this.restNames
      });

  final Map<String,List<Map<String,dynamic>>>myOrders;
  final Map<String,dynamic>restNames;

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Set<Marker> _markers = {};
  BitmapDescriptor? myTarcker;
  void setIconTracker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "images/icons/Location.png")
        .then((value) => myTarcker = value);
  }

  LatLng? _destination;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setIconTracker();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                zoom: 5,
                target: LatLng(
                    36, 2.5)),
            onMapCreated: (controller) {},
            markers: _markers,
            onTap: (loc) {
              setState(() {
                _destination = loc;
                _markers.removeWhere((element) =>
                    element.markerId == const MarkerId("Tap Location"));
                _markers.add(Marker(
                    icon: myTarcker!,
                    markerId: MarkerId("Tap Location"),
                    infoWindow:
                        InfoWindow(title: "Tap location", snippet: "Snippet"),
                    position: _destination!));
              });
            },
          ),
          Positioned(
              bottom: 100,
              left: 50,
              child: Material(
                color: Colors.transparent,
                elevation: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.put<StoreController>(StoreController());
                    widget.myOrders.keys.toList().forEach((element) {
                      double total=0;
                      String demand="";
                      for(int i=0;i<widget.myOrders[element]!.length;i++){
                        total=total + widget.myOrders[element]![i]["amount"] * widget.myOrders[element]![i]["unitPrice"];
                        if(i==0){
                          demand =" ${widget.myOrders[element]![i]["foodName"]} : ${widget.myOrders[element]![i]["amount"]}";
                        }else{
                          demand ="$demand , ${widget.myOrders[element]![i]["foodName"]} : ${widget.myOrders[element]![i]["amount"]}";
                        }
                      }
                      String restName=widget.restNames[element];
                      DateTime now = DateTime.now();
                      int currentHour = now.hour;
                      int currentMinute = now.minute;
                      StoreController.instance.myOrders("$currentHour : $currentMinute",
                          _destination!.latitude,
                          _destination!.longitude,
                          demand,
                          element,
                          total,
                          restName);
                    });
                    Get.snackbar("About user", "Orders have been added",
                      backgroundColor: Colors.greenAccent,
                      titleText: const Icon(Icons.done_all),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 61.h,
                    width: 294.w,
                    decoration: BoxDecoration(
                        color: MyColor().mainColor,
                        borderRadius: MyRaduis().mainRadius),
                    child: Center(
                      child: Text(
                        "Check out",
                        style: GoogleFonts.acme(
                            color: Colors.black,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
