import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCard extends ConsumerStatefulWidget {
  const CustomCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomCardState();
}

class _CustomCardState extends ConsumerState<CustomCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            spreadRadius: 2,
            blurRadius: 3,
          ),
        ],
      ),
      // height: 150,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.assignment,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Enter Details'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        // controller: assignmentTitle,
                                        decoration: const InputDecoration(
                                            labelText: 'Assignment Name'),
                                      ),
                                      TextField(
                                        // controller: assignmentDescription,
                                        decoration: const InputDecoration(
                                            labelText: 'Assignent Description'),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Perform submission actions here
                                        },
                                      child: const Text('Submit'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "widget.document.assignmentTitle",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "Posted on ",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      Offset offset = details.globalPosition;
                      showMenu(
                          context: context,
                          color: Colors.white,
                          position: RelativeRect.fromLTRB(
                              offset.dx, offset.dy + 20, 10, 0),
                          items: [
                            PopupMenuItem(
                              onTap: () {
                              },
                              value: 1,
                              child: const Row(
                                children: [
                                  Icon(Icons.upload),
                                  SizedBox(width: 5),
                                  Text("Upload to My Space"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                              },
                              value: 2,
                              child: const Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(width: 5),
                                  Text("Share"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                
                              },
                              value: 3,
                              child: const Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(width: 5),
                                        Text("Delete"),
                                      ],
                                    ),
                            ),
                            PopupMenuItem(
                              onTap: () {},
                              value: 4,
                              child: const Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 5),
                                  Text("Edit"),
                                ],
                              ),
                            ),
                          ]);
                    },
                    child: const Icon(Icons.more_vert_outlined),
                  ),
                ),
                // Text("Hello"),
              ],
            ),
            const SizedBox(height: 15),Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            height: 40,
                            width: 99,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              onPressed: () {
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: const Text(
                                  "Ask AI",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 8, top: 8, bottom: 8),
                                    height: 40,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.note,
                                            color: Colors.red.shade700),
                                        const SizedBox(width: 10),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  height: 40,
                                  width: 99,
                                  child: ElevatedButton(
                                    autofocus: true,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      elevation: 3,
                                    ),
                                    onPressed: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Icon(Icons.mic_none_rounded),
                                    ),
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
            const SizedBox(height: 15),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  const Text("Tags: "),
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 10,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red),
                          child: Text(
                            "widget.document.tags[index]",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Enter Tags'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  // controller: tags,
                                  decoration: const InputDecoration(
                                      labelText: 'Enter new tag'),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  
                                },
                                child: const Text('Submit'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.grey.shade600),
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