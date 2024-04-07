import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/core/utilities/utils.dart';
import 'package:ngo_app/features/news/controller/news_controller.dart';
import 'package:ngo_app/features/widgets/custom_text_field.dart';
import 'package:ngo_app/models/news_model.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/constants.dart';
import '../../ngo/controller/ngo_controller.dart';
import '../../widgets/custom_bottom_bar.dart';

class AddNewsScreen extends ConsumerStatefulWidget {
  const AddNewsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends ConsumerState<AddNewsScreen> {
  final TextEditingController _headLine = TextEditingController();
  final TextEditingController _news = TextEditingController();
  final TextEditingController _journalist = TextEditingController();
  final TextEditingController _newsDescription = TextEditingController();
  final TextEditingController _contactUs = TextEditingController();
  List<DropdownMenuItem<String>> dropDownValues = [];
  late File images;
  String imageName = "";
  bool fileExists = false;
  String? _selectedValue = "Advocacy and Research";

  void getNewsActivityList() {
    List<String> newsActivityList = [];
    newsActivityList = Constants.newsCategories;
    for (var ele in newsActivityList) {
      dropDownValues
          .add(DropdownMenuItem<String>(value: ele, child: Text(ele)));
    }
  }

  void addNews(NewsModel news) async {
    String downloadUrl = await ref
        .watch(ngoControllerProvider.notifier)
        .getDownloadURL(imageName);
    news = news.copyWith(coverImage: downloadUrl);
    // ignore: use_build_context_synchronously
    ref.watch(newsControllerProvider.notifier).addNews(context, news);
  }

  void pickNewsImage() async {
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
    getNewsActivityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post news",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      const CustomBottomNavigationBar(currentPage: 2)));
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
                if (_headLine.text.isNotEmpty &&
                    _news.text.isNotEmpty &&
                    _journalist.text.isNotEmpty &&
                    _newsDescription.text.isNotEmpty &&
                    _contactUs.text.isNotEmpty &&
                    fileExists) {
                  String newsId = const Uuid().v1();
                  NewsModel news = NewsModel(
                      headLine: _headLine.text.trim(),
                      newsId: newsId,
                      activity: _selectedValue!,
                      coverImage: "",
                      news: _news.text.trim(),
                      journalist: _journalist.text.trim(),
                      newsDescription: _newsDescription.text.trim(),
                      contactUs: _contactUs.text.trim());
                  addNews(news);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")));
                }
              },
              child: const Text(
                "Post",
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
                    controller: _headLine,
                    hintText: 'News Headline',
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
                        hintText: "News Activity",
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
                          onTap: pickNewsImage,
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
                    controller: _news,
                    maxLines: 3,
                    hintText: 'News',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _journalist,
                    hintText: 'Journalist',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _newsDescription,
                    hintText: 'News Description',
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
