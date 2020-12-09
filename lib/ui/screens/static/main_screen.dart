import 'package:comida/shared/color.dart';
import 'package:comida/states/provider/navigation_provider.dart';
import 'package:comida/ui/screens/food/explore_screen.dart';
import 'package:comida/ui/screens/offers/offers_screen.dart';
import 'package:comida/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: baseDarkColor,
          ),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  color: baseDarkColor,
                ),
                PageView(
                  controller: navigation.pageIndex,
                  onPageChanged: (index) {
                    navigation.changeIndex(index);
                  },
                  children: [
                    ExploreScreen(),
                    OffersScreen(),
                  ],
                ),
                BottomNavbar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}