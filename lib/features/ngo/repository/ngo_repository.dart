import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/models/ngo_model.dart';

final ngoRepositoryProvider = Provider((ref) => NgoRepository());

class NgoRepository {
  CollectionReference get ngoCollection =>
      FirebaseFirestore.instance.collection('ngo');
  CollectionReference get category =>
      FirebaseFirestore.instance.collection('category');

  Future<int> getNgoActivityCount(String activity) async {
    QuerySnapshot querySnapshot = await ngoCollection.where("activity", isEqualTo: activity).get();
    return querySnapshot.size;
  }

  Future<void> addNgo(BuildContext context, NGO ngo) async {
    QuerySnapshot querySnapshot =
        await ngoCollection.where('ngoName', isEqualTo: ngo.ngoName).get();

    if (querySnapshot.docs.isNotEmpty) {
      throw Exception();
    } else {
      await ngoCollection.doc(ngo.ngoId).set(ngo.toMap());
    }
  }

  Future<void> uploadImage(
      BuildContext context, File? coverImage, String name) async {
    if (coverImage != null) {
      try {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('coverImages/$name');
        UploadTask uploadTask = storageReference.putFile(coverImage);
        print("11111111111111111111111111111111111111111111111111111111111111111");
        await uploadTask.whenComplete(() => print("File Uploaded"));
        print("22222222222222222222222222222222222222222222222222222222222222222222");
      } catch (e) {
        print('Error uploading image: $e');
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      print('No image file selected');
    }
  }

  Future<String> getPdfDownloadUrl(String name) async {
    String downloadUrl = '';
    try {
      
        print("33333333333333333333333333333333333333333333333333333");
      Reference storageReference =
          FirebaseStorage.instance.ref().child('coverImages/$name');
      downloadUrl = await storageReference.getDownloadURL();
      
        print("444444444444444444444444444444444444444444444444444444444444");
    } catch (e) {
      print('Error getting download URL: $e');
    }
    return downloadUrl;
  }
}
