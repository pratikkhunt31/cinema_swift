// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cinema_swift/widgets/item_block.dart';
import 'package:flutter/material.dart';

import '../model/event_model.dart';

class EventItem extends StatelessWidget {
  final List<EventModel> events;
  const EventItem({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.27,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (_, i) {
          return ItemBlock(
            model: events[i],
            onTap: (model) {},
          );
        },
      ),
    );
  }
}
