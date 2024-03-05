// ignore_for_file: prefer_const_constructors

import 'package:cinema_swift/screens/detail_screen.dart';
import 'package:cinema_swift/utils/dummy_data.dart';
import 'package:cinema_swift/widgets/item_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.27,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (_, i) {
          return Hero(
            tag: "${movies[i].title}$i",
            child: ItemBlock(
              model: movies[i],
              isMovie: true,
              onTap: (model) {
                Get.to(() => DetailScreen(), arguments: [movies[i], i]);
              },
            ),
          );
        },
      ),
    );
  }
}
