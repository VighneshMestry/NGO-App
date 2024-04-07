// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_bar.dart';

class CategoryTile extends StatelessWidget {
  final Icon icon;
  final String categoryName;
  final int currentPage;
  const CategoryTile({
    Key? key,
    required this.icon,
    required this.categoryName,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomBottomNavigationBar(currentPage: currentPage)
        )
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 1,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: icon,
            ),
            const SizedBox(height: 10),
            Text(categoryName, style: const TextStyle(fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis, maxLines: 1,),
          ],
        ),
      ),
    );
  }
}
