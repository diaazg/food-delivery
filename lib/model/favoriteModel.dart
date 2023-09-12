import 'package:cloud_firestore/cloud_firestore.dart';
class FavoriteModel{
  List? favRest;
  FavoriteModel({this.favRest});
  FavoriteModel.fromMap(DocumentSnapshot data){
    favRest=data["favRest"];
  }
}