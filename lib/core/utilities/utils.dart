import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<FilePickerResult?> pickImages() async {
  // late File images;
  try{
    return await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    

    // if(files != null && files.files.isNotEmpty) {
    //   for(int i = 0; i < files.files.length; i++) {
    //     images.add(File(files.files[i].path!));
    //   }
    // }
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}