import 'package:cloud_firestore/cloud_firestore.dart';
class CategoryModel{
  List? categories;
  CategoryModel({this.categories});
  CategoryModel.fromMap(DocumentSnapshot data){
    categories=data["menuCategory"];
  }
}