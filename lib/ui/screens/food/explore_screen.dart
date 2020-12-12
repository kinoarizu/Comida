import 'package:comida/model/food_category.dart';
import 'package:comida/network/repositories/food_category_repository.dart';
import 'package:comida/shared/color.dart';
import 'package:comida/shared/font.dart';
import 'package:comida/states/bloc/user_bloc.dart';
import 'package:comida/ui/widgets/base_button.dart';
import 'package:comida/ui/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    context.bloc<UserBloc>().add(LoadUser());

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: ButtonTheme(
                  padding: EdgeInsets.all(12),
                  child: BaseButton(
                    width: 45,
                    height: 45,
                    color: baseColor,
                    child: Image.asset(
                      "assets/image/ic_location.png",
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                flex: 6,
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    controller: searchController,
                    style: regularBaseFont.copyWith(fontSize: 13.5),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: baseColor,
                      hintText: "Search for meals or area",
                      hintStyle: regularBaseFont.copyWith(
                        fontSize: 13.5,
                        color: whiteColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixIcon: UnconstrainedBox(
                        child: Image.asset(
                          "assets/image/ic_search.png",
                          width: 24,
                          height: 24,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: 16,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Categories",
                      style: semiBoldBaseFont.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/image/ic_filter.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Filter",
                            style: mediumBaseFont.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 96,
                child: FutureBuilder(
                  future: FoodCategoryRepository.getFoodCategories(),
                  builder: (context, snapshot) {
                    List<FoodCategory> foodCategories = snapshot.data;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: foodCategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: (index == foodCategories.length - 1) ? 16 : 0, 
                            ),
                            child: _buildFoodCategoryCard(
                              name: foodCategories[index].name,
                              image: foodCategories[index].image,
                              onTap: () {},
                            ),
                          );
                        },
                      );
                    } else {
                      return SpinKitDoubleBounce(
                        color: whiteColor,
                        size: 40,
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: 16,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Foods",
                      style: semiBoldBaseFont.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    BaseButton(
                      width: 88,
                      height: 26,
                      color: baseColor,
                      child: Text(
                        "View All",
                        style: mediumBaseFont.copyWith(
                          fontSize: 13,
                          color: greyColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: (index == 3 - 1) ? 16 : 0, 
                      ),
                      child: _buildPopularItemCard(
                        name: "Grilled Chicken",
                        restaurant: "KFC",
                        rating: 7.8,
                        image: "assets/image/image.png",
                        normalPrice: 14.55,
                        discountPrice: 10.35,
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: 16,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nearby Deals",
                      style: semiBoldBaseFont.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    BaseButton(
                      width: 88,
                      height: 26,
                      color: baseColor,
                      child: Text(
                        "View All",
                        style: mediumBaseFont.copyWith(
                          fontSize: 13,
                          color: greyColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 208,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: (index == 3 - 1) ? 16 : 0, 
                      ),
                      child: _buildNearbyDealCard(
                        name: "Mexican Creamy Nachos",
                        restaurant: "McDonald's",
                        discount: 10,
                        normalPrice: 14.99,
                        discountPrice: 10.99,
                        image: "assets/image/image.png",
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 68,
        ),
      ],
    );
  }

  Widget _buildFoodCategoryCard({String name, String image, Function onTap}) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 88,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: mediumBaseFont.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildPopularItemCard({String name, String restaurant, double rating, String image, double normalPrice, double discountPrice, Function onTap}) {
    return GestureDetector(
      child: Container(
        width: 276,
        height: 120,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 93,
              height: 100,
              margin: EdgeInsets.only(
                right: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),  
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    image,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: mediumBaseFont.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "By $restaurant",
                  style: mediumBaseFont.copyWith(
                    fontSize: 12,
                    color: darkGreyColor,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                RatingStars(
                  starSize: 16,
                  voteAverage: rating,
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$$normalPrice",
                      style: mediumBaseFont.copyWith(
                        fontSize: 14,
                        color: darkGreyColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "\$$discountPrice",
                      style: mediumBaseFont.copyWith(
                        fontSize: 14.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildNearbyDealCard({String name, String restaurant, String image, int discount, double normalPrice, double discountPrice, Function onTap}) {
    return GestureDetector(
      child: Container(
        width: 206,
        height: 120,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 206,
              height: 101,
              margin: EdgeInsets.only(
                bottom: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),  
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    image,
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 3, 3, 0),
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "$discount% OFF",
                    style: regularBaseFont.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              restaurant,
              style: mediumBaseFont.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              name,
              style: mediumBaseFont.copyWith(
                fontSize: 12,
                color: darkGreyColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$$normalPrice",
                  style: mediumBaseFont.copyWith(
                    fontSize: 14,
                    color: darkGreyColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "\$$discountPrice",
                  style: mediumBaseFont.copyWith(
                    fontSize: 14.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  // void onSignOutPressed(BuildContext context) async {
  //   if (StorageUtil.readStorage('status') == 'google') {
  //     await SocialAuthService.signOutGoogle();
  //   }
  //   else if (StorageUtil.readStorage('status') == 'facebook') {
  //     await SocialAuthService.signOutFacebook();
  //   }
  //   else {
  //     await AuthRepository.signOut();
  //   }

  //   context.bloc<UserBloc>().add(SignOut());
  //   context.bloc<PageBloc>().add(GoToSignInScreen());
  // }
}