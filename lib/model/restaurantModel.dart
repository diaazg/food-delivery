import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel{
  String? restName,restWilaya,id,img;
  double? lat,long;
  Map<String,dynamic>? ratingSystem;
  List? categories=[];

  RestaurantModel({this.restName,this.id,this.restWilaya,this.long,this.lat,this.ratingSystem,this.categories,this.img});

  RestaurantModel.fromMap(DocumentSnapshot data){
    restName=data["restName"];
    restWilaya=data["restWilaya"];
    lat=data["lat"];
    long=data["long"];
    id=data["id"];
    img=data["img"];
    ratingSystem=data["rating"];
    categories=data["menuCategory"];
  }
}