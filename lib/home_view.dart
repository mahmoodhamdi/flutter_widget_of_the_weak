import 'package:flutter/material.dart';
import 'package:flutter_widget_of_the_weak/search_anchor.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [MySearchAnchor()],
          ),
        ),
      ),
    );
  }
}
