import 'package:cloud_firestore/cloud_firestore.dart';
class MyOrderModel{
  String? demand,restName,state;
  MyOrderModel({this.demand,this.restName,this.state});
  MyOrderModel.fromMap(DocumentSnapshot data){
    demand=data["demand"];
    restName=data["restName"];
    state=data["state"];
  }
}