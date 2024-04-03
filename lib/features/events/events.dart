import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/core/constants/constants.dart';

class EventScreen extends ConsumerStatefulWidget {
  const EventScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventScreenState();
}

class _EventScreenState extends ConsumerState<EventScreen> {

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
                        "Search for Events",
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
                        // controller: _searchController,
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
                          // print(_searchController.text);
                          // isSearchingFunction();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
                    itemCount: Constants.eventsCategories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => NgoScreen(
                          //         activity: Constants.ngoCategories[index])));
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.only(
                                top: 25, bottom: 10, left: 20, right: 20),
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade400))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Constants.eventsCategories[index],
                                  style: const TextStyle(fontSize: 22),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                        "(${Constants.eventsCategoriesCount[index].toString()})",
                                        style: const TextStyle(fontSize: 22)),
                              ],
                            )),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.white,
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const AddNgoScreen()));
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