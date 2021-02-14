import 'package:comida/shared/color.dart';
import 'package:comida/shared/font.dart';
import 'package:comida/shared/size.dart';
import 'package:comida/states/bloc/page_bloc.dart';
import 'package:comida/ui/widgets/base_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainScreen());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: blackColor,
            ),
            SafeArea(
              child: Stack(
                children: [
                  /// Create Google Maps Widget Here
                  /// SECTION: SEARCH BAR
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: ButtonTheme(
                              padding: EdgeInsets.fromLTRB(12, 12, 14, 12),
                              child: BaseButton(
                                width: 45,
                                height: 45,
                                color: baseColor,
                                child: Image.asset(
                                  "assets/image/ic_back.png",
                                  width: 16,
                                  height: 16,
                                ),
                                onPressed: () {
                                  context.bloc<PageBloc>().add(GoToMapsScreen());
                                },
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
                                  hintText: "Search for restaurants",
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
                  ),
                  /// SECTION: MAPS INFO
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: defaultWidth(context),
                      height: 136,
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Radius",
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "10 KM",
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 11.5,
                                      color: darkGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Results Available",
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "357 Restaurant",
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 11.5,
                                      color: darkGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Location",
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "Bekasi City",
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 11.5,
                                      color: darkGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: BaseButton(
                                  width: defaultWidth(context),
                                  height: 40,
                                  color: borderColor,
                                  child: Text(
                                    "Current Location",
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 11,
                                      color: whiteColor,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Flexible(
                                flex: 1,
                                child: BaseButton(
                                  width: defaultWidth(context),
                                  height: 40,
                                  color: accentColor,
                                  child: Text(
                                    "Show Restaurants",
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 11,
                                      color: whiteColor,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}