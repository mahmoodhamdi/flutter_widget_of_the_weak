import 'package:flutter/material.dart';
import 'package:flutter_widget_of_the_weak/assets.dart';

class MyCarouselView extends StatefulWidget {
  const MyCarouselView({super.key});

  @override
  State<MyCarouselView> createState() => _MyCarouselViewState();
}

class _MyCarouselViewState extends State<MyCarouselView> {
  late CarouselController controller;
  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double itemExtent = MediaQuery.of(context).size.width * 0.8;
    final double shrinkExtent = MediaQuery.of(context).size.width * 0.6;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CarouselView(
          enableSplash: true,
          itemSnapping: true,
          shrinkExtent: shrinkExtent,
          itemExtent: itemExtent,
          scrollDirection: Axis.horizontal,
          controller: controller,
          onTap: (index) {
            controller.animateTo(
              150,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 500),
            );
            print("Tapped on index $index");
          },
          backgroundColor: Colors.grey[200],
          elevation: 4,
          padding: EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          children: Assets.imagesList.map((image) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(image, fit: BoxFit.fill));
          }).toList()),
    );
  }
}
