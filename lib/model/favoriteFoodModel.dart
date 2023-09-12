import 'package:cloud_firestore/cloud_firestore.dart';
class FavoriteFoodModel{
  List? favFood;
  FavoriteFoodModel({this.favFood});
  FavoriteFoodModel.fromMap(DocumentSnapshot data){
    favFood=data["favFood"];
  }
}