import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/widgets/custom_text_field.dart';

class AddNgoScreen extends ConsumerStatefulWidget {
  const AddNgoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNgoScreenState();
}

class _AddNgoScreenState extends ConsumerState<AddNgoScreen> {
  final TextEditingController _ngoName = TextEditingController();
  final TextEditingController _ngoActivity = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _coordinator = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _contactUs = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register NGO",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                minimumSize: const Size(105, 30),
                maximumSize: const Size(105, 30),
              ),
              onPressed: () {
                // if (_className.text.isNotEmpty &&
                //     _subjectType.text.isNotEmpty &&
                //     _createdBy.text.isNotEmpty &&
                //     _subjectJoiningCode.text.isNotEmpty) {
                //   if (_subjectJoiningCode.text.trim().length < 8) {
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         content: Text(
                //             "The joining code must be 8 alphanumeric characters")));
                //   } else {
                //     String subjectId = const Uuid().v1();
                //     String userId = ref.read(userProvider)!.uid;
                //     String userName = ref.read(userProvider)!.name;
                //     Subject subject = Subject(
                //       name: _className.text.trim(),
                //       subjectId: subjectId,
                //       subjectType: _subjectType.text.trim(),
                //       backGroundImageUrl: "",
                //       createdBy: userName,
                //       creatorId: userId,
                //       subjectJoiningCode:
                //           _subjectJoiningCode.text.trim().toUpperCase(),
                //       members: [userId],
                //     );
                //     createNewSubject(subject);
                //   }
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text("Please fill all fields")));
                // }
              },
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade400),
                height: 1,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                CustomTextField(
                  controller: _ngoName,
                  hintText: 'NGO Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _ngoActivity,
                  hintText: 'NGO Activity',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _address,
                  maxLines: 3,
                  hintText: 'Address',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _coordinator,
                  hintText: 'Co-ordinator',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _description,
                  hintText: 'Description',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _contactUs,
                  hintText: 'Contact Us',
                ),
                const SizedBox(height: 10),
                const Text(
                    "* Enter only the valid credentials *")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
