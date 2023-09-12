import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constant/Style.dart';
import 'package:food/view/widgets/RestaurantCard.dart';
import 'package:food/controller/Store.dart';
import 'package:get/get.dart';

class mapNormal extends StatefulWidget {
  mapNormal(
      {super.key, required this.restLocation,
       });
  final LocationObj restLocation;

  @override
  State<mapNormal> createState() => _mapNormalState();
}

class _mapNormalState extends State<mapNormal> {
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
    _markers.add(
      Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(204),
          markerId: MarkerId("currentLocation"),
          position:
          LatLng(widget.restLocation.lat!, widget.restLocation.long!)),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                zoom: 5,
                target: LatLng(
                    widget.restLocation.lat!, widget.restLocation.long!)),
            onMapCreated: (controller) {},
            markers: _markers,
            onTap: (loc) {
            },
          ),

        ],
      ),
    );
  }
}