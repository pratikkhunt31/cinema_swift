import 'package:cinema_swift/utils/dummy_data.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final index;
  const CustomSlider({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: Image.asset(sliderData[index].url, fit: BoxFit.cover),
    );
  }
}
