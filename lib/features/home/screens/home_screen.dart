import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/home/screens/attendance_screen.dart';
import '../../../models/attendance_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/screens/login_screen.dart';
import '../widgets/carousel.dart';
import '../widgets/custom_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void logOut() {
    ref.read(authControllerProvider.notifier).logOut();
    setState(() {});
  }

  void addAttendance(DateTime date) {
    final user = ref.read(userProvider)!;
    Attendance attendance =
        Attendance(date: date, uid: user.uid, name: user.name);
    ref
        .read(authControllerProvider.notifier)
        .addAttendance(context, attendance);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    addAttendance(date);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
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
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AttendanceScreen()));
                      },
                      child: Image.network(
                        user.profilePic,
                        height: 40,
                        width: 40,
                      ),
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
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('LogOut'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (Route<dynamic> route) => false);
                              logOut();
                            },
                            child: const Text('LogOut'),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 114, 226, 221),
                    Color.fromARGB(255, 162, 236, 233),
                  ],
                  stops: [
                    0.5,
                    1.0,
                  ],
                ),
                // color: Colors.blue.shade900
              ),
              padding: const EdgeInsets.only(left: 10),
              child: const Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                  // TO USE THE TEXTOVERFLOW PROPERTY EXPANDED WIDGET IS RECOMMENDED
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        'F-143, Prem Nagar, Kopri Colony, Thane, Maharashtra, 400603',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CarouselImages(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryTile(
                          icon: Icon(Icons.location_city_outlined),
                          categoryName: "NGO",
                          currentPage: 1),
                      CategoryTile(
                          icon: Icon(Icons.newspaper_outlined),
                          categoryName: "News",
                          currentPage: 2),
                      CategoryTile(
                          icon: Icon(Icons.event_outlined),
                          categoryName: "Events",
                          currentPage: 3),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryTile(
                          icon: Icon(Icons.info),
                          categoryName: "About Us",
                          currentPage: 4),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
