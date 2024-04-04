import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../models/ngo_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../../widgets/custom_card.dart';
import '../controller/ngo_controller.dart';
import 'add_ngo_screen.dart';
import 'ngo_screen.dart';

class NgoActivityScreen extends ConsumerStatefulWidget {
  const NgoActivityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NgoScreenState();
}

class _NgoScreenState extends ConsumerState<NgoActivityScreen> {
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

  List<int> ngoActivityCount = [];
  void getNgoActivityCount() async {
    List<String> ngoActivity = Constants.ngoCategories;
    for (var ele in ngoActivity) {
      int activityCount = await ref
          .read(ngoControllerProvider.notifier)
          .getNgoActivityCount(ele);
      ngoActivityCount.add(activityCount);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getNgoActivityCount();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
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
                        "Search for NGOs",
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
                    .collection("ngo")
                    .snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data();
                            NGO ngo = NGO.fromMap(data);

                            // if (query.isEmpty) {
                            //   return Padding(
                            //     padding: const EdgeInsets.only(bottom: 15),
                            //     child: DocumentCard(document: document),
                            //   );
                            // }
                            if (ngo.ngoName
                                .toString()
                                .toLowerCase()
                                .contains(_searchController.text.toLowerCase())) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal : 8),
                                child: CustomCard(ngo: ngo),
                              );
                            }
                            return Container();
                          },
                          itemCount: snapshots.data!.docs.length,
                        );
                },
              )
                : ListView.builder(
                    itemCount: Constants.ngoCategories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NgoScreen(
                                  activity: Constants.ngoCategories[index])));
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
                                  Constants.ngoCategories[index],
                                  style: const TextStyle(fontSize: 22),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ngoActivityCount.isEmpty
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            color: Colors.blue.shade400,
                                            strokeWidth: 3))
                                    : Text(
                                        "(${ngoActivityCount[index].toString()})",
                                        style: const TextStyle(fontSize: 22)),
                              ],
                            )),
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: !user.isNgo
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(5.0),
              height: 70,
              width: 70,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddNgoScreen()));
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
