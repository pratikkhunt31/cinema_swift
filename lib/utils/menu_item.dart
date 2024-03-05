// ignore_for_file: prefer_const_constructors

import 'package:cinema_swift/utils/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../screens/view_all_screen.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.13,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menus.length,
          itemBuilder: (_, i) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: GestureDetector(
                onTap: () {
                  print(menus[i].name);
                  // sending arguments
                  Get.to(() => ViewAllScreen(), arguments: menus[i]);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        menus[i].asset,
                        height: 35,
                        width: 35,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      menus[i].name,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
