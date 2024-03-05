// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cinema_swift/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final Function() onGoogleClick;
  final Function() onFbClick;
  const SocialButton(
      {super.key, required this.onGoogleClick, required this.onFbClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Material(
            color: MyTheme.redLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: MyTheme.redBorder, width: 0.2)),
            child: InkWell(
              onTap: onGoogleClick,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/google.svg"),
                    SizedBox(width: 8),
                    Text(
                      "Google",
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Material(
            color: MyTheme.blueLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: MyTheme.blueBorder, width: 0.2)),
            child: InkWell(
              onTap: onFbClick,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/facebook.svg"),
                    SizedBox(width: 8),
                    Text(
                      "Facebook",
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
