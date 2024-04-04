import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../about/about_us_screen.dart';
import '../events/events.dart';
import '../home/screens/home_screen.dart';
import '../news/news_screen.dart';
import '../ngo/screens/ngo_activity_screen.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  final int currentPage;
  const CustomBottomNavigationBar({super.key, 
    required this.currentPage,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState
    extends ConsumerState<CustomBottomNavigationBar> {
  int _page = 0;

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _page = widget.currentPage;
  }

  static const screens = [
    HomeScreen(),
    NgoActivityScreen(),
    NewsScreen(),
    EventScreen(),
    AboutUsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_page],
      bottomNavigationBar: CupertinoTabBar(
        border: const Border(top: BorderSide.none),
        height: 60,
        activeColor: Colors.blue.shade800,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city_outlined),
            label: 'NGO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          ),
        ],
        onTap: onPageChange,
        currentIndex: _page,
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:ngo_app/core/constants/constants.dart';
// import 'package:ngo_app/features/home/screens/home_screen.dart';

// // import 'package:hair_salon/features/schedule/screens/schedule_screen.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   const CustomBottomNavigationBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   var currentPage = 0;
//   double bottomBarWidth = 42;
//   double bottomBarBorderWidth = 5;

//   List<Widget> pages = [
//     const HomeScreen(),
//     const HomeScreen(),
//     const HomeScreen(),
//     const HomeScreen(),
//     const HomeScreen(),
//   ];

//   void updatePage(int page) {
//     setState(() {
//       currentPage = page;
//     });
//   }

//   @override
//   void initState() {
//     updatePage(0);
//     super.initState();
//   }

//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Builder(builder: (context) {
//         return pages[currentPage];
//       }),
//       bottomNavigationBar: Builder(builder: (context) {
//         return BottomNavigationBar(
//           currentIndex: currentPage,
//           selectedItemColor: Constants.selectedNavBarColor,
//           unselectedItemColor: Constants.unselectedNavBarColor,
//           // backgroundColor: GlobalVariables.backgroundColor,
//           iconSize: 28,
//           onTap: updatePage,
//           items: [
//             BottomNavigationBarItem(
//               icon: Container(
//                 width: bottomBarWidth,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: currentPage == 0
//                           ? Constants.selectedNavBarColor
//                           : Constants.backgroundColor,
//                       width: bottomBarBorderWidth,
//                     ),
//                   ),
//                 ),
//                 child: const Icon(Icons.home_outlined),
//               ),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Container(
//                 width: bottomBarWidth,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: currentPage == 1
//                           ? Constants.selectedNavBarColor
//                           : Constants.backgroundColor,
//                       width: bottomBarBorderWidth,
//                     ),
//                   ),
//                 ),
//                 child: const Icon(Icons.widgets_outlined),
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Container(
//                 width: bottomBarWidth,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: currentPage == 2
//                           ? Constants.selectedNavBarColor
//                           : Constants.backgroundColor,
//                       width: bottomBarBorderWidth,
//                     ),
//                   ),
//                 ),
//                 child: const Icon(Icons.calendar_month_outlined),
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Container(
//                 width: bottomBarWidth,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: currentPage == 3
//                           ? Constants.selectedNavBarColor
//                           : Constants.backgroundColor,
//                       width: bottomBarBorderWidth,
//                     ),
//                   ),
//                 ),
//                 child: const Icon(Icons.speaker_notes_outlined),
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Container(
//                 width: bottomBarWidth,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: currentPage == 4
//                           ? Constants.selectedNavBarColor
//                           : Constants.backgroundColor,
//                       width: bottomBarBorderWidth,
//                     ),
//                   ),
//                 ),
//                 child: const Icon(Icons.person_outline_outlined),
//               ),
//               label: '',
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
