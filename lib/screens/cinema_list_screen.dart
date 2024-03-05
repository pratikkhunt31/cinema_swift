import 'package:cinema_swift/model/movie_model.dart';
import 'package:cinema_swift/utils/dummy_data.dart';
import 'package:cinema_swift/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../widgets/theatre_block.dart';

class CinemaListScreen extends StatelessWidget {
  final MovieModel model;
  CinemaListScreen({super.key, required this.model});

  final DateFormat format = DateFormat("dd MMM");

  final now = DateTime.now();

  String selectedDate = DateFormat("dd MMM").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      bottomNavigationBar: BottomAppBar(
        color: MyTheme.appBarColor,
        elevation: 0,
        child: Container(
          width: double.maxFinite,
          height: AppBar().preferredSize.height,
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    format.format(DateTime.now()),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(model.title),
        actions: [
          IconButton(
            onPressed: () {
              // showSearch(
              //   context: context,
              //   delegate: MySearchDelegate(
              //     list: list,
              //     isMovie: menu.name.toLowerCase().contains("movies"),
              //   ),
              // );
            },
            icon: SvgPicture.asset("assets/icons/search.svg"),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: theatres.length,
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.only(
                  bottom: index != theatres.length - 1 ? 12 : 0),
              child: TheatreBlock(
                model: theatres[index],
              ),
            );
          }),
    );
  }
}
