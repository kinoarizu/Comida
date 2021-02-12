import 'package:comida/shared/color.dart';
import 'package:comida/shared/font.dart';
import 'package:comida/shared/size.dart';
import 'package:comida/states/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: deviceWidth(context),
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBottomNavBarItem(
              context,
              label: "Explore",
              icon: "assets/image/ic_explore.png",
              index: 0,
              onTap: () {
                navigation.changeIndex(0);
              },
            ),
            _buildBottomNavBarItem(
              context,
              label: "Offers",
              icon: "assets/image/ic_offers.png",
              index: 1,
              onTap: () {
                navigation.changeIndex(1);
              },
            ),
            _buildBottomNavBarItem(
              context,
              label: "Cart",
              icon: "assets/image/ic_cart.png",
              index: 2,
              onTap: () {
                navigation.changeIndex(2);
              },
            ),
            _buildBottomNavBarItem(
              context,
              label: "Profile",
              icon: "assets/image/ic_profile.png",
              index: 3,
              onTap: () {
                navigation.changeIndex(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBarItem(BuildContext context, {String label, String icon, int index, Function onTap}) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);

    return (navigation.index == index) ? Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: blackColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 26,
            height: 26,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            label,
            style: mediumBaseFont.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    ) : ButtonTheme(
      minWidth: 50,
      height: 50,
      padding: EdgeInsets.zero,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          icon,
          width: 26,
          height: 26,
        ),
        onPressed: onTap,
      ),
    );
  }
}