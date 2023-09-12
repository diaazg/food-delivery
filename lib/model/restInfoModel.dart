import 'package:cloud_firestore/cloud_firestore.dart';

class RestInfoModel{
  String? restName,restWilaya,img,phoneNumber,fbLink;
  double? lat,long;
  Map<String,dynamic>?rating;
  List<dynamic>?menuCategory;
  RestInfoModel({this.restName,this.restWilaya,this.lat,this.long,this.rating,this.menuCategory,this.img,this.phoneNumber,this.fbLink});
  RestInfoModel.fromMap(DocumentSnapshot data){
    restName=data["restName"];
    restWilaya=data["restWilaya"];
    lat=data["lat"];
    long=data["long"];
    rating=data["rating"];
    menuCategory=data["menuCategory"];
    img=data["img"];
    phoneNumber=data["phoneNbr"];
    fbLink=data["facebookLink"];
  }
}