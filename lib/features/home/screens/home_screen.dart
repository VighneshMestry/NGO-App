import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/auth/controller/auth_controller.dart';
import 'package:ngo_app/features/home/widgets/carousel.dart';
import 'package:searchbar_animation/const/dimensions.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    bool isBarOpen = true;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: user == null
                  ? Image.asset(
                      "assets/user.png",
                      height: 40,
                      width: 40,
                    )
                  : Image.network(
                      user.profilePic,
                      height: 40,
                      width: 40,
                    ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Good Morning",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                Text(
                  user == null ? "Name" : user.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                )
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: const Color.fromARGB(255, 227, 218, 218))),
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SearchBarAnimation(
                        textEditingController: _searchController,
                        isOriginalAnimation: true,
                        trailingWidget: const Icon(Icons.search),
                        secondaryButtonWidget: const Icon(Icons.close),
                        buttonWidget: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        searchBoxWidth: MediaQuery.of(context).size.width - 40,
                        durationInMilliSeconds: Dimensions.t700,
                        // isSearchBoxOnRightSide: true,
                        onChanged: (value) {
                          setState(() {
                            // searchString = value;
                          });
                          // filterSearchResults(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const CarouselImages(),
            // const SizedBox(height: 30),
            // const FeaturedServices(),
            // const SizedBox(height: 30),
            // const CategoryDisplay(),
            // const SizedBox(height: 30),
            // const MostPopularServices(),
          ],
        ),
      ),
    );
  }
}
