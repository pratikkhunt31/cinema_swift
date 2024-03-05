import 'package:cinema_swift/controller/location_controller.dart';
import 'package:cinema_swift/model/theatre_model.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';

class TheatreBlock extends StatelessWidget {
  final TheatreModel model;

  const TheatreBlock({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.name,
                // style: TextStyle(fontSize: 12.5),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.info_outline,
                  color: Colors.black.withOpacity(0.3),
                  size: 20,
                ),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.location_on,
                    size: 18,
                    color: Color(0xff999999),
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 3)),
                TextSpan(
                  text: LocationController.instance.city.value + ", ",
                  style: TextStyle(
                    color: Color(0xff999999),
                  ),
                ),
                TextSpan(
                  text: "2.3 Km Away",
                  style: TextStyle(
                    color: Color(0xff999999),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: List.generate(4, (index) {
              // bool isSelected = index == SeatSelectionController.instance.timeSelectedIndex.value && isBooking;
              Color color =
                  index % 2 == 0 ? MyTheme.orangeColor : MyTheme.greenColor;
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 20.0),
                  child: Container(
                    // height: 30,
                    decoration: BoxDecoration(
                      color: Color(0x22E5E5E5),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffE5E5E5),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                    child: Text(
                      model.timings[index],
                      style: TextStyle(color: color),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
