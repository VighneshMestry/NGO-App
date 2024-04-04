import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utilities/utils.dart';
import '../../../models/ngo_model.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_text_field.dart';
import '../controller/ngo_controller.dart';

class AddNgoScreen extends ConsumerStatefulWidget {
  const AddNgoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNgoScreenState();
}

class _AddNgoScreenState extends ConsumerState<AddNgoScreen> {
  final TextEditingController _ngoName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _coordinator = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _contactUs = TextEditingController();
  List<DropdownMenuItem<String>> dropDownValues = [];
  late File images;
  String imageName = "";
  bool fileExists = false;
  String? _selectedValue = "Advocacy and Research";

  void getNgoActivityList() {
    List<String> ngoActivityList = [];
    ngoActivityList = Constants.ngoCategories;
    for (var ele in ngoActivityList) {
      dropDownValues
          .add(DropdownMenuItem<String>(value: ele, child: Text(ele)));
    }
  }

  void addNgo(NGO ngo) async {
    String downloadUrl = await ref
        .watch(ngoControllerProvider.notifier)
        .getDownloadURL(imageName);
    ngo = ngo.copyWith(coverImage: downloadUrl);
    // ignore: use_build_context_synchronously
    ref.watch(ngoControllerProvider.notifier).addNgo(context, ngo);
  }

  void pickNgoImage() async {
    var result = await pickImages();
    if (result != null && result.files.isNotEmpty) {
      images = File(result.paths[0]!);
      imageName = result.names[0]!;
      fileExists = true;
      setState(() {});
      // ignore: use_build_context_synchronously
      ref
          .watch(ngoControllerProvider.notifier)
          .uploadImage(context, images, imageName);
    }
  }

  @override
  void initState() {
    super.initState();
    getNgoActivityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register NGO",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      const CustomBottomNavigationBar(currentPage: 1)));
            },
            icon: const Icon(Icons.arrow_back)),
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
                if (_ngoName.text.isNotEmpty &&
                    _address.text.isNotEmpty &&
                    _coordinator.text.isNotEmpty &&
                    _description.text.isNotEmpty &&
                    _contactUs.text.isNotEmpty &&
                    fileExists) {
                  String ngoId = const Uuid().v1();
                  NGO ngo = NGO(
                    ngoName: _ngoName.text.trim(),
                    ngoId: ngoId,
                    activity: _selectedValue!,
                    coverImage: "",
                    address: _address.text.trim(),
                    coordinator: _coordinator.text.trim(),
                    description: _description.text.trim(),
                    contactUs: _contactUs.text.trim(),
                  );
                  addNgo(ngo);
                  
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")));
                }
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
      body: SingleChildScrollView(
        child: Padding(
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
                  DropdownButtonFormField<String>(
                    value: _selectedValue,
                    items: dropDownValues,
                    hint: const Text('Select Option'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade700, width: 1.5),
                        ),
                        hintText: "NGO Activity",
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black38,
                        )),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black38,
                        ))),
                  ),
                  const SizedBox(height: 10),
                  fileExists
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          child: Image.file(
                            images,
                            height: 150,
                            width: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: pickNgoImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open_outlined,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Select Cover Image',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  )
                                ],
                              ),
                            ),
                          ),
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
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  const Text("* Enter only the valid credentials *")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
