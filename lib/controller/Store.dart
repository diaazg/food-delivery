import 'package:food/model/userModel.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/controller/Authentification.dart';
import 'package:food/model/restaurantModel.dart';
import 'package:flutter/material.dart';
import 'package:food/model/favoriteModel.dart';
import 'package:food/model/cartModel.dart';
import 'package:food/model/favoriteFoodModel.dart';



class StoreController extends GetxController{
  StoreController({this.restID});
  static StoreController instance = Get.find();
  FirebaseFirestore store = FirebaseFirestore.instance;

  // collections
  late CollectionReference users;
  late CollectionReference restaurants;
  late String? restID;



  //Rx
  Rx<UserMod>userInfo=Rx<UserMod>(UserMod(username: "",phoneNbr: "",img: "",wilaya: "",interest: []));
  Rx<List<RestaurantModel>> restaurantList=Rx<List<RestaurantModel>>([]);
  Rx<FavoriteModel>favoriteRest=Rx<FavoriteModel>(FavoriteModel(favRest: []));
  Rx<CartModel>myCart=Rx<CartModel>(CartModel(myCart: []));
  Rx<FavoriteFoodModel>favoriteFood=Rx<FavoriteFoodModel>(FavoriteFoodModel(favFood:[]));

  //getters

 UserMod get getterUserInfo=>userInfo.value;
 List<RestaurantModel> get getterRestaurants=>restaurantList.value;
 FavoriteModel get getterFavoriteRestaurants=>favoriteRest.value;
 CartModel get getterMyCart=>myCart.value;
 FavoriteFoodModel get getterFavoriteFood=>favoriteFood.value;


 //streams

  Stream<UserMod>getUserInfoStream(){
    String uid = Get.find<AuthController>().uid;
    return users.doc(uid).snapshots().map((event) => UserMod.fromMap(event));
  }


  Stream<List<RestaurantModel>>getRestaurantListStream(){
    return restaurants.snapshots().map((event) => event.docs.map((e) => RestaurantModel.fromMap(e)).toList());
  }


  Stream<FavoriteModel> getFavoriteRestStream(){
    String uid = Get.find<AuthController>().uid;
    return users.doc(uid).snapshots().map((event) => FavoriteModel.fromMap(event));
  }

  Stream<FavoriteFoodModel>getFavoriteFoodStream(){
    String uid = Get.find<AuthController>().uid;
    return users.doc(uid).snapshots().map((event) => FavoriteFoodModel.fromMap(event));
  }


  Stream<CartModel>getMyCartStream(){
    String uid = Get.find<AuthController>().uid;
    return users.doc(uid).snapshots().map((event) => CartModel.fromMap(event));
  }




 //on init


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    users=store.collection("users");
    restaurants=store.collection("restaurants");

    //bind Stream
    userInfo.bindStream(getUserInfoStream());
    restaurantList.bindStream(getRestaurantListStream());
    favoriteRest.bindStream(getFavoriteRestStream());
    myCart.bindStream(getMyCartStream());
    favoriteFood.bindStream(getFavoriteFoodStream());

  }

  //functions

  void favorite(String restId)async{
    try{
      String uid = Get.find<AuthController>().uid;
      DocumentReference docRef=users.doc(uid);
      DocumentSnapshot doc=await docRef.get();
      List fav=doc.get("favRest");
      if(fav.contains(restId)==true){
        docRef.update({
          'favRest':FieldValue.arrayRemove([restId])
        });
      }else{
        docRef.update({
          'favRest':FieldValue.arrayUnion([restId])
        });
      }
    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Somthing wrong"),
          messageText: Text(e.toString()));
    }
  }


  void addToCart(String restID,category, foodId,unitPrice,foodName)async{
    try{
      String uid = Get.find<AuthController>().uid;
      Map<String,dynamic> foodID=({
        'foodName':foodName,
        'restID':restID,
        'category':category,
        'foodID':foodId,
        'unitPrice':unitPrice,
        'amount':1
      });
      DocumentReference docRef=users.doc(uid);
      DocumentSnapshot doc=await docRef.get();
      List myCart=doc.get("myCart");
      if(myCart.contains(foodID)==true){

        Get.snackbar("About user", "User message",
            titleText: Text("Element is in cart"),
            messageText: Text(""));

      }else{
        docRef.update({
          'myCart':FieldValue.arrayUnion([foodID])
        });
      }
    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Somthing wrong"),
          messageText: Text(e.toString()));
    }
  }
  void deleteFromCart(String restID,category, foodId,unitPrice,amount,foodName)async{
    try{
      String uid = Get.find<AuthController>().uid;
      Map<String,dynamic> foodID=({
        'restID':restID,
        'category':category,
        'foodID':foodId,
        'foodName':foodName,
        'unitPrice':unitPrice,
        'amount':amount
      });
      DocumentReference docRef=users.doc(uid);
        docRef.update({
          'myCart':FieldValue.arrayRemove([foodID])
        });

    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Somthing wrong"),
          messageText: Text(e.toString()));
    }
  }

  void increment(int index)async{
    try{
      String uid = Get.find<AuthController>().uid;
      DocumentReference docRef=users.doc(uid);
      DocumentSnapshot doc=await docRef.get();
      List myCart=doc.get("myCart");
      Map<String,dynamic> elementToUpdate=myCart[index];
      print("aaaaaaaaaaaaaaaaaaaaaa");
      int oldNbr=elementToUpdate['amount'];
      oldNbr=oldNbr+1;
      elementToUpdate['amount']=oldNbr;
      myCart[index]=elementToUpdate;
      await docRef.update({
        'myCart':myCart
      });


    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Somthing wrong"),
          messageText: Text(e.toString()));
    }
  }
  void decrement(int index)async{
    try{
      String uid = Get.find<AuthController>().uid;
      DocumentReference docRef=users.doc(uid);
      DocumentSnapshot doc=await docRef.get();
      List myCart=doc.get("myCart");
      Map<String,dynamic> elementToUpdate=myCart[index];
      int oldNbr=elementToUpdate['amount'];
      if (!(oldNbr<=1)){
        oldNbr=oldNbr-1;
        elementToUpdate['amount']=oldNbr;
        myCart[index]=elementToUpdate;
        await docRef.update({
          'myCart':myCart
        });
      }
    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Somthing wrong"),
          messageText: Text(e.toString()));
    }
  }

  void askOrder(String time,orderID,double lat,long,String demand,restID,double price)async{
     try{
       String uid = Get.find<AuthController>().uid;
       Map<String,dynamic> order={
         'time':time,
         'lat':lat,
         'long':long,
         'demand':demand,
         'price':price,
         'clientID':uid,
         'orderID':orderID,
         "state":"wait"
       };
       DocumentReference docRef=restaurants.doc(restID);
       DocumentSnapshot doc=await docRef.get();
       List myCart=doc.get("orders");
       if(myCart.contains(order)==true){

         Get.snackbar("About user", "User message",
             titleText: Text("Element is in cart"),
             messageText: Text(""));

       }else{
         docRef.update({
           'orders':FieldValue.arrayUnion([order])
         });

     }}catch(e){
       Get.snackbar("About user", "User message",
           titleText: Text("Somthing wrong"),
           messageText: Text(e.toString()));
     }
  }
  void myOrders(String time,double lat,long,String demand,restID,double price,String restName)async{

    try{
      String uid = Get.find<AuthController>().uid;
      Map<String,dynamic> order={
        'restName':restName,
         'state':'wait',
        'demand':demand,
        'restID':restID
     
      };
      DocumentReference docRef=await users.doc(uid).collection('orders').add(order);
      String docID=docRef.id;
      askOrder(time,docID, lat, long, demand, restID, price);

      }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Somthing wrong"),
          messageText: Text(e.toString()));
    }

  }
  void removeOrder(String orderID)async{
    try{
      String uid = Get.find<AuthController>().uid;
      await users.doc(uid).collection("orders").doc(orderID).delete();
    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Somthing wrong"),
          messageText: Text(e.toString()));
    }
  }
  void rating(String restID,double newRating,BuildContext context)async{
   try{
     DocumentReference docRef= restaurants.doc(restID);
     DocumentSnapshot doc=await docRef.get();
     Map<String,dynamic>oldRating=doc.get("rating");
     double number=oldRating["number"].toDouble();
     double oldSome=oldRating["some"].toDouble();
     double nbr=number+1;
     double newSome=oldSome.toDouble()+newRating.toDouble();
     double rtg=newSome/nbr;
     Map<String,dynamic> ratingMap={
       "rating":rtg,
       "number":nbr,
       "some":newSome
     };
     await docRef.update({
       "rating":ratingMap
     });
     Navigator.pop(context);
   }catch(e){
     Get.snackbar("About user", "User message",
         titleText: Text("Somthing wrong"),
         messageText: Text(e.toString()));
   }

  }
  void favFood(String restID,foodCategory,foodID)async{
    try{
      String uid = Get.find<AuthController>().uid;
      Map<String,dynamic>element={
        "restID":restID,
        "foodCategory":foodCategory,
        "FoodID":foodID
      };
      DocumentReference docRef=users.doc(uid);
      DocumentSnapshot doc=await docRef.get();
      List favFood=doc.get('favFood');
      bool isElementInFavFood = favFood.any((map) =>
      map['restID'] == restID &&
          map['foodCategory'] == foodCategory &&
          map['FoodID'] == foodID);
      if(isElementInFavFood){
        docRef.update({
          'favFood':FieldValue.arrayRemove([element])
        });
      }else{
        docRef.update({
          'favFood':FieldValue.arrayUnion([element])
        });
      }

    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Somthing wrong"),
          messageText: Text(e.toString()));
    }
  }

  void updateImg(String img) async {
    try {
      String uid = Get.find<AuthController>().uid;
      await store.collection("users").doc(uid).update({'img': img});
    } catch (e) {
      print(e.toString());
      Get.snackbar("About user", "User message",
          titleText: Text("Update failed"), messageText: Text(e.toString()));
    }
  }
  void myInterest(List<String>myListInterest,BuildContext context)async{
    try{
      String uid = Get.find<AuthController>().uid;
      DocumentReference docRef=users.doc(uid);
      DocumentSnapshot doc=await docRef.get();
      List my=doc.get("myInterest");
      if(my.toList()!=myListInterest){
       await docRef.update({
          'myInterest':FieldValue.arrayRemove(my)
        });
       await docRef.update({
        'myInterest':FieldValue.arrayUnion(myListInterest)
        });
      }
    }catch(e){

      Get.snackbar("About user", "User message",
          titleText: const Text("Update failed"), messageText: Text(e.toString()));
    }finally{
      Navigator.pop(context);
    }
  }

  void changeRestWilaya(String newWilaya)async{
    try{
      String uid = Get.find<AuthController>().uid;
      await store.collection("users").doc(uid).update({'wilaya': newWilaya});
    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: const Text("Update failed"), messageText: Text(e.toString()));
    }
  }
}

