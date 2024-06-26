// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

// ignore: must_be_immutable
class CarouselImages extends StatefulWidget {
  List<String> imagesList;
  CarouselImages({
    Key? key,
    this.imagesList = Constants.carouselImages,
  }) : super(key: key);

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imagesList.map(
            (e) {
              return Builder(
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      e,
                      fit: BoxFit.fill,
                      // height: 220,
                      width: MediaQuery.of(context).size.width - 20,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            viewportFraction: 1,
            height: 220,
          ),
        ),
        DotsIndicator(
          decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: Colors.blue,
              activeSize: const Size(20, 9),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          dotsCount: Constants.carouselImages.length,
          position: currentIndex,
        ),
      ],
    );
  }
}
