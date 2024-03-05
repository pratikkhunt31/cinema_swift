import 'package:cinema_swift/screens/cinema_list_screen.dart';
import 'package:cinema_swift/utils/theme.dart';
import 'package:cinema_swift/widgets/offer_block.dart';
import 'package:cinema_swift/widgets/review_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/cast_crew_block.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});

  final dynamic model = Get.arguments[0];
  final int index = Get.arguments[1];

  titleWidget(model) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Black Panther: Wakanda Forever",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              const Icon(Icons.favorite, color: MyTheme.splash),
              const SizedBox(width: 5),
              Text(
                "${model.like}%",
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
        ],
      );

  final screenWidget = Row(
    children: [
      const Text(
        "Hindi",
        style: TextStyle(color: MyTheme.splash),
      ),
      const SizedBox(width: 10),
      Container(
        decoration: BoxDecoration(
          color: MyTheme.splash.withOpacity(0.1),
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: const Text(
          "2D",
          style: TextStyle(color: MyTheme.splash, fontSize: 12),
        ),
      ),
      const SizedBox(width: 8),
      Container(
        decoration: BoxDecoration(
          color: MyTheme.splash.withOpacity(0.1),
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: const Text(
          "3D",
          style: TextStyle(
            color: MyTheme.splash,
            fontSize: 12,
          ),
        ),
      ),
    ],
  );

  final descriptionWidget = RichText(
    text: TextSpan(
      children: [
        const WidgetSpan(
          child: Icon(
            Icons.history,
            color: Colors.black45,
            size: 17,
          ),
        ),
        const WidgetSpan(
          child: SizedBox(width: 3),
        ),
        const TextSpan(
          text: "2h 59m",
          style: TextStyle(color: Colors.black45),
        ),
        const WidgetSpan(
          child: SizedBox(width: 10),
        ),
        WidgetSpan(
          child: SvgPicture.asset(
            "assets/icons/theater_masks.svg",
            height: 14,
            width: 14,
            color: Colors.black45,
          ),
        ),
        const WidgetSpan(
          child: SizedBox(width: 5),
        ),
        const TextSpan(
          text: "Action, Drama",
          style: TextStyle(color: Colors.black45),
        ),
      ],
    ),
  );

  Widget Block1(model) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget(model),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "UA | Oct 15, 2019",
                  style: TextStyle(color: Colors.black45),
                ),
                Text(
                  "1.8k Votes",
                  style: TextStyle(
                    color: MyTheme.splash,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            screenWidget,
            const SizedBox(height: 10),
            descriptionWidget,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Get.to(
              () => CinemaListScreen(
                model: model,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyTheme.splash,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Container(
            width: double.maxFinite,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/armchair.svg",
                  color: Colors.white,
                  height: 20,
                ),
                const SizedBox(width: 5),
                const Text(
                  "Book your Seat",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: MyTheme.appBarColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(model.title),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "${model.title}$index",
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/movie_banner.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: const Color(0xFFF5F5FA),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Block1(model),
                    const SizedBox(height: 20),
                    const OfferBlock(),
                    const SizedBox(height: 20),
                    const ReviewBlock(),
                    const SizedBox(height: 20),
                    const CrewCastBlock(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
