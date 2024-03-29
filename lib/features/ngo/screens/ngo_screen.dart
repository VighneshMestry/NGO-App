import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/auth/controller/auth_controller.dart';
import 'package:ngo_app/features/ngo/screens/add_ngo_screen.dart';

class NgoScreen extends ConsumerStatefulWidget {
  const NgoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NgoScreenState();
}

class _NgoScreenState extends ConsumerState<NgoScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue.shade400,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400, spreadRadius: 3, blurRadius: 4)
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
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: !user.isNgo ? const SizedBox() : Container(
        padding: const EdgeInsets.all(5.0),
        height: 70,
        width: 70,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddNgoScreen()));
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
