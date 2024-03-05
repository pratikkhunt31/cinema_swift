import 'package:cinema_swift/controller/common_controller.dart';
import 'package:cinema_swift/model/menu_model.dart';
import 'package:cinema_swift/utils/dummy_data.dart';
import 'package:cinema_swift/utils/theme.dart';
import 'package:cinema_swift/widgets/item_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/location_controller.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  // getting arguments
  MenuModel menu = Get.arguments;

  // final tabList = ["Now showing", "Up coming", "Exclusive"];

  final selectedTextStyle =
      const TextStyle(color: MyTheme.splash, fontFamily: "Poppins");

  final normalTextStyle =
      const TextStyle(color: Colors.black45, fontFamily: "Poppins");

  late List<dynamic> list;

  @override
  void initState() {
    // TODO: implement initState
    if (menu.name.contains("Event")) {
      list = events;
    } else if (menu.name.contains("Movie")) {
      list = movies;
    } else {
      list = plays;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        CommonController.instance.tabController.animateTo(0);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${menu.name} in ${LocationController.instance.city}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15),
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(
                      list: list,
                      isMovie: menu.name.toLowerCase().contains("movies"),
                    ),
                  );
                },
                icon: SvgPicture.asset("assets/icons/search.svg"),
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: TabBar(
                  tabs: CommonController.instance.tabs,
                  controller: CommonController.instance.tabController,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: MyTheme.splash,
                      width: 3,
                    ),
                    insets: EdgeInsets.all(15),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  labelStyle: selectedTextStyle,
                  unselectedLabelColor: Colors.black45,
                  labelColor: MyTheme.splash,
                  isScrollable: false,
                  enableFeedback: false,
                  unselectedLabelStyle: normalTextStyle,
                  onTap: (index) => CommonController.instance.updatePage(index),
                ),
              ),
              Expanded(
                flex: 8,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: CommonController.instance.pageController,
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    return LayoutBuilder(
                      builder: (context, constraint) {
                        return GridView.builder(
                          // shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: constraint.maxWidth > 480 ? 4 : 2,
                            childAspectRatio: 0.76,
                          ),
                          itemBuilder: (_, index) {
                            return ItemBlock(
                              height: 180,
                              width: 150,
                              model: list[index],
                              isMovie:
                                  menu.name.toLowerCase().contains("movies"),
                              onTap: (model) {},
                            );
                          },
                          itemCount: list.length,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  final bool isMovie;
  final List<dynamic> list;
  MySearchDelegate({this.isMovie = false, required this.list});

  resultWidget(dynamic model) {
    return ItemBlock(
      model: model,
      height: 180,
      width: 150,
      isMovie: isMovie,
      onTap: (model) {},
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null.toString());
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? list
        : list
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return LayoutBuilder(
      builder: (context, constraint) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraint.maxWidth > 480 ? 4 : 2,
            childAspectRatio: 0.756,
          ),
          itemBuilder: (_, index) {
            return resultWidget(suggestionList[index]);
          },
          itemCount: suggestionList.length,
        );
      },
    );
  }
}
