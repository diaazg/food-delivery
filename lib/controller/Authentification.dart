import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food/view/screens/firstPages/firstPages.dart';
import 'package:food/view/screens/navBar.dart';
import 'package:flutter/material.dart';
import 'package:food/view/screens/authentication/login.dart';


class AuthController extends GetxController{
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore storeInstance = FirebaseFirestore.instance;
  late String uid;
  late CollectionReference userInfo;
  late CollectionReference allUsers;



  @override
  void onReady() {
    super.onReady();
    userInfo=storeInstance.collection("users");
    allUsers=storeInstance.collection("allUsers");
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user)async {
    if (user == null) {
      Get.offAll(() => firstPages());
    } else {
      uid = user.uid;
      DocumentSnapshot doc =await allUsers.doc(uid).get();
      String type=doc.get("type");
      if(type=="client"){
        Get.offAll(() => NavBar());
      }else{
        logOut();
      }
    }
  }

  void AddInfo(String username,phoneNumber,wilaya,List myInterest)async{
    try{
      await userInfo.doc(uid).set({
        'userName':username,
        'phoneNbr':phoneNumber,
        'wilaya':wilaya,
        'favFood':[],
        'favRest':[],
        'myCart':[],
        'myInterest':[],
        'img':"",
        'uid':uid,
        'myInterest':myInterest
      });
    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Registration failed"),
          messageText: Text(e.toString()));
    }

  }


  void Register(String email, password, username,phoneNbr,wilaya,BuildContext context,List<String>myListInterest) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      AddInfo(username, phoneNbr,wilaya,myListInterest);
      await allUsers.doc(uid).set({
        "type":"client"
      });

      Get.offAll(() => NavBar());
    } catch (e) {
      Navigator.pop(context);
      Get.snackbar("About user", "User message",
          titleText: Text("Registration failed"),
          messageText: Text(e.toString()));
    }
  }

  void Login(String email, password,BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Navigator.pop(context);
      Get.snackbar("About user", "User message",
          titleText: Text("Login failed"),
          messageText: Text(e.toString()));
    }
  }

  void logOut() async {
    await auth.signOut();
    Get.offAll(() => login());
  }

}