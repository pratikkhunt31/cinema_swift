// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cinema_swift/controller/location_controller.dart';
import 'package:cinema_swift/screens/home.dart';
import 'package:cinema_swift/utils/dummy_data.dart';
import 'package:cinema_swift/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(LocationController());
  }

  var myLocationWidget = Padding(
    padding: EdgeInsets.only(top: 20),
    child: GestureDetector(
      onTap: () async {
        LocationController.instance.isLocating(true);
        await LocationController.instance.getLocation();
        Get.offAll(() => HomeScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyTheme.greyColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.my_location,
              color: Colors.black45,
            ),
            SizedBox(width: 15),
            Text(
              "My Current Location",
              style: TextStyle(color: Colors.black45, fontSize: 16),
            ),
          ],
        ),
      ),
    ),
  );

  Widget locationSuggest(String city) => Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black45, width: 1),
        ),
        child: Center(
          child: Text(
            city,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Obx(
          () => LoadingOverlay(
            isLoading: LocationController.instance.isLocating.value,
            color: MyTheme.statusBar,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(MyTheme.appBarColor),
            ),
            child: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myLocationWidget,
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cities.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth > 680 ? 5 : 3,
                          childAspectRatio: 2.3,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          LocationController.instance.setCity(cities[index]);
                          Get.offAll(() => HomeScreen());
                        },
                        child: locationSuggest(cities[index]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search",
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 50,
                          maxWidth: 50,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            color: Colors.black45,
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.black45),
                        fillColor: MyTheme.greyColor,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
