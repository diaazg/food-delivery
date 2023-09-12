import 'package:cloud_firestore/cloud_firestore.dart';
class CartModel{
  List? myCart;
  CartModel({this.myCart});
  CartModel.fromMap(DocumentSnapshot data){
   myCart=data["myCart"];
  }
}