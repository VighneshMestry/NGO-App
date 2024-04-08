import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../models/news_model.dart';
import '../controller/news_controller.dart';
import '../widgets/news_custom_card.dart';
import 'add_news_screen.dart';
import 'news_screen.dart';

class NewsActivityScreen extends ConsumerStatefulWidget {
  const NewsActivityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsActivityScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  void isSearchingFunction() {
    if (_searchController.text.isNotEmpty) {
      isSearching = true;
      setState(() {});
    } else {
      isSearching = false;
      setState(() {});
    }
  }

  List<int> newsActivityCount = [];
  void getNewsActivityCount() async {
    List<String> newsActivity = Constants.newsCategories;
    for (var ele in newsActivity) {
      int activityCount = await ref
          .read(newsControllerProvider.notifier)
          .getNewsActivityCount(ele);
      newsActivityCount.add(activityCount);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getNewsActivityCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue.shade400,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 3,
                      blurRadius: 4)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        "Search for News",
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.only(top: 4, left: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade300),
                      height: 45,
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.blue.shade900),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        onChanged: (value) {
                          print(_searchController.text);
                          isSearchingFunction();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            isSearching
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("news")
                        .snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState ==
                              ConnectionState.waiting)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = snapshots.data!.docs[index].data();
                                NewsModel news = NewsModel.fromMap(data);

                                // if (query.isEmpty) {
                                //   return Padding(
                                //     padding: const EdgeInsets.only(bottom: 15),
                                //     child: DocumentCard(document: document),
                                //   );
                                // }
                                if (news.headLine
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        _searchController.text.toLowerCase())) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: NewsCustomCard(news: news),
                                  );
                                }
                                return Container();
                              },
                              itemCount: snapshots.data!.docs.length,
                            );
                    },
                  )
                : ListView.builder(
                    itemCount: Constants.newsCategories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewsScreen(
                                  activity: Constants.newsCategories[index])));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.only(
                              top: 25, bottom: 10, left: 20, right: 20),
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade400))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Constants.newsCategories[index],
                                style: const TextStyle(fontSize: 22),
                                overflow: TextOverflow.ellipsis,
                              ),
                              newsActivityCount.isEmpty
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          color: Colors.blue.shade400,
                                          strokeWidth: 3))
                                  : Text(
                                      "(${newsActivityCount[index].toString()})",
                                      style: const TextStyle(fontSize: 22)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(5.0),
        height: 70,
        width: 70,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNewsScreen()));
          },
          child: Icon(
            Icons.add,
            size: 32,
            color: Colors.blue.shade800,
          ),
        ),
      ),
    );
  }
}
