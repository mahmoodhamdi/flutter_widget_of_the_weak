import 'package:flutter/material.dart';
import 'package:flutter_widget_of_the_weak/carousel_view.dart';
import 'package:flutter_widget_of_the_weak/search_anchor.dart';
import 'package:flutter_widget_of_the_weak/video_player_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              spacing: 16,
              children: [
                MySearchAnchor(),
                MyCarouselView(),
                MyVideoPlayerView()
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
