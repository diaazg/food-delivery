import 'package:cloud_firestore/cloud_firestore.dart';
class UserMod{
  String? username,phoneNbr,img,wilaya;
  List? interest=[];
  UserMod({this.username,this.phoneNbr,this.img,this.wilaya,this.interest});
  UserMod.fromMap(DocumentSnapshot data){
    username=data["userName"];
    phoneNbr=data["phoneNbr"];
    img=data["img"];
    wilaya=data["wilaya"];
    interest=data["myInterest"];
  }
}