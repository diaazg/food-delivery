import 'package:flutter/material.dart';
import 'package:food/constant/Style.dart';
import 'package:food/view/widgets/RestaurantCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searchfield/searchfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:food/constant/lists.dart';
import 'package:food/model/restaurantModel.dart';
import 'package:food/controller/Store.dart';
import 'package:get/get.dart';
import 'package:food/model/favoriteModel.dart';

class AllRestaurants extends StatefulWidget {
  const AllRestaurants({Key? key}) : super(key: key);

  @override
  State<AllRestaurants> createState() => _AllRestaurantsState();
}

class _AllRestaurantsState extends State<AllRestaurants> {
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> restaurantsSearch = [];
  List<RestaurantModel> filteredList = [];
  List favRest=[];
  final List<String> wilayas = wilayatList;
  final List<String> rating = ['0', '1', '2', '3', '4', '5'];
  String? selectedWilaya;
  String? selectedRating;
  bool filter = false;
  bool noData=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put<StoreController>(StoreController());
    for(RestaurantModel rest in  StoreController.instance.getterRestaurants){
      setState(() {
        restaurants.add(rest);
        restaurantsSearch.add(rest);
      });
    }
    favRest=StoreController.instance.getterFavoriteRestaurants.favRest!;
  }
  void getRestaurant(String restName){
    Get.put<StoreController>(StoreController());
    setState(() {
     restaurants= StoreController.instance.getterRestaurants.where((element) => element.restName!.toUpperCase().contains(restName.toUpperCase())).toList();
    });
    if(restaurants==[]){
      setState(() {
        noData=true;
      });
    }else{
      setState(() {
        noData=false;
      });
    }
  }
  void filtering(){
    Get.put<StoreController>(StoreController());
    if(selectedWilaya!=null && selectedRating !=null){
      setState(() {
        filteredList= StoreController.instance.getterRestaurants.where((element) => element.restWilaya==selectedWilaya && element.ratingSystem!["rating"]>=int.parse(selectedRating!)).toList();
      });
      if(filteredList==[]){
        setState(() {
          noData=true;
        });
      }else{
        setState(() {
          noData=false;
        });
      }
    }
    else if(selectedWilaya!=null ){
      setState(() {
        filteredList= StoreController.instance.getterRestaurants.where((element) => element.restWilaya==selectedWilaya ).toList();
      });
      if(filteredList==[]){
        setState(() {
          noData=true;
        });
      }else{
        setState(() {
          noData=false;
        });
      }
    }
    else if(selectedRating!=null){
      setState(() {
        filteredList= StoreController.instance.getterRestaurants.where((element) =>  element.ratingSystem!["rating"]>=int.parse(selectedRating!)).toList();
      });
      if(filteredList==[]){
        setState(() {
          noData=true;
        });
      }else{
        setState(() {
          noData=false;
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              height: 60.h,
              width: 266.w,
              decoration: BoxDecoration(
                  borderRadius: MyRaduis().mainRadius, color: Colors.amber),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                child: SearchField(
                  suggestions: restaurantsSearch
                      .map((e) => SearchFieldListItem(e.restName!,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(e.restName!),
                          )))
                      .toList(),
                  suggestionState: Suggestion.expand,
                  hint: 'Search',
                  searchStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  validator: (x) => x!.isEmpty ? 'enter' : null,
                  searchInputDecoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hoverColor: Colors.black,
                      fillColor: Colors.black,
                      focusColor: Colors.black,
                      isCollapsed: false),
                  maxSuggestionsInViewPort: 2,
                  itemHeight: 50,
                  onSubmit: (x) {
                    getRestaurant(x);
                  },
                  onSearchTextChanged: (e){
                    getRestaurant(e);
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      filter = !filter;
                    });
                    if(filter==true){
                      filtering();
                    }
                  },
                  child: Container(
                    height: 37.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                        borderRadius: MyRaduis().mainRadius,
                        color: filter ? Colors.amber : Colors.white),
                    child: Center(
                      child: Text(
                        "Filter",
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 37.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: MyRaduis().mainRadius,
                  ),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        iconStyleData: IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down_sharp)),
                        isExpanded: true,
                        hint: Text(
                          'Wilaya',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: wilayas
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedWilaya,
                        onChanged: (String? value) {
                          setState(() {
                            selectedWilaya = value;
                          });
                          if(filter==true){
                            filtering();
                          }
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 37.h,
                  width: 100.w,
                  decoration:
                      BoxDecoration(borderRadius: MyRaduis().mainRadius),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        iconStyleData: IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down_sharp)),
                        isExpanded: true,
                        hint: Text(
                          'Rating',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: rating
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedRating,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRating = value;
                          });
                          if(filter==true){
                            filtering();
                          }
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            noData?Center(
              child: Text("No data"),
            ):filter?GetX(init: Get.put<StoreController>(StoreController()),
              builder: (StoreController store){
                return Expanded(
                    child:store.getterRestaurants.isEmpty?Text("data"): GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 15.0,
                        children: List.generate(filteredList.length, (index) {
                          return RestaurantCard(
                            systemRating: filteredList[index].ratingSystem!,
                            restID:filteredList[index].id! ,
                            restaurantName:filteredList[index].restName!,
                            restaurantPic: filteredList[index].img!,
                            isFavorite:store.getterFavoriteRestaurants.favRest==[]?false: store.getterFavoriteRestaurants.favRest!.contains(filteredList[index].id),
                            restWilaya: filteredList[index].restWilaya!,
                            location: LocationObj(lat:filteredList[index].lat!, long: filteredList[index].long!),);
                        })));
              },

            ):  GetX(init: Get.put<StoreController>(StoreController()),
              builder: (StoreController store){
                return Expanded(
                    child:store.getterRestaurants.isEmpty?Text("data"): GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 15.0,
                        children: List.generate(restaurants.length, (index) {
                          return RestaurantCard(
                            systemRating: restaurants[index].ratingSystem!,
                            restID:restaurants[index].id! ,
                            restaurantName:restaurants[index].restName!,
                            restaurantPic: restaurants[index].img!,
                            isFavorite:store.getterFavoriteRestaurants.favRest==[]?false: store.getterFavoriteRestaurants.favRest!.contains(restaurants[index].id),
                            restWilaya: restaurants[index].restWilaya!,
                            location: LocationObj(lat: restaurants[index].lat!, long: restaurants[index].long!),);
                        })));
              },

            )
          ],
        ),
      ),
    ));
  }
}
