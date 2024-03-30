import 'package:cloud_firestore/cloud_firestore.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("NGO with same name already exists")));
    } else {
      await ngoCollection.doc(ngo.ngoId).set(ngo.toMap());
    }
  }
}
