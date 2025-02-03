import 'package:example/common/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitle: 'Carousel',
      children: [
        ShadCarousel(
          carouselHeight: 200,
          children: List.generate(
            20,
            (index) => Container(
              // height: 100,
              width: 200,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Hello, $index",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
