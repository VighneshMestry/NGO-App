import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/custom_bottom_bar.dart';

class CarouselScreen extends ConsumerStatefulWidget {
  const CarouselScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends ConsumerState<CarouselScreen> {
  CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  List<Color> backgroundColors = const [
    Color.fromARGB(255, 244, 167, 35),
    Color.fromARGB(255, 32, 48, 82),
    Color.fromARGB(255, 1, 177, 24),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors[currentIndex],
      body: Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            items: Constants.carouselScreenImages.map(
              (e) {
                return Builder(
                  builder: (BuildContext context) => ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      e,
                      fit: BoxFit.fitHeight,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              // autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              viewportFraction: 1,
              height: MediaQuery.of(context).size.height - 90,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Container(
              color: backgroundColors[currentIndex],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        carouselController.previousPage();
                      },
                      child: Text("BACK",
                          style: TextStyle(color: Colors.blue.shade900))),
                  DotsIndicator(
                    decorator: DotsDecorator(
                        color: Colors.grey,
                        activeColor: Colors.blue,
                        activeSize: const Size(20, 9),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    dotsCount: Constants.carouselScreenImages.length,
                    position: currentIndex,
                  ),
                  TextButton(
                    onPressed: () {
                      if (currentIndex == 2) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CustomBottomNavigationBar(
                                        currentPage: 0)),
                            (Route<dynamic> route) => false);
                      }
                      carouselController.nextPage();
                    },
                    child: Text("NEXT",
                        style: TextStyle(color: Colors.blue.shade900)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
