// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_swift/controller/auth_controller.dart';
import 'package:cinema_swift/screens/profile_screen.dart';
import 'package:cinema_swift/screens/select_location.dart';
import 'package:cinema_swift/utils/constants.dart';
import 'package:cinema_swift/utils/custom_slider.dart';
import 'package:cinema_swift/utils/dummy_data.dart';
import 'package:cinema_swift/utils/event_item.dart';
import 'package:cinema_swift/utils/menu_item.dart';
import 'package:cinema_swift/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/location_controller.dart';
import '../controller/shared_pref.dart';
import '../utils/movie_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = cities[0];
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    SharedPref.getLocation()
        .then((value) => LocationController.instance.setCity(value));
    super.initState();
  }

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: MyTheme.statusBar));

    String? picUrl = AuthController.instance.user!.photoURL;
    picUrl = picUrl ?? Constants.dummyAvatar;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => ProfileScreen());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                      imageUrl: picUrl,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60),
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AuthController.instance.user!.displayName ?? "Name",
                    style: TextStyle(color: Colors.white),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        Get.to(() => SelectLocation());
                      },
                      child: Row(
                        children: [
                          Text(
                            LocationController.instance.city.value,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              inherit: true,
                              fontSize: 10,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // DropdownButton<String>(
                  //   value: city,
                  //   dropdownColor: MyTheme.statusBar,
                  //   isDense: true,
                  //   icon: Icon(
                  //     Icons.keyboard_arrow_down,
                  //     color: Colors.white.withOpacity(0.7),
                  //   ),
                  //   items: cities
                  //       .map(
                  //         (e) => DropdownMenuItem<String>(
                  //           value: e,
                  //           child: Text(e),
                  //         ),
                  //       )
                  //       .toList(),
                  //   onChanged: (st) {
                  //     setState(() {
                  //       city = st!;
                  //     });
                  //   },
                  // )
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  print(AuthController.instance.user!.displayName);
                },
                icon: SvgPicture.asset("assets/icons/search.svg"),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/notification.svg",
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width,
                  // color: Colors.red,
                  child: PageView.builder(
                    itemCount: sliderData.length,
                    itemBuilder: (_, i) {
                      return CustomSlider(index: i);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
                MenuItem(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    "Recommendation",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
                MovieItem(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 10.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nearby Theaters",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: MyTheme.splash,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    //   Factory<OneSequenceGestureRecognizer>(
                    //       () => EagerGestureRecognizer())
                    // },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    zoomControlsEnabled: false,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 10.0, right: 15.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/spotlights.svg",
                        color: Colors.black,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Events",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: MyTheme.splash,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                EventItem(events: events),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 10.0, right: 15.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/theater_masks.svg",
                        color: Colors.black,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Plays",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: MyTheme.splash,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                EventItem(events: plays),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
