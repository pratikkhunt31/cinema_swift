import 'package:flutter/material.dart';

import '../utils/theme.dart';

class ItemBlock extends StatelessWidget {
  final dynamic model;
  final bool isMovie;
  final double height;
  final double width;
  final Function(dynamic model) onTap;

  const ItemBlock({
    super.key,
    this.isMovie = false,
    required this.model,
    this.height = 150,
    this.width = 120,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 10.0),
      child: GestureDetector(
        onTap: () {
          onTap(model);
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  model.bannerUrl,
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: width,
                child: Text(
                  model.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.6)),
                ),
              ),
              isMovie
                  ? Row(
                      children: [
                        const Icon(Icons.favorite, color: MyTheme.splash),
                        const SizedBox(width: 5),
                        Text(
                          "${model.like}%",
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    )
                  : Text(
                      model.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}