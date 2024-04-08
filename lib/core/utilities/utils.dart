import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }