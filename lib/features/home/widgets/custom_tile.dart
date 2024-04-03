// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ngo_app/features/widgets/custom_bottom_bar.dart';

class CategoryTile extends StatelessWidget {
  final Icon icon;
  final String categoryName;
  const CategoryTile({
    Key? key,
    required this.icon,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CustomBottomNavigationBar(currentPage: 1)
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